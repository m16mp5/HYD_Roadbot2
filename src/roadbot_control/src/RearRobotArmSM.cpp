#include <assert.h>
#include <sstream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <cmath>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "RearRobotArmSM.h"


#define ARM_A5_TO_REF_RADIUS_MM							1880.0
#define ARM_A5_TO_FLANGE_LEN_MM							170.0
#define ARM_REF_TO_TCP_LEN_MM							(ARM_A5_TO_FLANGE_LEN_MM + ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM)
#define ARM_TCP_LIMIT_X_MM								1350.0
#define ARM_TCP_LIMIT_Y_MM								1400.0

#define LID_MIN_X_M										0.100	// avoid lock lidar themselves, in lidar/detector space and unit
#define AUTO_TARGET_SELECT_LID_MIN_X_M					LID_MIN_X_M	//0.600	//0.25
#define AUTO_TARGET_SELECT_LID_LIMIT_Y_M				((ARM_TCP_LIMIT_Y_MM+50.0)/1000.0)

#define COLLECTTRACE_MAX_ARM_GRIP_MM					(ARM_A5_TO_REF_RADIUS_MM + ARM_REF_TO_TCP_LEN_MM)
#define COLLECTTRACE_SHORTEST_TIMETOGRIP				ROBOTARM_SHORTEST_JERK_TIME_SEC		// in sec, from experiment of jerk of kr60
#define COLLECTTRACE_CORRECT_TOL_MM						50.0	//100.0	//50.0
#define COLLECTTRACE_STANDBYFRLMT_DIST_MM				150.0	//200.0	//300.0
#define COLLECTTRACE_TRACENOUPD_DIST_MM					COLLECTTRACE_STANDBYFRLMT_DIST_MM

#define COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC				0.1		//0.5
#define COLLECTTRACE_MIN_OBJ_ACC						0.075		// in m/s2
#define COLLECTTRACE_MIN_OBJ_VEL						0.0254		// in m/s
#define COLLECTTRACE_PREDICTSCAN_TRIAL					100
#define COLLECTTRACE_CMD_DELAY_SEC						0.20	//0.28	//0.25 (setting at 26Jun TKO) //0.30 //0.28		// delay time form controller to arm exec
#define COLLECTTRACE_MAX_MOTION_DETLA_SEC				0.01

#define CATCH_COMPMOV_TCP_LIMIT_X_MM					(ARM_TCP_LIMIT_X_MM + 100.0)	//20.0)

#define ARM_GRIP_CONE_DIST_M							0.270	//0.150	//0.300 //0.270
#define ARM_GRIP_STOP_BASE_DIST_M						0.170
#define ARM_GRIP_STOP_REACTION_TIME_SEC					(0.15+0.35) //(0.15+0.15)	//0.11 //Stop reaction + grip closing time

#define AUTOLOCK_RELOCK_FAR_DIST_M						5.0
#define AUTOLOCK_RELOCK_STABLE_TIME_SEC					3.0


RearRobotArmSM::RearRobotArmSM() : calData_rearDetectToRearRobotTCP_Angle(0), calData_rearDetectToRearRobotTCP_OffsetX(0),
			calData_rearDetectToRearRobotTCP_OffsetY(0),
			targetObjectID(0), targetFused(0), targetAge(0),
			conePlaceInitPoseBatchStartBlkNum(0), conePlaceInitPoseBatchEndBlkNum(0),
			conePlaceLLBExitFloorBatchStartBlkNum(0), conePlaceLLBExitFloorBatchEndBlkNum(0),
			conePlaceLLBPickBatchStartBlkNum(0), conePlaceLLBPickBatchEndBlkNum(0),
			conePlaceRLBExitFloorBatchStartBlkNum(0), conePlaceRLBExitFloorBatchEndBlkNum(0),
			conePlaceRLBPickBatchStartBlkNum(0), conePlaceRLBPickBatchEndBlkNum(0),
			conePlaceLLBFloorBatchStartBlkNum(0), conePlaceLLBFloorBatchEndBlkNum(0),
			conePlaceRLBFloorBatchStartBlkNum(0), conePlaceRLBFloorBatchEndBlkNum(0),
			coneCollectInitPoseBatchStartBlkNum(0), coneCollectInitPoseBatchEndBlkNum(0),
			coneCollectAimBatchStartBlkNum(0),coneCollectAimBatchEndBlkNum(0),
			coneCollectTraceGripEntryBatchStartBlkNum(0), coneCollectTraceGripEntryBatchEndBlkNum(0),
			coneCollectConeGripBatchStartBlkNum(0), coneCollectConeGripBatchEndBlkNum(0),
			coneCollectGripUpBatchStartBlkNum(0), coneCollectGripUpBatchEndBlkNum(0),
			coneCollectWaitLBPoseBatchStartBlkNum(0), coneCollectWaitLBPoseBatchEndBlkNum(0),
			coneCollectLLBFillBatchStartBlkNum(0), coneCollectLLBFillBatchEndBlkNum(0),
			coneCollectRLBFillBatchStartBlkNum(0), coneCollectRLBFillBatchEndBlkNum(0),
			coneCollectLLBExitBatchStartBlkNum(0), coneCollectLLBExitBatchEndBlkNum(0),
			coneCollectRLBExitBatchStartBlkNum(0), coneCollectRLBExitBatchEndBlkNum(0),
			coneCollectConeGripFailBatchStartBlkNum(0), coneCollectConeGripFailBatchEndBlkNum(0),
			PlacementConeChainTemplate(0), PlacementConeChainCurrIndex(0), CollectionConeAmount(0), CollectionConeCount(0),
			frontArmCurrTCP_X(0), frontArmCurrTCP_Y(0), frontArmCurrTCP_Z(0),
			left_loadingbay_reararmtcp_pos_x(0), left_loadingbay_reararmtcp_pos_y(0),
			right_loadingbay_reararmtcp_pos_x(0), right_loadingbay_reararmtcp_pos_y(0),
			left_loadingbay_reararmtcp_pos_z(0), right_loadingbay_reararmtcp_pos_z(0),
			pLoadingBaySM(0), cycleStartTimeStamp(0),
			collectFloorZHeight(170), collectCatchCanReach(0), collectCancelCmdCount(0),
			placementRefToLineMode(0), collectAtStationary(false),
			rearDetectObjectInDeadZone(false), rearDetectObjectInPlaceZoneRight(false),
			rearDetectObjectInPlaceZoneCenter(false), rearDetectObjectInPlaceZoneLeft(false),
			rearDetectNonLockObjectInOperationZone(false),
			roadmarkLineX(1550.0), roadmarkLineY(0), armDetectObjectInGrip(false),
			standPlaceLLBInitPoseBatchStartBlkNum(0),
			standPlaceLLBInitPoseBatchEndBlkNum(0),
			standPlaceLLBPickBatchStartBlkNum(0),
			standPlaceLLBPickBatchEndBlkNum(0),
			standPlaceLLBFloorBatchStartBlkNum(0),
			standPlaceLLBFloorBatchEndBlkNum(0),
			standPlaceRLBInitPoseBatchStartBlkNum(0),
			standPlaceRLBInitPoseBatchEndBlkNum(0),
			standPlaceRLBPickBatchStartBlkNum(0),
			standPlaceRLBPickBatchEndBlkNum(0),
			standPlaceRLBFloorBatchStartBlkNum(0),
			standPlaceRLBFloorBatchEndBlkNum(0),
			standPlaceRLB2InitPoseBatchStartBlkNum(0),
			standPlaceRLB2InitPoseBatchEndBlkNum(0),
			standPlaceRLB2PickBatchStartBlkNum(0),
			standPlaceRLB2PickBatchEndBlkNum(0),
			standPlaceRLB2FloorBatchStartBlkNum(0),
			standPlaceRLB2FloorBatchEndBlkNum(0),
			standCollectInitPoseBatchStartBlkNum(0),
			standCollectInitPoseBatchEndBlkNum(0),
			standCollectTraceGripEntryBatchStartBlkNum(0),
			standCollectTraceGripEntryBatchEndBlkNum(0),
			standCollectStandGripBatchStartBlkNum(0),
			standCollectStandGripBatchEndBlkNum(0),
			standCollectLLBFillBatchStartBlkNum(0),
			standCollectLLBFillBatchEndBlkNum(0),
			standCollectRLBFillBatchStartBlkNum(0),
			standCollectRLBFillBatchEndBlkNum(0),
			standCollectRLB2FillBatchStartBlkNum(0),
			standCollectRLB2FillBatchEndBlkNum(0),
			signPlaceLBInitPoseBatchStartBlkNum(0),
			signPlaceLBInitPoseBatchEndBlkNum(0),
			signPlaceLBPickBatchStartBlkNum(0),
			signPlaceLBPickBatchEndBlkNum(0),
			signPlaceLBFloorBatchStartBlkNum(0),
			signPlaceLBFloorBatchEndBlkNum(0),
			signCollectInitPoseBatchStartBlkNum(0),
			signCollectInitPoseBatchEndBlkNum(0),
			signCollectTraceGripEntryBatchStartBlkNum(0),
			signCollectTraceGripEntryBatchEndBlkNum(0),
			signCollectSignGripBatchStartBlkNum(0),
			signCollectSignGripBatchEndBlkNum(0),
			signCollectLBFillBatchStartBlkNum(0),
			signCollectLBFillBatchEndBlkNum(0),
			signStandPosX(0), signStandPosY(0), signStandLBLocation(0)

{
	_maxStates = ST_REARARM_MAX_STATES;

	autolockTh = thread(autolockThreadRun, this);
	lineTrackTh = thread(lineTrackThreadRun, this);
}

RearRobotArmSM::~RearRobotArmSM()
{
	autolockTh.join();
	lineTrackTh.join();
}

void RearRobotArmSM::loadLBBasePosition()
{
	Route* pBase_Pos = searchRouteByName("LB_Base_Position");
	if (pBase_Pos == NULL)
	{
		ROS_INFO("Missing route definition - LB_Base_Position.");
		return;
	}
	left_loadingbay_reararmtcp_pos_x = pBase_Pos->waypoints[0].BATCH_POS.X;
	left_loadingbay_reararmtcp_pos_y = pBase_Pos->waypoints[0].BATCH_POS.Y;
	left_loadingbay_reararmtcp_pos_z = pBase_Pos->waypoints[0].BATCH_POS.Z;
	right_loadingbay_reararmtcp_pos_x = pBase_Pos->waypoints[1].BATCH_POS.X;
	right_loadingbay_reararmtcp_pos_y = pBase_Pos->waypoints[1].BATCH_POS.Y;
	right_loadingbay_reararmtcp_pos_z = pBase_Pos->waypoints[1].BATCH_POS.Z;
}

void RearRobotArmSM::coord_FrontRobotArm_RobotArmTCP(double fa_x, double fa_y, double fa_z, double* ra_x, double* ra_y, double* ra_z)
{
	*ra_x = -(fa_x) + pLoadingBaySM->left_loadingbay_frontarmtcp_pos_x + left_loadingbay_reararmtcp_pos_x;
	*ra_y = -(fa_y) + pLoadingBaySM->left_loadingbay_frontarmtcp_pos_y + left_loadingbay_reararmtcp_pos_y;
	*ra_z = fa_z - pLoadingBaySM->left_loadingbay_frontarmtcp_pos_z + left_loadingbay_reararmtcp_pos_z;
}

bool RearRobotArmSM::checkHitBoundaryZone()
{
	// Checking condition for each arm / installation
	kr_state_accesskey.lock();
	double tcpx = robotArmState->pos_fb.X;
	double tcpy = robotArmState->pos_fb.Y;
	double tcpz = robotArmState->pos_fb.Z;
	kr_state_accesskey.unlock();

	if ((tcpx == 0) && (tcpy == 0) && (tcpz == 0))
		return false;

/*	if ((tcpx < -330.0) && (abs(tcpy) > 1200.0))
	{
		ROS_INFO("Rear Arm hit when x < -330.0mm, y > +-1200.0mm.");
		return true;
	}

	if ((tcpz < 550.0) && (tcpx < 800.0))
	{
		ROS_INFO("Rear Arm hit when z < 550mm, x < 800.0mm.");
		return true;
	}*/

	if ((frontArmCurrTCP_X != 0) && (frontArmCurrTCP_Y != 0) && (frontArmCurrTCP_Z != 0) &&
		(tcpx != 0) && (tcpy != 0) && (tcpz != 0))
	{
		double fa_tcpx, fa_tcpy, fa_tcpz, dist;
		coord_FrontRobotArm_RobotArmTCP(frontArmCurrTCP_X, frontArmCurrTCP_Y, frontArmCurrTCP_Z, &fa_tcpx, &fa_tcpy, &fa_tcpz);
		dist = calPointDist(tcpx, tcpy, tcpz, fa_tcpx, fa_tcpy, fa_tcpz);
		if (dist <= 500.0)
		{
			ROS_INFO("Rear Arm very close (500.0mm) to Front Arm grip point.");
			return true;
		}
	}

	return false;
}

bool RearRobotArmSM::checkOperationZone(double grip_x_mm, double grip_y_mm)
{
	if (ARM_TCP_LIMIT_X_MM > grip_x_mm)
		return false;

	if (ARM_TCP_LIMIT_Y_MM < abs(grip_y_mm))
		return false;

	double baseToA5_x = grip_x_mm - ARM_REF_TO_TCP_LEN_MM;
	double a5Radius = sqrt(baseToA5_x*baseToA5_x + grip_y_mm*grip_y_mm);
	if (ARM_A5_TO_REF_RADIUS_MM < a5Radius)
		return false;

	return true;
}

void RearRobotArmSM::calProjectedStandbyZone(double obj_y_mm, double* grip_x_mm, double* grip_y_mm)
{
	if (abs(obj_y_mm) > ARM_TCP_LIMIT_Y_MM)
	{
		if (obj_y_mm < 0)
			obj_y_mm = -ARM_TCP_LIMIT_Y_MM;
		else
			obj_y_mm = ARM_TCP_LIMIT_Y_MM;
	}
	double x_mm = sqrt((ARM_A5_TO_REF_RADIUS_MM * ARM_A5_TO_REF_RADIUS_MM) - (obj_y_mm * obj_y_mm));
	*grip_x_mm = x_mm + ARM_REF_TO_TCP_LEN_MM - COLLECTTRACE_STANDBYFRLMT_DIST_MM;
	if (*grip_x_mm < ARM_TCP_LIMIT_X_MM)
		*grip_x_mm = ARM_TCP_LIMIT_X_MM;
	*grip_y_mm = obj_y_mm;
}

void RearRobotArmSM::coord_RearDetect_RobotArmTCP(double lmm_x, double lmm_y, double lmm_z, double* amm_x, double* amm_y)
{
	double cos_ang = cos(calData_rearDetectToRearRobotTCP_Angle);
	double sin_ang = sin(calData_rearDetectToRearRobotTCP_Angle);

	if (lmm_z < 0)
		lmm_y = -lmm_y;

	double rot_lmm_x = lmm_x*cos_ang - lmm_y*sin_ang;
	double rot_lmm_y = lmm_x*sin_ang + lmm_y*cos_ang;

	*amm_x = rot_lmm_x + calData_rearDetectToRearRobotTCP_OffsetX;
	*amm_y = rot_lmm_y + calData_rearDetectToRearRobotTCP_OffsetY;
}

void RearRobotArmSM::orient_RearDetect_RobotArmTCP(double l_x, double l_y, double l_z, double* a_x, double* a_y)
{
	double cos_ang = cos(calData_rearDetectToRearRobotTCP_Angle);
	double sin_ang = sin(calData_rearDetectToRearRobotTCP_Angle);

	if (l_z < 0)
		l_y = -l_y;

	*a_x = l_x*cos_ang - l_y*sin_ang;
	*a_y = l_x*sin_ang + l_y*cos_ang;
}

// external event
void RearRobotArmSM::OnUpdateRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
	RobotArmSM::OnUpdateRobotArmState(msg);

	// Identify motion complete event
	if ((robotArmState->com_action == 0) && ((ros::Time::now().toSec() - previousMotionCmdTimestamp) > 0.15))
    {
		// given event, transition to a new state based upon
		// the current state of the state machine
		BEGIN_TRANSITION_MAP   // - New State -						|- Current State -
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_DISABLE
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_IDLE
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_STOP
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_PAUSE
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_RESUME
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_ERROR
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_HOME
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_DEMO

			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITLBREADY)			// ST_CONEPLACE_INITPOSE
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITLBREADY)			// ST_CONEPLACE_WAITLBREADY, idle polling peripheral
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITFORCOND)			// ST_CONEPLACE_LBPICK
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITFORCOND)			// ST_CONEPLACE_FLOOREXITLBPICK
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITFORCOND)			// ST_CONEPLACE_WAITFORCOND, idle polling peripheral
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_COMPLETED)			// ST_CONEPLACE_FLOOR
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_INITPOSE)			// ST_CONEPLACE_COMPLETED

			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_AIM)				// ST_CONECOLLECT_INITPOSE
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_TRACEGRIPENTRY)	// ST_CONECOLLECT_AIM
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_CONECOLLECT_TRACEGRIPENTRY, by sensor event
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_GRIPUP)			// ST_CONECOLLECT_CONEGRIP
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_CHECKGRIPOK)		// ST_CONECOLLECT_GRIPUP
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_CONECOLLECT_CHECKGRIPOK, by sensor event
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_WAITLBREADY)		// ST_CONECOLLECT_WAITLBPOSE
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_WAITLBREADY)		// ST_CONECOLLECT_WAITLBREADY, idle polling peripheral
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_COMPLETED)			// ST_CONECOLLECT_LBFILL
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_AIM)				// ST_CONECOLLECT_LOST
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_AIM)				// ST_CONECOLLECT_CONEGRIPFAIL
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_AIM)				// ST_CONECOLLECT_COMPLETED

			TRANSITION_MAP_ENTRY (ST_SAFEHOME_CHECKGRIPCENTEREXIT)	// ST_SAFEHOME_HANDLEREARSIDE
			TRANSITION_MAP_ENTRY (ST_SAFEHOME_CHECKGRIPCENTEREXIT)	// ST_SAFEHOME_HANDLETRUCKSIDE
			TRANSITION_MAP_ENTRY (ST_HOME)							// ST_SAFEHOME_CHECKGRIPCENTEREXIT

			TRANSITION_MAP_ENTRY (ST_STANDPLACE_WAITLBREADY)		// ST_STANDPLACE_INITPOSE
			TRANSITION_MAP_ENTRY (ST_STANDPLACE_LBPICK)				// ST_STANDPLACE_WAITLBREADY
			TRANSITION_MAP_ENTRY (ST_STANDPLACE_WAITFORCOND)		// ST_STANDPLACE_LBPICK
			TRANSITION_MAP_ENTRY (ST_STANDPLACE_FLOOR)				// ST_STANDPLACE_WAITFORCOND
			TRANSITION_MAP_ENTRY (ST_STANDPLACE_COMPLETED)			// ST_STANDPLACE_FLOOR
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_STANDPLACE_COMPLETED

			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_AIM)				// ST_STANDCOLLECT_INITPOSE
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_TRACEGRIPENTRY)	// ST_STANDCOLLECT_AIM
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_STANDGRIP)		// ST_STANDCOLLECT_TRACEGRIPENTRY
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_GRIPUP)			// ST_STANDCOLLECT_STANDGRIP
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_WAITLBPOSE)		// ST_STANDCOLLECT_GRIPUP
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_WAITLBREADY)		// ST_STANDCOLLECT_WAITLBPOSE
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_LBFILL)			// ST_STANDCOLLECT_WAITLBREADY
			TRANSITION_MAP_ENTRY (ST_STANDCOLLECT_COMPLETED)		// ST_STANDCOLLECT_LBFILL
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_STANDCOLLECT_COMPLETED

			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNPLACE_INITPOSE
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNPLACE_WAITLBREADY
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNPLACE_LBPICK
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNPLACE_WAITFORCOND
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNPLACE_FLOOR
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNPLACE_COMPLETED

			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_INITPOSE
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_AIM
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_TRACEGRIPENTRY
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_SIGNGRIP
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_GRIPUP
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_WAITLBPOSE
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_WAITLBREADY
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_LBFILL
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_SIGNCOLLECT_COMPLETED
		END_TRANSITION_MAP(NULL)
    }
}

// external event
void RearRobotArmSM::OnUpdateArmDetectorState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
	RobotArmSM::OnUpdateArmDetectorState(msg);

	double middle_distX1 = msg->columnscan_up_dist[3];
	double middle_distX2 = msg->columnscan_up_dist[4];
	double middle_distX3 = msg->columnscan_down_dist[3];
	double middle_distX4 = msg->columnscan_down_dist[4];
	if ( ((middle_distX1 > 0) && (middle_distX1 <= ARM_GRIP_CONE_DIST_M)) ||
			((middle_distX2 > 0) && (middle_distX2 <= ARM_GRIP_CONE_DIST_M)) ||
			((middle_distX3 > 0) && (middle_distX3 <= ARM_GRIP_CONE_DIST_M)) ||
			((middle_distX4 > 0) && (middle_distX4 <= ARM_GRIP_CONE_DIST_M)) )
		armDetectObjectInGrip = true;
	else
		armDetectObjectInGrip = false;

	// Identify cone reached grip during going to grip (1)
	if (currentState == ST_CONECOLLECT_CONEGRIP)
	{
	    rear_lt_state_accesskey.lock();
		double objAtDetector_vx = targetObjectVelAtLid.X;			// in m/s
		double objAtDetector_vy = targetObjectVelAtLid.Y;			// in m/s
	    rear_lt_state_accesskey.unlock();
	    // TBD: include also the arm speed
		double objSpeedXComp_m = (/*arm_speed*/ -objAtDetector_vx) * ARM_GRIP_STOP_REACTION_TIME_SEC;
		double grip_stop_threshold_dist = ARM_GRIP_STOP_BASE_DIST_M + objSpeedXComp_m;

		if ( ((middle_distX1 > 0) && (middle_distX1 <= grip_stop_threshold_dist)) ||
				((middle_distX2 > 0) && (middle_distX2 <= grip_stop_threshold_dist)) )
		{
			ROS_INFO("Rear Arm sensor detected cone reached gripper. Can go earlier to grip up? Thres=%.3f,Up grip[3,4]=%.3f,%.3f.",
					grip_stop_threshold_dist, msg->columnscan_up_dist[3], msg->columnscan_up_dist[4]);

			if (collectCancelCmdCount == 0)
			{
				collectCancelCmdCount++;
				kuka_robot::kr_rampstop_Args srv;
				srv.request.mode = 3;				// Special mode cancel motion without notify ac
				if (!kr_rampdown_stop.call(srv))
					ROS_INFO("kr_rampdown_stop returned error: %ld", (long int)srv.response.response);

				ROS_INFO("Catch cancel stop triggered.");
			}
		}
	}

	// Check grip ok or not
	// TBD: Read twice to confirm / allow sensor update reflecting the latest case
	if (currentState == ST_CONECOLLECT_CHECKGRIPOK)
	{
		if (armDetectObjectInGrip)
		{
			ROS_INFO("Rear Arm sensor detected cone in gripper, up grip[3,4]=%.3f,%.3f.",
					msg->columnscan_up_dist[3], msg->columnscan_up_dist[4]);

			// check if LB is ready and reserved
//			RobotArmEventData* psmData = new RobotArmEventData();
			RobotArmEventData smData;
			smData.cmd = pLoadingBaySM->getReadyLB_CollectToLoad();
			if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
				ExternalEvent(ST_CONECOLLECT_LBFILL, NULL);	// set state and do move
			else
				ExternalEvent(ST_CONECOLLECT_WAITLBPOSE, NULL);
		}
		else
		{
			ROS_INFO("Rear Arm sensor detected cone NOT in gripper, up grip[3,4]=%.3f,%.3f.",
					msg->columnscan_up_dist[3], msg->columnscan_up_dist[4]);

			ExternalEvent(ST_CONECOLLECT_CONEGRIPFAIL, NULL);
		}
	}

	// Identify grip have incline angle with target event

    // Identify grip off-center event
}

// external event
void RearRobotArmSM::OnUpdateRearDetectorState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
    rear_lt_state_accesskey.lock();
	rearDetectState = msg;
    int targetObjectIndex = getObjectIndexByID(targetObjectID);
	// Update info if having target locked
	if (targetObjectIndex >= 0)
	{
		targetFused = rearDetectState->objects[targetObjectIndex].Is_Fused;
		double existTimestamp = rearDetectState->objects[targetObjectIndex].IDTimestamp;
		targetAge = rearDetectState->timestamp - existTimestamp;

		double objAtLid_x, objAtLid_y;
		double objAtArmTCP_x, objAtArmTCP_y;
		getObjectPositionInRobotSpace(targetObjectIndex, 0, 0, 0, &objAtLid_x, &objAtLid_y, &objAtArmTCP_x, &objAtArmTCP_y);
		targetObjectPose.X = objAtArmTCP_x;
		targetObjectPose.Y = objAtArmTCP_y;
		targetObjectPose.Z = 0.0;

		targetObjectPoseAtLid.X = objAtLid_x;											// in mm
		targetObjectPoseAtLid.Y = objAtLid_y;											// in mm
		targetObjectPoseAtLid.Z = 0.0;
		targetObjectVelAtLid.X = rearDetectState->objects[targetObjectIndex].Est_Vel.x;	// in m/s
		targetObjectVelAtLid.Y = rearDetectState->objects[targetObjectIndex].Est_Vel.y;	// in m/s
		targetObjectVelAtLid.Z = 0.0;
		targetObjectAccAtLid.X = rearDetectState->objects[targetObjectIndex].Est_Acc.x;	// in m/s2
		targetObjectAccAtLid.Y = rearDetectState->objects[targetObjectIndex].Est_Acc.y;	// in m/s2
		targetObjectAccAtLid.Z = 0.0;
	}
	else
	{
		targetObjectID = 0;
		targetObjectPose.X = 0.0;
		targetObjectPose.Y = 0.0;
		targetObjectPose.Z = 0.0;

		targetObjectPoseAtLid.X = 0;
		targetObjectPoseAtLid.Y = 0;
		targetObjectPoseAtLid.Z = 0.0;
		targetObjectVelAtLid.X = 0;
		targetObjectVelAtLid.Y = 0;
		targetObjectVelAtLid.Z = 0.0;
		targetObjectAccAtLid.X = 0;
		targetObjectAccAtLid.Y = 0;
		targetObjectAccAtLid.Z = 0.0;
	}
    rear_lt_state_accesskey.unlock();

	// For cone collection
    if (currentState == ST_CONECOLLECT_TRACEGRIPENTRY)
    {
		// Identify lost target cone event in to-ST_CONECOLLECT_TRACE_GRIP_ENTRY
		// With updated target location/info, polling peripheral / re-invoke
		ExternalEvent(ST_CONECOLLECT_TRACEGRIPENTRY, NULL);
    }

	// Identify cone reached grip during going to grip (2)
	if (currentState == ST_CONECOLLECT_CONEGRIP)
	{
		double distBetweenGripPtAndObj = calPointDistToRobotArmGripPoint2D_mm(targetObjectPose.X, targetObjectPose.Y);
		if ( distBetweenGripPtAndObj <= (COLLECTTRACE_CORRECT_TOL_MM/3.0) )
		{
			ROS_INFO("Rear Detector detected cone reached gripper. Can go earlier to grip up? Distance between GripPt and Cone = %.3f.", distBetweenGripPtAndObj);
/*			if (collectCancelCmdCount == 0)
			{
				collectCancelCmdCount++;
				kuka_robot::kr_rampstop_Args srv;
				srv.request.mode = 3;				// Special mode cancel motion without notify ac
				if (!kr_rampdown_stop.call(srv))
					ROS_INFO("kr_rampdown_stop returned error: %ld", (long int)srv.response.response);

				ROS_INFO("Catch cancel stop triggered.");
			}*/
		}
	}

	// Identify non-cone in operation zone event
	rear_lt_state_accesskey.lock();
	int objIndex = getObjectIndexInZone(-AUTO_TARGET_SELECT_LID_LIMIT_Y_M, AUTO_TARGET_SELECT_LID_LIMIT_Y_M, (ARM_TCP_LIMIT_X_MM-660.0)/1000.0);
	if (objIndex >= 0)
		rearDetectObjectInDeadZone = true;
	else
		rearDetectObjectInDeadZone = false;

	// Left: +Y, Right: -Y in LiDAR space
	double RBoundY = -AUTO_TARGET_SELECT_LID_LIMIT_Y_M + (AUTO_TARGET_SELECT_LID_LIMIT_Y_M * 2 / 3.0);
	double LBoundY = AUTO_TARGET_SELECT_LID_LIMIT_Y_M - (AUTO_TARGET_SELECT_LID_LIMIT_Y_M * 2 / 3.0);
	int objRIndex = getObjectIndexInZone(-AUTO_TARGET_SELECT_LID_LIMIT_Y_M, RBoundY, (ARM_TCP_LIMIT_X_MM+300.0-660.0)/1000.0);
	int objCIndex = getObjectIndexInZone(RBoundY, LBoundY, (ARM_TCP_LIMIT_X_MM+300.0-660.0)/1000.0);
	int objLIndex = getObjectIndexInZone(LBoundY, AUTO_TARGET_SELECT_LID_LIMIT_Y_M, (ARM_TCP_LIMIT_X_MM+300.0-660.0)/1000.0);
	if (objRIndex >= 0)
		rearDetectObjectInPlaceZoneRight = true;
	else
		rearDetectObjectInPlaceZoneRight = false;
	if (objCIndex >= 0)
		rearDetectObjectInPlaceZoneCenter = true;
	else
		rearDetectObjectInPlaceZoneCenter = false;
	if (objLIndex >= 0)
		rearDetectObjectInPlaceZoneLeft = true;
	else
		rearDetectObjectInPlaceZoneLeft = false;

	int objOpZIndex = getObjectIndexInZone(-AUTO_TARGET_SELECT_LID_LIMIT_Y_M, AUTO_TARGET_SELECT_LID_LIMIT_Y_M, (COLLECTTRACE_MAX_ARM_GRIP_MM-660.0)/1000.0);

	if ( (objOpZIndex >= 0) && (objOpZIndex != targetObjectIndex) )
		rearDetectNonLockObjectInOperationZone = true;
	else
		rearDetectNonLockObjectInOperationZone = false;
	rear_lt_state_accesskey.unlock();

//	ROS_INFO("Detected dead zone: x=%.3f, y=%.3f", rearDetectState->objects[objIndex].CenterPoint.x, rearDetectState->objects[objIndex].CenterPoint.y);
//	ROS_INFO("Detected obj zone: D=%d, R=%d, C=%d, L=%d, NonLk=%d", rearDetectObjectInDeadZone, rearDetectObjectInPlaceZoneRight, rearDetectObjectInPlaceZoneCenter, rearDetectObjectInPlaceZoneLeft, rearDetectNonLockObjectInOperationZone);

    // Identify unlocked object fast approaching event
}

// external event
void RearRobotArmSM::OnUpdateLoadingBayState()
{
/*	// For cone placement
	if (currentState == ST_CONEPLACE_LBPICK)
	{
		pLoadingBaySM->acquireLLB_ExclusiveLock(1);
		pLoadingBaySM->acquireRLB_ExclusiveLock(1);
	}

	// For cone collection
    if (currentState == ST_CONECOLLECT_WAITLBREADY)
    {
		pLoadingBaySM->acquireLLB_ExclusiveLock(1);
		pLoadingBaySM->acquireRLB_ExclusiveLock(1);
    }*/
}


// Need protected by mutex
int RearRobotArmSM::getObjectIndexByID(int ID)
{
	int index = -1;
	for (int i=0; i<rearDetectState->objects.size(); i++)
		if (rearDetectState->objects[i].ID == ID)
		{
			index = i;
			break;
		}
	return index;
}

// Need protected by mutex
int RearRobotArmSM::getNearestConeObjectIndex(double limitY_lid_m, double minX_lid_m, bool printlog)
{
	int minDindex = -1;
	double minD = 9999.9;

	// still using detector coord space, in meters
	for (int i=0; i<rearDetectState->trackedcone_indexes.size(); i++)
	{
		int index = rearDetectState->trackedcone_indexes[i];
		double dist = rearDetectState->objects[index].CenterPoint.Dist;
		double absY = abs(rearDetectState->objects[index].CenterPoint.y);

		if ( (rearDetectState->objects[index].CenterPoint.x >= minX_lid_m) && (absY <= limitY_lid_m) )
		{
			if (printlog)
			{
				double existTimestamp = rearDetectState->objects[index].IDTimestamp;
				double timestampAge = rearDetectState->timestamp - existTimestamp;
				ROS_INFO("RearRobotArmSM[%s]: Suspicious=%ld, Age=%.3f, Dist=%.3f, AbsY=%.3f.", armName.c_str(), rearDetectState->objects[index].ID, timestampAge, dist, absY);
			}
			// Find the closest relative to robot arm
//			if (minD > dist)
//			{
//				minD = dist;
//				minDindex = index;
//			}
			// Find the closest relative to vehicle
			if (minD > rearDetectState->objects[index].CenterPoint.x)
			{
				minD = rearDetectState->objects[index].CenterPoint.x;
				minDindex = index;
			}
		}
	}

	if (printlog)
	{
		if (minDindex >= 0)
			ROS_INFO("RearRobotArmSM[%s]: Select=%ld.", armName.c_str(), rearDetectState->objects[minDindex].ID);
	}

	return minDindex;
}

// Need protected by mutex
int RearRobotArmSM::getObjectIndexNearAPoint(double x_tcp_mm, double y_tcp_mm, double* dist_mm)
{
	int minDindex = -1;
	double minD = 99999999.9;

	for (int i=0; i<rearDetectState->objects.size(); i++)
	{
		double objAtArmTCP_x, objAtArmTCP_y;
		double detx = rearDetectState->objects[i].CenterPoint.x * 1000.0;	// to mm
		double dety = rearDetectState->objects[i].CenterPoint.y * 1000.0;	// to mm
		coord_RearDetect_RobotArmTCP(detx, dety, -1, &objAtArmTCP_x, &objAtArmTCP_y);

		double dx = x_tcp_mm - objAtArmTCP_x;
		double dy = y_tcp_mm - objAtArmTCP_y;
		double D = sqrt(dx*dx + dy*dy);
		if (minD > D)
		{
			minD = D;
			minDindex = i;
		}
	}

	*dist_mm = minD;
	return minDindex;
}

// Need protected by mutex
int RearRobotArmSM::getObjectIndexInZone(double limitY1_lid_m, double limitY2_lid_m, double limitX_lid_m)
{
	int index = -1;

	for (int i=0; i<rearDetectState->objects.size(); i++)
	{
		if ( (rearDetectState->objects[i].CenterPoint.x >= LID_MIN_X_M) &&
			(rearDetectState->objects[i].CenterPoint.x <= limitX_lid_m) &&
			(rearDetectState->objects[i].CenterPoint.y >= limitY1_lid_m) &&
			(rearDetectState->objects[i].CenterPoint.y <= limitY2_lid_m) )
		{
			index = i;
			break;
		}

		if ( (rearDetectState->objects[i].IncEdge.x >= LID_MIN_X_M) &&
			(rearDetectState->objects[i].IncEdge.x <= limitX_lid_m) &&
			(rearDetectState->objects[i].IncEdge.y >= limitY1_lid_m) &&
			(rearDetectState->objects[i].IncEdge.y <= limitY2_lid_m) )
		{
			index = i;
			break;
		}

		if ( (rearDetectState->objects[i].DecEdge.x >= LID_MIN_X_M) &&
			(rearDetectState->objects[i].DecEdge.x <= limitX_lid_m) &&
			(rearDetectState->objects[i].DecEdge.y >= limitY1_lid_m) &&
			(rearDetectState->objects[i].DecEdge.y <= limitY2_lid_m) )
		{
			index = i;
			break;
		}
	}

	return index;
}

// Need protected by mutex
int RearRobotArmSM::getObjectPositionInRobotSpace(int objectIndex, double pred_t, double shf_x_lid_mm, double shf_y_lid_mm, double* x_lid_mm, double* y_lid_mm, double* x_tcp_mm, double* y_tcp_mm)
{
	double objAtDetector_x = rearDetectState->objects[objectIndex].CenterPoint.x * 1000.0;	// to mm
	double objAtDetector_y = rearDetectState->objects[objectIndex].CenterPoint.y * 1000.0;	// to mm
	double objAtDetector_vx = rearDetectState->objects[objectIndex].Est_Vel.x;
	double objAtDetector_vy = rearDetectState->objects[objectIndex].Est_Vel.y;
	double objAtDetector_ax = rearDetectState->objects[objectIndex].Est_Acc.x;
	double objAtDetector_ay = rearDetectState->objects[objectIndex].Est_Acc.y;

	if (pred_t > 0)
	{
		if (abs(objAtDetector_vx) < COLLECTTRACE_MIN_OBJ_VEL)
			objAtDetector_vx = 0.0;

		if (abs(objAtDetector_vy) < COLLECTTRACE_MIN_OBJ_VEL)
			objAtDetector_vy = 0.0;

		if (abs(objAtDetector_ax) < COLLECTTRACE_MIN_OBJ_ACC)
			objAtDetector_ax = 0.0;

		if (abs(objAtDetector_ay) < COLLECTTRACE_MIN_OBJ_ACC)
			objAtDetector_ay = 0.0;

		double acc_t2;
		// Bounded by COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC
		if (pred_t > COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC)
			acc_t2 = COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC * COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC;
		else
			acc_t2 = pred_t * pred_t;

		// Position in mm, vel in m/s, acc in m/s2
		objAtDetector_x = ((objAtDetector_ax * acc_t2)/2.0 + objAtDetector_vx * pred_t) * 1000.0 + objAtDetector_x;
		objAtDetector_y = ((objAtDetector_ay * acc_t2)/2.0 + objAtDetector_vy * pred_t) * 1000.0 + objAtDetector_y;
	}

	// Current/Predicted object position, apply entry point position shift, using detector coord space first
	*x_lid_mm = objAtDetector_x + shf_x_lid_mm;
	*y_lid_mm = objAtDetector_y + shf_y_lid_mm;

	coord_RearDetect_RobotArmTCP(*x_lid_mm, *y_lid_mm, -1, x_tcp_mm, y_tcp_mm);

	return 0;
}

int RearRobotArmSM::getTargetPositionInRobotSpace(double pred_t, double* x_lid_mm, double* y_lid_mm, double* x_tcp_mm, double* y_tcp_mm)
{
    rear_lt_state_accesskey.lock();
	double objAtDetector_x = targetObjectPoseAtLid.X;	// in mm
	double objAtDetector_y = targetObjectPoseAtLid.Y;	// in mm
	double objAtDetector_vx = targetObjectVelAtLid.X;	// in m/s
	double objAtDetector_vy = targetObjectVelAtLid.Y;	// in m/s
	double objAtDetector_ax = targetObjectAccAtLid.X;	// in m/s2
	double objAtDetector_ay = targetObjectAccAtLid.Y;	// in m/s2
    rear_lt_state_accesskey.unlock();

	if (pred_t > 0)
	{
		if (abs(objAtDetector_vx) < COLLECTTRACE_MIN_OBJ_VEL)
			objAtDetector_vx = 0.0;

		if (abs(objAtDetector_vy) < COLLECTTRACE_MIN_OBJ_VEL)
			objAtDetector_vy = 0.0;

		if (abs(objAtDetector_ax) < COLLECTTRACE_MIN_OBJ_ACC)
			objAtDetector_ax = 0.0;

		if (abs(objAtDetector_ay) < COLLECTTRACE_MIN_OBJ_ACC)
			objAtDetector_ay = 0.0;

		double acc_t2;
		// Bounded by COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC
		if (pred_t > COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC)
			acc_t2 = COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC * COLLECTTRACE_MAX_OBJ_ACC_TIME_SEC;
		else
			acc_t2 = pred_t * pred_t;
		// Position in mm, vel in m/s, acc in m/s2
		objAtDetector_x = ((objAtDetector_ax * acc_t2)/2.0 + objAtDetector_vx * pred_t) * 1000.0 + objAtDetector_x;
		objAtDetector_y = ((objAtDetector_ay * acc_t2)/2.0 + objAtDetector_vy * pred_t) * 1000.0 + objAtDetector_y;
	}

	// Current/Predicted object position, apply entry point position shift, using detector coord space first
	*x_lid_mm = objAtDetector_x /*+ shf_x_lid_mm*/;
	*y_lid_mm = objAtDetector_y /*+ shf_y_lid_mm*/;

	coord_RearDetect_RobotArmTCP(*x_lid_mm, *y_lid_mm, -1, x_tcp_mm, y_tcp_mm);

	return 0;
}

// Return: -1-error, 0-target not reachable/reachable but not right time, 1-right time to grip (static), 2-right time to grip (moving)
int RearRobotArmSM::predictArmGripPositionWithTarget(double* x_lid_mm, double* y_lid_mm, double* x_tcp_mm, double* y_tcp_mm)
{
	// Cal predicted point of object, from min t=300ms to robot arm max travel dist (~2.0M) time
	// Arm run min time and max time
	double maxVel = 0;
	double delayTimeForCmdExec = COLLECTTRACE_CMD_DELAY_SEC;
	double minTimeForArmRun = COLLECTTRACE_SHORTEST_TIMETOGRIP + delayTimeForCmdExec;
/*	if ((ros::Time::now().toSec() - previousMotionCmdTimestamp) < minTimeForArmRun)
	{
		double addDelayForPrevExec = minTimeForArmRun - (ros::Time::now().toSec() - previousMotionCmdTimestamp);
		delayTimeForCmdExec = COLLECTTRACE_CMD_DELAY_SEC + addDelayForPrevExec;
		minTimeForArmRun = COLLECTTRACE_SHORTEST_TIMETOGRIP + delayTimeForCmdExec;
		ROS_INFO("RearRobotArmSM[%s]: Pre-prediction algorithm... Adjust cmd exec delay time: %.3f.", armName.c_str(), delayTimeForCmdExec);
	}*/
	double maxTimeForArmRun = calLinProfileTimeWithSpeedScale(COLLECTTRACE_MAX_ARM_GRIP_MM/1000.0, 10.0, 3.0, &maxVel) + delayTimeForCmdExec;
	double timeElapse = minTimeForArmRun;
	double timeElapseInc = (maxTimeForArmRun - minTimeForArmRun)/COLLECTTRACE_PREDICTSCAN_TRIAL;
	vector<double>  predictX;
	vector<double>  predictY;
	vector<double>  predictT;

    rear_lt_state_accesskey.lock();
	ROS_INFO("RearRobotArmSM[%s]: Start prediction algorithm... Target %d(%d, Age=%.3f)[%.3f,%.3f]: vel=%.3f,%.3f acc=%.3f,%.3f.", armName.c_str(),
			targetObjectID, targetFused, targetAge, targetObjectPose.X, targetObjectPose.Y,
			targetObjectVelAtLid.X, targetObjectVelAtLid.Y, targetObjectAccAtLid.X, targetObjectAccAtLid.Y);
    rear_lt_state_accesskey.unlock();

	predictX.clear();
	predictY.clear();
	predictT.clear();
	kr_state_accesskey.lock();
	double curr_tcp_x = robotArmState->pos_setpt.X;
//	double curr_tcp_y = robotArmState->pos_setpt.Y;
//	double curr_tcp_z = robotArmState->pos_setpt.Z;
    kr_state_accesskey.unlock();

	// Fast scan object positions can reach operating radius
	bool canReach = false;
	int scan_trial = -1;
	for (scan_trial=-1; scan_trial<COLLECTTRACE_PREDICTSCAN_TRIAL; scan_trial++)
	{
		double scan_x_tcp_mm, scan_y_tcp_mm;
		double scan_t = timeElapse + ((scan_trial+1)*timeElapseInc);
		// Scan the predicted position whether is valid
		getTargetPositionInRobotSpace(scan_t, x_lid_mm, y_lid_mm, &scan_x_tcp_mm, &scan_y_tcp_mm);

		// Scan point passed the current gripper position
		if (scan_x_tcp_mm < curr_tcp_x)
			break;

		//double DistToArmBase = calPointDist(scan_x_tcp_mm, scan_y_tcp_mm, 0, 0.0, 0.0, 0);
		//if (DistToArmBase <= COLLECTTRACE_MAX_ARM_GRIP_MM)
		if (checkOperationZone(scan_x_tcp_mm, scan_y_tcp_mm))
		{
			canReach = true;
			predictX.push_back(scan_x_tcp_mm);
			predictY.push_back(scan_y_tcp_mm);
			predictT.push_back(scan_t);
		}
	}

	// The object predicted path not reach operating radius, project a position in the operating radius (standby point)
	if (!canReach)
	{
		getTargetPositionInRobotSpace(0, x_lid_mm, y_lid_mm, x_tcp_mm, y_tcp_mm);
		calProjectedStandbyZone(*y_lid_mm, x_lid_mm, y_lid_mm);
		calProjectedStandbyZone(*y_tcp_mm, x_tcp_mm, y_tcp_mm);
		if (scan_trial < 0)
		{
			ROS_INFO("RearRobotArmSM[%s]: Scan first predicted position error encountered.", armName.c_str());
			return -1;
		}
		else
		{
			ROS_INFO("RearRobotArmSM[%s]: Target non-reachable, project to standby point.", armName.c_str());
			return 0;
		}
	}

	// The object predicted whole path inside operating radius
	if (predictT.size() >= COLLECTTRACE_PREDICTSCAN_TRIAL)
	{
		ROS_INFO("RearRobotArmSM[%s]: All predicted target positions are inside operation radius.", armName.c_str());

		// Check t=0 and t=max distance, if < tol, stand still
		double still_x_tcp_mm, still_y_tcp_mm;
		double max_x_tcp_mm, max_y_tcp_mm;
		getTargetPositionInRobotSpace(maxTimeForArmRun, x_lid_mm, y_lid_mm, &max_x_tcp_mm, &max_y_tcp_mm);
		getTargetPositionInRobotSpace(0, x_lid_mm, y_lid_mm, &still_x_tcp_mm, &still_y_tcp_mm);
		double dist = calPointDist(still_x_tcp_mm, still_y_tcp_mm, 0, max_x_tcp_mm, max_y_tcp_mm, 0);
		if (dist <= COLLECTTRACE_CORRECT_TOL_MM)
		{
			ROS_INFO("RearRobotArmSM[%s]: Time to grip stand still target.", armName.c_str());
			*x_tcp_mm = still_x_tcp_mm;
			*y_tcp_mm = still_y_tcp_mm;
			return 1;
		}
	}

	// The object predicted path reach operating radius
	double deltaPrev;
	double delta = COLLECTTRACE_SHORTEST_TIMETOGRIP;
	for (int i=0; i<predictT.size(); i++)
	{
		//double distToGripPt = calPointDistToRobotArmGripPoint2D_mm(predictX[i], predictY[i]);
		double distToGripPt = calPointDistToRobotArmGripPoint_mm(predictX[i], predictY[i], collectFloorZHeight);
		double gripPfTime = calLinProfileTimeWithSpeedScale(distToGripPt/1000.0, 10.0, 3.0, &maxVel) + delayTimeForCmdExec;
		if (i == 0)
			deltaPrev = gripPfTime - predictT[i];	// Initialize
		else
			deltaPrev = delta;
		delta = gripPfTime - predictT[i];		// error time
		if (abs(delta) < COLLECTTRACE_MAX_MOTION_DETLA_SEC)		// almost the same, cmd to grip this virtual position
		{
			// Predicted t == Robot arm profile time, time to grip
			ROS_INFO("RearRobotArmSM[%s]: Time to grip at predicted position A [%.3f,%.3f], calculated pfT=%.3f, Tdiff=%.3f!", armName.c_str(), predictX[i], predictY[i], predictT[i], delta);
			*x_tcp_mm = predictX[i];
			*y_tcp_mm = predictY[i];
			return 2;
		}
		else if ((deltaPrev * delta) < 0.0)						// zero crossing (TBD: min point), narrow time values
		{
			// Refine and find the valley time, time to grip
			timeElapse = predictT[i-1];
			timeElapseInc = (predictT[i] - predictT[i-1])/COLLECTTRACE_PREDICTSCAN_TRIAL;
			double minDiffX = 0.0;
			double minDiffY = 0.0;
			double minDiffT = 99999.0;
			for (int scan_trial2=-1; scan_trial2<COLLECTTRACE_PREDICTSCAN_TRIAL; scan_trial2++)
			{
				double scan_x_tcp_mm, scan_y_tcp_mm;
				double scan_t = timeElapse + ((scan_trial2+1)*timeElapseInc);
				// Scan the predicted position whether is valid
				getTargetPositionInRobotSpace(scan_t, x_lid_mm, y_lid_mm, &scan_x_tcp_mm, &scan_y_tcp_mm);
				//double distToGripPt2 = calPointDistToRobotArmGripPoint2D_mm(scan_x_tcp_mm, scan_y_tcp_mm);
				double distToGripPt2 = calPointDistToRobotArmGripPoint_mm(scan_x_tcp_mm, scan_y_tcp_mm, collectFloorZHeight);
				double gripPfTime2 = calLinProfileTimeWithSpeedScale(distToGripPt2/1000.0, 10.0, 3.0, &maxVel) + delayTimeForCmdExec;
				delta = abs(gripPfTime2 - scan_t);		// error time
				if (delta < COLLECTTRACE_MAX_MOTION_DETLA_SEC)	// almost the same, cmd to grip this virtual position
				{
					// Predicted t == Robot arm profile time, time to grip
					ROS_INFO("RearRobotArmSM[%s]: Time to grip at predicted position B [%.3f,%.3f], calculated pfT=%.3f, Tdiff=%.3f!", armName.c_str(), scan_x_tcp_mm, scan_y_tcp_mm, scan_t, delta);
					*x_tcp_mm = scan_x_tcp_mm;
					*y_tcp_mm = scan_y_tcp_mm;
					return 2;
				}
				if (minDiffT > delta)
				{
					minDiffT = delta;
					minDiffX = scan_x_tcp_mm;
					minDiffY = scan_y_tcp_mm;
				}
			}

			// Not found close to zero time, use minimum
			ROS_INFO("RearRobotArmSM[%s]: Time to grip at predicted position C [%.3f,%.3f], Tdiff=%.3f!", armName.c_str(), predictX[i], predictY[i], delta);
			*x_tcp_mm = minDiffX;
			*y_tcp_mm = minDiffY;
			return 2;
		}
	}

	// Target reachable but not the right time, project a position in the operating radius (standby point)
	getTargetPositionInRobotSpace(0, x_lid_mm, y_lid_mm, x_tcp_mm, y_tcp_mm);
	calProjectedStandbyZone(*y_lid_mm, x_lid_mm, y_lid_mm);
	calProjectedStandbyZone(*y_tcp_mm, x_tcp_mm, y_tcp_mm);
	ROS_INFO("RearRobotArmSM[%s]: Target reachable but not the right time, project to standby point.", armName.c_str());
	return 0;
}

// external event
void RearRobotArmSM::changeAutolockTarget(int newID)
{
	rear_lt_state_accesskey.lock();
    // Select by user specified ID
    int targetObjectIndex = getObjectIndexByID(newID);
    ROS_INFO("RearRobotArmSM[%s]: Change new id cmd=%d, index=%d.", armName.c_str(), newID, targetObjectIndex);
	// Update info
	if (targetObjectIndex >= 0)
	{
		targetObjectID = newID;

		targetFused = rearDetectState->objects[targetObjectIndex].Is_Fused;
		double existTimestamp = rearDetectState->objects[targetObjectIndex].IDTimestamp;
		targetAge = rearDetectState->timestamp - existTimestamp;

		double objAtLid_x, objAtLid_y;
		double objAtArmTCP_x, objAtArmTCP_y;
		getObjectPositionInRobotSpace(targetObjectIndex, 0, 0, 0, &objAtLid_x, &objAtLid_y, &objAtArmTCP_x, &objAtArmTCP_y);
		targetObjectPose.X = objAtArmTCP_x;
		targetObjectPose.Y = objAtArmTCP_y;
		targetObjectPose.Z = 0.0;

		targetObjectPoseAtLid.X = objAtLid_x;											// in mm
		targetObjectPoseAtLid.Y = objAtLid_y;											// in mm
		targetObjectPoseAtLid.Z = 0.0;
		targetObjectVelAtLid.X = rearDetectState->objects[targetObjectIndex].Est_Vel.x;	// in m/s
		targetObjectVelAtLid.Y = rearDetectState->objects[targetObjectIndex].Est_Vel.y;	// in m/s
		targetObjectVelAtLid.Z = 0.0;
		targetObjectAccAtLid.X = rearDetectState->objects[targetObjectIndex].Est_Acc.x;	// in m/s2
		targetObjectAccAtLid.Y = rearDetectState->objects[targetObjectIndex].Est_Acc.y;	// in m/s2
		targetObjectAccAtLid.Z = 0.0;
	}
	else
	{
		targetObjectID = 0;
		targetObjectPose.X = 0.0;
		targetObjectPose.Y = 0.0;
		targetObjectPose.Z = 0.0;

		targetObjectPoseAtLid.X = 0;
		targetObjectPoseAtLid.Y = 0;
		targetObjectPoseAtLid.Z = 0.0;
		targetObjectVelAtLid.X = 0;
		targetObjectVelAtLid.Y = 0;
		targetObjectVelAtLid.Z = 0.0;
		targetObjectAccAtLid.X = 0;
		targetObjectAccAtLid.Y = 0;
		targetObjectAccAtLid.Z = 0.0;
	}
	rear_lt_state_accesskey.unlock();
}

void RearRobotArmSM::changeRoadmarkLineTrack(double x, double y)
{
	roadmarkLine_accesskey.lock();
	roadmarkLineX = x;
	roadmarkLineY = y;
	roadmarkLine_accesskey.unlock();
}

// external event
void RearRobotArmSM::goConePlacement(vector<ConeSet>* PlacementConeChain, int mode)
{
	PlacementConeChainTemplate = PlacementConeChain;
	PlacementConeChainCurrIndex = 0;

	placementRefToLineMode = mode;

	// Download all routes for cone placement to batch blocks
	if (reloadPlacementRoutes())
		return;

	if (currentState == ST_IDLE)
	{
		// Set TCP to gripper grip point
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = 0.0;
		srv.request.pose.Y = 0.0;
		srv.request.pose.Z = ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM;
		srv.request.pose.A = 0.0;
		srv.request.pose.B = 0.0;
		srv.request.pose.C = 0.0;
		if (!kr_set_tool_coord.call(srv))
			ROS_INFO("kr_set_tool_coord returned error: %ld", (long int)srv.response.response);

		// Enable single move rounding
		kuka_robot::kr_set_real_Args srv2;
		srv2.request.number = 100;
		if (!kr_set_default_round.call(srv2))
			ROS_INFO("kr_set_default_round returned error: %ld", (long int)srv2.response.response);

		// Re-fresh and select the closest cone target
		targetObjectID = 0;

		cycleStartTimeStamp = ros::Time::now().toSec();
		ExternalEvent(ST_CONEPLACE_INITPOSE, NULL);
	}
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

// external event
void RearRobotArmSM::goConeCollection(int numOfCones, int mode)
{
	CollectionConeAmount = numOfCones;
	CollectionConeCount = 0;

	// Download all routes for cone collection to batch blocks
	if (reloadCollectionRoutes())
		return;

	if (mode > 0)
		collectAtStationary = true;
	else
		collectAtStationary = false;

	if (currentState == ST_IDLE)
	{
		// Set TCP to gripper grip point
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = 0.0;
		srv.request.pose.Y = 0.0;
		srv.request.pose.Z = ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM;
		srv.request.pose.A = 0.0;
		srv.request.pose.B = 0.0;
		srv.request.pose.C = 0.0;
		if (!kr_set_tool_coord.call(srv))
			ROS_INFO("kr_set_tool_coord returned error: %ld", (long int)srv.response.response);

		// Enable single move rounding
		kuka_robot::kr_set_real_Args srv2;
		srv2.request.number = 100;
		if (!kr_set_default_round.call(srv2))
			ROS_INFO("kr_set_default_round returned error: %ld", (long int)srv2.response.response);

		// Re-fresh and select the closest cone target
		targetObjectID = 0;

		cycleStartTimeStamp = ros::Time::now().toSec();
		ExternalEvent(ST_CONECOLLECT_INITPOSE, NULL);
	}
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

int RearRobotArmSM::reloadPlacementRoutes()
{
	Route* pRoute0 = searchRouteByName("ConePlaceInitPose");
	Route* pRoute1 = searchRouteByName("ConePlaceLLBExitFloor");
	Route* pRoute2 = searchRouteByName("ConePlaceLLBPick");
	Route* pRoute3 = searchRouteByName("ConePlaceRLBExitFloor");
	Route* pRoute4 = searchRouteByName("ConePlaceRLBPick");
	Route* pRoute5 = searchRouteByName("ConePlaceLLBFloor");
	Route* pRoute6 = searchRouteByName("ConePlaceRLBFloor");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL) && (pRoute4 != NULL)
			&& (pRoute5 != NULL) && (pRoute6 != NULL) )
	{
		conePlaceInitPoseBatchStartBlkNum = ROBOTARM_CONEPLACEMENT_BATCH_START_BLKNO;
		conePlaceInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, conePlaceInitPoseBatchStartBlkNum);
		conePlaceLLBExitFloorBatchStartBlkNum = conePlaceInitPoseBatchEndBlkNum + 1;
		conePlaceLLBExitFloorBatchEndBlkNum = setRouteBatch(pRoute1, conePlaceLLBExitFloorBatchStartBlkNum);
		conePlaceLLBPickBatchStartBlkNum = conePlaceLLBExitFloorBatchEndBlkNum + 1;
		conePlaceLLBPickBatchEndBlkNum = setRouteBatch(pRoute2, conePlaceLLBPickBatchStartBlkNum);
		conePlaceRLBExitFloorBatchStartBlkNum = conePlaceLLBPickBatchEndBlkNum + 1;
		conePlaceRLBExitFloorBatchEndBlkNum = setRouteBatch(pRoute3, conePlaceRLBExitFloorBatchStartBlkNum);
		conePlaceRLBPickBatchStartBlkNum = conePlaceRLBExitFloorBatchEndBlkNum + 1;
		conePlaceRLBPickBatchEndBlkNum = setRouteBatch(pRoute4, conePlaceRLBPickBatchStartBlkNum);
		conePlaceLLBFloorBatchStartBlkNum = conePlaceRLBPickBatchEndBlkNum + 1;
		conePlaceLLBFloorBatchEndBlkNum = setRouteBatch(pRoute5, conePlaceLLBFloorBatchStartBlkNum);
		conePlaceRLBFloorBatchStartBlkNum = conePlaceLLBFloorBatchEndBlkNum + 1;
		conePlaceRLBFloorBatchEndBlkNum = setRouteBatch(pRoute6, conePlaceRLBFloorBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goConePlacement - missing route definition.", armName.c_str());
		return -1;
	}

	#define FL_PL_WAYPOINT_BLK_NUM		4
	// Update placement line X distance for line tracking ref
	roadmarkLineX = pRoute5->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.X;

	return 0;
}

int RearRobotArmSM::reloadCollectionRoutes()
{
	Route* pRoute0 = searchRouteByName("ConeCollectInitPose");
	Route* pRoute1 = searchRouteByName("ConeCollectAim");
	Route* pRoute2 = searchRouteByName("ConeCollectTraceGripEntry");
	Route* pRoute3 = searchRouteByName("ConeCollectConeGrip");
	Route* pRoute4 = searchRouteByName("ConeCollectGripUp");
	Route* pRoute5 = searchRouteByName("ConeCollectWaitLBPose");
	Route* pRoute6 = searchRouteByName("ConeCollectLLBFill");
	Route* pRoute7 = searchRouteByName("ConeCollectRLBFill");
	Route* pRoute8 = searchRouteByName("ConeCollectLLBExit");
	Route* pRoute9 = searchRouteByName("ConeCollectRLBExit");
	Route* pRoute10 = searchRouteByName("ConeCollectConeGripFail");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL) && (pRoute4 != NULL)
			&& (pRoute5 != NULL) && (pRoute6 != NULL) && (pRoute7 != NULL) && (pRoute8 != NULL)
			 && (pRoute9 != NULL) && (pRoute10 != NULL) )
	{
		coneCollectInitPoseBatchStartBlkNum = ROBOTARM_CONECOLLECTION_BATCH_START_BLKNO;
		coneCollectInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, coneCollectInitPoseBatchStartBlkNum);
		coneCollectAimBatchStartBlkNum = coneCollectInitPoseBatchEndBlkNum + 1;
		coneCollectAimBatchEndBlkNum = setRouteBatch(pRoute1, coneCollectAimBatchStartBlkNum);
		coneCollectTraceGripEntryBatchStartBlkNum = coneCollectAimBatchEndBlkNum + 1;
		coneCollectTraceGripEntryBatchEndBlkNum = setRouteBatch(pRoute2, coneCollectTraceGripEntryBatchStartBlkNum);
		coneCollectConeGripBatchStartBlkNum = coneCollectTraceGripEntryBatchEndBlkNum + 1;
		coneCollectConeGripBatchEndBlkNum = setRouteBatch(pRoute3, coneCollectConeGripBatchStartBlkNum);
		coneCollectGripUpBatchStartBlkNum = coneCollectConeGripBatchEndBlkNum + 1;
		coneCollectGripUpBatchEndBlkNum = setRouteBatch(pRoute4, coneCollectGripUpBatchStartBlkNum);
		coneCollectWaitLBPoseBatchStartBlkNum = coneCollectGripUpBatchEndBlkNum + 1;;
		coneCollectWaitLBPoseBatchEndBlkNum = setRouteBatch(pRoute5, coneCollectWaitLBPoseBatchStartBlkNum);
		coneCollectLLBFillBatchStartBlkNum = coneCollectWaitLBPoseBatchEndBlkNum + 1;
		coneCollectLLBFillBatchEndBlkNum = setRouteBatch(pRoute6, coneCollectLLBFillBatchStartBlkNum);
		coneCollectRLBFillBatchStartBlkNum = coneCollectLLBFillBatchEndBlkNum + 1;
		coneCollectRLBFillBatchEndBlkNum = setRouteBatch(pRoute7, coneCollectRLBFillBatchStartBlkNum);
		coneCollectLLBExitBatchStartBlkNum = coneCollectRLBFillBatchEndBlkNum + 1;
		coneCollectLLBExitBatchEndBlkNum = setRouteBatch(pRoute8, coneCollectLLBExitBatchStartBlkNum);
		coneCollectRLBExitBatchStartBlkNum = coneCollectLLBExitBatchEndBlkNum + 1;
		coneCollectRLBExitBatchEndBlkNum = setRouteBatch(pRoute9, coneCollectRLBExitBatchStartBlkNum);
		coneCollectConeGripFailBatchStartBlkNum = coneCollectRLBExitBatchEndBlkNum + 1;
		coneCollectConeGripFailBatchEndBlkNum = setRouteBatch(pRoute10, coneCollectConeGripFailBatchStartBlkNum);

		// Pre-fill/Initialize ZABC info by route record
		targetObjectCmdTracePose.X = pRoute2->waypoints[0].BATCH_POS.X;	// don't care
		targetObjectCmdTracePose.Y = pRoute2->waypoints[0].BATCH_POS.Y;	// don't care
		targetObjectCmdTracePose.Z = pRoute2->waypoints[0].BATCH_POS.Z;
		targetObjectCmdTracePose.A = pRoute2->waypoints[0].BATCH_POS.A;
		targetObjectCmdTracePose.B = pRoute2->waypoints[0].BATCH_POS.B;
		targetObjectCmdTracePose.C = pRoute2->waypoints[0].BATCH_POS.C;
		targetObjectCmdTracePose.S = -1;
		targetObjectCmdTracePose.T = -1;

		// Update Floor pick Z height (from ConeCollectConeGrip)
		collectFloorZHeight = pRoute3->waypoints[0].BATCH_POS.Z;
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goConeCollection - missing route definition.", armName.c_str());
		return -1;
	}

	return 0;
}

void RearRobotArmSM::goHomeSafely()
{
	// Download all routes for cone collection to batch blocks (need make use of collection route)
	if (reloadCollectionRoutes())
		return;

	Route* pRoute = searchRouteByName("Home");
	if (pRoute != NULL)
	{
		// First point should be MovJByJoint.
		if (pRoute->waypoints[0].BATCH_ACTION != MOVJ_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("RearRobotArmSM[%s]: goHomeSafely - first point should be MovjByJoints.", armName.c_str());
			return;
		}
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goHomeSafely - missing route info/definitation.", armName.c_str());
		return;
	}

	if (currentState == ST_IDLE)
		ExternalEvent(ST_SAFEHOME_HANDLEREARSIDE, NULL);
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

void RearRobotArmSM::goStandPlacement(int LBLocation, double x, double y)
{
	Route* pRoute0 = searchRouteByName("StandPlaceLLBInitPose");
	Route* pRoute1 = searchRouteByName("StandPlaceLLBPick");
	Route* pRoute2 = searchRouteByName("StandPlaceLLBFloor");
	Route* pRoute3 = searchRouteByName("StandPlaceRLBInitPose");
	Route* pRoute4 = searchRouteByName("StandPlaceRLBPick");
	Route* pRoute5 = searchRouteByName("StandPlaceRLBFloor");
	Route* pRoute6 = searchRouteByName("StandPlaceRLB2InitPose");
	Route* pRoute7 = searchRouteByName("StandPlaceRLB2Pick");
	Route* pRoute8 = searchRouteByName("StandPlaceRLB2Floor");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL) && (pRoute4 != NULL)
			&& (pRoute5 != NULL) && (pRoute6 != NULL) && (pRoute7 != NULL) && (pRoute8 != NULL) )
	{
		standPlaceLLBInitPoseBatchStartBlkNum = ROBOTARM_CONEPLACEMENT_BATCH_START_BLKNO;
		standPlaceLLBInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, standPlaceLLBInitPoseBatchStartBlkNum);
		standPlaceLLBPickBatchStartBlkNum = standPlaceLLBInitPoseBatchEndBlkNum + 1;
		standPlaceLLBPickBatchEndBlkNum = setRouteBatch(pRoute1, standPlaceLLBPickBatchStartBlkNum);
		standPlaceLLBFloorBatchStartBlkNum = standPlaceLLBPickBatchEndBlkNum + 1;
		standPlaceLLBFloorBatchEndBlkNum = setRouteBatch(pRoute2, standPlaceLLBFloorBatchStartBlkNum);
		standPlaceRLBInitPoseBatchStartBlkNum = standPlaceLLBFloorBatchEndBlkNum + 1;
		standPlaceRLBInitPoseBatchEndBlkNum = setRouteBatch(pRoute3, standPlaceRLBInitPoseBatchStartBlkNum);
		standPlaceRLBPickBatchStartBlkNum = standPlaceRLBInitPoseBatchEndBlkNum + 1;
		standPlaceRLBPickBatchEndBlkNum = setRouteBatch(pRoute4, standPlaceRLBPickBatchStartBlkNum);
		standPlaceRLBFloorBatchStartBlkNum = standPlaceRLBPickBatchEndBlkNum + 1;
		standPlaceRLBFloorBatchEndBlkNum = setRouteBatch(pRoute5, standPlaceRLBFloorBatchStartBlkNum);
		standPlaceRLB2InitPoseBatchStartBlkNum = standPlaceRLBFloorBatchEndBlkNum + 1;
		standPlaceRLB2InitPoseBatchEndBlkNum = setRouteBatch(pRoute6, standPlaceRLB2InitPoseBatchStartBlkNum);
		standPlaceRLB2PickBatchStartBlkNum = standPlaceRLB2InitPoseBatchEndBlkNum + 1;
		standPlaceRLB2PickBatchEndBlkNum = setRouteBatch(pRoute7, standPlaceRLB2PickBatchStartBlkNum);
		standPlaceRLB2FloorBatchStartBlkNum = standPlaceRLB2PickBatchEndBlkNum + 1;
		standPlaceRLB2FloorBatchEndBlkNum = setRouteBatch(pRoute8, standPlaceRLB2FloorBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goStandPlacement - missing route definition.", armName.c_str());
		return;
	}

	signStandLBLocation = LBLocation;
	signStandPosX = x;
	signStandPosY = y;
	if (currentState == ST_IDLE)
		ExternalEvent(ST_STANDPLACE_INITPOSE, NULL);
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

void RearRobotArmSM::goStandCollection(int LBLocation, double x, double y)
{
	Route* pRoute0 = searchRouteByName("StandCollectInitPose");
	Route* pRoute1 = searchRouteByName("StandCollectTraceGripEntry");
	Route* pRoute2 = searchRouteByName("StandCollectStandGrip");
	Route* pRoute3 = searchRouteByName("StandCollectLLBFill");
	Route* pRoute4 = searchRouteByName("StandCollectRLBFill");
	Route* pRoute5 = searchRouteByName("StandCollectRLB2Fill");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL) && (pRoute4 != NULL)
			&& (pRoute5 != NULL) )
	{
		standCollectInitPoseBatchStartBlkNum = ROBOTARM_CONECOLLECTION_BATCH_START_BLKNO;
		standCollectInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, standCollectInitPoseBatchStartBlkNum);
		standCollectTraceGripEntryBatchStartBlkNum = standCollectInitPoseBatchEndBlkNum + 1;
		standCollectTraceGripEntryBatchEndBlkNum = setRouteBatch(pRoute1, standCollectTraceGripEntryBatchStartBlkNum);
		standCollectStandGripBatchStartBlkNum = standCollectTraceGripEntryBatchEndBlkNum + 1;
		standCollectStandGripBatchEndBlkNum = setRouteBatch(pRoute2, standCollectStandGripBatchStartBlkNum);
		standCollectLLBFillBatchStartBlkNum = standCollectStandGripBatchEndBlkNum + 1;
		standCollectLLBFillBatchEndBlkNum = setRouteBatch(pRoute3, standCollectLLBFillBatchStartBlkNum);
		standCollectRLBFillBatchStartBlkNum = standCollectLLBFillBatchEndBlkNum + 1;
		standCollectRLBFillBatchEndBlkNum = setRouteBatch(pRoute4, standCollectRLBFillBatchStartBlkNum);
		standCollectRLB2FillBatchStartBlkNum = standCollectRLBFillBatchEndBlkNum + 1;
		standCollectRLB2FillBatchEndBlkNum = setRouteBatch(pRoute5, standCollectRLB2FillBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goStandCollection - missing route definition.", armName.c_str());
		return;
	}

	signStandLBLocation = LBLocation;
	signStandPosX = x;
	signStandPosY = y;
	if (currentState == ST_IDLE)
		ExternalEvent(ST_STANDCOLLECT_INITPOSE, NULL);
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

void RearRobotArmSM::goSignPlacement(int LBLocation, double x, double y)
{
	Route* pRoute0 = searchRouteByName("SignPlaceLBInitPose");
	Route* pRoute1 = searchRouteByName("SignPlaceLBPick");
	Route* pRoute2 = searchRouteByName("SignPlaceLBFloor");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) )
	{
		signPlaceLBInitPoseBatchStartBlkNum = ROBOTARM_CONEPLACEMENT_BATCH_START_BLKNO;
		signPlaceLBInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, signPlaceLBInitPoseBatchStartBlkNum);
		signPlaceLBPickBatchStartBlkNum = signPlaceLBInitPoseBatchEndBlkNum + 1;
		signPlaceLBPickBatchEndBlkNum = setRouteBatch(pRoute1, signPlaceLBPickBatchStartBlkNum);
		signPlaceLBFloorBatchStartBlkNum = signPlaceLBPickBatchEndBlkNum + 1;
		signPlaceLBFloorBatchEndBlkNum = setRouteBatch(pRoute2, signPlaceLBFloorBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goSignPlacement - missing route definition.", armName.c_str());
		return;
	}

	signStandLBLocation = LBLocation;
	signStandPosX = x;
	signStandPosY = y;
	if (currentState == ST_IDLE)
		ExternalEvent(ST_SIGNPLACE_INITPOSE, NULL);
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

void RearRobotArmSM::goSignCollection(int LBLocation, double x, double y)
{
	Route* pRoute0 = searchRouteByName("SignCollectInitPose");
	Route* pRoute1 = searchRouteByName("SignCollectTraceGripEntry");
	Route* pRoute2 = searchRouteByName("SignCollectSignGrip");
	Route* pRoute3 = searchRouteByName("SignCollectLBFill");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL) )
	{
		signCollectInitPoseBatchStartBlkNum = ROBOTARM_CONECOLLECTION_BATCH_START_BLKNO;
		signCollectInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, signCollectInitPoseBatchStartBlkNum);
		signCollectTraceGripEntryBatchStartBlkNum = signCollectInitPoseBatchEndBlkNum + 1;
		signCollectTraceGripEntryBatchEndBlkNum = setRouteBatch(pRoute1, signCollectTraceGripEntryBatchStartBlkNum);
		signCollectSignGripBatchStartBlkNum = signCollectTraceGripEntryBatchEndBlkNum + 1;
		signCollectSignGripBatchEndBlkNum = setRouteBatch(pRoute2, signCollectSignGripBatchStartBlkNum);
		signCollectLBFillBatchStartBlkNum = signCollectSignGripBatchEndBlkNum + 1;
		signCollectLBFillBatchEndBlkNum = setRouteBatch(pRoute3, signCollectLBFillBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("RearRobotArmSM[%s]: goSignCollection - missing route definition.", armName.c_str());
		return;
	}

	signStandLBLocation = LBLocation;
	signStandPosX = x;
	signStandPosY = y;
	if (currentState == ST_IDLE)
		ExternalEvent(ST_SIGNCOLLECT_INITPOSE, NULL);
	ROS_INFO("RearRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

/* Rear Arm targeting thread -------------------------------------------------------------------------*/
void RearRobotArmSM::autolockThreadRun(RearRobotArmSM* self)
{
	// Max re-fresh at 5Hz
	ros::Rate loop_rate(5);
	ROS_INFO("Start rear arm auto select lock cone target.");
	while (ros::ok())
	{
		loop_rate.sleep();

		if ((self->rearDetectState == NULL) || (self->vs_check_position_has_cone == NULL))
			continue;

		self->rear_lt_state_accesskey.lock();
	    // Auto select and lock of a target object, if ID is invalid, say 0
	    int targetObjectIndex = self->getObjectIndexByID(self->targetObjectID);
		if (targetObjectIndex < 0)
		{
		    // If not targeted a cone object, search closest, insight (within Y limit),
			// TBD: check Is_tracked, Is_Cone objects, Is_vision verified
			targetObjectIndex = self->getNearestConeObjectIndex(AUTO_TARGET_SELECT_LID_LIMIT_Y_M, AUTO_TARGET_SELECT_LID_MIN_X_M, true);		// get new, use lidar space, in meters
			if (targetObjectIndex >= 0)
				self->targetObjectID = self->rearDetectState->objects[targetObjectIndex].ID;
			else
				self->targetObjectID = 0;
		}

		// If current target far away (At Lid, >5m), check if any stable closer target exist, Re-autolock
		if (targetObjectIndex >= 0)
		{
			double distToLid = self->rearDetectState->objects[targetObjectIndex].CenterPoint.x;
			if (distToLid > AUTOLOCK_RELOCK_FAR_DIST_M)
			{
				int newtargetObjectIndex = self->getNearestConeObjectIndex(AUTO_TARGET_SELECT_LID_LIMIT_Y_M, AUTO_TARGET_SELECT_LID_MIN_X_M, false);		// get new, use lidar space, in meters
				//ROS_INFO("RearRobotArmSM[%s]: distToLid=%.3f, currInd=%d, newInd=%d.", armName.c_str(), distToLid, targetObjectIndex, newtargetObjectIndex);
				if (newtargetObjectIndex != targetObjectIndex)
				{
					// If new closer target old enough (>3s, consider as stable target), Re-autolock
					double existTimestamp = self->rearDetectState->objects[newtargetObjectIndex].IDTimestamp;
					double timestampAge = self->rearDetectState->timestamp - existTimestamp;
					ROS_INFO("RearRobotArmSM[%s]: Found closer=%ld, Age=%.3fs.", self->armName.c_str(), self->rearDetectState->objects[newtargetObjectIndex].ID, timestampAge);
					if (timestampAge > AUTOLOCK_RELOCK_STABLE_TIME_SEC)
					{
						targetObjectIndex = newtargetObjectIndex;
						self->targetObjectID = self->rearDetectState->objects[targetObjectIndex].ID;
						ROS_INFO("RearRobotArmSM[%s]: Re-autolock=%ld.", self->armName.c_str(), self->rearDetectState->objects[targetObjectIndex].ID);
					}
				}
			}
		}

//		ROS_INFO("Before call vs_check_position_has_cone.");
		vision_system::vs_check_position_has_cone_Args srv_vs;
		srv_vs.request.x = self->rearDetectState->objects[targetObjectIndex].CenterPoint.x;
		srv_vs.request.y = self->rearDetectState->objects[targetObjectIndex].CenterPoint.y;
//20220817		if (!self->vs_check_position_has_cone.call(srv_vs))
//20220817			ROS_INFO("vs_check_position_has_cone returned error: %ld", (long int)srv_vs.response.response);
//		ROS_INFO("Called vs_check_position_has_cone, result code = %ld.", srv_vs.response.result_code);
		// TBD: select next object if vision check not cone
		self->rear_lt_state_accesskey.unlock();
	}
}

void RearRobotArmSM::lineTrackThreadRun(RearRobotArmSM* self)
{
	// Wait vision function avaliable
	sleep(5);

	// Max re-fresh at 5Hz
	ros::Rate loop_rate(5);
	ROS_INFO("Start rear arm auto line tracking.");
	while (ros::ok())
	{
		loop_rate.sleep();

		if ((self->rearDetectState == NULL) || (self->vs_get_white_marking_position == NULL))
			continue;

		vision_system::vs_get_white_marking_position_Args srv_vs;
		self->roadmarkLine_accesskey.lock();
	    srv_vs.request.x = self->roadmarkLineX;								// Placement line X Pos in robot space (mm)
	    srv_vs.request.y = self->roadmarkLineY;
		if (!self->vs_get_white_marking_position.call(srv_vs))
			ROS_INFO("vs_get_white_marking_position returned error: %ld", (long int)srv_vs.response.response);
//		ROS_INFO("Called vs_get_white_marking_position, result code = %ld, Y = %.3f.", srv_vs.response.result_code, srv_vs.response.y);
		self->roadmarkLineY = srv_vs.response.y;
		self->roadmarkLine_accesskey.unlock();
	}
}

/* Cone Placement SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_ConePlaceInitPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceInitPose");
	UpdateCmdTimestampIfChangeOfState();

	runRouteBatch(conePlaceInitPoseBatchStartBlkNum, conePlaceInitPoseBatchEndBlkNum);
}

void RearRobotArmSM::ST_ConePlaceWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();

	if (PlacementConeChainTemplate->size() <= PlacementConeChainCurrIndex)
	{
		InternalEvent(ST_IDLE, NULL);				// set state and do move
		return;
	}

	// check if LB is ready and reserved
//	RobotArmEventData* psmData = new RobotArmEventData();
	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_LoadToPlace();
	if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
		InternalEvent(ST_CONEPLACE_LBPICK, NULL);	// set state and do move
}

void RearRobotArmSM::ST_ConePlaceLBPick(RobotArmEventData* pData)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceLBPick");
	UpdateCmdTimestampIfChangeOfState();

	int LBStateForPlacement = pLoadingBaySM->getReadyLB_LoadToPlace();
	if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
	{
		runRouteBatch(conePlaceLLBPickBatchStartBlkNum, conePlaceLLBPickBatchEndBlkNum);
		ROS_INFO("Pick to place from left loading bay.");
	}
	else if (LBStateForPlacement == LoadingBaySM::LB_RIGHT)
	{
		runRouteBatch(conePlaceRLBPickBatchStartBlkNum, conePlaceRLBPickBatchEndBlkNum);
		ROS_INFO("Pick to place from right loading bay.");
	}
	else
	{
		InternalEvent(ST_CONEPLACE_WAITLBREADY, NULL);	// set state and do move
		ROS_INFO("Having error, return to waiting.");
	}
}

void RearRobotArmSM::ST_ConePlaceFloorExitLBPick(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceFloorExitLBPick");
	UpdateCmdTimestampIfChangeOfState();

	int LBStateForPlacement = pLoadingBaySM->getReadyLB_LoadToPlace();
	if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
	{
		runRouteBatch(conePlaceLLBExitFloorBatchStartBlkNum, conePlaceLLBPickBatchEndBlkNum);
		ROS_INFO("Floor exit and pick to place from left loading bay.");
	}
	else if (LBStateForPlacement == LoadingBaySM::LB_RIGHT)
	{
		runRouteBatch(conePlaceRLBExitFloorBatchStartBlkNum, conePlaceRLBPickBatchEndBlkNum);
		ROS_INFO("Floor exit and pick place from right loading bay.");
	}
	else
	{
		InternalEvent(ST_CONEPLACE_WAITLBREADY, NULL);	// set state and do move
		ROS_INFO("Having error, return to waiting.");
	}
}

void RearRobotArmSM::ST_ConePlaceWaitForCond(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceWaitForCond");
	UpdateCmdTimestampIfChangeOfState();

	Route* pRoute = searchRouteByName("ConePlaceLLBFloor");		// Same as "ConePlaceRLBFloor"
	#define FL_PL_WAYPOINT_BLK_NUM		4
	double placementFloorZHeight = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.Z;
	double placementFloorXDist = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.X;
	// Compensate with reference to line (road marking) selected
	double placementFloorYDist;
	if (placementRefToLineMode == 0)
		placementFloorYDist = (*PlacementConeChainTemplate)[PlacementConeChainCurrIndex].relativeY + 0;
	else
		placementFloorYDist = (*PlacementConeChainTemplate)[PlacementConeChainCurrIndex].relativeY + roadmarkLineY;
	if (placementFloorYDist > ARM_TCP_LIMIT_Y_MM)
		placementFloorYDist = ARM_TCP_LIMIT_Y_MM;
	if (placementFloorYDist < -ARM_TCP_LIMIT_Y_MM)
		placementFloorYDist = -ARM_TCP_LIMIT_Y_MM;

	// Check route clear to place
	if (rearDetectObjectInDeadZone)
	{
		ROS_INFO("Something blocked the way in dead zone during placement.");
		return;
	}
	double curr_tcp_y = robotArmState->pos_setpt.Y;
	double checkCross = placementFloorYDist * curr_tcp_y;
	if (checkCross > 0)
	{
		// If no cross moving route. Left: -Y, Right: +Y in robot space
		if (placementFloorYDist > 0)
		{
			if (rearDetectObjectInPlaceZoneRight)
			{
				ROS_INFO("Something blocked the way in right placement zone.");
				return;
			}
		}
		else
		{
			if (rearDetectObjectInPlaceZoneLeft)
			{
				ROS_INFO("Something blocked the way in left placement zone.");
				return;
			}
		}
	}
	else
	{
		// If having cross moving route
		if ( (rearDetectObjectInPlaceZoneLeft) || (rearDetectObjectInPlaceZoneRight) || (rearDetectObjectInPlaceZoneCenter) )
		{
			ROS_INFO("Something blocked the way in L/C/R placement zone.");
			return;
		}
	}

	// Check if first placement, or no spacing was selected
	double reqDist = (*PlacementConeChainTemplate)[PlacementConeChainCurrIndex].relativeX;
	if ( (PlacementConeChainCurrIndex == 0) || (reqDist == 0) )
	{
		double maxVel = 0;
		double delayTimeForCmdExec = COLLECTTRACE_CMD_DELAY_SEC + 0.20;		// 0.20s gripper open cone drop delay
		double distToGripPt = calPointDistToRobotArmGripPoint_mm(placementFloorXDist, placementFloorYDist, placementFloorZHeight);
		double gripPfTime = calLinProfileTimeWithSpeedScale(distToGripPt/1000.0, 10.0, 3.0, &maxVel) * 1.70 + delayTimeForCmdExec;	// factor 1.70 for movj + movl mixed move
		ROS_INFO("Placement to floor move calculated profile time = %.3fs, vel = Nil.", gripPfTime);

		// Place regardless last cone distance for the first cone
		InternalEvent(ST_CONEPLACE_FLOOR, NULL);
		return;
	}

	if (targetObjectID > 0)
	{
		double lastConeDist = 9999.9;
		// Cal estimated to floor dist with velocity of cone (vehicle) and arm motion
		// Current wait position to floor position travel time
		double maxVel = 0;
		double delayTimeForCmdExec = COLLECTTRACE_CMD_DELAY_SEC + 0.20;		// 0.20s gripper open cone drop delay
		double distToGripPt = calPointDistToRobotArmGripPoint_mm(placementFloorXDist, placementFloorYDist, placementFloorZHeight);
		double gripPfTime = calLinProfileTimeWithSpeedScale(distToGripPt/1000.0, 10.0, 3.0, &maxVel) * 1.87 + delayTimeForCmdExec;	//was 1.7, factor 1.87 for movj + movl mixed move

		// Last cone (vehicle) travel speed and cal for added distance due to arm motion
	    rear_lt_state_accesskey.lock();
		double objAtDetector_vx = targetObjectVelAtLid.X;			// in m/s
		double objAtDetector_vy = targetObjectVelAtLid.Y;			// in m/s
	    rear_lt_state_accesskey.unlock();
		if (abs(objAtDetector_vx) < COLLECTTRACE_MIN_OBJ_VEL)
			objAtDetector_vx = 0.0;
		if (abs(objAtDetector_vy) < COLLECTTRACE_MIN_OBJ_VEL)
			objAtDetector_vy = 0.0;
		double objSpeedXComp_mm = objAtDetector_vx * gripPfTime * 1000.0;	// should be +ve vel
		lastConeDist = targetObjectPose.X - placementFloorXDist + objSpeedXComp_mm;

		if (reqDist <= lastConeDist)
		{
			ROS_INFO("Placement to floor move calculated profile time = %.3fs, vel = %.3fm/s.", gripPfTime, objAtDetector_vx);
			InternalEvent(ST_CONEPLACE_FLOOR, NULL);
		}
	}
	else
	{
		ROS_INFO("Not found last placed cone! Place Now.");
		InternalEvent(ST_CONEPLACE_FLOOR, NULL);
	}
}

void RearRobotArmSM::ST_ConePlaceFloor(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceFloor");
	UpdateCmdTimestampIfChangeOfState();

	// Update Floor Y Position
	Route* pFloorRoute = searchRouteByName("ConePlaceLLBFloor");		// Same as "ConePlaceRLBFloor"
	#define FL_PL_WAYPOINT_BLK_NUM		4
	double placementFloorXDist = pFloorRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.X;
	// Compensate with reference to line (road marking) selected
	double placementFloorYDist;
	if (placementRefToLineMode == 0)
		placementFloorYDist = (*PlacementConeChainTemplate)[PlacementConeChainCurrIndex].relativeY + 0;
	else
		placementFloorYDist = (*PlacementConeChainTemplate)[PlacementConeChainCurrIndex].relativeY + roadmarkLineY;
	if (placementFloorYDist > ARM_TCP_LIMIT_Y_MM)
		placementFloorYDist = ARM_TCP_LIMIT_Y_MM;
	if (placementFloorYDist < -ARM_TCP_LIMIT_Y_MM)
		placementFloorYDist = -ARM_TCP_LIMIT_Y_MM;

	kuka_robot::kr_batch_mv_bypose_Args srv;
	int LBStateForPlacement = pLoadingBaySM->getReadyLB_LoadToPlace();
	if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
	{
		Route* pRoute = searchRouteByName("ConePlaceLLBFloor");
		srv.request.pose.X = placementFloorXDist;
		srv.request.pose.Y = placementFloorYDist;
		srv.request.pose.Z = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.Z;
		srv.request.pose.A = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.A;
		srv.request.pose.B = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.B;
		srv.request.pose.C = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.C;
		srv.request.pose.S = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.S;
		srv.request.pose.T = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.T;
		srv.request.round = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_ROUNDM;
		srv.request.block = conePlaceLLBFloorBatchStartBlkNum + FL_PL_WAYPOINT_BLK_NUM;
		if (!kr_set_batch_movj_bypose.call(srv))
			ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

		runRouteBatch(conePlaceLLBFloorBatchStartBlkNum, conePlaceLLBFloorBatchEndBlkNum);
		ROS_INFO("Place exit from left loading bay to floor.");
	}
	else if (LBStateForPlacement == LoadingBaySM::LB_RIGHT)
	{
		Route* pRoute = searchRouteByName("ConePlaceRLBFloor");
		srv.request.pose.X = placementFloorXDist;
		srv.request.pose.Y = placementFloorYDist;
		srv.request.pose.Z = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.Z;
		srv.request.pose.A = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.A;
		srv.request.pose.B = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.B;
		srv.request.pose.C = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.C;
		srv.request.pose.S = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.S;
		srv.request.pose.T = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_POS.T;
		srv.request.round = pRoute->waypoints[FL_PL_WAYPOINT_BLK_NUM].BATCH_ROUNDM;
		srv.request.block = conePlaceRLBFloorBatchStartBlkNum + FL_PL_WAYPOINT_BLK_NUM;
		if (!kr_set_batch_movj_bypose.call(srv))
			ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

		runRouteBatch(conePlaceRLBFloorBatchStartBlkNum, conePlaceRLBFloorBatchEndBlkNum);
		ROS_INFO("Place exit from right loading bay to floor.");
	}
	else
	{
		ROS_INFO("Having error. Place pick up but no LB lock.");
		return;
	}

	// Enable release LB exclusive lock by moving out
	pLoadingBaySM->enable_ReleaseLB_ExclusiveLock_IfMovOut(1);
}

void RearRobotArmSM::ST_ConePlaceCompleted(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConePlaceCompleted");
	double dT = ros::Time::now().toSec() - previousMotionCmdTimestamp;
	UpdateCmdTimestampIfChangeOfState();

	ROS_INFO("Placement to floor move actual (plus exit) stateChangeT=%.3fs.", dT);

	// Re-fresh and select the closest cone target (probably just place)
	// TBD: better --> set the target ID by position
	targetObjectID = 0;

	double cycleTime = ros::Time::now().toSec() - cycleStartTimeStamp;
	cycleStartTimeStamp = ros::Time::now().toSec();
	ROS_INFO("Rear Arm placement [%d] cycle time = %.3fs.", PlacementConeChainCurrIndex, cycleTime);

	// Check if all placement completed
	PlacementConeChainCurrIndex++;
	if (PlacementConeChainTemplate->size() <= PlacementConeChainCurrIndex)
	{
		int LBStateForPlacement = pLoadingBaySM->getReadyLB_LoadToPlace();
		if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
			runRouteBatch(conePlaceLLBExitFloorBatchStartBlkNum, conePlaceLLBExitFloorBatchEndBlkNum);
		else
			runRouteBatch(conePlaceRLBExitFloorBatchStartBlkNum, conePlaceRLBExitFloorBatchEndBlkNum);
		return;
	}

	// check if LB is ready and reserved
//	RobotArmEventData* psmData = new RobotArmEventData();
	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_LoadToPlace();
	if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
		InternalEvent(ST_CONEPLACE_FLOOREXITLBPICK, NULL);		// set state and do move
	else
	{
		int LBStateForPlacement = pLoadingBaySM->getReadyLB_LoadToPlace();
		if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
			runRouteBatch(conePlaceLLBExitFloorBatchStartBlkNum, conePlaceLLBExitFloorBatchEndBlkNum);
		else
			runRouteBatch(conePlaceRLBExitFloorBatchStartBlkNum, conePlaceRLBExitFloorBatchEndBlkNum);
		return;
	}
}


/* Cone Collection SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_ConeCollectInitPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectInitPose");
	UpdateCmdTimestampIfChangeOfState();

	runRouteBatch(coneCollectInitPoseBatchStartBlkNum, coneCollectInitPoseBatchEndBlkNum);
}

void RearRobotArmSM::ST_ConeCollectAim(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectAim");
	UpdateCmdTimestampIfChangeOfState();

	if (CollectionConeAmount <= CollectionConeCount)
	{
		InternalEvent(ST_IDLE, NULL);					// set state and do move
		return;
	}

	if (targetObjectID <= 0)
	{
		ROS_INFO("Rear Arm waiting cone to aim.");
	    InternalEvent(ST_CONECOLLECT_INITPOSE, NULL);	// set state and do move
	    return;
	}

	// Check if something blocked in dead zone
	if (rearDetectObjectInDeadZone)
	{
		ROS_INFO("Something blocked the way in dead zone during collection.");
		return;
	}

	if (rearDetectNonLockObjectInOperationZone)
	{
		ROS_INFO("Non-target object blocked in operation zone during collection.");
		return;
	}

	// Enable cancel cmd
	collectCancelCmdCount = 0;
	collectCatchCanReach = -1;
}

void RearRobotArmSM::ST_ConeCollectTraceGripEntry(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ConeCollectTraceGripEntry");
	UpdateCmdTimestampIfChangeOfState();

	// Update, predict or project target object position
	double targetPosAtLid_x, targetPosAtLid_y;
	double targetPosAtArmTCP_x, targetPosAtArmTCP_y;
	if (targetObjectID > 0)
		collectCatchCanReach = predictArmGripPositionWithTarget(&targetPosAtLid_x, &targetPosAtLid_y, &targetPosAtArmTCP_x, &targetPosAtArmTCP_y);
	else
		collectCatchCanReach = -1;

	// Check again after time consuming routine
	if (targetObjectID <= 0)
	{
		ROS_INFO("RearRobotArmSM[%s]: Target lost!", armName.c_str());
		InternalEvent(ST_CONECOLLECT_LOST, NULL);
		return;
	}
	if (collectCatchCanReach < 0)
	{
		ROS_INFO("RearRobotArmSM[%s]: Tracing object have problem. Re-Aim...", armName.c_str());
		InternalEvent(ST_CONECOLLECT_LOST, NULL);
		return;
	}

	// If only catch at stop
	if ( collectAtStationary && (collectCatchCanReach != 1) )
		return;

	if (collectCatchCanReach == 0)		// Not reachable or Not right time to catch
	{
		// Cmd arm to projected standby position, if position error is large between cmd and target position, and current object position far away
		double DistStandbyPosToCmd = calPointDist(targetPosAtArmTCP_x, targetPosAtArmTCP_y, 0, targetObjectCmdTracePose.X, targetObjectCmdTracePose.Y, 0);
		double distBetweenGripPtAndObj = calPointDistToRobotArmGripPoint2D_mm(targetObjectPose.X, targetObjectPose.Y);
	    rear_lt_state_accesskey.lock();
		double objAtDetector_vx = targetObjectVelAtLid.X;			// in m/s
		double objAtDetector_vy = targetObjectVelAtLid.Y;			// in m/s
	    rear_lt_state_accesskey.unlock();

	    // TBD: Debug sudden zero bug
	    if ( (targetObjectVelAtLid.X == 0) && (targetObjectVelAtLid.Y == 0) && (targetObjectAccAtLid.X == 0) && (targetObjectAccAtLid.Y == 0) )
	    {
			ROS_INFO("Discovered target vel acc all zero. Potential bug. Skip in trace.");
	    	return;
	    }
	    if ( (targetObjectVelAtLid.X == 0.00001314) && (targetObjectVelAtLid.Y == 0.00001314) )
	    {
			ROS_INFO("Discovered target vel not updated. Potential bug. Skip in trace.");
	    	return;
	    }

/*		double objSpeedXComp_mm = -objAtDetector_vx * 2.5 * 1000.0;// Assume the worst pftime is 2.5s
		double NoUpdate_Dist = COLLECTTRACE_TRACENOUPD_DIST_MM + objSpeedXComp_mm;*/
		double NoUpdate_Dist = COLLECTTRACE_TRACENOUPD_DIST_MM;
		if (abs(objAtDetector_vx) > COLLECTTRACE_MIN_OBJ_VEL)
			NoUpdate_Dist = COLLECTTRACE_TRACENOUPD_DIST_MM + 1000.0;	// No update move when moving object close to around 1m
		if ( (DistStandbyPosToCmd > COLLECTTRACE_CORRECT_TOL_MM) &&
				(distBetweenGripPtAndObj > NoUpdate_Dist) )
		{
			ROS_INFO("Tracing(Update) MovJbyPose: StandbyPosToCmd=%.3f, ObjDist=%.3f.", DistStandbyPosToCmd, distBetweenGripPtAndObj);
			targetObjectCmdTracePose.X = targetPosAtArmTCP_x;
			targetObjectCmdTracePose.Y = targetPosAtArmTCP_y;

			previousMotionCmdTimestamp = ros::Time::now().toSec();		// set timestamp only if call move directly
			kuka_robot::kr_mv_bypose_Args srv;
			srv.request.pose.X = targetObjectCmdTracePose.X;
			srv.request.pose.Y = targetObjectCmdTracePose.Y;
			srv.request.pose.Z = targetObjectCmdTracePose.Z;
			srv.request.pose.A = targetObjectCmdTracePose.A;
			srv.request.pose.B = targetObjectCmdTracePose.B;
			srv.request.pose.C = targetObjectCmdTracePose.C;
			srv.request.pose.S = -1;
			srv.request.pose.T = -1;
			if (!kr_movj_bypose.call(srv))
				ROS_INFO("kr_movj_bypose returned error: %ld", (long int)srv.response.response);
		}

		// Cmd arm at least every 7sec to avoid arm entering brake mode
		if ((ros::Time::now().toSec() - previousMotionCmdTimestamp) > 7.0)
		{
			ROS_INFO("Tracing(Unbrake) MovJbyPose: CurrToCmd=previous position.");

			previousMotionCmdTimestamp = ros::Time::now().toSec();		// set timestamp only if call move directly
			kuka_robot::kr_mv_bypose_Args srv;
			srv.request.pose.X = 0;
			srv.request.pose.Y = 0;
			srv.request.pose.Z = 0;
			srv.request.pose.A = 0;
			srv.request.pose.B = 0;
			srv.request.pose.C = 0;
			srv.request.pose.S = -1;
			srv.request.pose.T = -1;
			if (!kr_movlrel_bypose.call(srv))
				ROS_INFO("kr_movlrel_bypose returned error: %ld", (long int)srv.response.response);
		}
	}
	else								// Right time to catch (>=1)
	{
		// MovL to predicted position by cone grip
		targetObjectCmdTracePose.X = targetPosAtArmTCP_x;
		targetObjectCmdTracePose.Y = targetPosAtArmTCP_y;
		InternalEvent(ST_CONECOLLECT_CONEGRIP, NULL);
	}
}

void RearRobotArmSM::ST_ConeCollectConeGrip(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectConeGrip");
	UpdateCmdTimestampIfChangeOfState();

	// Check again after time consuming routine
	if (targetObjectID <= 0)
	{
		ROS_INFO("RobotArmSM[%s]: Target lost!", armName.c_str());
		InternalEvent(ST_CONECOLLECT_LOST, NULL);
		return;
	}

	// MovL to predicted position (pass thur entry point), cal go to calculated orientation.
	/*		+X
	 * 		|
	 * 	 -C | +C
	 * +Y--------Y
	 */
//	kr_state_accesskey.lock();
//	double deltaX = targetObjectCmdTracePose.X - robotArmState->pos_setpt.X;
//	double deltaY = targetObjectCmdTracePose.Y - robotArmState->pos_setpt.Y;
//	kr_state_accesskey.unlock();
	double deltaX = targetObjectCmdTracePose.X;									// if catch use angle from base
	double deltaY = targetObjectCmdTracePose.Y;
	if (deltaX == 0)	deltaX = 0.0001;
	if (deltaY == 0)	deltaY = 0.00001;
	double angleA = 0.001;
	double angleB = 89.99;
	double angleC = -atan(deltaY/deltaX)/M_PI*180.0;
	if (deltaX < 0)
	{
		if (deltaY < 0)
			angleC = 180.0 - angleC;
		else
			angleC = -180.0 - angleC;
	}
	// Limit AngleC
	if (angleC > 60.0)
		angleC = 60.0;
	else if (angleC < -60.0)
		angleC = 60.0;

	// TBD: AngleA, AngleB correction by arm detectors
	// Static grip up (=1) or Moving grip up (>1)
	if (collectCatchCanReach == 1)
	{
		ROS_INFO("Go Static GripIn MovLbyPose: [%.3f,%.3f,%.3f] C=%.3f.",
				targetObjectCmdTracePose.X, targetObjectCmdTracePose.Y, collectFloorZHeight, angleC);
	}
	else
	{
		angleA = targetObjectCmdTracePose.A;
		angleB = targetObjectCmdTracePose.B;
		angleC = targetObjectCmdTracePose.C;

		// No modify angles for speed
		ROS_INFO("Go Moving GripIn MovLbyPose: [%.3f,%.3f,%.3f] C=%.3f.",
				targetObjectCmdTracePose.X, targetObjectCmdTracePose.Y, collectFloorZHeight, angleC);
	}

	// Catch move in (Use single cmd for speed, no adjust angle)
	previousMotionCmdTimestamp = ros::Time::now().toSec();		// set timestamp only if call move directly
	kuka_robot::kr_mv_bypose_Args srv;
	srv.request.pose.X = targetObjectCmdTracePose.X;
	srv.request.pose.Y = targetObjectCmdTracePose.Y;
	srv.request.pose.Z = collectFloorZHeight; 					// from ConeCollectConeGrip batch
	srv.request.pose.A = angleA;
	srv.request.pose.B = angleB;
	srv.request.pose.C = angleC;
	srv.request.pose.S = -1;
	srv.request.pose.T = -1;
	if (!kr_movl_bypose.call(srv))
		ROS_INFO("kr_movl_bypose returned error: %ld", (long int)srv.response.response);

	// Update "ConeCollectGripUp" batch backward move position (element 1) for next move first
	rear_lt_state_accesskey.lock();
	double objAtDetector_vx = targetObjectVelAtLid.X;			// in m/s
	double objAtDetector_vy = targetObjectVelAtLid.Y;			// in m/s
	rear_lt_state_accesskey.unlock();
	if (abs(objAtDetector_vx) < COLLECTTRACE_MIN_OBJ_VEL)
		objAtDetector_vx = 0.0;
	if (abs(objAtDetector_vy) < COLLECTTRACE_MIN_OBJ_VEL)
		objAtDetector_vy = 0.0;
	double objSpeedXComp_mm = objAtDetector_vx * 1.5 * 1000.0;	// should be -ve vel, assume duration in 1.5s
	double finalPosTCPx = targetObjectCmdTracePose.X + objSpeedXComp_mm;
	if ( finalPosTCPx < CATCH_COMPMOV_TCP_LIMIT_X_MM )
		objSpeedXComp_mm = -(targetObjectCmdTracePose.X - CATCH_COMPMOV_TCP_LIMIT_X_MM);
	Route* pRoute = searchRouteByName("ConeCollectGripUp");
	kuka_robot::kr_batch_mv_bypose_Args srv2;
	#define FL_CO_WAYPOINT_BLK_NUM		1
	srv2.request.pose.X = objSpeedXComp_mm;
	srv2.request.pose.Y = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.Y;
	srv2.request.pose.Z = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.Z;
	srv2.request.pose.A = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.A;
	srv2.request.pose.B = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.B;
	srv2.request.pose.C = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.C;
	srv2.request.pose.S = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.S;
	srv2.request.pose.T = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_POS.T;
	srv2.request.round = pRoute->waypoints[FL_CO_WAYPOINT_BLK_NUM].BATCH_ROUNDM;
	srv2.request.block = coneCollectGripUpBatchStartBlkNum + FL_CO_WAYPOINT_BLK_NUM;
	if (!kr_set_batch_movlrel_bypose.call(srv2))
		ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);
}

void RearRobotArmSM::ST_ConeCollectGripUp(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectGripUp");
	double dT = ros::Time::now().toSec() - previousMotionCmdTimestamp;
	UpdateCmdTimestampIfChangeOfState();

	ROS_INFO("Last ConeGrip MovL actual motT=%.3fs stateChangeT=%.3fs.", (robotArmState->com_last_mot_time/1000.0), dT);

	runRouteBatch(coneCollectGripUpBatchStartBlkNum, coneCollectGripUpBatchEndBlkNum);			// grip-back-up
}

void RearRobotArmSM::ST_ConeCollectCheckGripOK(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectCheckGripOK");
	double dT = ros::Time::now().toSec() - previousMotionCmdTimestamp;
	UpdateCmdTimestampIfChangeOfState();

	ROS_INFO("Last GripUp Batch actual motT=%.3fs stateChangeT=%.3fs.", (robotArmState->com_last_mot_time/1000.0), dT);
	// TBD: This is to-check grip, can add clear previous grip sensor state

	// State switching / handling by OnUpdateArmDetectorState()
}

void RearRobotArmSM::ST_ConeCollectWaitLBPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectWaitLBPose");
	UpdateCmdTimestampIfChangeOfState();
	runRouteBatch(coneCollectWaitLBPoseBatchStartBlkNum, coneCollectWaitLBPoseBatchEndBlkNum);
}

void RearRobotArmSM::ST_ConeCollectWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();

	// check if LB is ready and reserved
//	RobotArmEventData* psmData = new RobotArmEventData();
	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_CollectToLoad();
	if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
		InternalEvent(ST_CONECOLLECT_LBFILL, NULL);	// set state and do move
}

void RearRobotArmSM::ST_ConeCollectLBFill(RobotArmEventData* pData)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectLBFill");
	UpdateCmdTimestampIfChangeOfState();

	int LBStateForCollection = pLoadingBaySM->getReadyLB_CollectToLoad();
	if (LBStateForCollection == LoadingBaySM::LB_LEFT)
	{
		runRouteBatch(coneCollectLLBFillBatchStartBlkNum, coneCollectLLBFillBatchEndBlkNum);
		ROS_INFO("Collect to left loading bay.");
	}
	else if (LBStateForCollection == LoadingBaySM::LB_RIGHT)
	{
		runRouteBatch(coneCollectRLBFillBatchStartBlkNum, coneCollectRLBFillBatchEndBlkNum);
		ROS_INFO("Collect to right loading bay.");
	}
	else
	{
		InternalEvent(ST_CONECOLLECT_WAITLBREADY, NULL);	// set state and do move
		ROS_INFO("Having error, return to waiting.");
	}

	// By this move, target will lost and re-target next object
}

void RearRobotArmSM::ST_ConeCollectLost(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectLost");
	UpdateCmdTimestampIfChangeOfState();

	targetObjectCmdTracePose.X = 0;
	targetObjectCmdTracePose.Y = 0;
	// Open grip, back MovLRel, go AIM/Trace again
	runRouteBatch(coneCollectConeGripFailBatchStartBlkNum, coneCollectConeGripFailBatchEndBlkNum);
}

void RearRobotArmSM::ST_ConeCollectConeGripFail(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectConeGripFail");
	UpdateCmdTimestampIfChangeOfState();

	targetObjectCmdTracePose.X = 0;
	targetObjectCmdTracePose.Y = 0;
	// Open grip, back MovLRel, go AIM/Trace again
	runRouteBatch(coneCollectConeGripFailBatchStartBlkNum, coneCollectConeGripFailBatchEndBlkNum);
}

void RearRobotArmSM::ST_ConeCollectCompleted(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_ConeCollectCompleted");
	UpdateCmdTimestampIfChangeOfState();

	bool armToTrace = true;

	double cycleTime = ros::Time::now().toSec() - cycleStartTimeStamp;
	cycleStartTimeStamp = ros::Time::now().toSec();
	ROS_INFO("Rear Arm collection [%d] cycle time = %.3fs.", CollectionConeCount, cycleTime);

	// Collection completed counter +1
	CollectionConeCount++;
	if (CollectionConeAmount <= CollectionConeCount)
		armToTrace = false;

	double targetPosAtLid_x, targetPosAtLid_y;
	double targetPosAtArmTCP_x, targetPosAtArmTCP_y;
	if (targetObjectID > 0)
		collectCatchCanReach = predictArmGripPositionWithTarget(&targetPosAtLid_x, &targetPosAtLid_y, &targetPosAtArmTCP_x, &targetPosAtArmTCP_y);
	else
		collectCatchCanReach = -1;

	// Unreachable valid target (0) will go Trace position, TBD: handle ready reachable moving target(2) case
	if (collectCatchCanReach != 0)
		armToTrace = false;

	if (collectAtStationary)
		armToTrace = false;

	int LBStateForCollection = pLoadingBaySM->getReadyLB_CollectToLoad();
	if (LBStateForCollection == LoadingBaySM::LB_LEFT)
	{
		if (armToTrace)
		{
			targetObjectCmdTracePose.X = targetPosAtArmTCP_x;
			targetObjectCmdTracePose.Y = targetPosAtArmTCP_y;
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = targetObjectCmdTracePose.X;
			srv.request.pose.Y = targetObjectCmdTracePose.Y;
			srv.request.pose.Z = targetObjectCmdTracePose.Z;
			srv.request.pose.A = targetObjectCmdTracePose.A;
			srv.request.pose.B = targetObjectCmdTracePose.B;
			srv.request.pose.C = targetObjectCmdTracePose.C;
			srv.request.pose.S = -1;
			srv.request.pose.T = -1;
			srv.request.round = 0;
			srv.request.block = coneCollectLLBExitBatchEndBlkNum;
			if (!kr_set_batch_movj_bypose.call(srv))
				ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);
		}
		else
		{
			targetObjectCmdTracePose.X = 0;
			targetObjectCmdTracePose.Y = 0;
			Route* pRoute = searchRouteByName("ConeCollectInitPose");

		    rear_lt_state_accesskey.lock();
			double tcpx = targetObjectPose.X;
			double tcpy = targetObjectPose.Y;
			rear_lt_state_accesskey.unlock();
			// Reset pose (init pose) with a base angle
			if (tcpx == 0)	tcpx = 0.001;
			if (tcpy == 0)	tcpy = 0.00001;
			double baseAngle = atan(tcpy/tcpx)/M_PI*180.0;
			if (tcpx >= 0)
				baseAngle = -baseAngle;
			else
			{
				if (tcpy < 0)
					baseAngle = 180.0 - baseAngle;
				else
					baseAngle = -180.0 - baseAngle;
			}
			kuka_robot::kr_batch_mv_byjoint_Args srv;
			srv.request.joints.A1 = baseAngle;
			srv.request.joints.A2 = pRoute->waypoints[0].BATCH_E6AXIS.A2;
			srv.request.joints.A3 = pRoute->waypoints[0].BATCH_E6AXIS.A3;
			srv.request.joints.A4 = pRoute->waypoints[0].BATCH_E6AXIS.A4;
			srv.request.joints.A5 = pRoute->waypoints[0].BATCH_E6AXIS.A5;
			srv.request.joints.A6 = pRoute->waypoints[0].BATCH_E6AXIS.A6;
			srv.request.round = pRoute->waypoints[0].BATCH_ROUNDM;
			srv.request.block = coneCollectLLBExitBatchEndBlkNum;
			if (!kr_set_batch_movj_byjoint.call(srv))
				ROS_INFO("kr_set_batch_movj_byjoint returned error: %ld", (long int)srv.response.response);
		}

		runRouteBatch(coneCollectLLBExitBatchStartBlkNum, coneCollectLLBExitBatchEndBlkNum);
		ROS_INFO("Collect completed. Moving out from left loading bay.");
	}
	else if (LBStateForCollection == LoadingBaySM::LB_RIGHT)
	{
		if (armToTrace)
		{
			targetObjectCmdTracePose.X = targetPosAtArmTCP_x;
			targetObjectCmdTracePose.Y = targetPosAtArmTCP_y;
			kuka_robot::kr_batch_mv_bypose_Args srv;
			srv.request.pose.X = targetObjectCmdTracePose.X;
			srv.request.pose.Y = targetObjectCmdTracePose.Y;
			srv.request.pose.Z = targetObjectCmdTracePose.Z;
			srv.request.pose.A = targetObjectCmdTracePose.A;
			srv.request.pose.B = targetObjectCmdTracePose.B;
			srv.request.pose.C = targetObjectCmdTracePose.C;
			srv.request.pose.S = -1;
			srv.request.pose.T = -1;
			srv.request.round = 0;
			srv.request.block = coneCollectRLBExitBatchEndBlkNum;
			if (!kr_set_batch_movj_bypose.call(srv))
				ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);
		}
		else
		{
			targetObjectCmdTracePose.X = 0;
			targetObjectCmdTracePose.Y = 0;
			Route* pRoute = searchRouteByName("ConeCollectInitPose");

		    rear_lt_state_accesskey.lock();
			double tcpx = targetObjectPose.X;
			double tcpy = targetObjectPose.Y;
			rear_lt_state_accesskey.unlock();
			// Reset pose (init pose) with a base angle
			if (tcpx == 0)	tcpx = 0.001;
			if (tcpy == 0)	tcpy = 0.00001;
			double baseAngle = atan(tcpy/tcpx)/M_PI*180.0;
			if (tcpx >= 0)
				baseAngle = -baseAngle;
			else
			{
				if (tcpy < 0)
					baseAngle = 180.0 - baseAngle;
				else
					baseAngle = -180.0 - baseAngle;
			}
			kuka_robot::kr_batch_mv_byjoint_Args srv;
			srv.request.joints.A1 = baseAngle;
			srv.request.joints.A2 = pRoute->waypoints[0].BATCH_E6AXIS.A2;
			srv.request.joints.A3 = pRoute->waypoints[0].BATCH_E6AXIS.A3;
			srv.request.joints.A4 = pRoute->waypoints[0].BATCH_E6AXIS.A4;
			srv.request.joints.A5 = pRoute->waypoints[0].BATCH_E6AXIS.A5;
			srv.request.joints.A6 = pRoute->waypoints[0].BATCH_E6AXIS.A6;
			srv.request.round = pRoute->waypoints[0].BATCH_ROUNDM;
			srv.request.block = coneCollectRLBExitBatchEndBlkNum;
			if (!kr_set_batch_movj_byjoint.call(srv))
				ROS_INFO("kr_set_batch_movj_byjoint returned error: %ld", (long int)srv.response.response);
		}

		runRouteBatch(coneCollectRLBExitBatchStartBlkNum, coneCollectRLBExitBatchEndBlkNum);
		ROS_INFO("Collect completed. Moving out from right loading bay.");
	}
	else
	{
		ROS_INFO("Having error. Collect completed but no LB lock.");
		return;
	}

	// Enable release LB exclusive lock by moving out
	pLoadingBaySM->enable_ReleaseLB_ExclusiveLock_IfMovOut(1);
}

/* Safe Home-ing SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_SafeHomeHandleRearSide(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SafeHomeHandleRearSide");
	UpdateCmdTimestampIfChangeOfState();

	// Check if gripper outside the rear part (at operation zone), open gripper->home
	kr_state_accesskey.lock();
	double curr_tcp_x = robotArmState->pos_setpt.X;
	int curr_do_port = robotArmState->com_do_port_value;
    kr_state_accesskey.unlock();

    // If inside truck, go to other state
    if (curr_tcp_x < ARM_TCP_LIMIT_X_MM)
    {
		InternalEvent(ST_SAFEHOME_HANDLETRUCKSIDE, NULL);			// set state and do move
		return;
    }

	// If outside truck, grip closed
	if ((curr_do_port & 0x8000) || (curr_do_port & 0x4000))
	{
		// Open grip, bit 15,14 are upper and lower gripper control pin
		previousMotionCmdTimestamp = ros::Time::now().toSec();	// set timestamp only if call move directly
		kuka_robot::kr_setdo_Args srv;
		srv.request.value = 0x0000;
		srv.request.mask = 0xE000;
		srv.request.settle_sec = 1.0;
		if (!kr_setdigitaloutput.call(srv))
			ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
	}
}

void RearRobotArmSM::ST_SafeHomeHandleTruckSide(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SafeHomeHandleTruckSide");
	UpdateCmdTimestampIfChangeOfState();

	kr_state_accesskey.lock();
	double curr_tcp_x = robotArmState->pos_setpt.X;
	double curr_tcp_z = robotArmState->pos_setpt.Z;
	int curr_do_port = robotArmState->com_do_port_value;
    kr_state_accesskey.unlock();

	// Check if something in grip and grip closed, put to an empty LB
    if ( (armDetectObjectInGrip) &&
    	((curr_do_port & 0x8000) || (curr_do_port & 0x4000)) )
	{
		int LBStateForCollection = pLoadingBaySM->getReadyLB_CollectToLoad();
		if (LBStateForCollection == LoadingBaySM::LB_LEFT)
		{
			if (curr_tcp_x > 0)
				runRouteBatch(coneCollectLLBFillBatchStartBlkNum, coneCollectLLBFillBatchEndBlkNum);
			else if (curr_tcp_z < 1560)
				runRouteBatch(coneCollectLLBFillBatchStartBlkNum+3, coneCollectLLBFillBatchEndBlkNum);
			else
				runRouteBatch(coneCollectLLBFillBatchStartBlkNum+2, coneCollectLLBFillBatchEndBlkNum);
			ROS_INFO("Put cone to left loading bay.");
		}
		else if (LBStateForCollection == LoadingBaySM::LB_RIGHT)
		{
			if (curr_tcp_x > 0)
				runRouteBatch(coneCollectRLBFillBatchStartBlkNum, coneCollectRLBFillBatchEndBlkNum);
			else if (curr_tcp_z < 1560)
				runRouteBatch(coneCollectRLBFillBatchStartBlkNum+3, coneCollectRLBFillBatchEndBlkNum);
			else
				runRouteBatch(coneCollectRLBFillBatchStartBlkNum+2, coneCollectRLBFillBatchEndBlkNum);
			ROS_INFO("Put cone to right loading bay.");
		}
		else
		{
			// Open grip, bit 15,14 are upper and lower gripper control pin
			previousMotionCmdTimestamp = ros::Time::now().toSec();		// set timestamp only if call move directly
			kuka_robot::kr_setdo_Args srv;
			srv.request.value = 0x0000;
			srv.request.mask = 0xE000;
			srv.request.settle_sec = 1.0;
			if (!kr_setdigitaloutput.call(srv))
				ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
			ROS_INFO("No space in loading bay. Just drop it.");
		}
	}
    else
		ROS_INFO("Nothing gripped so no need put back Loading Bay.");
}

void RearRobotArmSM::ST_SafeHomeCheckGripCenterExit(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SafeHomeCheckGripCenterExit");
	UpdateCmdTimestampIfChangeOfState();

	if (armDetectObjectInGrip)
	{
		// Go movlreltool to center (exit waypoint)
		previousMotionCmdTimestamp = ros::Time::now().toSec();		// set timestamp only if call move directly
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = -50.0;
		srv.request.pose.Y = 0;
		srv.request.pose.Z = -200.0;
		srv.request.pose.A = 0;
		srv.request.pose.B = 0;
		srv.request.pose.C = 0;
		srv.request.pose.S = -1;
		srv.request.pose.T = -1;
		if (!kr_movlreltool_bypose.call(srv))
			ROS_INFO("kr_movlreltool_bypose returned error: %ld", (long int)srv.response.response);
		ROS_INFO("Do exit move.");
	}
    else
		ROS_INFO("Nothing in grip area so no exit move.");
}


/* Stand Placement SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_StandPlaceInitPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandPlaceInitPose");
	UpdateCmdTimestampIfChangeOfState();

	//signStandPosX;
	//signStandPosY;
	if (signStandLBLocation == 2)
		runRouteBatch(standPlaceLLBInitPoseBatchStartBlkNum, standPlaceLLBFloorBatchEndBlkNum);
	else if (signStandLBLocation == 1)
		runRouteBatch(standPlaceRLBInitPoseBatchStartBlkNum, standPlaceRLBFloorBatchEndBlkNum);
	else if (signStandLBLocation == 0)
		runRouteBatch(standPlaceRLB2InitPoseBatchStartBlkNum, standPlaceRLB2FloorBatchEndBlkNum);
}

void RearRobotArmSM::ST_StandPlaceWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandPlaceWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandPlaceLBPick(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandPlaceLBPick");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandPlaceWaitForCond(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandPlaceWaitForCond");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandPlaceFloor(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandPlaceFloor");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandPlaceCompleted(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandPlaceCompleted");
	UpdateCmdTimestampIfChangeOfState();
}


/* Stand Placement SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_StandCollectInitPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectInitPose");
	UpdateCmdTimestampIfChangeOfState();

	runRouteBatch(standCollectInitPoseBatchStartBlkNum, standCollectStandGripBatchEndBlkNum);
}

void RearRobotArmSM::ST_StandCollectAim(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectAim");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandCollectTraceGripEntry(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectTraceGripEntry");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandCollectStandGrip(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectStandGrip");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandCollectGripUp(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectGripUp");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandCollectWaitLBPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectWaitLBPose");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandCollectWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_StandCollectLBFill(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectLBFill");
	UpdateCmdTimestampIfChangeOfState();

	//signStandPosX;
	//signStandPosY;
	if (signStandLBLocation == 2)
		runRouteBatch(standCollectLLBFillBatchStartBlkNum, standCollectLLBFillBatchEndBlkNum);
	else if (signStandLBLocation == 1)
		runRouteBatch(standCollectRLBFillBatchStartBlkNum, standCollectRLBFillBatchEndBlkNum);
	else if (signStandLBLocation == 0)
		runRouteBatch(standCollectRLB2FillBatchStartBlkNum, standCollectRLB2FillBatchEndBlkNum);
}

void RearRobotArmSM::ST_StandCollectCompleted(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_StandCollectCompleted");
	UpdateCmdTimestampIfChangeOfState();
}


/* Sign Placement SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_SignPlaceInitPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignPlaceInitPose");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignPlaceWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignPlaceWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignPlaceLBPick(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignPlaceLBPick");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignPlaceWaitForCond(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignPlaceWaitForCond");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignPlaceFloor(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignPlaceFloor");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignPlaceCompleted(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignPlaceCompleted");
	UpdateCmdTimestampIfChangeOfState();
}


/* Sign Placement SM ---------------------------------------------------------------------------------*/
void RearRobotArmSM::ST_SignCollectInitPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectInitPose");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectAim(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectAim");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectTraceGripEntry(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectTraceGripEntry");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectSignGrip(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectSignGrip");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectGripUp(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectGripUp");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectWaitLBPose(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectWaitLBPose");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectLBFill(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectLBFill");
	UpdateCmdTimestampIfChangeOfState();
}

void RearRobotArmSM::ST_SignCollectCompleted(RobotArmEventData*)
{
	ROS_INFO("RearRobotArmSM::ST_SignCollectCompleted");
	UpdateCmdTimestampIfChangeOfState();
}




