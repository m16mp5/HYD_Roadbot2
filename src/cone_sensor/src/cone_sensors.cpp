/*
 * cone_sensors.cpp
 *
 *  Cone Sensor Interface ROS program.
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

#include <fcntl.h>
#include <termios.h>
#include <unistd.h>
#include <errno.h>
#include <sys/file.h>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "cone_sensor/cs_state_Type.h"
#include "cone_sensor/cs_set_bool_Args.h"

#include "crc16_modbus.h"

using namespace std;
using namespace ros;

// Calibation macros
#define CS_TOPIC_UPDATE_RATE_HZ					3.0

#define WEIGHT_SENSOR_1_MODBUS_ID				0x0F
#define WEIGHT_SENSOR_0_MODBUS_ID				0x0E

#define WEIGHT_SENSOR_PROCESS_TIME_MS			200 // 85 // 70


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
//			ROS_INFO("Read time=%dms, rx=%d\n", i, bytes_read);		// to check max time and how many byte rx
			int crc16 = getCRC16_Modbus(buf, byteNeed-2);
			if ( (buf[byteNeed-2] != (unsigned char)(crc16 >> 8)) ||
				 (buf[byteNeed-1] != (unsigned char)(crc16 & 0xFF)) )
				bytes_read = -1;
			break;
		}
	}
	return bytes_read;
}

class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
//	ros::Subscriber Sub;
//	ros::ServiceServer Service;
//	ros::Publisher pub;

	string portpath;
	int sensor_offset[14];
	double sensor_gain[14];

public:
	SubscribeAndPublish() : pn("~")
	{
		// Subscribe topics, FIFO = 1
//		Sub = n.subscribe("kr1/kr_state", 1, &SubscribeAndPublish::rearArmStateCallback, this, ros::TransportHints().tcpNoDelay());

		// Create clients for services (function calls)
//		rearArmSM.kr_movj_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movj_bypose");

		pn.getParam("serialport", portpath);
		pn.getParam("sensor_offset1", sensor_offset[0]);
		pn.getParam("sensor_offset2", sensor_offset[1]);
		pn.getParam("sensor_offset3", sensor_offset[2]);
		pn.getParam("sensor_offset4", sensor_offset[3]);
		pn.getParam("sensor_offset5", sensor_offset[4]);
		pn.getParam("sensor_offset6", sensor_offset[5]);
		pn.getParam("sensor_offset7", sensor_offset[6]);
		pn.getParam("sensor_offset8", sensor_offset[7]);
		pn.getParam("sensor_offset9", sensor_offset[8]);
		pn.getParam("sensor_offset10", sensor_offset[9]);
		pn.getParam("sensor_offset11", sensor_offset[10]);
		pn.getParam("sensor_offset12", sensor_offset[11]);
		pn.getParam("sensor_offset13", sensor_offset[12]);
		pn.getParam("sensor_offset14", sensor_offset[13]);
		pn.getParam("sensor_gain1", sensor_gain[0]);
		pn.getParam("sensor_gain2", sensor_gain[1]);
		pn.getParam("sensor_gain3", sensor_gain[2]);
		pn.getParam("sensor_gain4", sensor_gain[3]);
		pn.getParam("sensor_gain5", sensor_gain[4]);
		pn.getParam("sensor_gain6", sensor_gain[5]);
		pn.getParam("sensor_gain7", sensor_gain[6]);
		pn.getParam("sensor_gain8", sensor_gain[7]);
		pn.getParam("sensor_gain9", sensor_gain[8]);
		pn.getParam("sensor_gain10", sensor_gain[9]);
		pn.getParam("sensor_gain11", sensor_gain[10]);
		pn.getParam("sensor_gain12", sensor_gain[11]);
		pn.getParam("sensor_gain13", sensor_gain[12]);
		pn.getParam("sensor_gain14", sensor_gain[13]);
		if (portpath.empty())
		{
			portpath = "/dev/ttyUSB0";
			ROS_INFO("No specified port, use /dev/ttyUSB0.");

			for (int i=0; i<14; i++)
			{
				sensor_offset[i] = 0;
				sensor_gain[i] = 1;
			}
		}

		// Register Publish Topics (stream/pipe data), FIFO size = 3, in worker thread
		workerTh = thread(threadRun, pn, portpath, sensor_offset, sensor_gain);

		// Register services (function calls)
//		Service = pn.advertiseService("ac_reload_routes", &SubscribeAndPublish::r1Callback, this);
	}

/*	bool r1Callback(cone_sensor::cs_set_bool_Args::Request  &req,
			cone_sensor::cs_set_bool_Args::Response &res)
	{
		int retval = 0;
		bool state = req.state;
		res.response = retval;
		return true;
	}*/

	std::thread workerTh;
	static void threadRun(ros::NodeHandle n, string portpath, int* sensor_offset, double* sensor_gain)
	{
		cone_sensor::cs_state_Type msg;
		ros::Publisher pub = n.advertise<cone_sensor::cs_state_Type>("cs_state", 3);
		ros::Rate loop_rate(CS_TOPIC_UPDATE_RATE_HZ);
		ROS_INFO("Start publishing cone sensor states.");

		// Loop read RS485 port to periodic update the latest state
		while (ros::ok())
		{
			msg.timestamp = ros::Time::now().toSec();

			// Open RS232/RS485 port
			int fd;
			fd = open(portpath.c_str(), O_RDWR | O_NOCTTY);
			if (fd == -1)
			{
				ROS_INFO("Cone sensor node trying to open serial port %s.\n", portpath.c_str());
				usleep(100 * 1000);
				for (int i=0; i<14; i++)
				{
					msg.state[i] = -1;
					pub.publish(msg);
				}
				continue;
			}

			// Acquire exclusive lock, non-blocking call
			if (flock(fd, LOCK_EX | LOCK_NB) == -1)
			{
				close(fd);
				usleep(4 * 1000);
				continue;
			}

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

			// Write read sensor boxes
			unsigned char wr_buf1[] = {WEIGHT_SENSOR_0_MODBUS_ID,0x04,0x00,0x00,0x00,0x10,0xf1,0x39};
			unsigned char wr_buf2[] = {WEIGHT_SENSOR_1_MODBUS_ID,0x04,0x00,0x00,0x00,0x10,0xf0,0xe8};
			unsigned char rd_buf1[1024];
			unsigned char rd_buf2[1024];
			int bytes_written1 = 0;
			int bytes_read1 = 0;
			int bytes_written2 = 0;
			int bytes_read2 = 0;
			bool read_ok1 = false;
			bool read_ok2 = false;

			int crc16, msglen;
			msglen = sizeof(wr_buf1);
			crc16 = getCRC16_Modbus(wr_buf1, msglen-2);
			wr_buf1[msglen-2] = (unsigned char)(crc16 >> 8);
			wr_buf1[msglen-1] = (unsigned char)(crc16 & 0xFF);
			msglen = sizeof(wr_buf2);
			crc16 = getCRC16_Modbus(wr_buf2, msglen-2);
			wr_buf2[msglen-2] = (unsigned char)(crc16 >> 8);
			wr_buf2[msglen-1] = (unsigned char)(crc16 & 0xFF);

			//usleep(4 * 1000);
			usleep(50 * 1000);
			tcflush(fd, TCIFLUSH);
			bytes_written1 = write(fd, wr_buf1, sizeof(wr_buf1));
//			usleep(WEIGHT_SENSOR_PROCESS_TIME_MS * 1000);
//			bytes_read1 = read(fd, rd_buf1, sizeof(rd_buf1));
			bytes_read1 = serialReadWithTimeOut(fd, rd_buf1, 37, WEIGHT_SENSOR_PROCESS_TIME_MS);
			read_ok1 = true;
			if (bytes_read1 < 37)
			{
//				ROS_INFO("Cone sensor box 0 read error! Rx=%d\n", bytes_read1);
				read_ok1 = false;
			}
			//usleep(4 * 1000);
			usleep(50 * 1000);
			tcflush(fd, TCIFLUSH);
			bytes_written2 = write(fd, wr_buf2, sizeof(wr_buf2));
//			usleep(WEIGHT_SENSOR_PROCESS_TIME_MS * 1000);
//			bytes_read2 = read(fd, rd_buf2, sizeof(rd_buf2));
			bytes_read2 = serialReadWithTimeOut(fd, rd_buf2, 37, WEIGHT_SENSOR_PROCESS_TIME_MS);
			read_ok2 = true;
			if (bytes_read2 < 37)
			{
//				ROS_INFO("Cone sensor box 1 read error! Rx=%d\n", bytes_read2);
				read_ok2 = false;
			}

			// Close RS232/RS485 port for other use
			close(fd);

/*			ROS_INFO("%02x%02x%02x%02x %02x%02x%02x%02x %02x%02x%02x%02x\n",
					rd_buf1[3], rd_buf1[4],
					rd_buf1[5], rd_buf1[6],
					rd_buf1[7], rd_buf1[8],
					rd_buf1[9], rd_buf1[10],
					rd_buf1[11], rd_buf1[12],
					rd_buf1[13], rd_buf1[14]);*/

			// Do some calculation on zero and gain, then write data and state to msg
			int rd_ptr = 3;
			for (int i=0; i<8; i++)
			{
				int tmp;
				tmp = (int)((unsigned int)rd_buf1[rd_ptr]<<24) + ((unsigned int)rd_buf1[rd_ptr+1]<<16) + ((unsigned int)rd_buf1[rd_ptr+2]<<8) + rd_buf1[rd_ptr+3];
				rd_ptr += 4;
				msg.weight_slots[i] = (tmp + sensor_offset[i]) * sensor_gain[i];

				// Normal if below 400.0kg
				if (!read_ok1)
				{
					msg.state[i] = -2;
					msg.weight_slots[i] = 0;
				}
				else if (abs(msg.weight_slots[i]) > 400.0)
					msg.state[i] = 1;
				else
					msg.state[i] = 0;
			}

			rd_ptr = 3;
			for (int i=8; i<14; i++)
			{
				int tmp;
				tmp = (int)((unsigned int)rd_buf2[rd_ptr]<<24) + ((unsigned int)rd_buf2[rd_ptr+1]<<16) + ((unsigned int)rd_buf2[rd_ptr+2]<<8) + rd_buf2[rd_ptr+3];
				rd_ptr += 4;
				msg.weight_slots[i] = (tmp + sensor_offset[i]) * sensor_gain[i];

				// Normal if below 400.0kg
				if (!read_ok2)
				{
					msg.state[i] = -2;
					msg.weight_slots[i] = 0;
				}
				else if (abs(msg.weight_slots[i]) > 400.0)
					msg.state[i] = 1;
				else
					msg.state[i] = 0;
			}

			pub.publish(msg);
			loop_rate.sleep();
		}
	}

};

int main(int argc, char **argv)
{
	// Initialize ros
	ros::init(argc, argv, "cone_sensors");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;

	ROS_INFO("Start Cone Sensing in LB and SB.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(4);
	spinner.spin();
	SAPObject.workerTh.join();
	ROS_INFO("Close Cone Sensing in LB and SB.");

	return 0;
}
