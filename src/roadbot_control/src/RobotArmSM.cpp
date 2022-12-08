#include <assert.h>
#include <iostream>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "RobotArmSM.h"

// external event
void RobotArmSM::OnUpdateRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
    kr_state_accesskey.lock();
	robotArmState = msg;
    kr_state_accesskey.unlock();

	// Identify autoext mode ok event
	if (robotArmState->com_autext_start == true)
	{
		if (currentState == ST_DISABLE)
			ExternalEvent(ST_IDLE, NULL);
	}

/*	// Identify motion disabled event
	if (robotArmState->com_move_enable == false)
	{
	}*/

	// Identify emergency stop case being activated
	IsEmergencyStopActivatedPrev = IsEmergencyStopActivated;
	if ((robotArmState->com_error_no > 0) && (robotArmState->com_error_no < 100))
		IsEmergencyStopActivated = true;
	else
		IsEmergencyStopActivated = false;

	// Identify stop state in robot arm (usually by external control), not handle >2 (stop but don't stop auto control)
	if (robotArmState->com_motstop == 2)
	{
		if ((currentState != ST_STOP) && (currentState != ST_IDLE))
			ExternalEvent(ST_STOP, NULL);
	}
	// Identify pause event (due to error / user trigger)
	else if (robotArmState->com_motstop == 1)
	{
		if (currentState != ST_PAUSE)
		{
			if (IsEmergencyStopActivated)
				ROS_INFO("RobotArmSM[%s]: Emergency Stop Activated at state=%d, kr err=%ld!", armName.c_str(), currentState, robotArmState->com_error_no);
			else if (robotArmState->com_error_no != 0)
				ROS_INFO("RobotArmSM[%s]: Pause by error at state=%d, kr err=%ld!", armName.c_str(), currentState, robotArmState->com_error_no);

			ExternalEvent(ST_PAUSE, NULL);
		}
	}
	// Identify resume event
	else if ((robotArmState->com_motstop == 0) && (robotArmState->com_error_no == 0))
	{
		// TBD: can be stop selected but fail to catch signal, now use more stop() or use stopautocontrol()
		// TBD: or com_action !=0 or motion complete with motion time > 0
		if (currentState == ST_PAUSE)
			ExternalEvent(ST_RESUME, NULL);
	}

	// Identify if hit boundary event
	if (checkHitBoundaryZone())
    {
		if ((currentState != ST_STOP) && (currentState != ST_IDLE))
		{
			ROS_INFO("RobotArmSM[%s]: Hit boundary zone at state=%d! Stop.", armName.c_str(), currentState);
			ExternalEvent(ST_STOP, NULL);
		}
    }

	// Identify motion complete event
	if ((robotArmState->com_action == 0) && ((ros::Time::now().toSec() - previousMotionCmdTimestamp) > 0.15))
    {
		if (currentState == ST_HOME)
			ExternalEvent(ST_IDLE, NULL);
		else if (currentState == ST_DEMO)
			ExternalEvent(ST_IDLE, NULL);
    }

}

// external event
void RobotArmSM::OnUpdateArmDetectorState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
    arm_lt_state_accesskey.lock();
	armDetectState = msg;
    arm_lt_state_accesskey.unlock();
}

// external event
void RobotArmSM::cmdResumeMove()
{
	kuka_robot::kr_rampstop_Args srv;
	srv.request.mode = 0;
	kr_rampdown_stop.call(srv);

	ROS_INFO("RobotArmSM[%s]: sent resume command.", armName.c_str());
}


// external event
void RobotArmSM::disableHWMoveSignal()
{
	kuka_robot::kr_set_bool_Args srv;
	srv.request.state = false;
	kr_set_moveenable_signal.call(srv);

	if (currentState != ST_STOP)
		ExternalEvent(ST_STOP, NULL);
	ROS_INFO("RobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

// external event
void RobotArmSM::stopAutoControl()
{
	if (currentState != ST_STOP)
		ExternalEvent(ST_STOP, NULL);
	ROS_INFO("RobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

// external event
void RobotArmSM::goHome(void)
{
	Route* pRoute = searchRouteByName("Home");

	// Download all waypoints for home to batch blocks
	if (pRoute != NULL)
	{
		// First point should be MovJByJoint.
		if (pRoute->waypoints[0].BATCH_ACTION != MOVJ_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("RobotArmSM[%s]: goHome - first point should be MovjByJoints.", armName.c_str());
			return;
		}
	}
	else
	{
		ROS_INFO("RobotArmSM[%s]: goHome - missing route info/definitation.", armName.c_str());
		return;
	}

	if (currentState == ST_IDLE)
		ExternalEvent(ST_HOME, NULL);
	ROS_INFO("RobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

// external event
void RobotArmSM::goDemo(Route* pRoute)
{
	// Download all waypoints for demo to batch blocks
	if (pRoute == NULL)
		pRoute = searchRouteByName("Demo");

	if (pRoute != NULL)
		setRouteBatch(pRoute, ROBOTARM_CUSTOM_BATCH_START_BLKNO);
	else
	{
		ROS_INFO("RobotArmSM[%s]: goDemo - missing route info/definitation.", armName.c_str());
		return;
	}

	if (currentState == ST_IDLE)
		ExternalEvent(ST_DEMO, NULL);
	ROS_INFO("RobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

// external event
void RobotArmSM::goConePlacement()
{
}

// external event
void RobotArmSM::goConeCollection()
{
}


bool RobotArmSM::checkHitBoundaryZone()
{
	ROS_INFO("RobotArmSM[%s]: No defined boundary zone.", armName.c_str());
	return false;
}

double RobotArmSM::calLinProfileTime(double distToGo, double acc, double vel, double* pmaxVel)
{
	// Only for byPose and linear move profile, in m, m/s, m/s2
	double time_without_vel = sqrt(4 * distToGo / acc);
	double fvel = time_without_vel / 2 * acc;

	if (fvel < vel)
	{
		*pmaxVel = fvel;
		return time_without_vel;
	}

	*pmaxVel = vel;

	double t1 = vel / acc;
	double dist_in_t1 = vel * t1 / 2;
	double dist_in_vel = distToGo - dist_in_t1 * 2;
	double t2 = dist_in_vel / vel;

	return t1 + t2 + t1;
}

double RobotArmSM::calLinProfileTimeWithSpeedScale(double distToGo, double acc, double vel, double* pmaxVel)
{
	// Only for byPose and linear move profile, in m, m/s, m/s2
	double scale = robotArmState->ov_pro / 100.0;
	double scaled_acc = acc * (scale * scale);
	return calLinProfileTime(distToGo, scaled_acc, vel, pmaxVel) + ROBOTARM_SHORTEST_JERK_TIME_SEC;
}

double RobotArmSM::calLinProfileTimeToDest(double destX, double destY, double destZ, double acc, double vel, double* pmaxVel)
{
	// Show motion info (only by pose linear move), in mm, m/s, m/s2
	kr_state_accesskey.lock();
	double dx = (robotArmState->pos_setpt.X - destX) / 1000.0;
	double dy = (robotArmState->pos_setpt.Y - destY) / 1000.0;
	double dz = (robotArmState->pos_setpt.Z - destZ) / 1000.0;
	double distToGo = sqrt(dx*dx + dy*dy + dz*dz);
	double scale = robotArmState->ov_pro / 100.0;
	double scaled_acc = acc * (scale * scale);
	kr_state_accesskey.unlock();
	return calLinProfileTime(distToGo, scaled_acc, vel, pmaxVel) + ROBOTARM_SHORTEST_JERK_TIME_SEC;
}

void RobotArmSM::getCurrentGripPointPosition_mm(double* gripPointX, double* gripPointY, double* gripPointZ)
{
	// If not set robot tcp, use coordinate rotation to offset from flange TCP to tool TCP
	// Rotation through angle A about the Z axis
	// Rotation through angle B about the Y axis
	// Rotation through angle C about the X axis
	kr_state_accesskey.lock();
	double offsetx = 0;//ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM * cos(robotArmState->pos_setpt.B/180.0*M_PI);
	double offsety = 0;//ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM * cos(robotArmState->pos_setpt.C/180.0*M_PI);
	double offsetz = 0;//ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM * cos(robotArmState->pos_setpt.A/180.0*M_PI);
	*gripPointX = robotArmState->pos_setpt.X + offsetx;
	*gripPointY = robotArmState->pos_setpt.Y + offsety;
	*gripPointZ = robotArmState->pos_setpt.Z + offsetz;
    kr_state_accesskey.unlock();
}

double RobotArmSM::calPointDist(double Point1X, double Point1Y, double Point1Z,double Point2X, double Point2Y, double Point2Z)
{
	double dx = (Point1X - Point2X);
	double dy = (Point1Y - Point2Y);
	double dz = (Point1Z - Point2Z);
	return sqrt(dx*dx + dy*dy + dz*dz);
}

double RobotArmSM::calPointDistToRobotArmGripPoint_mm(double PointX_mm, double PointY_mm, double PointZ_mm)
{
	// Cal position of the current grip point with current tcp plus grip angle and offset = 163mm
	double gpt_tcpx;
	double gpt_tcpy;
	double gpt_tcpz;
	getCurrentGripPointPosition_mm(&gpt_tcpx, &gpt_tcpy, &gpt_tcpz);

	return calPointDist(gpt_tcpx, gpt_tcpy, gpt_tcpz, PointX_mm, PointY_mm, PointZ_mm);
}

double RobotArmSM::calPointDistToRobotArmGripPoint2D_mm(double PointX_mm, double PointY_mm)
{
	// Cal position of the current grip point with current tcp plus grip angle and offset = 163mm
	double gpt_tcpx;
	double gpt_tcpy;
	double gpt_tcpz;
	getCurrentGripPointPosition_mm(&gpt_tcpx, &gpt_tcpy, &gpt_tcpz);

	return calPointDist(gpt_tcpx, gpt_tcpy, 0, PointX_mm, PointY_mm, 0);
}

Route* RobotArmSM::searchRouteByName(string name)
{
	for (int i=0; i<Routes.size(); i++)
	{
		if (Routes[i].name == name)
			return &Routes[i];
	}
	return NULL;
}

int RobotArmSM::setRouteBatch(Route* route, int startBlockNum)
{
	previousDLCustomBatchStartBlkno = previousDLCustomBatchEndBlkno = 0;

	if (route == NULL)
	{
		ROS_INFO("RobotArmSM[%s]: Empty route.", armName.c_str());
		return -1;
	}

	int numOfWaypoints = route->waypoints.size();
	if (numOfWaypoints < 1)
	{
		ROS_INFO("RobotArmSM[%s]: Invalid route %s: numOfWaypoints=%d", armName.c_str(), route->name.c_str(), numOfWaypoints);
		return -2;
	}

	int blockNum = startBlockNum;
	for (int i=0; i<numOfWaypoints; i++)
	{
		if (route->waypoints[i].BATCH_ACTION == MOVJ_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovjbyJoints[%d]...", blockNum);
			kuka_robot::kr_batch_mv_byjoint_Args srv;
			srv.request.joints.A1 = route->waypoints[i].BATCH_E6AXIS.A1;
			srv.request.joints.A2 = route->waypoints[i].BATCH_E6AXIS.A2;
			srv.request.joints.A3 = route->waypoints[i].BATCH_E6AXIS.A3;
			srv.request.joints.A4 = route->waypoints[i].BATCH_E6AXIS.A4;
			srv.request.joints.A5 = route->waypoints[i].BATCH_E6AXIS.A5;
			srv.request.joints.A6 = route->waypoints[i].BATCH_E6AXIS.A6;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movj_byjoint.call(srv))
				ROS_INFO("kr_set_batch_movj_byjoint returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVJ_BYPOSE_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovjbyPose[%d]...", blockNum);
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = route->waypoints[i].BATCH_POS.X;
			srv.request.pose.Y = route->waypoints[i].BATCH_POS.Y;
			srv.request.pose.Z = route->waypoints[i].BATCH_POS.Z;
			srv.request.pose.A = route->waypoints[i].BATCH_POS.A;
			srv.request.pose.B = route->waypoints[i].BATCH_POS.B;
			srv.request.pose.C = route->waypoints[i].BATCH_POS.C;
			srv.request.pose.S = route->waypoints[i].BATCH_POS.S;
			srv.request.pose.T = route->waypoints[i].BATCH_POS.T;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
//			ROS_INFO("movj(XYZ)[%d]:%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f", srv.request.block, srv.request.pose.X, srv.request.pose.Y, srv.request.pose.Z,
//					srv.request.pose.A, srv.request.pose.B, srv.request.pose.C, srv.request.pose.S, srv.request.pose.T, srv.request.round);
			if (!kr_set_batch_movj_bypose.call(srv))
				ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVL_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovlbyJoints[%d]...", blockNum);
			kuka_robot::kr_batch_mv_byjoint_Args srv;
			srv.request.joints.A1 = route->waypoints[i].BATCH_E6AXIS.A1;
			srv.request.joints.A2 = route->waypoints[i].BATCH_E6AXIS.A2;
			srv.request.joints.A3 = route->waypoints[i].BATCH_E6AXIS.A3;
			srv.request.joints.A4 = route->waypoints[i].BATCH_E6AXIS.A4;
			srv.request.joints.A5 = route->waypoints[i].BATCH_E6AXIS.A5;
			srv.request.joints.A6 = route->waypoints[i].BATCH_E6AXIS.A6;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movl_byjoint.call(srv))
				ROS_INFO("kr_set_batch_movl_byjoint returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVL_BYPOSE_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovlbyPose[%d]...", blockNum);
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = route->waypoints[i].BATCH_POS.X;
			srv.request.pose.Y = route->waypoints[i].BATCH_POS.Y;
			srv.request.pose.Z = route->waypoints[i].BATCH_POS.Z;
			srv.request.pose.A = route->waypoints[i].BATCH_POS.A;
			srv.request.pose.B = route->waypoints[i].BATCH_POS.B;
			srv.request.pose.C = route->waypoints[i].BATCH_POS.C;
			srv.request.pose.S = route->waypoints[i].BATCH_POS.S;
			srv.request.pose.T = route->waypoints[i].BATCH_POS.T;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movl_bypose.call(srv))
				ROS_INFO("kr_set_batch_movl_bypose returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVJREL_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovjrelbyJoints[%d]...", blockNum);
			kuka_robot::kr_batch_mv_byjoint_Args srv;
			srv.request.joints.A1 = route->waypoints[i].BATCH_E6AXIS.A1;
			srv.request.joints.A2 = route->waypoints[i].BATCH_E6AXIS.A2;
			srv.request.joints.A3 = route->waypoints[i].BATCH_E6AXIS.A3;
			srv.request.joints.A4 = route->waypoints[i].BATCH_E6AXIS.A4;
			srv.request.joints.A5 = route->waypoints[i].BATCH_E6AXIS.A5;
			srv.request.joints.A6 = route->waypoints[i].BATCH_E6AXIS.A6;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movjrel_byjoint.call(srv))
				ROS_INFO("kr_set_batch_movjrel_byjoint returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVJREL_BYPOSE_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovjrelbyPose[%d]...", blockNum);
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = route->waypoints[i].BATCH_POS.X;
			srv.request.pose.Y = route->waypoints[i].BATCH_POS.Y;
			srv.request.pose.Z = route->waypoints[i].BATCH_POS.Z;
			srv.request.pose.A = route->waypoints[i].BATCH_POS.A;
			srv.request.pose.B = route->waypoints[i].BATCH_POS.B;
			srv.request.pose.C = route->waypoints[i].BATCH_POS.C;
			srv.request.pose.S = route->waypoints[i].BATCH_POS.S;
			srv.request.pose.T = route->waypoints[i].BATCH_POS.T;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movjrel_bypose.call(srv))
				ROS_INFO("kr_set_batch_movjrel_bypose returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVLREL_BYPOSE_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovlrelbyPose[%d]...", blockNum);
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = route->waypoints[i].BATCH_POS.X;
			srv.request.pose.Y = route->waypoints[i].BATCH_POS.Y;
			srv.request.pose.Z = route->waypoints[i].BATCH_POS.Z;
			srv.request.pose.A = route->waypoints[i].BATCH_POS.A;
			srv.request.pose.B = route->waypoints[i].BATCH_POS.B;
			srv.request.pose.C = route->waypoints[i].BATCH_POS.C;
			srv.request.pose.S = route->waypoints[i].BATCH_POS.S;
			srv.request.pose.T = route->waypoints[i].BATCH_POS.T;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movlrel_bypose.call(srv))
				ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVJRELTOOL_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovjreltoolbyJoints[%d]...", blockNum);
			kuka_robot::kr_batch_mv_byjoint_Args srv;
			srv.request.joints.A1 = route->waypoints[i].BATCH_E6AXIS.A1;
			srv.request.joints.A2 = route->waypoints[i].BATCH_E6AXIS.A2;
			srv.request.joints.A3 = route->waypoints[i].BATCH_E6AXIS.A3;
			srv.request.joints.A4 = route->waypoints[i].BATCH_E6AXIS.A4;
			srv.request.joints.A5 = route->waypoints[i].BATCH_E6AXIS.A5;
			srv.request.joints.A6 = route->waypoints[i].BATCH_E6AXIS.A6;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movjreltool_byjoint.call(srv))
				ROS_INFO("kr_set_batch_movjreltool_byjoint returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVJRELTOOL_BYPOSE_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovjreltoolbyPose[%d]...", blockNum);
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = route->waypoints[i].BATCH_POS.X;
			srv.request.pose.Y = route->waypoints[i].BATCH_POS.Y;
			srv.request.pose.Z = route->waypoints[i].BATCH_POS.Z;
			srv.request.pose.A = route->waypoints[i].BATCH_POS.A;
			srv.request.pose.B = route->waypoints[i].BATCH_POS.B;
			srv.request.pose.C = route->waypoints[i].BATCH_POS.C;
			srv.request.pose.S = route->waypoints[i].BATCH_POS.S;
			srv.request.pose.T = route->waypoints[i].BATCH_POS.T;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movjreltool_bypose.call(srv))
				ROS_INFO("kr_set_batch_movjreltool_bypose returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == MOVLRELTOOL_BYPOSE_ACTION_TYPE)
		{
			ROS_INFO("SetBatchMovlreltoolbyPose[%d]...", blockNum);
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = route->waypoints[i].BATCH_POS.X;
			srv.request.pose.Y = route->waypoints[i].BATCH_POS.Y;
			srv.request.pose.Z = route->waypoints[i].BATCH_POS.Z;
			srv.request.pose.A = route->waypoints[i].BATCH_POS.A;
			srv.request.pose.B = route->waypoints[i].BATCH_POS.B;
			srv.request.pose.C = route->waypoints[i].BATCH_POS.C;
			srv.request.pose.S = route->waypoints[i].BATCH_POS.S;
			srv.request.pose.T = route->waypoints[i].BATCH_POS.T;
			srv.request.round = route->waypoints[i].BATCH_ROUNDM;
			srv.request.block = blockNum++;
			if (!kr_set_batch_movlreltool_bypose.call(srv))
				ROS_INFO("kr_set_batch_movlreltool_bypose returned error: %ld", (long int)srv.response.response);
		}
		else if (route->waypoints[i].BATCH_ACTION == DO_ACTION_TYPE)
		{
			ROS_INFO("SetBatchSetdigitaloutput[%d]...", blockNum);
			kuka_robot::kr_batch_setdo_Args srv;
			srv.request.value = route->waypoints[i].DO_VALUE;
			srv.request.mask = route->waypoints[i].DO_MASK;
			srv.request.settle_sec = route->waypoints[i].DO_SETSEC;
			srv.request.block = blockNum++;
			if (!kr_set_batch_setdigitaloutput.call(srv))
				ROS_INFO("kr_set_batch_setdigitaloutput returned error: %ld", (long int)srv.response.response);
		}
		else
		{
			ROS_INFO("RobotArmSM[%s]: Unknown %s: numOfWaypoints=%ld action[%d]=%d", armName.c_str(), route->name.c_str(), route->waypoints.size(), i, route->waypoints[i].BATCH_ACTION);
			return -3;
		}
	}

	previousDLCustomBatchStartBlkno = startBlockNum;
	previousDLCustomBatchEndBlkno = blockNum-1;
	return blockNum-1;
}

int RobotArmSM::runRouteBatch(int startBlockNum, int endBlockNum)
{
	if (startBlockNum > endBlockNum)
	{
		ROS_INFO("RobotArmSM[%s]: Invalid startBlockNum %d and endBlockNum %d", armName.c_str(), startBlockNum, endBlockNum);
		return -1;
	}

//	ROS_INFO("RunBatchMov...");
	previousMotionCmdTimestamp = ros::Time::now().toSec();
	kuka_robot::kr_batch_mv_run_Args srv;
	srv.request.start_block = startBlockNum;
	srv.request.end_block = endBlockNum;
	if (!kr_batch_mov_run.call(srv))
		ROS_INFO("kr_batch_mov_run returned error: %ld", (long int)srv.response.response);

	return 0;
}

int RobotArmSM::runRouteSingle(Route* route, int blockNum)
{
	if (route == NULL)
	{
		ROS_INFO("RobotArmSM[%s]: Empty route.", armName.c_str());
		return -1;
	}

	if (blockNum >= route->waypoints.size())
	{
		ROS_INFO("RobotArmSM[%s]: Invalid blockNum %d for %s: numOfWaypoints=%ld", armName.c_str(), blockNum, route->name.c_str(), route->waypoints.size());
		return -2;
	}

	if (route->waypoints[blockNum].BATCH_ACTION == MOVJ_BYJOINTS_ACTION_TYPE)
	{
		ROS_INFO("MovjbyJoints...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_byjoint_Args srv;
		srv.request.joints.A1 = route->waypoints[blockNum].BATCH_E6AXIS.A1;
		srv.request.joints.A2 = route->waypoints[blockNum].BATCH_E6AXIS.A2;
		srv.request.joints.A3 = route->waypoints[blockNum].BATCH_E6AXIS.A3;
		srv.request.joints.A4 = route->waypoints[blockNum].BATCH_E6AXIS.A4;
		srv.request.joints.A5 = route->waypoints[blockNum].BATCH_E6AXIS.A5;
		srv.request.joints.A6 = route->waypoints[blockNum].BATCH_E6AXIS.A6;
//		ROS_INFO("movj(A1-A6):%.3f,%.3f,%.3f,%.3f,%.3f,%.3f", srv.request.joints.A1, srv.request.joints.A2, srv.request.joints.A3,
//				srv.request.joints.A4, srv.request.joints.A5, srv.request.joints.A6);
		if (!kr_movj_byjoint.call(srv))
			ROS_INFO("kr_movj_byjoint returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVJ_BYPOSE_ACTION_TYPE)
	{
		ROS_INFO("MovjbyPose...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = route->waypoints[blockNum].BATCH_POS.X;
		srv.request.pose.Y = route->waypoints[blockNum].BATCH_POS.Y;
		srv.request.pose.Z = route->waypoints[blockNum].BATCH_POS.Z;
		srv.request.pose.A = route->waypoints[blockNum].BATCH_POS.A;
		srv.request.pose.B = route->waypoints[blockNum].BATCH_POS.B;
		srv.request.pose.C = route->waypoints[blockNum].BATCH_POS.C;
		srv.request.pose.S = route->waypoints[blockNum].BATCH_POS.S;
		srv.request.pose.T = route->waypoints[blockNum].BATCH_POS.T;
//		ROS_INFO("movj(XYZ):%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f", srv.request.pose.X, srv.request.pose.Y, srv.request.pose.Z,
//				srv.request.pose.A, srv.request.pose.B, srv.request.pose.C, srv.request.pose.S, srv.request.pose.T);
		if (!kr_movj_bypose.call(srv))
			ROS_INFO("kr_movj_bypose returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVL_BYJOINTS_ACTION_TYPE)
	{
		ROS_INFO("MovlbyJoints...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_byjoint_Args srv;
		srv.request.joints.A1 = route->waypoints[blockNum].BATCH_E6AXIS.A1;
		srv.request.joints.A2 = route->waypoints[blockNum].BATCH_E6AXIS.A2;
		srv.request.joints.A3 = route->waypoints[blockNum].BATCH_E6AXIS.A3;
		srv.request.joints.A4 = route->waypoints[blockNum].BATCH_E6AXIS.A4;
		srv.request.joints.A5 = route->waypoints[blockNum].BATCH_E6AXIS.A5;
		srv.request.joints.A6 = route->waypoints[blockNum].BATCH_E6AXIS.A6;
		if (!kr_movl_byjoint.call(srv))
			ROS_INFO("kr_movl_byjoint returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVL_BYPOSE_ACTION_TYPE)
	{
		ROS_INFO("MovlbyPose...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = route->waypoints[blockNum].BATCH_POS.X;
		srv.request.pose.Y = route->waypoints[blockNum].BATCH_POS.Y;
		srv.request.pose.Z = route->waypoints[blockNum].BATCH_POS.Z;
		srv.request.pose.A = route->waypoints[blockNum].BATCH_POS.A;
		srv.request.pose.B = route->waypoints[blockNum].BATCH_POS.B;
		srv.request.pose.C = route->waypoints[blockNum].BATCH_POS.C;
		srv.request.pose.S = route->waypoints[blockNum].BATCH_POS.S;
		srv.request.pose.T = route->waypoints[blockNum].BATCH_POS.T;
		if (!kr_movl_bypose.call(srv))
			ROS_INFO("kr_movl_bypose returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVJREL_BYJOINTS_ACTION_TYPE)
	{
		ROS_INFO("MovjrelbyJoints...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_byjoint_Args srv;
		srv.request.joints.A1 = route->waypoints[blockNum].BATCH_E6AXIS.A1;
		srv.request.joints.A2 = route->waypoints[blockNum].BATCH_E6AXIS.A2;
		srv.request.joints.A3 = route->waypoints[blockNum].BATCH_E6AXIS.A3;
		srv.request.joints.A4 = route->waypoints[blockNum].BATCH_E6AXIS.A4;
		srv.request.joints.A5 = route->waypoints[blockNum].BATCH_E6AXIS.A5;
		srv.request.joints.A6 = route->waypoints[blockNum].BATCH_E6AXIS.A6;
		if (!kr_movjrel_byjoint.call(srv))
			ROS_INFO("kr_movjrel_byjoint returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVJREL_BYPOSE_ACTION_TYPE)
	{
		ROS_INFO("MovjrelbyPose...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = route->waypoints[blockNum].BATCH_POS.X;
		srv.request.pose.Y = route->waypoints[blockNum].BATCH_POS.Y;
		srv.request.pose.Z = route->waypoints[blockNum].BATCH_POS.Z;
		srv.request.pose.A = route->waypoints[blockNum].BATCH_POS.A;
		srv.request.pose.B = route->waypoints[blockNum].BATCH_POS.B;
		srv.request.pose.C = route->waypoints[blockNum].BATCH_POS.C;
		srv.request.pose.S = route->waypoints[blockNum].BATCH_POS.S;
		srv.request.pose.T = route->waypoints[blockNum].BATCH_POS.T;
		if (!kr_movjrel_bypose.call(srv))
			ROS_INFO("kr_movjrel_bypose returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVLREL_BYPOSE_ACTION_TYPE)
	{
		ROS_INFO("MovlrelbyPose...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = route->waypoints[blockNum].BATCH_POS.X;
		srv.request.pose.Y = route->waypoints[blockNum].BATCH_POS.Y;
		srv.request.pose.Z = route->waypoints[blockNum].BATCH_POS.Z;
		srv.request.pose.A = route->waypoints[blockNum].BATCH_POS.A;
		srv.request.pose.B = route->waypoints[blockNum].BATCH_POS.B;
		srv.request.pose.C = route->waypoints[blockNum].BATCH_POS.C;
		srv.request.pose.S = route->waypoints[blockNum].BATCH_POS.S;
		srv.request.pose.T = route->waypoints[blockNum].BATCH_POS.T;
		if (!kr_movlrel_bypose.call(srv))
			ROS_INFO("kr_movlrel_bypose returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVJRELTOOL_BYJOINTS_ACTION_TYPE)
	{
		ROS_INFO("MovjreltoolbyJoints...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_byjoint_Args srv;
		srv.request.joints.A1 = route->waypoints[blockNum].BATCH_E6AXIS.A1;
		srv.request.joints.A2 = route->waypoints[blockNum].BATCH_E6AXIS.A2;
		srv.request.joints.A3 = route->waypoints[blockNum].BATCH_E6AXIS.A3;
		srv.request.joints.A4 = route->waypoints[blockNum].BATCH_E6AXIS.A4;
		srv.request.joints.A5 = route->waypoints[blockNum].BATCH_E6AXIS.A5;
		srv.request.joints.A6 = route->waypoints[blockNum].BATCH_E6AXIS.A6;
		if (!kr_movjreltool_byjoint.call(srv))
			ROS_INFO("kr_movjreltool_byjoint returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVJRELTOOL_BYPOSE_ACTION_TYPE)
	{
		ROS_INFO("MovjreltoolbyPose...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = route->waypoints[blockNum].BATCH_POS.X;
		srv.request.pose.Y = route->waypoints[blockNum].BATCH_POS.Y;
		srv.request.pose.Z = route->waypoints[blockNum].BATCH_POS.Z;
		srv.request.pose.A = route->waypoints[blockNum].BATCH_POS.A;
		srv.request.pose.B = route->waypoints[blockNum].BATCH_POS.B;
		srv.request.pose.C = route->waypoints[blockNum].BATCH_POS.C;
		srv.request.pose.S = route->waypoints[blockNum].BATCH_POS.S;
		srv.request.pose.T = route->waypoints[blockNum].BATCH_POS.T;
		if (!kr_movjreltool_bypose.call(srv))
			ROS_INFO("kr_movjreltool_bypose returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == MOVLRELTOOL_BYPOSE_ACTION_TYPE)
	{
		ROS_INFO("MovlreltoolbyPose...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = route->waypoints[blockNum].BATCH_POS.X;
		srv.request.pose.Y = route->waypoints[blockNum].BATCH_POS.Y;
		srv.request.pose.Z = route->waypoints[blockNum].BATCH_POS.Z;
		srv.request.pose.A = route->waypoints[blockNum].BATCH_POS.A;
		srv.request.pose.B = route->waypoints[blockNum].BATCH_POS.B;
		srv.request.pose.C = route->waypoints[blockNum].BATCH_POS.C;
		srv.request.pose.S = route->waypoints[blockNum].BATCH_POS.S;
		srv.request.pose.T = route->waypoints[blockNum].BATCH_POS.T;
		if (!kr_movlreltool_bypose.call(srv))
			ROS_INFO("kr_movlreltool_bypose returned error: %ld", (long int)srv.response.response);
	}
	else if (route->waypoints[blockNum].BATCH_ACTION == DO_ACTION_TYPE)
	{
		ROS_INFO("Setdigitaloutput...");
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		kuka_robot::kr_setdo_Args srv;
		srv.request.value = route->waypoints[blockNum].DO_VALUE;
		srv.request.mask = route->waypoints[blockNum].DO_MASK;
		srv.request.settle_sec = route->waypoints[blockNum].DO_SETSEC;
		if (!kr_setdigitaloutput.call(srv))
			ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
	}
	else
	{
		ROS_INFO("RobotArmSM[%s]: Unknown %s: numOfWaypoints=%ld action[%d]=%d", armName.c_str(), route->name.c_str(), route->waypoints.size(), blockNum, route->waypoints[blockNum].BATCH_ACTION);
		return -3;
	}

	return 0;
}

void RobotArmSM::UpdateCmdTimestampIfChangeOfState()
{
	// Update current state cmd timestamp for extending motion complete check
	if (previousState != currentState)
	{
		previousMotionCmdTimestamp = ros::Time::now().toSec();
		ROS_INFO("RobotArmSM[%s]: Update Motion Cmd Timestamp with state change from %d->%d.", armName.c_str(), previousState, currentState);
	}
}

void RobotArmSM::ST_Disable(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Disable");
}

void RobotArmSM::ST_Idle(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Idle");
}

void RobotArmSM::ST_Stop(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Stop");

	// 1. From Any state to stop state then idle state. 2. Stop robot if not stopped
	if (robotArmState->com_motstop != 2)
	{
		kuka_robot::kr_rampstop_Args srv;
		srv.request.mode = 2;
		if (!kr_rampdown_stop.call(srv))
			ROS_INFO("kr_rampdown_stop returned error: %ld", (long int)srv.response.response);
	}

	// transition to ST_IDLE via an internal event whatever states after command robot arm stop
	InternalEvent(ST_IDLE);
}

void RobotArmSM::ST_Pause(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Pause");
	previousStateBeforePause = previousState;
	ROS_INFO("RobotArmSM[%s]: Saved state before pause = %d.", armName.c_str(), previousStateBeforePause);
}

void RobotArmSM::ST_Resume(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Resume");
	if (previousStateBeforePause != CANNOT_HAPPEN)
	{
		ROS_INFO("RobotArmSM[%s]: Resume state = %d.", armName.c_str(), previousStateBeforePause);
//		InternalEvent(previousStateBeforePause);		// no re-do state, only resume previous state variable
	    previousState = currentState;
	    currentState = previousStateBeforePause;
		previousStateBeforePause = CANNOT_HAPPEN;
	}
	else
		ROS_INFO("RobotArmSM: Error on resume state!");
}

void RobotArmSM::ST_Error(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Error");
}

void RobotArmSM::ST_Home(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Home");

	Route* pRoute = searchRouteByName("Home");

	// Insert first point with A1 not moving (with current A1)
	kr_state_accesskey.lock();
	double curr_A1 = robotArmState->axis_setpt.A1;
	kr_state_accesskey.unlock();
	kuka_robot::kr_batch_mv_byjoint_Args srv;
	srv.request.joints.A1 = curr_A1;
	srv.request.joints.A2 = pRoute->waypoints[0].BATCH_E6AXIS.A2;
	srv.request.joints.A3 = pRoute->waypoints[0].BATCH_E6AXIS.A3;
	srv.request.joints.A4 = pRoute->waypoints[0].BATCH_E6AXIS.A4;
	srv.request.joints.A5 = pRoute->waypoints[0].BATCH_E6AXIS.A5;
	srv.request.joints.A6 = pRoute->waypoints[0].BATCH_E6AXIS.A6;
	srv.request.round = 0;
	srv.request.block = ROBOTARM_CUSTOM_BATCH_START_BLKNO;
	if (!kr_set_batch_movj_byjoint.call(srv))
		ROS_INFO("kr_set_batch_movj_byjoint returned error: %ld", (long int)srv.response.response);

	// Append the preset waypoints to first block
	int endBlkno = setRouteBatch(pRoute, ROBOTARM_CUSTOM_BATCH_START_BLKNO+1);

	// previousDLCustomBatchStartBlkno, previousDLCustomBatchEndBlkno altered by setRouteBatch()
	// If downloaded all routes for demo to batch blocks
	if ((previousDLCustomBatchStartBlkno > 0) && (previousDLCustomBatchEndBlkno > 0))
	{
		runRouteBatch(ROBOTARM_CUSTOM_BATCH_START_BLKNO, endBlkno);
		previousDLCustomBatchStartBlkno = previousDLCustomBatchEndBlkno = 0;
	}
}

void RobotArmSM::ST_Demo(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_Demo");

//	Route* pRoute = searchRouteByName("Demo");
//	int endBlockNum = ROBOTARM_CUSTOM_BATCH_START_BLKNO + pRoute->waypoints.size() - 1;
//	runRouteBatch(ROBOTARM_CUSTOM_BATCH_START_BLKNO, endBlockNum);

	// Pre-requisites: downloaded all routes for demo to batch blocks
	if ((previousDLCustomBatchStartBlkno > 0) && (previousDLCustomBatchEndBlkno > 0))
	{
		runRouteBatch(previousDLCustomBatchStartBlkno, previousDLCustomBatchEndBlkno);
		previousDLCustomBatchStartBlkno = previousDLCustomBatchEndBlkno = 0;
	}
}

void RobotArmSM::ST_ConePlacementInitPose(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_ConePlacementInitPose");
}

void RobotArmSM::ST_ConeCollectionInitPose(RobotArmEventData* pData)
{
	ROS_INFO("RobotArmSM::ST_ConeCollectionInitPose");
}

