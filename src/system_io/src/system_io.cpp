/*
 * system_io.cpp
 *
 *  System IO (for power system, safety, compressor etc fault) Interface ROS program.
 *  Created on: 13 Jun 2020
 *      Author: IY
 */

#include <sstream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <cmath>

#include <modbus/modbus.h>
#include <mutex>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "system_io/sio_state_Type.h"
#include "system_io/sio_set_value_Args.h"
#include "system_io/sio_set_bool_Args.h"

using namespace std;
using namespace ros;

// Calibation macros
#define SIO_TOPIC_UPDATE_RATE_HZ						5.0

#define SIO_MAX_IO_BITS									18

#define SIO_INPUT_BITS_PER_PORT							6
#define SIO_INPUT_PORT_ADDR								0
#define SIO_OUTPUT_BITS_PER_PORT						6
#define SIO_OUTPUT_PORT_ADDR							16

#define SIO_LEFT_LB_INBIT								0
#define SIO_RIGHT_LB_INBIT								1

#define SIO_REAR_SLIDER_OUTBIT							0
#define SIO_CONE_SLIDER_OUTBIT							1
#define SIO_AIRPUMP_PWR_OUTBIT							2
#define SIO_ARROWLIGHT_PWR_OUTBIT						3
#define SIO_REAR_SLIDER2_OUTBIT							4		// Javier
#define SIO_CONE_SLIDER2_OUTBIT							5		// Javier

class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
//	ros::Subscriber Sub;
	ros::ServiceServer setEthernetIOService, setRearSliderService, setConeSliderService, setAirPumpService, setArrowLightService;
//	ros::Publisher pub;

	string EthIoAddress;
	modbus_t* Ctx;

	uint8_t DO[MODBUS_MAX_READ_BITS];
	uint8_t DI[MODBUS_MAX_READ_BITS];

	mutex accesskey;

public:
	SubscribeAndPublish() : pn("~")
	{
		// Subscribe topics, FIFO = 1
//		Sub = n.subscribe("kr1/kr_state", 1, &SubscribeAndPublish::rearArmStateCallback, this, ros::TransportHints().tcpNoDelay());

		// Create clients for services (function calls)
//		rearArmSM.kr_movj_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movj_bypose");

		pn.getParam("io0_ip", EthIoAddress);
		if (EthIoAddress.empty())
		{
			EthIoAddress = "192.168.10.51";
			ROS_INFO("No specified Ethernet IO port address, use default.");
		}

		Ctx = modbus_new_tcp(EthIoAddress.c_str(), 502); 	//connection
		if (modbus_connect(Ctx) == -1)
		{
			ROS_INFO("Ethernet IO connection failed: %s\n", modbus_strerror(errno));
			modbus_free(Ctx);
			return;
		}
		else
			ROS_INFO("Ethernet IO connection success\n");
		modbus_get_header_length(Ctx);

		for (int i=0; i<SIO_MAX_IO_BITS; i++)
		{
			DI[i] = 0;
			DO[i] = 0;
		}
		// Register Publish Topics (stream/pipe data), FIFO size = 1
		workerTh = thread(threadRun, pn, EthIoAddress.c_str(), &Ctx, DI, DO, &accesskey);

		// Register services (function calls)
		setEthernetIOService = pn.advertiseService("sio_set_system_do", &SubscribeAndPublish::setSystemDOCallback, this);
		setRearSliderService = pn.advertiseService("sio_set_rear_slider", &SubscribeAndPublish::setRearSliderCallback, this);
		setConeSliderService = pn.advertiseService("sio_set_cone_slider", &SubscribeAndPublish::setConeSliderCallback, this);
		setAirPumpService = pn.advertiseService("sio_set_airpump", &SubscribeAndPublish::setAirPumpCallback, this);
		setArrowLightService = pn.advertiseService("sio_set_arrowlight", &SubscribeAndPublish::setArrowLightCallback, this);
	}

	bool setSystemDOCallback(system_io::sio_set_value_Args::Request  &req,
			system_io::sio_set_value_Args::Response &res)
	{
		int retval = 0;

		int rc;
		int addr = SIO_OUTPUT_PORT_ADDR;
		int nb = SIO_OUTPUT_BITS_PER_PORT;
		uint8_t relays[MODBUS_MAX_READ_BITS];

		accesskey.lock();
		for (int i=0; i<SIO_MAX_IO_BITS; i++)
		{
			int maskBit = (0x01 << i);
			if (req.mask & maskBit)
			{
				if (req.value & maskBit)
					relays[i] = 1;
				else
					relays[i] = 0;
			}
			else
			{
				relays[i] = DO[i];
			}
		}

		// TBD: Only 6bit write to output port box, need to update
		rc = modbus_write_bits(Ctx, addr, nb, &relays[0]);
		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}
		accesskey.unlock();

		res.response = retval;
		return true;
	}

	bool setRearSliderCallback(system_io::sio_set_bool_Args::Request  &req,
			system_io::sio_set_bool_Args::Response &res)
	{
		int retval = 0;

		int rc;
		int addr = SIO_OUTPUT_PORT_ADDR;
		int nb = SIO_OUTPUT_BITS_PER_PORT;
		uint8_t relays[MODBUS_MAX_READ_BITS];
		//uint8_t relays2[MODBUS_MAX_READ_BITS];	// Javier

		accesskey.lock();
		//Original
		///*
		for (int i=0; i<SIO_MAX_IO_BITS; i++)
			relays[i] = DO[i];

		if (req.state)
		{
			relays[SIO_REAR_SLIDER_OUTBIT] = 1;
			relays[SIO_REAR_SLIDER2_OUTBIT] = 0;
		}
		else
		{
			relays[SIO_REAR_SLIDER_OUTBIT] = 0;
			relays[SIO_REAR_SLIDER2_OUTBIT] = 1;
		}

		// TBD: Only 6bit write to output port box, need to update
		rc = modbus_write_bits(Ctx, addr, nb, &relays[0]);
		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}
		//*/


/*		// Javier
		for (int i=0; i<SIO_MAX_IO_BITS; i++)
		{
			relays[i] = DO[i];
			relays2[i] = DO[i];
		}

		if (req.state)
		{
			relays[SIO_REAR_SLIDER_OUTBIT] = 1;
			relays2[SIO_REAR_SLIDER2_OUTBIT] = 0;
		}
		else
		{
			relays[SIO_REAR_SLIDER_OUTBIT] = 0;
			relays2[SIO_REAR_SLIDER2_OUTBIT] = 1;
		}

		// TBD: Only 6bit write to output port box, need to update
		rc = modbus_write_bits(Ctx, addr, nb, &relays[0]);

		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}

		// TBD: Only 6bit write to output port box, need to update
		//rc = modbus_write_bits(Ctx, addr, nb, &relays2[0]);
		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}
		// Javier
		*/

		accesskey.unlock();

		res.response = retval;
		return true;
	}

	bool setConeSliderCallback(system_io::sio_set_bool_Args::Request  &req,
			system_io::sio_set_bool_Args::Response &res)
	{
		int retval = 0;

		int rc;
		int addr = SIO_OUTPUT_PORT_ADDR;
		int nb = SIO_OUTPUT_BITS_PER_PORT;
		uint8_t relays[MODBUS_MAX_READ_BITS];

		accesskey.lock();
		for (int i=0; i<SIO_MAX_IO_BITS; i++)
			relays[i] = DO[i];

		if (req.state)
		{
			relays[SIO_CONE_SLIDER_OUTBIT] = 1;
			relays[SIO_CONE_SLIDER2_OUTBIT] = 0;	// Javier
		}
		else
		{
			relays[SIO_CONE_SLIDER_OUTBIT] = 0;
			relays[SIO_CONE_SLIDER2_OUTBIT] = 1;	// Javier
		}

		// TBD: Only 6bit write to output port box, need to update
		rc = modbus_write_bits(Ctx, addr, nb, &relays[0]);
		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}
		accesskey.unlock();

		res.response = retval;
		return true;
	}

	bool setAirPumpCallback(system_io::sio_set_bool_Args::Request  &req,
			system_io::sio_set_bool_Args::Response &res)
	{
		int retval = 0;

		int rc;
		int addr = SIO_OUTPUT_PORT_ADDR;
		int nb = SIO_OUTPUT_BITS_PER_PORT;
		uint8_t relays[MODBUS_MAX_READ_BITS];

		accesskey.lock();
		for (int i=0; i<SIO_MAX_IO_BITS; i++)
			relays[i] = DO[i];

		if (req.state)
			relays[SIO_AIRPUMP_PWR_OUTBIT] = 1;
		else
			relays[SIO_AIRPUMP_PWR_OUTBIT] = 0;

		// TBD: Only 6bit write to output port box, need to update
		rc = modbus_write_bits(Ctx, addr, nb, &relays[0]);
		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}
		accesskey.unlock();

		res.response = retval;
		return true;
	}

	bool setArrowLightCallback(system_io::sio_set_bool_Args::Request  &req,
			system_io::sio_set_bool_Args::Response &res)
	{
		int retval = 0;

		int rc;
		int addr = SIO_OUTPUT_PORT_ADDR;
		int nb = SIO_OUTPUT_BITS_PER_PORT;
		uint8_t relays[MODBUS_MAX_READ_BITS];

		accesskey.lock();
		for (int i=0; i<SIO_MAX_IO_BITS; i++)
			relays[i] = DO[i];

		if (req.state)
			relays[SIO_ARROWLIGHT_PWR_OUTBIT] = 1;
		else
			relays[SIO_ARROWLIGHT_PWR_OUTBIT] = 0;

		// TBD: Only 6bit write to output port box, need to update
		rc = modbus_write_bits(Ctx, addr, nb, &relays[0]);
		if (rc != nb)
		{
			ROS_INFO("ERROR modbus_write_bits (%d)\n", rc);
			retval = 1;
		}
		accesskey.unlock();

		res.response = retval;
		return true;
	}

	std::thread workerTh;
	static void threadRun(ros::NodeHandle n, const char* ctx_ipaddr, modbus_t** ctx, uint8_t* dI, uint8_t* dO, mutex* acckey)
	{
		system_io::sio_state_Type msg;
		ros::Publisher pub = n.advertise<system_io::sio_state_Type>("sio_state", 3);
		ros::Rate loop_rate(SIO_TOPIC_UPDATE_RATE_HZ);
		ROS_INFO("Start publishing system IO states.");

		int rc;
		int addr;
		int nb;
		modbus_t* Ctx = *ctx;

		while (ros::ok())
		{
			msg.timestamp = ros::Time::now().toSec();
			msg.state = 0;

			// Read DO bits
			addr = SIO_OUTPUT_PORT_ADDR;
			nb = SIO_OUTPUT_BITS_PER_PORT;
			acckey->lock();
			rc = modbus_read_bits(Ctx, addr, nb, dO);
			if (rc < 0)
			{
				ROS_INFO("Read DO(Relay) fail: %s\n", modbus_strerror(errno));
				msg.state = 1;
			}
			else
			{
//				ROS_INFO("Read DO(Relay):\n");
				for (int i=0; i < rc; i++)
				{
					msg.output_pin[i] = dO[i];
//					ROS_INFO("[%d]=%d\n", i, relays[i]);
				}
			}
			acckey->unlock();

			// Read DI bits
			addr = SIO_INPUT_PORT_ADDR;
			nb = SIO_INPUT_BITS_PER_PORT;
			acckey->lock();
			rc = modbus_read_bits(Ctx, addr, nb, dI);
			if (rc < 0)
			{
				ROS_INFO("Read DI fail: %s\n", modbus_strerror(errno));
				if (msg.state == 1)
				{
					ROS_INFO("Sys_IO error re-connect...\n");
					modbus_close(Ctx);
					modbus_free(Ctx);

					usleep(10 * 1000);
					Ctx = modbus_new_tcp(ctx_ipaddr, 502); 	//connection
					*ctx = Ctx;
					if (modbus_connect(Ctx) == -1)
					{
						ROS_INFO("Ethernet IO re-connection failed: %s\n", modbus_strerror(errno));
						acckey->unlock();
						modbus_free(Ctx);
						return;
					}
					else
						ROS_INFO("Ethernet IO connection success\n");
					modbus_get_header_length(Ctx);
				}
				else
					msg.state = 1;
			}
			else
			{
//				ROS_INFO("Read DI:\n");
				for (int i=0; i < rc; i++)
				{
					msg.input_pin[i] = dI[i];
//					ROS_INFO("[%d]=%d\n", i, DI[i]);
				}
			}
			acckey->unlock();

			msg.llb_has_cone = dI[SIO_LEFT_LB_INBIT];
			msg.rlb_has_cone = dI[SIO_RIGHT_LB_INBIT];

			msg.rear_slider_down = dO[SIO_REAR_SLIDER_OUTBIT];
			msg.cone_slider_extend = dO[SIO_CONE_SLIDER_OUTBIT];
			msg.airpump_on = dO[SIO_AIRPUMP_PWR_OUTBIT];
			msg.arrowlight_on = dO[SIO_ARROWLIGHT_PWR_OUTBIT];

			pub.publish(msg);
			loop_rate.sleep();
		}

		modbus_close(Ctx);
		modbus_free(Ctx);
	}

};

int main(int argc, char **argv)
{
	// Initialize ros
	ros::init(argc, argv, "system_io");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;

	ROS_INFO("Start System IO.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(4);
	spinner.spin();
	SAPObject.workerTh.join();
	ROS_INFO("Close System IO.");

	return 0;
}
