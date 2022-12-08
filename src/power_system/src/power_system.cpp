/*
 * power_system.cpp
 *
 *  Power System Interface ROS program.
 *  Created on: 13 Nov 2019
 *      Author: IY
 */

#include <sstream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <cmath>

#include <fcntl.h>
#include <termios.h>
#include <unistd.h>
#include <errno.h>
#include <sys/file.h>
#include <modbus/modbus.h>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "power_system/ps_state_Type.h"
#include "power_system/ps_set_double_Args.h"
#include "power_system/ps_set_bool_Args.h"

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

#define INVERTOR_PRINT_STATE						1

// Calibation macros
#define PS_TOPIC_UPDATE_RATE_HZ						0.5

#define HUMIDITY_TEMP_SENSOR_1_MODBUS_ID			0x0D
#define HUMIDITY_TEMP_SENSOR_0_MODBUS_ID			0x0C
#define THREEPHASE_METER_1_MODBUS_ID				0x0B
#define THREEPHASE_METER_0_MODBUS_ID				0x0A
#define THREEPHASE_MCB_1_MODBUS_ID					0x09
#define THREEPHASE_MCB_0_MODBUS_ID					0x08

/*#define HUMIDITY_TEMP_SENSOR_PROCESS_TIME_MS		300
#define THREEPHASE_METER_PROCESS_TIME_MS			300
#define THREEPHASE_MCB_PROCESS_TIME_MS				300*/


/*static int serialReadWithTimeOut(int fd, unsigned char* buf, int byteNeed, int timeoutMS)
{
	int bytes_read = 0;
	for (int i=0; i<timeoutMS; i++)
	{
		usleep(1 * 1000);
		int bytes_rx = read(fd, buf+bytes_read, 1024);
		bytes_read += bytes_rx;
		if (bytes_read >= byteNeed)
		{
//			ROS_INFO("Read time=%dms, rx=%d\n", i, bytes_read);		// to check max time and how many byte rx
			int crc16 = getCRC16_Modbus(buf, byteNeed-2);
			if ( (buf[byteNeed-2] != (unsigned char)(crc16 >> 8)) ||
				 (buf[byteNeed-1] != (unsigned char)(crc16 & 0xFF)) )
			{
				// Special handling for one problemic temp_hum box
				int crc16sp = crc16 & 0x00F0;
				crc16sp |= ((crc16 & 0xB000) | ((crc16 ^ 0x4000) & 0x4000));
				crc16sp |= ((crc16 & 0x0800) | ((crc16 ^ 0x0700) & 0x0700));
				crc16sp |= ((crc16 & 0x000D) | ((crc16 ^ 0x0002) & 0x0002));
				if ( (buf[byteNeed-2] == (unsigned char)(crc16sp >> 8)) &&
					 (buf[byteNeed-1] == (unsigned char)(crc16sp & 0xFF)) )
					break;

				ROS_INFO("PwrSys Rxlen:%d, CRC:%02x%02x. CalCRC:%04x. CalCRCSP:%04x.", bytes_read, buf[byteNeed-2], buf[byteNeed-1], crc16, crc16sp);
				bytes_read = -1;
			}
			break;
		}
	}
	return bytes_read;
}*/

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

class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
//	ros::Subscriber Sub;
	ros::ServiceServer switchOnInverterMCBService, switchOffInverterMCBService;
	ros::ServiceServer switchOnOffBattPackService, switchOnOffBattChargingService;
//	ros::Publisher pub;

	string portpath;
	modbus_t *Ctx;

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
		workerTh = thread(threadRun, pn, Ctx, portpath);

		// Register services (function calls)
		switchOnInverterMCBService = pn.advertiseService("ps_switchon_invertermcb", &SubscribeAndPublish::switchOnInverterMCBCallback, this);
		switchOffInverterMCBService = pn.advertiseService("ps_switchoff_invertermcb", &SubscribeAndPublish::switchOffInverterMCBCallback, this);
		switchOnOffBattPackService = pn.advertiseService("ps_switchonoff_battpack", &SubscribeAndPublish::switchOnOffBattPackCallback, this);
		switchOnOffBattChargingService = pn.advertiseService("ps_switchonoff_battcharging", &SubscribeAndPublish::switchOnOffBattChargingCallback, this);
	}

	bool switchOnInverterMCBCallback(power_system::ps_set_double_Args::Request  &req,
			power_system::ps_set_double_Args::Response &res)
	{
		int num = (int)req.num;
		res.response = 0;
		if ( (num != 0) && (num != 1) )
		{
			res.response = -1;
			return false;
		}

		int rc = -1;
		// Open RS232/RS485 port as exclusive lock
		int fd;
		res.response = acquireSerialLock(portpath.c_str(), &fd);
		if (res.response != 0)
			return false;

		int slaveID;
		if (num == 0)
		{
			slaveID = THREEPHASE_MCB_0_MODBUS_ID;
			modbus_set_slave(Ctx, slaveID);
			// [09][05][00][01][FF][00][DC][B2]
			rc = modbus_write_bit(Ctx, 0x0001, 0xFF00);
		}
		else
		{
			slaveID = THREEPHASE_MCB_1_MODBUS_ID;
			modbus_set_slave(Ctx, slaveID);
			// [09][06][02][8C][00][01][xx][xx] // clear fault
			// [09][06][02][8E][00][01][28][D1] // off grid
			// [09][06][02][8A][00][01][69][10] // turn on
			rc = modbus_write_register(Ctx, 0x028C, 0x0001);
			usleep(500 * 1000);
			rc = modbus_write_register(Ctx, 0x028E, 0x0001);
			usleep(500 * 1000);
			rc = modbus_write_register(Ctx, 0x028A, 0x0001);
		}

		if (rc == -1)
		{
			ROS_INFO("%s for 0x%x write\n", modbus_strerror(errno), slaveID);
			res.response = 1;
		}

		// Release exclusive lock
		close(fd);
		return true;
	}

	bool switchOffInverterMCBCallback(power_system::ps_set_double_Args::Request  &req,
			power_system::ps_set_double_Args::Response &res)
	{
		int num = (int)req.num;
		res.response = 0;
		if ( (num != 0) && (num != 1) )
		{
			res.response = -1;
			return false;
		}

		int rc = -1;
		// Open RS232/RS485 port as exclusive lock
		int fd;
		res.response = acquireSerialLock(portpath.c_str(), &fd);
		if (res.response != 0)
			return false;

		int slaveID;
		if (num == 0)
		{
			slaveID = THREEPHASE_MCB_0_MODBUS_ID;
			modbus_set_slave(Ctx, slaveID);
			// [09][05][00][01][00][00][DC][B2]
			rc = modbus_write_bit(Ctx, 0x0001, 0x0000);
		}
		else
		{
			slaveID = THREEPHASE_MCB_1_MODBUS_ID;
			modbus_set_slave(Ctx, slaveID);
			// [09][06][02][8B][00][01][38][D0] // turn off
			// [09][06][02][8C][00][01][xx][xx] // clear fault
			rc = modbus_write_register(Ctx, 0x028B, 0x0001);
			usleep(500 * 1000);
			rc = modbus_write_register(Ctx, 0x028C, 0x0001);
		}

		if (rc == -1)
		{
			ROS_INFO("%s for 0x%x write\n", modbus_strerror(errno), slaveID);
			res.response = 1;
		}

		// Release exclusive lock
		close(fd);
		return true;
	}

	bool switchOnOffBattPackCallback(power_system::ps_set_bool_Args::Request  &req,
			power_system::ps_set_bool_Args::Response &res)
	{
		res.response = 0;
		bool state = req.state;
		// TBD: CAN bus operation to battery BMS controller
		return true;
	}

	bool switchOnOffBattChargingCallback(power_system::ps_set_bool_Args::Request  &req,
			power_system::ps_set_bool_Args::Response &res)
	{
		res.response = 0;
		bool state = req.state;
		// TBD: CAN bus operation to battery BMS controller
		return true;
	}

	std::thread workerTh;
	static void threadRun(ros::NodeHandle n, modbus_t *ctx, string portpath)
	{
		power_system::ps_state_Type msg;
		ros::Publisher pub = n.advertise<power_system::ps_state_Type>("ps_state", 3);
		ros::Rate loop_rate(PS_TOPIC_UPDATE_RATE_HZ);
		ROS_INFO("Start publishing power system states.");

		// Loop read RS485 port to periodic update the latest state
		while (ros::ok())
		{
			// Open RS232/RS485 port as exclusive lock
			int fd;
			acquireSerialLock(portpath.c_str(), &fd);

			msg.timestamp = ros::Time::now().toSec();

			uint16_t  tab_reg0[64] = {0};
			uint16_t  tab_reg1[64] = {0};
			uint16_t  tab_reg2[64] = {0};
			uint16_t  tab_reg3[64] = {0};
			uint16_t  tab_reg4[64] = {0};
			uint16_t  tab_reg5[64] = {0};
			int rc0 = -1, rc1 = -1, rc2 = -1, rc3 = -1, rc4 = -1, rc5 = -1;

//			usleep(50 * 1000);
/*			modbus_set_slave(ctx, HUMIDITY_TEMP_SENSOR_0_MODBUS_ID);
			// [0C][03][00][C8][00][02][44][E8]
	    	rc0 = modbus_read_registers(ctx, 0x00, 0x06, tab_reg0);
	    	if (rc0 == -1)
	    		ROS_INFO("%s for 0x%x read\n", modbus_strerror(errno), HUMIDITY_TEMP_SENSOR_0_MODBUS_ID);*/
//			usleep(50 * 1000);
	    	modbus_set_slave(ctx, HUMIDITY_TEMP_SENSOR_1_MODBUS_ID);
			// [0C][03][00][C8][00][02][44][E8]
	    	rc1 = modbus_read_registers(ctx, 0x00, 0x06, tab_reg1);
	    	if (rc1 == -1)
	    		ROS_INFO("%s for 0x%x read\n", modbus_strerror(errno), HUMIDITY_TEMP_SENSOR_1_MODBUS_ID);

			usleep(90 * 1000);
			modbus_set_slave(ctx, THREEPHASE_METER_0_MODBUS_ID);
			// [08][04][00][00][00][05][30][90]
			rc2 = modbus_read_input_registers(ctx, 0x00, 0x18, tab_reg2);
			if (rc2 == -1)
				ROS_INFO("%s for 0x%x read\n", modbus_strerror(errno), THREEPHASE_METER_0_MODBUS_ID);
			usleep(90 * 1000);
			modbus_set_slave(ctx, THREEPHASE_METER_1_MODBUS_ID);
			// [08][04][00][00][00][05][30][90]
			rc3 = modbus_read_input_registers(ctx, 0x00, 0x18, tab_reg3);
			if (rc3 == -1)
				ROS_INFO("%s for 0x%x read\n", modbus_strerror(errno), THREEPHASE_METER_1_MODBUS_ID);

//			usleep(50 * 1000);
/*			modbus_set_slave(ctx, THREEPHASE_MCB_0_MODBUS_ID);
			// [08][04][00][00][00][05][30][90]
			rc4 = modbus_read_input_registers(ctx, 0x00, 0x05, tab_reg4);
			if (rc4 == -1)
				ROS_INFO("%s for 0x%x read\n", modbus_strerror(errno), THREEPHASE_MCB_0_MODBUS_ID);*/
			usleep(40 * 1000);
			modbus_set_slave(ctx, THREEPHASE_MCB_1_MODBUS_ID);
			// [09][03][02][8A][00][01][xx][xx]
			rc5 = modbus_read_registers(ctx, 0x028A, 0x01, tab_reg5);
			if (rc5 == -1)
				ROS_INFO("%s for 0x%x[0x28A] read\n", modbus_strerror(errno), THREEPHASE_MCB_1_MODBUS_ID);
			// [09][03][00][8D][00][03][xx][xx]
			usleep(30 * 1000);
			rc5 = modbus_read_registers(ctx, 0x008D, 0x03, tab_reg5+1);
			if (rc5 == -1)
				ROS_INFO("%s for 0x%x[0x08D] read\n", modbus_strerror(errno), THREEPHASE_MCB_1_MODBUS_ID);

			if (INVERTOR_PRINT_STATE)
			{
				// [09][03][02][60][00][02][xx][xx]
				usleep(30 * 1000);
				int rc5a = modbus_read_registers(ctx, 0x0260, 0x04, tab_reg5+16);
				if (rc5a == -1)
					ROS_INFO("%s for 0x%x[0x260] read\n", modbus_strerror(errno), THREEPHASE_MCB_1_MODBUS_ID);
				else
					ROS_INFO("Invertor state [0x260-263]: 0x%x, 0x%x, 0x%x, 0x%x\n", tab_reg5[16], tab_reg5[17], tab_reg5[18], tab_reg5[19]);

				// invertor version info
				/*usleep(30 * 1000);
				int rc5b = modbus_read_registers(ctx, 0x0220, 0x08, tab_reg5+16);
				if (rc5b == -1)
					ROS_INFO("%s for 0x%x[0x220] read\n", modbus_strerror(errno), THREEPHASE_MCB_1_MODBUS_ID);
				else
					ROS_INFO("Invertor info [0x220]: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
							tab_reg5[16], tab_reg5[17], tab_reg5[18], tab_reg5[19],
							tab_reg5[20], tab_reg5[21], tab_reg5[22], tab_reg5[23]);*/
			}

	    	// Release exclusive lock
			close(fd);

			// Humidity and Temp sensors 0
			if (rc0 == -1)
				msg.state_temphum[0] = -2;
			else
			{
				msg.state_temphum[0] = 0;
				msg.th_humidity[0] = tab_reg0[0] / 10.0;
				msg.th_temperature[0] = tab_reg0[1] / 10.0;
			}

			// Humidity and Temp sensors 1
			if (rc1 == -1)
				msg.state_temphum[1] = -2;
			else
			{
				msg.state_temphum[1] = 0;
				msg.th_humidity[1] = tab_reg1[0] / 10.0;
				msg.th_temperature[1] = tab_reg1[1] / 10.0;
			}

			// 3 phase meter 0
			// rd_ptr+3, 0 A-V, 2*2 B-V, 4*2 C-V, 8*2 A-A, 10*2 B-A, 12*2 C-A, 16*2 Tot-W, 18*2 A-W, 20*2 B-W, 22*2 C-W
			if (rc2 == -1)
				msg.state_meter[0] = -2;
			else
			{
				msg.state_meter[0] = 0;

				uint16_t swap_reg[2];
				swap_reg[0] = tab_reg2[1];
				swap_reg[1] = tab_reg2[0];
				msg.meter_phA_V[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[3];
				swap_reg[1] = tab_reg2[2];
				msg.meter_phB_V[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[5];
				swap_reg[1] = tab_reg2[4];
				msg.meter_phC_V[0] = modbus_get_float(&swap_reg[0]);
				// skip 2 words
				swap_reg[0] = tab_reg2[9];
				swap_reg[1] = tab_reg2[8];
				msg.meter_phA_I[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[11];
				swap_reg[1] = tab_reg2[10];
				msg.meter_phB_I[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[13];
				swap_reg[1] = tab_reg2[12];
				msg.meter_phC_I[0] = modbus_get_float(&swap_reg[0]);
				// skip 2 words
				swap_reg[0] = tab_reg2[17];
				swap_reg[1] = tab_reg2[16];
				msg.meter_tot_W[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[19];
				swap_reg[1] = tab_reg2[18];
				msg.meter_phA_W[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[21];
				swap_reg[1] = tab_reg2[20];
				msg.meter_phB_W[0] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg2[23];
				swap_reg[1] = tab_reg2[22];
				msg.meter_phC_W[0] = modbus_get_float(&swap_reg[0]);
			}

			// 3 phase meter 1
			if (rc3 == -1)
				msg.state_meter[1] = -2;
			else
			{
				msg.state_meter[1] = 0;

				uint16_t swap_reg[2];
				swap_reg[0] = tab_reg3[1];
				swap_reg[1] = tab_reg3[0];
				msg.meter_phA_V[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[3];
				swap_reg[1] = tab_reg3[2];
				msg.meter_phB_V[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[5];
				swap_reg[1] = tab_reg3[4];
				msg.meter_phC_V[1] = modbus_get_float(&swap_reg[0]);
				// skip 2 words
				swap_reg[0] = tab_reg3[9];
				swap_reg[1] = tab_reg3[8];
				msg.meter_phA_I[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[11];
				swap_reg[1] = tab_reg3[10];
				msg.meter_phB_I[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[13];
				swap_reg[1] = tab_reg3[12];
				msg.meter_phC_I[1] = modbus_get_float(&swap_reg[0]);
				// skip 2 words
				swap_reg[0] = tab_reg3[17];
				swap_reg[1] = tab_reg3[16];
				msg.meter_tot_W[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[19];
				swap_reg[1] = tab_reg3[18];
				msg.meter_phA_W[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[21];
				swap_reg[1] = tab_reg3[20];
				msg.meter_phB_W[1] = modbus_get_float(&swap_reg[0]);
				swap_reg[0] = tab_reg3[23];
				swap_reg[1] = tab_reg3[22];
				msg.meter_phC_W[1] = modbus_get_float(&swap_reg[0]);
			}

			// 3 phase inverter MCB 0
			// rece：01 04 0A, 00 EA, 00 EA, 00 EA, 00 00, 00 0F, 74 04
			if  (rc4 == -1)
				msg.state_mcb[0] = -2;
			else
			{
				msg.state_mcb[0] = 0;
				msg.mcb_V[0] = tab_reg4[0] * 0.462773;
				msg.mcb_I[0] = tab_reg4[3];
				if (tab_reg4[4] > 0x000F)
					msg.mcb_sw_pos[0] = 1;
				else
					msg.mcb_sw_pos[0] = 0;
			}

			// 3 phase inverter MCB 1
			if  (rc5 == -1)
				msg.state_mcb[1] = -2;
			else
			{
				msg.state_mcb[1] = 0;

				msg.mcb_V[1] = tab_reg5[2]/10.0;
				msg.mcb_I[1] = tab_reg5[3]/10.0;
				if (tab_reg5[0] > 0)
					msg.mcb_sw_pos[1] = 1;
				else
					msg.mcb_sw_pos[1] = 0;
			}

			pub.publish(msg);
			usleep(10 * 1000);
			loop_rate.sleep();
		}
	}

};

int main(int argc, char **argv)
{
	// Initialize ros
	ros::init(argc, argv, "power_system");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;

	ROS_INFO("Start Power System.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(4);
	spinner.spin();
	SAPObject.workerTh.join();
	ROS_INFO("Close Power System.");

	return 0;
}
