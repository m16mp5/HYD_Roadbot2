/*
 * lantern_racks.cpp
 *
 *  Lantern Rack Interface ROS program.
 *  Created on: 12 Nov 2019
 *      Author: IY
 */

#include <sstream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <cmath>
#include <string>
#include <stdio.h>

#include <fcntl.h>
#include <termios.h>
#include <unistd.h>
#include <errno.h>
#include <sys/file.h>
#include <modbus/modbus.h>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "lantern_rack/lr_state_Type.h"
#include "lantern_rack/lr_set_mode_Args.h"
#include "lantern_rack/lr_set_double_Args.h"

#include "crc16_modbus.h"


using namespace std;
using namespace ros;


#define MODBUS_SERIAL_BAUDRATE						9600
#define MODBUS_SERIAL_PARITY						'N'
#define MODBUS_SERIAL_DATABITS						8
#define MODBUS_SERIAL_STOPBITS						1
#define MODBUS_TIMEOUT_SEC							1
#define MODBUS_TIMEOUT_USEC							0
#define MODBUS_DEBUG								OFF

#define LEVELSEN_PRINT_STATE						1

// Calibation macros
#define LR_TOPIC_UPDATE_RATE_HZ						0.5

#define HUMIDITY_TEMP_SENSOR_1_MODBUS_ID			0x0D
#define HUMIDITY_TEMP_SENSOR_0_MODBUS_ID			0x0C
#define THREEPHASE_METER_1_MODBUS_ID				0x0B
#define THREEPHASE_METER_0_MODBUS_ID				0x0A
#define THREEPHASE_MCB_1_MODBUS_ID					0x09
#define THREEPHASE_MCB_0_MODBUS_ID					0x08

#define LANTERN_RACK_4_MODBUS_ID					0x04
#define LANTERN_RACK_3_MODBUS_ID					0x03
#define LANTERN_RACK_2_MODBUS_ID					0x02
#define LANTERN_RACK_1_MODBUS_ID					0x01
#define LANTERN_RACK_LEVEL_4_MODBUS_ID				0x04
#define LANTERN_RACK_LEVEL_3_MODBUS_ID				0x03
#define LANTERN_RACK_LEVEL_2_MODBUS_ID				0x02
#define LANTERN_RACK_LEVEL_1_MODBUS_ID				0x01

#define LANTERN_RACK_PROCESS_TIME_MS				200

/**pucFrame – pointer on “Addr” of message
usLen – length message from “Addr” to end “Data”*/
static unsigned char calLRC(unsigned char* pucFrame, unsigned short usLen)
{
	unsigned char ucLRC = 0; // LRC char initialized
	while (usLen--)
	{
		ucLRC += *pucFrame++;
		// Add buffer byte without carry
	}

	// Return twos complement
	ucLRC = (unsigned char) (-((char) ucLRC));
	return ucLRC;
}


string GetBinaryStringFromHexString (string sHex)
{
	string sReturn = "";
	for (int i = 0; i < sHex.length (); ++i)
	{
		switch (sHex [i])
		{
			case '0': sReturn.append ("0000"); break;
			case '1': sReturn.append ("0001"); break;
			case '2': sReturn.append ("0010"); break;
			case '3': sReturn.append ("0011"); break;
			case '4': sReturn.append ("0100"); break;
			case '5': sReturn.append ("0101"); break;
			case '6': sReturn.append ("0110"); break;
			case '7': sReturn.append ("0111"); break;
			case '8': sReturn.append ("1000"); break;
			case '9': sReturn.append ("1001"); break;
			case 'A': sReturn.append ("1010"); break;
			case 'B': sReturn.append ("1011"); break;
			case 'C': sReturn.append ("1100"); break;
			case 'D': sReturn.append ("1101"); break;
			case 'E': sReturn.append ("1110"); break;
			case 'F': sReturn.append ("1111"); break;
		}
	}
	return sReturn;
}


static int serialReadWithTimeOut(int fd, unsigned char* buf, int byteNeed, int timeoutMS)
{
	int bytes_read = 0;
	for (int i=0; i<timeoutMS; i++)
	{
		usleep(1 * 1000);
		int bytes_rx = read(fd, buf+bytes_read, 1024);
		bytes_read += bytes_rx;
		if (bytes_read >= byteNeed)
		{
/*			ROS_INFO("Read time=%dms, rx=%d\n", i, bytes_read);		// to check max time and how many byte rx
			int crc16 = getCRC16_Modbus(buf, byteNeed-2);
			if ( (buf[byteNeed-2] != (unsigned char)(crc16 >> 8)) ||
				 (buf[byteNeed-1] != (unsigned char)(crc16 & 0xFF)) )
				bytes_read = -1;*/
			break;
		}
	}
	return bytes_read;
}

static int acquireSerialLock(const char* portpathstr, int* pfd)
{
	int retval = -1;

	// Open RS232/RS485 port as exclusive lock
	while (ros::ok())
	{
		*pfd = open(portpathstr, O_RDWR | O_NOCTTY);
		if (*pfd == -1)
		{
			ROS_INFO("Node trying to open serial port %s.\n", portpathstr);
			return -2;
		}
		// Acquire exclusive lock, non-blocking call
		if (flock(*pfd, LOCK_EX | LOCK_NB) == -1)
		{
			// Fail retry
			close(*pfd);
			usleep(4 * 1000);
		}
		else
		{
			retval = 0;
			break;
		}
	}

	return retval;
}

static int serialOpenWRAsciiModbus(const char* portpathstr, unsigned char* bin_buf, char* rd_buf, int byteNeed)
{
	int fd;
	// Open RS232/RS485 port as exclusive lock
	int retval = acquireSerialLock(portpathstr, &fd);
	if (retval != 0)
		return retval;

	struct termios SerialPortSettings;
	tcgetattr(fd, &SerialPortSettings);
	cfsetispeed(&SerialPortSettings, B9600);
	cfsetospeed(&SerialPortSettings, B9600);
	SerialPortSettings.c_cflag &= ~PARENB;
	SerialPortSettings.c_cflag &= ~CSTOPB;
	SerialPortSettings.c_cflag &= ~CSIZE;
	SerialPortSettings.c_cflag |=  CS8;
	SerialPortSettings.c_cflag &= ~CRTSCTS;
	SerialPortSettings.c_cflag |= CREAD | CLOCAL;
	SerialPortSettings.c_iflag &= ~(IXON | IXOFF | IXANY);
	SerialPortSettings.c_iflag &= ~(ICANON | ECHO | ECHOE | ISIG);
	SerialPortSettings.c_oflag = 0;
	SerialPortSettings.c_iflag &= ~IGNBRK;
	SerialPortSettings.c_lflag = 0;
	SerialPortSettings.c_oflag = 0;
	SerialPortSettings.c_cc[VMIN] = 0;			// read block if = 1
	SerialPortSettings.c_cc[VTIME] = 0;			// 0 = 0.0s, 1 = Wait 0.1s
	if ((tcsetattr(fd, TCSANOW, &SerialPortSettings)) != 0)
		ROS_INFO("\n  ERROR ! in setting cone sensors serial port attributes");

	int bin_buf_len = 6; //sizeof(bin_buf);  //find the len
	char wr_buf[1024];
	int bytes_written = 0;
	int bytes_read = 0;
	bool read_ok = false;

	unsigned char lrc = calLRC(bin_buf, bin_buf_len);
	sprintf(wr_buf, ":");
	for (int i=0; i<bin_buf_len; i++)
		sprintf(wr_buf, "%s%02X", wr_buf, bin_buf[i]);
	sprintf(wr_buf, "%s%02X\r\n", wr_buf, lrc);  //combine wr_buf with ":" + "bin_buf" + "lrc" + "\r\n";
	int msglen = strlen(wr_buf);

/*	// Check TxRx
	ROS_INFO("Modbus-ascii Tx[%d]: %s", msglen, wr_buf);*/

	usleep(20 * 1000);
	tcflush(fd, TCIFLUSH);
	bytes_written = write(fd, wr_buf, msglen);
	bytes_read = serialReadWithTimeOut(fd, (unsigned char*)rd_buf, byteNeed, 200);
	read_ok = true;
	if (bytes_read < byteNeed)
	{
		ROS_INFO("Modbus-ascii Tx[%d]: %s", msglen, wr_buf);
		ROS_INFO("Box read error! Rx=%d\n", bytes_read);
		read_ok = false;
	}

	if (bytes_read > 0)
	{
		rd_buf[bytes_read] = 0;
		for (int i=0; i<bytes_read; i++)
			rd_buf[i] = rd_buf[i]&0x7F;

/*		// Check for ascii array
		ROS_INFO("Modbus-ascii Rx[%d]: %s", bytes_read, rd_buf);*/
	}

	// Release exclusive lock
	close(fd);

	if (read_ok)
		return 0;
	else
		return -3;
}


class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
//	ros::Subscriber Sub;
	ros::ServiceServer setLanternRackCmdService, setLanternRackModeService;
//	ros::Publisher pub;

	string portpath;
	modbus_t *Ctx;

	int PLCStateRecord[4];

public:
	SubscribeAndPublish() : pn("~")
	{
		// Subscribe topics, FIFO = 1
//		Sub = n.subscribe("kr1/kr_state", 1, &SubscribeAndPublish::rearArmStateCallback, this, ros::TransportHints().tcpNoDelay());

		// Create clients for services (function calls)
//		rearArmSM.kr_movj_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movj_bypose");

		pn.getParam("serialport", portpath);
		if (portpath.empty())
		{
			portpath = "/dev/ttyUSB0";
			ROS_INFO("No specified port, use /dev/ttyUSB0.");
		}

		for (int i=0; i<4; i++)
			PLCStateRecord[i] = 99;

	    Ctx = modbus_new_rtu(portpath.c_str(),
	            MODBUS_SERIAL_BAUDRATE,
	            MODBUS_SERIAL_PARITY,
	            MODBUS_SERIAL_DATABITS,
	            MODBUS_SERIAL_STOPBITS);
	    if (Ctx == NULL)
	    {
	    	ROS_INFO("Unable to create the libmodbus context\n");
	        exit(-1);
	    }
	    modbus_set_debug(Ctx, MODBUS_DEBUG);
	    struct timeval  timeout;
//	    timeout.tv_sec = MODBUS_TIMEOUT_SEC;
//	    timeout.tv_usec = MODBUS_TIMEOUT_USEC;
//	    modbus_set_byte_timeout(Ctx, &timeout);
	    timeout.tv_sec = MODBUS_TIMEOUT_SEC;
	    timeout.tv_usec = MODBUS_TIMEOUT_USEC;
	    modbus_set_response_timeout(Ctx, &timeout);
	    int ret = modbus_connect(Ctx);
	    if (ret == -1)
	    {
	    	ROS_INFO("Can't open the modbus connection\n");
	        exit(-1);
	    }
	    modbus_set_error_recovery(Ctx, MODBUS_ERROR_RECOVERY_PROTOCOL);

		// Register Publish Topics (stream/pipe data), FIFO size = 3, in worker thread
		workerTh = thread(threadRun, pn, Ctx, portpath, PLCStateRecord);

		// Register services (function calls)
		setLanternRackCmdService = pn.advertiseService("lr_set_lantern_rack_cmd", &SubscribeAndPublish::setLanternRackCmdCallback, this);
		setLanternRackModeService = pn.advertiseService("lr_set_lantern_rack_mode", &SubscribeAndPublish::setLanternRackModeCallback, this);
	}

	bool setLanternRackCmdCallback(lantern_rack::lr_set_mode_Args::Request &req,
			lantern_rack::lr_set_mode_Args::Response &res) //pointer for two service msgs (Request and Respond)
	{
		int retval = 0;
		int mode = (int)req.mode;   //msg

		// Write read PLC boxes
		unsigned char bin_buf[] = {LANTERN_RACK_1_MODBUS_ID,0x05,0x08,0x08,0xFF,0x00};   //assign the protocol for bin_buff
		if (mode == 0)//AUTO MODE OFF
			{bin_buf[2] = 0x08; bin_buf[3] = 0x08; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//AUTO MODE OFF
		else if (mode == 1)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x08; bin_buf[4] = 0x00; bin_buf[5] = 0x00;} 	//AUTO MODE ON

		else if (mode == 2)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x1E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//LR1 AUTO PICK ON
		else if (mode == 3)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x0A; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//LR1 AUTO COLLECT On
		else if (mode == 4)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x6E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//LR1 Back TO Zero
		else if (mode == 5)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//LR1 E-Stop On
		else if (mode == 6)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0x00; bin_buf[5] = 0x00;} 	//LR1 E-stop Off

		else if (mode == 7)
			{bin_buf[0] = 0x02; bin_buf[2] = 0x08; bin_buf[3] = 0x1E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR2 AUTO PICK ON
		else if (mode == 8)
			{bin_buf[0] = 0x02; bin_buf[2] = 0x08; bin_buf[3] = 0x0A; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR2 AUTO COLLECT ON
		else if (mode == 9)
			{bin_buf[0] = 0x02; bin_buf[2] = 0x08; bin_buf[3] = 0x6E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR2 Back TO Zero
		else if (mode == 10)
			{bin_buf[0] = 0x02; bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR2 E-Stop On
		else if (mode == 11)
			{bin_buf[0] = 0x02; bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0x00; bin_buf[5] = 0x00;} //LR2 E-Stop Off

		else if (mode == 12)
			{bin_buf[0] = 0x03; bin_buf[2] = 0x08; bin_buf[3] = 0x1E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR3 AUTO PICK ON
		else if (mode == 13)
			{bin_buf[0] = 0x03; bin_buf[2] = 0x08; bin_buf[3] = 0x0A; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR3 AUTO COLLECT ON
		else if (mode == 14)
			{bin_buf[0] = 0x03; bin_buf[2] = 0x08; bin_buf[3] = 0x6E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR3 Back TO Zero
		else if (mode == 15)
			{bin_buf[0] = 0x03; bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR3 E-Stop On
		else if (mode == 16)
			{bin_buf[0] = 0x03; bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0x00; bin_buf[5] = 0x00;} //LR3 E-Stop On

		else if (mode == 17)
			{bin_buf[0] = 0x04; bin_buf[2] = 0x08; bin_buf[3] = 0x1E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR4 AUTO PICK ON
		else if (mode == 18)
			{bin_buf[0] = 0x04; bin_buf[2] = 0x08; bin_buf[3] = 0x0A; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR4 AUTO COLLECT ON
		else if (mode == 19)
			{bin_buf[0] = 0x04; bin_buf[2] = 0x08; bin_buf[3] = 0x6E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR4 Back TO Zero
		else if (mode == 20)
			{bin_buf[0] = 0x04; bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} //LR4 E-Stop On
		else if (mode == 21)
			{bin_buf[0] = 0x04; bin_buf[2] = 0x08; bin_buf[3] = 0x8C; bin_buf[4] = 0x00; bin_buf[5] = 0x00;} //LR4 E-Stop On

		else if (mode == 22)
			{bin_buf[0] = 0x01; bin_buf[1] = 0x02; bin_buf[2] = 0x04; bin_buf[3] = 0x03; bin_buf[4] = 0x00; bin_buf[5] = 0x01;} //LR1 Read Y2
		else if (mode == 23)
			{bin_buf[0] = 0x01; bin_buf[1] = 0x02; bin_buf[2] = 0x04; bin_buf[3] = 0x04; bin_buf[4] = 0x00; bin_buf[5] = 0x01;} //LR1 Read X4
		else if (mode == 24)
			{bin_buf[0] = 0x01; bin_buf[1] = 0x02; bin_buf[2] = 0x04; bin_buf[3] = 0x05; bin_buf[4] = 0x00; bin_buf[5] = 0x01;} //LR1 Read X5
		else if (mode == 25)
			{bin_buf[0] = 0x01; bin_buf[1] = 0x02; bin_buf[2] = 0x04; bin_buf[3] = 0x06; bin_buf[4] = 0x00; bin_buf[5] = 0x01;} //LR1 Read X6
	

		char rd_buf[1024];
		retval = serialOpenWRAsciiModbus(portpath.c_str(), bin_buf, rd_buf, 17);
	
		res.response = retval;
		cout << res.response;
		return true;
	}

	bool setLanternRackModeCallback(lantern_rack::lr_set_mode_Args::Request &req,
			lantern_rack::lr_set_mode_Args::Response &res) //pointer for two service msgs (Request and Respond)
	{
		int retval = 0;
		int mode = (int)req.mode;   //msg

		// Write read all PLC boxes
		unsigned char binStopOn_buf[] = {LANTERN_RACK_1_MODBUS_ID,0x05,0x08,0x8C,0xFF,0x00};	// E-Stop On
		unsigned char binStopOff_buf[] = {LANTERN_RACK_1_MODBUS_ID,0x05,0x08,0x8C,0x00,0x00};	// E-stop Off
		unsigned char bin_buf[] = {LANTERN_RACK_1_MODBUS_ID,0x05,0x08,0x08,0xFF,0x00};   		// assign the protocol for bin_buff
		char rd_buf[1024];

		if (mode == 0)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x6E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//0: Back TO Zero
		else if (mode == 1)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x1E; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//1: AUTO PICK ON
		else if (mode == 2)
			{bin_buf[2] = 0x08; bin_buf[3] = 0x0A; bin_buf[4] = 0xFF; bin_buf[5] = 0x00;} 	//2: AUTO COLLECT ON
																							//Other: Stop/Off
		for (int i=0; i<4; i++)
		{
			/*//Remove Lantern Rack
			if (i==1)
				continue;*/
			//Remove Lantern Rack
			if (i==2)
				continue;
			//Remove Lantern Rack
			if (i==3)
				continue;

			if ( (PLCStateRecord[i] != mode) || (mode > 2) )		// Call stop if mode > 2
			{
				usleep(20 * 1000);
				binStopOn_buf[0] = LANTERN_RACK_1_MODBUS_ID + i;								// ID of PLC boxes
				retval += serialOpenWRAsciiModbus(portpath.c_str(), binStopOn_buf, rd_buf, 17);

				usleep(20 * 1000);
				binStopOff_buf[0] = LANTERN_RACK_1_MODBUS_ID + i;								// ID of PLC boxes
				retval += serialOpenWRAsciiModbus(portpath.c_str(), binStopOff_buf, rd_buf, 17);

				// Other mode stop lantern rack only, skip
				if (mode <= 2)
				{
					usleep(20 * 1000);
					bin_buf[0] = LANTERN_RACK_1_MODBUS_ID + i;							// ID of PLC boxes
					retval += serialOpenWRAsciiModbus(portpath.c_str(), bin_buf, rd_buf, 17);
				}

				PLCStateRecord[i] = mode;
			}
		}

		res.response = retval;
		return true;
	}


	std::thread workerTh;
	static void threadRun(ros::NodeHandle n, modbus_t *ctx, string portpath, int* pPLCStateRecord)
	{
		lantern_rack::lr_state_Type msg;
		ros::Publisher pub = n.advertise<lantern_rack::lr_state_Type>("lr_state", 3); //publish to topic "lr_state" with queue size 3 
		ros::Rate loop_rate(LR_TOPIC_UPDATE_RATE_HZ);
		ROS_INFO("Start publishing lantern rack states.");

		// Loop read RS485 port to periodic update the latest state
		while (ros::ok())
		{
			int retval = 0;
			int sensorState[4] = {0,0,0,0};
			int plcState[4] = {4,4,4,4};
			int levelDist[4] = {-1,-1,-1,-1};

 			// (Ascii mode) Read all PLC boxes for sensor states (Address of X = 0400-04FF)
			unsigned char binReadSensors3_buf[] = {LANTERN_RACK_1_MODBUS_ID,0x02,0x04,0x03,0x00,0x09};	// Read x3,x4,x5,x6,x7,x10,x11
			char rd_buf[1024];
			for (int i=0; i<4; i++)
			{
				int ret;
				usleep(20 * 1000);
				rd_buf[7] = rd_buf[8] = rd_buf[9] = rd_buf[10] = 0;
				binReadSensors3_buf[0] = LANTERN_RACK_1_MODBUS_ID + i;
				if (i < 2)
				{
					binReadSensors3_buf[5] = 0x04;  											// ID of PLC boxes & Read 4 sensors only for LR1&LR2
					ret = serialOpenWRAsciiModbus(portpath.c_str(), binReadSensors3_buf, rd_buf, 13);
				}
				else 
				{
					binReadSensors3_buf[5] = 0x09; 												// ID of PLC boxes & Read 9 sensors only for LR3&LR4
					ret = serialOpenWRAsciiModbus(portpath.c_str(), binReadSensors3_buf, rd_buf, 15);
				}
				retval += ret;

				// Convert ascii string number to binary number
				if (ret == 0)
				{
					unsigned int temp, highb, lowb;
					std::stringstream ss;
					rd_buf[9] = 0;
					ss << std::hex << (rd_buf+7);				// |x12,x11,x10,x7|x6,x5,x4,x3|
					ss >> temp;
					highb = (temp >> 1) & 0x30;
					lowb = temp & 0x0F;
					sensorState[i] = (highb | lowb);
				}
//				ROS_INFO("Lantern rack read sensor[%d]: 0x%02x", i, sensorState[i]);

				// TBD: also read working mode and error state of each PLC
				// 0: Storage, 1: Pick, 2: Collect, Others: Stop
				plcState[i] = pPLCStateRecord[i];
			}

			// (Binary mode) Read all level sensors for lantern level
			// Open RS232/RS485 port as exclusive lock, for modbus lib binary write read
			int fd;
			acquireSerialLock(portpath.c_str(), &fd);
			int rc;
			uint16_t  tab_reg[64] = {0};
			for (int i=0; i<4; i++)
			{
				//remove for skipping the lantern rack sensor
				/*//Remove Lantern Rack
				if (i==1)
					continue;*/
				//Remove Lantern Rack
				if (i==2)
					continue;
				//Remove Lantern Rack
				if (i==3)
					continue;

				usleep(20 * 1000);
				// [ID][03][00][00][00][02][cc][cc]
				modbus_set_slave(ctx, LANTERN_RACK_LEVEL_1_MODBUS_ID + i);
				rc = modbus_read_registers(ctx, 0x00, 0x02, tab_reg);
				if (rc == -1)
				{
					ROS_INFO("%s for 0x%x read\n", modbus_strerror(errno), LANTERN_RACK_LEVEL_1_MODBUS_ID + i);
					ROS_INFO("Lantern rack read level[%d]: na", i);

					retval += rc;
				}
				else
				{
					if (LEVELSEN_PRINT_STATE)
						ROS_INFO("Lantern rack read level[%d]: %d", i, tab_reg[1]);

					// Record level state here
					levelDist[i] = tab_reg[1];
				}
			}
	    	// Release exclusive lock
			close(fd);

			// Prepare ROS message for publish
			msg.timestamp = ros::Time::now().toSec();
			if (retval == 0)
				msg.state = 0;
			else
				msg.state = -1;

			msg.sensor_state[0] = (sensorState[2] >> 2) & 0x03;
			msg.sensor_state[1] = sensorState[2] & 0x03;
			msg.sensor_state[2] = (sensorState[2] >> 4) & 0x03;
			msg.sensor_state[3] = (sensorState[0] >> 2) & 0x03;
			msg.sensor_state[4] = sensorState[0] & 0x03;
			msg.sensor_state[5] = sensorState[1] & 0x03;
			msg.sensor_state[6] = (sensorState[1] >> 2) & 0x03;
			msg.sensor_state[7] = (sensorState[3] >> 4) & 0x03;
			msg.sensor_state[8] = sensorState[3] & 0x03;
			msg.sensor_state[9] = (sensorState[3] >> 2) & 0x03;

			msg.mode[0] = plcState[2];
			msg.mode[1] = plcState[2];
			msg.mode[2] = plcState[2];
			msg.mode[3] = plcState[0];
			msg.mode[4] = plcState[0];
			msg.mode[5] = plcState[1];
			msg.mode[6] = plcState[1];
			msg.mode[7] = plcState[3];
			msg.mode[8] = plcState[3];
			msg.mode[9] = plcState[3];

			// Process 4 level dist to number of lantern at level
			int numOfLanternLevel;
			// Lantern rack PLC
			for (int i=0; i<4; i++)
			{
				if (levelDist[i] < 0)
					numOfLanternLevel = -1;
				else if (levelDist[i] < 210)
					numOfLanternLevel = 0;
				else if (levelDist[i] < 740)
					numOfLanternLevel = 1;
				else if (levelDist[i] < 1256)
					numOfLanternLevel = 2;
				else if (levelDist[i] < 1820)
					numOfLanternLevel = 3;
				else if (levelDist[i] < 2322)
					numOfLanternLevel = 4;
				else if (levelDist[i] < 2869)
					numOfLanternLevel = 5;
				else if (levelDist[i] < 3355)
					numOfLanternLevel = 6;
				else if (levelDist[i] < 3864)
					numOfLanternLevel = 7;
				else if (levelDist[i] < 4439)
					numOfLanternLevel = 8;
				else if (levelDist[i] < 4995)
					numOfLanternLevel = 9;
				else if (levelDist[i] < 5510)
					numOfLanternLevel = 10;
				else if (levelDist[i] < 6050)
					numOfLanternLevel = 11;
				else if (levelDist[i] < 6568)
					numOfLanternLevel = 12;
				else if (levelDist[i] < 7120)
					numOfLanternLevel = 13;
				else if (levelDist[i] < 7606)
					numOfLanternLevel = 14;
				else if (levelDist[i] < 8185)
					numOfLanternLevel = 15;
				else if (levelDist[i] < 8694)
					numOfLanternLevel = 16;
				else if (levelDist[i] < 8900)
					numOfLanternLevel = 17;
				else if (levelDist[i] < 10000)
					numOfLanternLevel = 18;
				else
					numOfLanternLevel = 0;

				if (i == 3)
				{
					if (levelDist[i] < 0)
						numOfLanternLevel = -1;
					else if (levelDist[i] < 50)
						numOfLanternLevel = 0;
					else if (levelDist[i] < 100)
						numOfLanternLevel = 1;
					else if (levelDist[i] < 160)
						numOfLanternLevel = 2;
					else if (levelDist[i] < 280)
						numOfLanternLevel = 3;
					else if (levelDist[i] < 370)
						numOfLanternLevel = 4;
					else if (levelDist[i] < 430)
						numOfLanternLevel = 5;
					else if (levelDist[i] < 520)
						numOfLanternLevel = 6;
					else if (levelDist[i] < 590)
						numOfLanternLevel = 7;
					else if (levelDist[i] < 650)
						numOfLanternLevel = 8;
					else if (levelDist[i] < 750)
						numOfLanternLevel = 9;
					else if (levelDist[i] < 850)
						numOfLanternLevel = 10;
					else
						numOfLanternLevel = 0;
				}

				if (LEVELSEN_PRINT_STATE)
					ROS_INFO("Lantern rack lvl num[%d] before process: %d", i, levelDist[i]);

				if (i == 0)
				{
					if (numOfLanternLevel >= 0)
					{
						// Map to LANTERNRACK_2
						numOfLanternLevel = 17 - numOfLanternLevel;
						msg.level[3] = numOfLanternLevel;
						msg.level[4] = numOfLanternLevel;

						// sensor detected object -> +1 to stack level count
						if (msg.sensor_state[3] > 0)
							msg.level[3]++;
						if (msg.sensor_state[4] > 0)
							msg.level[4]++;
					}
					else
					{
						msg.level[3] = -1;
						msg.level[4] = -1;
					}
				}
				else if (i == 1)
				{
					if (numOfLanternLevel >= 0)
					{
						// Map to LANTERNRACK_3
						numOfLanternLevel = 17 - numOfLanternLevel;
						msg.level[5] = numOfLanternLevel;
						msg.level[6] = numOfLanternLevel;

						// sensor detected object -> +1 to stack level count
						if (msg.sensor_state[5] > 0)
							msg.level[5]++;
						if (msg.sensor_state[6] > 0)
							msg.level[6]++;
					}
					else
					{
						msg.level[5] = -1;
						msg.level[6] = -1;
					}
				}
				else if (i == 2)
				{
					if (numOfLanternLevel >= 0)
					{
						// Map to LANTERNRACK_1
						numOfLanternLevel = 3 - numOfLanternLevel;
						msg.level[0] = numOfLanternLevel;
						msg.level[1] = numOfLanternLevel;
						msg.level[2] = numOfLanternLevel;

						// sensor detected object -> +1 to stack level count
						if (msg.sensor_state[0] > 0)
							msg.level[0]++;
						if (msg.sensor_state[1] > 0)
							msg.level[1]++;
						if (msg.sensor_state[2] > 0)
							msg.level[2]++;
					}
					else
					{
						msg.level[0] = -1;
						msg.level[1] = -1;
						msg.level[2] = -1;
					}
				}
				else if (i == 3)
				{
					if (numOfLanternLevel >= 0)
					{
						// Map to LANTERNRACK_4
						numOfLanternLevel = 9 - numOfLanternLevel;
						msg.level[7] = numOfLanternLevel;
						msg.level[8] = numOfLanternLevel;
						msg.level[9] = numOfLanternLevel;

						// sensor detected object -> +1 to stack level count
						if (msg.sensor_state[7] > 0)
							msg.level[7]++;
						if (msg.sensor_state[8] > 0)
							msg.level[8]++;
						if (msg.sensor_state[9] > 0)
							msg.level[9]++;
					}
					else
					{
						msg.level[7] = -1;
						msg.level[8] = -1;
						msg.level[9] = -1;
					}
				}

				if (LEVELSEN_PRINT_STATE)
					ROS_INFO("Lantern rack lvl num[%d] : %d", i, numOfLanternLevel);
			}

			pub.publish(msg);
			// Free to other use
			usleep(100 * 1000);
			loop_rate.sleep();
		}

		modbus_close(ctx);
		modbus_free(ctx);
	}

};

int main(int argc, char **argv)
{
	// Initialize ros node
	ros::init(argc, argv, "lantern_racks");	
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;

	ROS_INFO("Start Lantern Rack.");	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(4);
	spinner.spin();
	SAPObject.workerTh.join();
	ROS_INFO("Close Lantern Rack.");

	return 0;
}
