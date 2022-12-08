/*
 * kuka_robot_server.cpp
 *
 *  Kuka Robot Arm Interface ROS program.
 *  Created on: 5 Jun 2019
 *      Author: IY
 */

#include <sstream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <cstring>
#include <iomanip>

#include "ros/ros.h"
#include "std_msgs/String.h"
#include "kuka_robot/kr_joint_Type.h"
#include "kuka_robot/kr_pose_Type.h"
#include "kuka_robot/kr_payload_Type.h"
#include "kuka_robot/kr_robot_error_Type.h"
#include "kuka_robot/kr_robot_state_Type.h"

#include "kuka_robot/kr_add_Args.h"
#include "kuka_robot/kr_rwraw_Args.h"
#include "kuka_robot/kr_mv_byjoint_Args.h"
#include "kuka_robot/kr_mv_bypose_Args.h"
#include "kuka_robot/kr_batch_mv_byjoint_Args.h"
#include "kuka_robot/kr_batch_mv_bypose_Args.h"
#include "kuka_robot/kr_batch_mv_run_Args.h"
#include "kuka_robot/kr_cov_joint_pose_Args.h"
#include "kuka_robot/kr_rampstop_Args.h"
#include "kuka_robot/kr_set_speed_scale_Args.h"
#include "kuka_robot/kr_set_load_Args.h"
#include "kuka_robot/kr_set_real_Args.h"
#include "kuka_robot/kr_set_bool_Args.h"
#include "kuka_robot/kr_dummy_Args.h"
#include "kuka_robot/kr_setdo_Args.h"
#include "kuka_robot/kr_batch_setdo_Args.h"
#include "kuka_robot/kr_set_accvel_Args.h"

#include "KukaRobotArm.h"

using namespace std;
using namespace ros;

KukaRobotArm krArm;

#define STATE_MEMBER_UPDATE_HZ			50

static bool readThreadAlive;

// Internal functions
/*static void cout_hex(unsigned char* buf, int buf_len)
{
	unsigned char* pRc= buf;
	for (int i=0; i < buf_len; i++)
		cout << hex << setfill('0') << setw(2) << (unsigned short)pRc[i] << " ";
	cout << endl;
}*/

// Export functions
bool kr_add(kuka_robot::kr_add_Args::Request  &req,
          kuka_robot::kr_add_Args::Response &res)
{
	res.sum = req.a + req.b;
	ROS_INFO("request: x=%ld, y=%ld", (long int)req.a, (long int)req.b);
	ROS_INFO("sending back response: [%ld]", (long int)res.sum);

	return true;
}

bool kr_read_var_raw(kuka_robot::kr_rwraw_Args::Request  &req,
          kuka_robot::kr_rwraw_Args::Response &res)
{
	string varname = req.name;
	string retstring;

	if (krArm.readVarFromKrc4(varname, &retstring))
	{
		ROS_INFO("Read var krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
	{
		std::stringstream ss;
		ss << varname << ":" << retstring;
		res.serialvalue = ss.str();
	}

	return true;
}

bool kr_write_var_raw(kuka_robot::kr_rwraw_Args::Request  &req,
          kuka_robot::kr_rwraw_Args::Response &res)
{
	string varname = req.name;
	string retstring;

	if (krArm.writeVarToKrc4(varname, req.value))
	{
		ROS_INFO("Write var krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
	{
		std::stringstream ss;
		ss << varname << ":" << retstring;
		res.serialvalue = ss.str();
	}

	return true;
}

bool kr_movj_bypose(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.moveJ(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movj_byjoint(kuka_robot::kr_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.moveJ(&joints);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else

		res.response = retval;

	return true;
}

bool kr_movl_bypose(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.moveL(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movl_byjoint(kuka_robot::kr_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.moveL(&joints);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movjrel_bypose(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.moveJRel(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movjrel_byjoint(kuka_robot::kr_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.moveJRel(&joints);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movlrel_bypose(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.moveLRel(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movjreltool_bypose(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.moveJRelTool(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movjreltool_byjoint(kuka_robot::kr_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.moveJRelTool(&joints);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_movlreltool_bypose(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.moveLRelTool(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_setdigitaloutput(kuka_robot::kr_setdo_Args::Request  &req,
          kuka_robot::kr_setdo_Args::Response &res)
{
	int retval;
	int mask = req.mask;
	int value = req.value;
	double settle_sec = req.settle_sec;

	retval = krArm.setDigitalOutput(mask, value, settle_sec);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}


bool kr_set_batch_movj_bypose(kuka_robot::kr_batch_mv_bypose_Args::Request  &req,
          kuka_robot::kr_batch_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;
	double round = req.round;
	int block = req.block;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.batchMoveJSetup(&pose, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movj_byjoint(kuka_robot::kr_batch_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_batch_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;
	double round = req.round;
	int block = req.block;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.batchMoveJSetup(&joints, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else

		res.response = retval;

	return true;
}

bool kr_set_batch_movl_bypose(kuka_robot::kr_batch_mv_bypose_Args::Request  &req,
          kuka_robot::kr_batch_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;
	double round = req.round;
	int block = req.block;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.batchMoveLSetup(&pose, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movl_byjoint(kuka_robot::kr_batch_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_batch_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;
	double round = req.round;
	int block = req.block;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.batchMoveLSetup(&joints, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movjrel_bypose(kuka_robot::kr_batch_mv_bypose_Args::Request  &req,
          kuka_robot::kr_batch_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;
	double round = req.round;
	int block = req.block;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.batchMoveJRelSetup(&pose, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movjrel_byjoint(kuka_robot::kr_batch_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_batch_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;
	double round = req.round;
	int block = req.block;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.batchMoveJRelSetup(&joints, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movlrel_bypose(kuka_robot::kr_batch_mv_bypose_Args::Request  &req,
          kuka_robot::kr_batch_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;
	double round = req.round;
	int block = req.block;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.batchMoveLRelSetup(&pose, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movjreltool_bypose(kuka_robot::kr_batch_mv_bypose_Args::Request  &req,
          kuka_robot::kr_batch_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;
	double round = req.round;
	int block = req.block;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.batchMoveJRelToolSetup(&pose, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movjreltool_byjoint(kuka_robot::kr_batch_mv_byjoint_Args::Request  &req,
          kuka_robot::kr_batch_mv_byjoint_Args::Response &res)
{
	int retval;
	E6AXIS joints;
	double round = req.round;
	int block = req.block;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.batchMoveJRelToolSetup(&joints, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_movlreltool_bypose(kuka_robot::kr_batch_mv_bypose_Args::Request  &req,
          kuka_robot::kr_batch_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;
	double round = req.round;
	int block = req.block;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.batchMoveLRelToolSetup(&pose, round, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_batch_setdigitaloutput(kuka_robot::kr_batch_setdo_Args::Request  &req,
          kuka_robot::kr_batch_setdo_Args::Response &res)
{
	int retval;
	int mask = req.mask;
	int value = req.value;
	double settle_sec = req.settle_sec;
	int block = req.block;

	retval = krArm.batchSetDigitalOutputSetup(mask, value, settle_sec, block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_batch_mov_run(kuka_robot::kr_batch_mv_run_Args::Request  &req,
          kuka_robot::kr_batch_mv_run_Args::Response &res)
{
	int retval;
	int start_block = req.start_block;
	int end_block = req.end_block;

	retval = krArm.batchMoveRun(start_block, end_block);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_rampdown_stop(kuka_robot::kr_rampstop_Args::Request  &req,
          kuka_robot::kr_rampstop_Args::Response &res)
{
	int retval;
	int mode = req.mode;

	retval = krArm.rampdown_stop(mode);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_check_mov_completed(kuka_robot::kr_dummy_Args::Request  &req,
          kuka_robot::kr_dummy_Args::Response &res)
{
	int retval = krArm.checkMotionCompleted();
	res.response = retval;

	if (retval < 0)
		return false;

	return true;
}

bool kr_set_speedscale(kuka_robot::kr_set_speed_scale_Args::Request  &req,
          kuka_robot::kr_set_speed_scale_Args::Response &res)
{
	int retval;
	int scale = req.scale;

	retval = krArm.setSpeedScale(scale);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_payload(kuka_robot::kr_set_load_Args::Request  &req,
          kuka_robot::kr_set_load_Args::Response &res)
{
	int retval;
	PAYLOAD load, load_a1, load_a2, load_a3;

	memset((void*)&load, 0, sizeof(load));
	memset((void*)&load_a1, 0, sizeof(load_a1));
	memset((void*)&load_a2, 0, sizeof(load_a2));
	memset((void*)&load_a3, 0, sizeof(load_a3));

	load.Mass = req.load.mass;
	load.CenterOfGravity.X = req.load.CenterOfGravity.X;
	load.CenterOfGravity.Y = req.load.CenterOfGravity.Y;
	load.CenterOfGravity.Z = req.load.CenterOfGravity.Z;
	load.CenterOfGravity.A = req.load.CenterOfGravity.A;
	load.CenterOfGravity.B = req.load.CenterOfGravity.B;
	load.CenterOfGravity.C = req.load.CenterOfGravity.C;
	load.Inertia.X = req.load.Inertia.X;
	load.Inertia.Y = req.load.Inertia.Y;
	load.Inertia.Z = req.load.Inertia.Z;

	load_a1.Mass = req.load_a1.mass;
	load_a1.CenterOfGravity.X = req.load_a1.CenterOfGravity.X;
	load_a1.CenterOfGravity.Y = req.load_a1.CenterOfGravity.Y;
	load_a1.CenterOfGravity.Z = req.load_a1.CenterOfGravity.Z;
	load_a1.CenterOfGravity.A = req.load_a1.CenterOfGravity.A;
	load_a1.CenterOfGravity.B = req.load_a1.CenterOfGravity.B;
	load_a1.CenterOfGravity.C = req.load_a1.CenterOfGravity.C;
	load_a1.Inertia.X = req.load_a1.Inertia.X;
	load_a1.Inertia.Y = req.load_a1.Inertia.Y;
	load_a1.Inertia.Z = req.load_a1.Inertia.Z;

	load_a2.Mass = req.load_a2.mass;
	load_a2.CenterOfGravity.X = req.load_a2.CenterOfGravity.X;
	load_a2.CenterOfGravity.Y = req.load_a2.CenterOfGravity.Y;
	load_a2.CenterOfGravity.Z = req.load_a2.CenterOfGravity.Z;
	load_a2.CenterOfGravity.A = req.load_a2.CenterOfGravity.A;
	load_a2.CenterOfGravity.B = req.load_a2.CenterOfGravity.B;
	load_a2.CenterOfGravity.C = req.load_a2.CenterOfGravity.C;
	load_a2.Inertia.X = req.load_a2.Inertia.X;
	load_a2.Inertia.Y = req.load_a2.Inertia.Y;
	load_a2.Inertia.Z = req.load_a2.Inertia.Z;

	load_a3.Mass = req.load_a3.mass;
	load_a3.CenterOfGravity.X = req.load_a3.CenterOfGravity.X;
	load_a3.CenterOfGravity.Y = req.load_a3.CenterOfGravity.Y;
	load_a3.CenterOfGravity.Z = req.load_a3.CenterOfGravity.Z;
	load_a3.CenterOfGravity.A = req.load_a3.CenterOfGravity.A;
	load_a3.CenterOfGravity.B = req.load_a3.CenterOfGravity.B;
	load_a3.CenterOfGravity.C = req.load_a3.CenterOfGravity.C;
	load_a3.Inertia.X = req.load_a3.Inertia.X;
	load_a3.Inertia.Y = req.load_a3.Inertia.Y;
	load_a3.Inertia.Z = req.load_a3.Inertia.Z;

	retval = krArm.setPayload(&load, &load_a1, &load_a2, &load_a3);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_base_coord(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.setBaseCoord(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_tool_coord(kuka_robot::kr_mv_bypose_Args::Request  &req,
          kuka_robot::kr_mv_bypose_Args::Response &res)
{
	int retval;
	POS pose;

	memset((void*)&pose, 0, sizeof(pose));
	pose.X = req.pose.X;
	pose.Y = req.pose.Y;
	pose.Z = req.pose.Z;
	pose.A = req.pose.A;
	pose.B = req.pose.B;
	pose.C = req.pose.C;
	pose.S = req.pose.S;
	pose.T = req.pose.T;
	retval = krArm.setToolCoord(&pose);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_cov_joints_to_pose(kuka_robot::kr_cov_joint_pose_Args::Request  &req,
          kuka_robot::kr_cov_joint_pose_Args::Response &res)
{
	int retval;
	POS pose;
	E6AXIS joints;

	memset((void*)&joints, 0, sizeof(joints));
	joints.A1 = req.joints.A1;
	joints.A2 = req.joints.A2;
	joints.A3 = req.joints.A3;
	joints.A4 = req.joints.A4;
	joints.A5 = req.joints.A5;
	joints.A6 = req.joints.A6;
	retval = krArm.convertJointsToPose(&pose, &joints);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
	{
		res.response = retval;
		res.pose.X = pose.X;
		res.pose.Y = pose.Y;
		res.pose.Z = pose.Z;
		res.pose.A = pose.A;
		res.pose.B = pose.B;
		res.pose.C = pose.C;
		res.pose.S = pose.S;
		res.pose.T = pose.T;
	}

	return true;
}

bool kr_set_default_accvel(kuka_robot::kr_set_accvel_Args::Request  &req,
          kuka_robot::kr_set_accvel_Args::Response &res)
{
	int retval;
	double acc = req.acc;
	double acc_swivel = req.acc_swivel;
	double acc_rot = req.acc_rot;
	double vel = req.vel;
	double vel_swivel = req.vel_swivel;
	double vel_rot = req.vel_rot;

	retval = krArm.setDefaultAccVel(acc, acc_swivel, acc_rot, vel, vel_swivel, vel_rot);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_set_default_round(kuka_robot::kr_set_real_Args::Request  &req,
          kuka_robot::kr_set_real_Args::Response &res)
{
	int retval;
	double round = req.number;

	retval = krArm.setDefaultMoveRound(round);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}

bool kr_start_autoext_mode(kuka_robot::kr_dummy_Args::Request  &req,
          kuka_robot::kr_dummy_Args::Response &res)
{
	int retval = krArm.startAutoExternalMode();
	res.response = retval;
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}

	return true;
}

bool kr_set_moveenable_signal(kuka_robot::kr_set_bool_Args::Request  &req,
          kuka_robot::kr_set_bool_Args::Response &res)
{
	int retval;
	bool state = req.state;

	retval = krArm.setMoveEnableSignal(state);
	if (retval)
	{
		ROS_INFO("Send command to krc4[%s] failed.", krArm.krc4_ipAddress.c_str());
		return false;
	}
	else
		res.response = retval;

	return true;
}



// Thread and main function
static void readVar_thread(ros::NodeHandle n)
{
	kuka_robot::kr_robot_state_Type msg;

	// Register Publish Topics (stream/pipe data), FIFO size = 5 //3
	ros::Publisher pub = n.advertise<kuka_robot::kr_robot_state_Type>("kr_state", 5);
	ros::Rate loop_rate(STATE_MEMBER_UPDATE_HZ);
	ROS_INFO("Start publishing kuka robot arm states.");

	while (ros::ok())
	{
		msg.timestamp = ros::Time::now().toSec();
		if (krArm.updateAllMember() != 0)
		{
			ROS_INFO("Problem on communication to KR! Shutdown KR node.");
			ros::shutdown();
			break;
		}

		msg.pos_setpt.X = krArm.pos_act.X;
		msg.pos_setpt.Y = krArm.pos_act.Y;
		msg.pos_setpt.Z = krArm.pos_act.Z;
		msg.pos_setpt.A = krArm.pos_act.A;
		msg.pos_setpt.B = krArm.pos_act.B;
		msg.pos_setpt.C = krArm.pos_act.C;
		msg.pos_setpt.S = krArm.pos_act.S;
		msg.pos_setpt.T = krArm.pos_act.T;

		msg.pos_fb.X = krArm.pos_act_mes.X;
		msg.pos_fb.Y = krArm.pos_act_mes.Y;
		msg.pos_fb.Z = krArm.pos_act_mes.Z;
		msg.pos_fb.A = krArm.pos_act_mes.A;
		msg.pos_fb.B = krArm.pos_act_mes.B;
		msg.pos_fb.C = krArm.pos_act_mes.C;
		msg.pos_fb.S = krArm.pos_act_mes.S;
		msg.pos_fb.T = krArm.pos_act_mes.T;

		msg.axis_setpt.A1 = krArm.axis_act.A1;
		msg.axis_setpt.A2 = krArm.axis_act.A2;
		msg.axis_setpt.A3 = krArm.axis_act.A3;
		msg.axis_setpt.A4 = krArm.axis_act.A4;
		msg.axis_setpt.A5 = krArm.axis_act.A5;
		msg.axis_setpt.A6 = krArm.axis_act.A6;

		msg.axis_fb.A1 = krArm.axis_act_meas.A1;
		msg.axis_fb.A2 = krArm.axis_act_meas.A2;
		msg.axis_fb.A3 = krArm.axis_act_meas.A3;
		msg.axis_fb.A4 = krArm.axis_act_meas.A4;
		msg.axis_fb.A5 = krArm.axis_act_meas.A5;
		msg.axis_fb.A6 = krArm.axis_act_meas.A6;

		msg.dist_next = krArm.dist_next;
		msg.vel_act = krArm.vel_act;

		for (int i=0; i<6; i++)
		{
			msg.vel_axis_act[i] = krArm.vel_axis_act[i];
			msg.curr_act[i] = krArm.curr_act[i];
			msg.mot_temp[i] = krArm.mot_temp[i];
		}

		msg.brake_sig = krArm.brake_sig;
		msg.com_action = krArm.com_action;
		msg.com_motstop = krArm.com_motstop;
		msg.com_last_mot_time = krArm.com_last_mot_time;
		msg.com_move_enable = krArm.com_move_enable;
		msg.com_autext_start = krArm.com_autext_start;
		msg.com_error_no = krArm.com_error_no;
		msg.com_alarm_normal = krArm.com_alarm_normal;

		msg.com_di_port_value = krArm.com_di_port_value;
		msg.com_do_port_value = krArm.com_do_port_value;

		msg.mode_op = krArm.mode_op;
		msg.ov_pro = krArm.ov_pro;
		msg.power_fail = krArm.power_fail;

		pub.publish(msg);
		loop_rate.sleep();
	}

	readThreadAlive = false;
}

int main(int argc, char **argv)
{
	string krc4Address;

	// Initialize ros
	ros::init(argc, argv, "kuka_robot_server");
	ros::NodeHandle n("~");
	if (!n.hasParam("hostname"))
		ROS_INFO("Cannot get hostname from param server!");
	n.param("hostname", krc4Address, std::string("127.0.0.1")); // kr1:172.31.1.147

	// Establish connection with krc4
	ROS_INFO("Connecting to krc4[%s] ...", krc4Address.c_str());
	if (krArm.connectKrc4(krc4Address))
	{
		ROS_INFO("Connecting to krc4[%s] failed. Unable to run kuka_robot_server!", krc4Address.c_str());
		return -1;
	}
	else
		ROS_INFO("Connected to krc4[%s] successfully.", krc4Address.c_str());

	// Register Publish Topics (stream/pipe data)
	// Start readVar_thread sync status with kuka robot arm
	readThreadAlive = true;
	std::thread rt(readVar_thread, n);

	// Register services (function calls)
	ros::ServiceServer service100 = n.advertiseService("kr_add", kr_add);
	ros::ServiceServer service101 = n.advertiseService("kr_rraw", kr_read_var_raw);
	ros::ServiceServer service102 = n.advertiseService("kr_wraw", kr_write_var_raw);

	ros::ServiceServer service0 = n.advertiseService("kr_movj_bypose", kr_movj_bypose);
	ros::ServiceServer service1 = n.advertiseService("kr_movj_byjoint", kr_movj_byjoint);
	ros::ServiceServer service2 = n.advertiseService("kr_movl_bypose", kr_movl_bypose);
	ros::ServiceServer service3 = n.advertiseService("kr_movl_byjoint", kr_movl_byjoint);
	ros::ServiceServer service4 = n.advertiseService("kr_movjrel_bypose", kr_movjrel_bypose);
	ros::ServiceServer service5 = n.advertiseService("kr_movjrel_byjoint", kr_movjrel_byjoint);
	ros::ServiceServer service6 = n.advertiseService("kr_movlrel_bypose", kr_movlrel_bypose);
	ros::ServiceServer service7 = n.advertiseService("kr_movjreltool_bypose", kr_movjreltool_bypose);
	ros::ServiceServer service8 = n.advertiseService("kr_movjreltool_byjoint", kr_movjreltool_byjoint);
	ros::ServiceServer service9 = n.advertiseService("kr_movlreltool_bypose", kr_movlreltool_bypose);
	ros::ServiceServer service10 = n.advertiseService("kr_setdigitaloutput", kr_setdigitaloutput);

	ros::ServiceServer service0b = n.advertiseService("kr_set_batch_movj_bypose", kr_set_batch_movj_bypose);
	ros::ServiceServer service1b = n.advertiseService("kr_set_batch_movj_byjoint", kr_set_batch_movj_byjoint);
	ros::ServiceServer service2b = n.advertiseService("kr_set_batch_movl_bypose", kr_set_batch_movl_bypose);
	ros::ServiceServer service3b = n.advertiseService("kr_set_batch_movl_byjoint", kr_set_batch_movl_byjoint);
	ros::ServiceServer service4b = n.advertiseService("kr_set_batch_movjrel_bypose", kr_set_batch_movjrel_bypose);
	ros::ServiceServer service5b = n.advertiseService("kr_set_batch_movjrel_byjoint", kr_set_batch_movjrel_byjoint);
	ros::ServiceServer service6b = n.advertiseService("kr_set_batch_movlrel_bypose", kr_set_batch_movlrel_bypose);
	ros::ServiceServer service7b = n.advertiseService("kr_set_batch_movjreltool_bypose", kr_set_batch_movjreltool_bypose);
	ros::ServiceServer service8b = n.advertiseService("kr_set_batch_movjreltool_byjoint", kr_set_batch_movjreltool_byjoint);
	ros::ServiceServer service9b = n.advertiseService("kr_set_batch_movlreltool_bypose", kr_set_batch_movlreltool_bypose);
	ros::ServiceServer service10b = n.advertiseService("kr_set_batch_setdigitaloutput", kr_set_batch_setdigitaloutput);
	ros::ServiceServer service11b = n.advertiseService("kr_batch_mov_run", kr_batch_mov_run);

	ros::ServiceServer service30 = n.advertiseService("kr_rampdown_stop", kr_rampdown_stop);
	ros::ServiceServer service31 = n.advertiseService("kr_check_mov_completed", kr_check_mov_completed);
	ros::ServiceServer service32 = n.advertiseService("kr_set_speedscale", kr_set_speedscale);
	ros::ServiceServer service33 = n.advertiseService("kr_set_payload", kr_set_payload);
	ros::ServiceServer service34 = n.advertiseService("kr_set_base_coord", kr_set_base_coord);
	ros::ServiceServer service35 = n.advertiseService("kr_set_tool_coord", kr_set_tool_coord);
	ros::ServiceServer service36 = n.advertiseService("kr_conv_joints_to_pose", kr_cov_joints_to_pose);
	ros::ServiceServer service37 = n.advertiseService("kr_set_default_accvel", kr_set_default_accvel);
	ros::ServiceServer service38 = n.advertiseService("kr_set_default_round", kr_set_default_round);
	ros::ServiceServer service39 = n.advertiseService("kr_start_autoext_mode", kr_start_autoext_mode);
	ros::ServiceServer service40 = n.advertiseService("kr_set_moveenable_signal", kr_set_moveenable_signal);

	ROS_INFO("Ready to command kuka robot arm.");

	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(4);
	spinner.spin();
	// Wait readvar_thread close
	rt.join();
	// Close connection with krc4
	if (krArm.disconnectKrc4())
		ROS_INFO("Disconnect with krc4[%s] failed.", krc4Address.c_str());
	else
		ROS_INFO("Disconnected with krc4[%s] successfully.", krc4Address.c_str());

	return 0;
}
