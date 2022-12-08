#include <assert.h>
#include <iostream>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "FrontRobotArmSM.h"


#define ARM_GRIP_CONE_DIST_M				0.270	//0.150	//0.300 //0.270


FrontRobotArmSM::FrontRobotArmSM() : conePlaceInitPoseBatchStartBlkNum(0), conePlaceInitPoseBatchEndBlkNum(0),
		conePlaceLBExitBatchStartBlkNum(0), conePlaceLBExitBatchEndBlkNum(0),
		conePlaceSBPickBatchStartBlkNum(0), conePlaceSBPickBatchEndBlkNum(0),
		conePlaceLBFillBatchStartBlkNum(0), conePlaceLBFillBatchEndBlkNum(0),
		conePlaceLRPickFillBatchStartBlkNum(0), conePlaceLRPickFillBatchEndBlkNum(0),
		coneCollectInitPoseBatchStartBlkNum(0), coneCollectInitPoseBatchEndBlkNum(0),
		coneCollectSBExitBatchStartBlkNum(0), coneCollectSBExitBatchEndBlkNum(0),
		coneCollectLBPickBatchStartBlkNum(0), coneCollectLBPickBatchEndBlkNum(0),
		coneCollectSBExitLRWayptBatchStartBlkNum(0), coneCollectSBExitLRWayptBatchEndBlkNum(0),
		coneCollectSBFillBatchStartBlkNum(0), coneCollectSBFillBatchEndBlkNum(0),
		coneCollectLRPickFillBatchStartBlkNum(0), coneCollectLRPickFillBatchEndBlkNum(0),
		coneCollectSBExitLRBulkBatchStartBlkNum(0), coneCollectSBExitLRBulkBatchEndBlkNum(0),
		coneCollectLRPickFillLRBulkBatchStartBlkNum(0), coneCollectLRPickFillLRBulkBatchEndBlkNum(0),
		coneInventoryCheckPoseABatchStartBlkNum(0), coneInventoryCheckPoseABatchEndBlkNum(0),
		coneInventoryCheckPoseBBatchStartBlkNum(0), coneInventoryCheckPoseBBatchEndBlkNum(0),
		coneInventoryCheckExitBatchStartBlkNum(0), coneInventoryCheckExitBatchEndBlkNum(0),
		PlacementConeChainTemplate(0), PlacementConeChainCurrIndex(0), CollectionConeAmount(0), CollectionConeCount(0),
		rearArmCurrTCP_X(0), rearArmCurrTCP_Y(0), rearArmCurrTCP_Z(0),
		left_loadingbay_frontarmtcp_pos_x(0), left_loadingbay_frontarmtcp_pos_y(0),
		right_loadingbay_frontarmtcp_pos_x(0), right_loadingbay_frontarmtcp_pos_y(0),
		left_loadingbay_frontarmtcp_pos_z(0), right_loadingbay_frontarmtcp_pos_z(0),
		pLoadingBaySM(0), pLanternRackSM(0), pConeStorageBaySM(0), cycleStartTimeStamp(0),
		insertExitRoute(false), insertLRExitRoute(false), detectedLanternInLLB(0), detectedLanternInRLB(0),
		currentWorkingSBStackPos(0), currentWorkingLBPos(0), currentWorkingLRStackPos(0),
		armDetectObjectInGrip(false), insertBulkColLRExitRoute(false), bulkColLRMode(false)
{
	_maxStates = ST_FRONTARM_MAX_STATES;
}

void FrontRobotArmSM::loadLBBasePosition()
{
	Route* pBase_Pos = searchRouteByName("LB_Base_Position");
	if (pBase_Pos == NULL)
	{
		ROS_INFO("Missing route definition - LB_Base_Position.");
		return;
	}
	left_loadingbay_frontarmtcp_pos_x = pBase_Pos->waypoints[0].BATCH_POS.X;
	left_loadingbay_frontarmtcp_pos_y = pBase_Pos->waypoints[0].BATCH_POS.Y;
	left_loadingbay_frontarmtcp_pos_z = pBase_Pos->waypoints[0].BATCH_POS.Z;
	right_loadingbay_frontarmtcp_pos_x = pBase_Pos->waypoints[1].BATCH_POS.X;
	right_loadingbay_frontarmtcp_pos_y = pBase_Pos->waypoints[1].BATCH_POS.Y;
	right_loadingbay_frontarmtcp_pos_z = pBase_Pos->waypoints[1].BATCH_POS.Z;
}

void FrontRobotArmSM::coord_RearRobotArm_RobotArmTCP(double ra_x, double ra_y, double ra_z, double* fa_x, double* fa_y, double* fa_z)
{
	*fa_x = -(ra_x) + pLoadingBaySM->left_loadingbay_reararmtcp_pos_x + left_loadingbay_frontarmtcp_pos_x;
	*fa_y = -(ra_y) + pLoadingBaySM->left_loadingbay_reararmtcp_pos_y + left_loadingbay_frontarmtcp_pos_y;
	*fa_z = ra_z - pLoadingBaySM->left_loadingbay_reararmtcp_pos_z + left_loadingbay_frontarmtcp_pos_z;
}

bool FrontRobotArmSM::checkHitBoundaryZone()
{
	// Checking condition for each arm / installation
	kr_state_accesskey.lock();
	double tcpx = robotArmState->pos_fb.X;
	double tcpy = robotArmState->pos_fb.Y;
	double tcpz = robotArmState->pos_fb.Z;
	kr_state_accesskey.unlock();

	if ((tcpx == 0) && (tcpy == 0) && (tcpz == 0))
		return false;

/*	if (abs(tcpy) > 1200.0)
	{
		ROS_INFO("Front Arm hit y > +-1200.0mm.");
		return true;
	}*/

	if ((rearArmCurrTCP_X != 0) && (rearArmCurrTCP_Y != 0) && (rearArmCurrTCP_Z != 0) &&
		(tcpx != 0) && (tcpy != 0) && (tcpz != 0))
	{
		double ra_tcpx, ra_tcpy, ra_tcpz, dist;
		coord_RearRobotArm_RobotArmTCP(rearArmCurrTCP_X, rearArmCurrTCP_Y, rearArmCurrTCP_Z, &ra_tcpx, &ra_tcpy, &ra_tcpz);
		dist = calPointDist(tcpx, tcpy, tcpz, ra_tcpx, ra_tcpy, ra_tcpz);
		if (dist <= 500.0)
		{
			ROS_INFO("Front Arm very close (500.0mm) to Rear Arm grip point.");
			return true;
		}
	}

	return false;
}

// external event
void FrontRobotArmSM::OnUpdateRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
	RobotArmSM::OnUpdateRobotArmState(msg);

	// Identify motion complete event
	if ((robotArmState->com_action == 0) && ((ros::Time::now().toSec() - previousMotionCmdTimestamp) > 0.15))
    {
		// given event, transition to a new state based upon
		// the current state of the state machine
		BEGIN_TRANSITION_MAP   // - New State -   						|- Current State -
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_DISABLE
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_IDLE
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_STOP
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_PAUSE
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_RESUME
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_ERROR
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)  						// ST_HOME
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)   						// ST_DEMO

			TRANSITION_MAP_ENTRY (ST_CONEPLACE_SBPICK)					// ST_CONEPLACE_INITPOSE
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITLBREADY)				// ST_CONEPLACE_SBPICK
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITLBREADY)				// ST_CONEPLACE_LBEXITSBPICK
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_WAITLBREADY)				// ST_CONEPLACE_WAITLBREADY, idle polling peripheral
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_LRPICKFILL)				// ST_CONEPLACE_LBFILL
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_COMPLETED)     			// ST_CONEPLACE_LRPICKFILL
			TRANSITION_MAP_ENTRY (ST_CONEPLACE_INITPOSE)     			// ST_CONEPLACE_COMPLETED

			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_WAITLBREADY)			// ST_CONECOLLECT_INITPOSE
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_WAITLBREADY)			// ST_CONECOLLECT_WAITLBREADY, idle polling peripheral
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_CHECKLANTERNONCONE)	// ST_CONECOLLECT_CHECKLANTERNONCONE, idle polling peripheral
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_LBPICK)				// ST_CONECOLLECT_LRPICKFILL
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_SBFILL)				// ST_CONECOLLECT_LBPICK
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_COMPLETED)				// ST_CONECOLLECT_SBFILL
			TRANSITION_MAP_ENTRY (ST_CONECOLLECT_INITPOSE)     			// ST_CONECOLLECT_COMPLETED

			TRANSITION_MAP_ENTRY (ST_INVENTORYCHECK_CHECKA)			// ST_INVENTORYCHECK_POSEA
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_INVENTORYCHECK_CHECKA
			TRANSITION_MAP_ENTRY (ST_INVENTORYCHECK_CHECKB)			// ST_INVENTORYCHECK_POSEB
			TRANSITION_MAP_ENTRY (EVENT_IGNORED)					// ST_INVENTORYCHECK_CHECKB
			TRANSITION_MAP_ENTRY (ST_IDLE)							// ST_INVENTORYCHECK_EXIT

			TRANSITION_MAP_ENTRY (ST_SAFEHOME_MOVEUPEXIT)				// ST_SAFEHOME_HANDLEREARSIDE
			TRANSITION_MAP_ENTRY (ST_SAFEHOME_MOVEUPEXIT)				// ST_SAFEHOME_HANDLEFRONTSIDE
			TRANSITION_MAP_ENTRY (ST_HOME)								// ST_SAFEHOME_MOVEUPEXIT
		END_TRANSITION_MAP(NULL)
    }
}

// external event
void FrontRobotArmSM::OnUpdateArmDetectorState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
	RobotArmSM::OnUpdateArmDetectorState(msg);

	double middle_distX1 = msg->columnscan_down_dist[3];
	double middle_distX2 = msg->columnscan_down_dist[4];
	if ( ((middle_distX1 > 0) && (middle_distX1 <= ARM_GRIP_CONE_DIST_M)) ||
			((middle_distX2 > 0) && (middle_distX2 <= ARM_GRIP_CONE_DIST_M)) )
		armDetectObjectInGrip = true;
	else
		armDetectObjectInGrip = false;

	// Identify align grip event

    // Identify grip off-center event

	// Identify grip ok event

	// Identify cone inventory check 1 event
	if (currentState == ST_INVENTORYCHECK_CHECKA)
	{
		// Identify cone stack height
		double right_distX = msg->columnscan_down_dist[0] * 1000.0;
		double middle_distX = (msg->columnscan_down_dist[3] + msg->columnscan_down_dist[4])/2.0 * 1000.0;
		double left_distX = msg->columnscan_down_dist[7] * 1000.0;

		Route* pTop_Pos = searchRouteByName("ConeInventoryCheckA");
		double topPosDist = pTop_Pos->waypoints[0].BATCH_POS.Z;

		ROS_INFO("FrontArmDetect dist cone bay 0,1,2: %.3f,%.3f,%.3f", left_distX, middle_distX, right_distX);

		if (right_distX <= 0) right_distX = 2350.0;
		if (middle_distX <= 0) middle_distX = 2350.0;
		if (left_distX <= 0) left_distX = 2350.0;
		double stackH[3];
		stackH[0] = topPosDist +1190.0 - left_distX;
		stackH[1] = topPosDist +1190.0 - middle_distX;
		stackH[2] = topPosDist +1190.0 - right_distX;
		pConeStorageBaySM->setSBStackLevel(stackH, 0, 2);

		// Go to next step after got sensor data updated, count number of cones for CB 0,1,2
		ExternalEvent(ST_INVENTORYCHECK_POSEB, NULL);
	}

	// Identify cone inventory check 2 event
	if (currentState == ST_INVENTORYCHECK_CHECKB)
	{
		// Identify cone stack height
		double right_distX = msg->columnscan_down_dist[0] * 1000.0;
		double middle_distX = (msg->columnscan_down_dist[3] + msg->columnscan_down_dist[4])/2.0 * 1000.0;
		double left_distX = msg->columnscan_down_dist[7] * 1000.0;

		Route* pTop_Pos = searchRouteByName("ConeInventoryCheckB");
		double topPosDist = pTop_Pos->waypoints[0].BATCH_POS.Z;

		ROS_INFO("FrontArmDetect dist cone bay 3,4,5: %.3f,%.3f,%.3f", left_distX, middle_distX, right_distX);

		if (right_distX <= 0) right_distX = 2350.0;
		if (middle_distX <= 0) middle_distX = 2350.0;
		if (left_distX <= 0) left_distX = 2350.0;
		double stackH[3];
		stackH[0] = topPosDist +1190.0 - left_distX;
		stackH[1] = topPosDist +1190.0 - middle_distX;
		stackH[2] = topPosDist +1190.0 - right_distX;
		pConeStorageBaySM->setSBStackLevel(stackH, 3, 5);

		// Go to next step after got sensor data updated, count number of cones for CB 3,4,5
		ExternalEvent(ST_INVENTORYCHECK_EXIT, NULL);
	}

	// Evaluate lantern present at LB by arm sensor (upper scanner)
	double left_distX1 = msg->columnscan_up_dist[1] * 1000.0;
	double left_distX0 = msg->columnscan_up_dist[2] * 1000.0;
	double right_distX0 = msg->columnscan_up_dist[5] * 1000.0;
	double right_distX1 = msg->columnscan_up_dist[6] * 1000.0;

	if ((left_distX1 > 0) && (left_distX1 <= 1350.0))
		detectedLanternInLLB = 2;					// with something, larger in width
	else if ((left_distX0 > 0) && (left_distX0 <= 1350.0))
		detectedLanternInLLB = 1;					// with something
	else
		detectedLanternInLLB = 0;					// nothing

	if ((right_distX1 > 0) && (right_distX1 <= 1000.0))
		detectedLanternInRLB = 2;					// with something, larger in width
	else if ((right_distX0 > 0) && (right_distX0 <= 1000.0))
		detectedLanternInRLB = 1;					// with something
	else
		detectedLanternInRLB = 0;					// nothing

	// Debug, for testing only
	ROS_INFO("*** LB sensorR: %d; LB sensorL: %d", detectedLanternInRLB, detectedLanternInLLB);
	ROS_INFO("&&& LB sensorL: far:%.3f, center:%.3f", left_distX1, left_distX0);
	ROS_INFO("$$$ LB sensorR: far:%.3f, center:%.3f", right_distX1, right_distX0);
}

// external event
void FrontRobotArmSM::OnUpdateLoadingBayState()
{

}

// external event
void FrontRobotArmSM::OnUpdateLanternRackState()
{

}

// external event
void FrontRobotArmSM::OnUpdateConeStorageSliderState()
{

}

// external event
void FrontRobotArmSM::goConePlacement(vector<ConeSet>* PlacementConeChain)
{
	PlacementConeChainTemplate = PlacementConeChain;
	PlacementConeChainCurrIndex = 0;

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

		kuka_robot::kr_set_accvel_Args srv1;
		srv1.request.acc = 5.0; //3.0;	//10.0;
		srv1.request.acc_swivel = 1000.0;
		srv1.request.acc_rot = 1000.0;
		srv1.request.vel = 2.5; //2.0;	//3.0;
		srv1.request.vel_swivel = 350.0; //300.0;	//400.0;
		srv1.request.vel_rot = 350.0; //300.0;		//400.0;
		if (!kr_set_default_accvel.call(srv1))
			ROS_INFO("kr_set_default_accvel returned error: %ld", (long int)srv.response.response);

		// Enable single move rounding
		kuka_robot::kr_set_real_Args srv2;
		srv2.request.number = 100;
		if (!kr_set_default_round.call(srv2))
			ROS_INFO("kr_set_default_round returned error: %ld", (long int)srv2.response.response);

		cycleStartTimeStamp = ros::Time::now().toSec();
		ExternalEvent(ST_CONEPLACE_INITPOSE, NULL);
	}
	ROS_INFO("FrontRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

// external event
void FrontRobotArmSM::goConeCollection(int numOfCones)
{
	CollectionConeAmount = numOfCones;
	CollectionConeCount = 0;

	// Download all routes for cone collection to batch blocks
	if (reloadCollectionRoutes())
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
		
		kuka_robot::kr_set_accvel_Args srv1;
		srv1.request.acc = 5.0; //3.0;	//10.0;
		srv1.request.acc_swivel = 1000.0;
		srv1.request.acc_rot = 1000.0;
		srv1.request.vel = 2.5; //2.0;	//3.0;
		srv1.request.vel_swivel = 350.0; //300.0;	//400.0;
		srv1.request.vel_rot = 350.0; //300.0;		//400.0;
		if (!kr_set_default_accvel.call(srv1))
			ROS_INFO("kr_set_default_accvel returned error: %ld", (long int)srv.response.response);

		// Enable single move rounding
		kuka_robot::kr_set_real_Args srv2;
		srv2.request.number = 100;
		if (!kr_set_default_round.call(srv2))
			ROS_INFO("kr_set_default_round returned error: %ld", (long int)srv2.response.response);

		cycleStartTimeStamp = ros::Time::now().toSec();
		ExternalEvent(ST_CONECOLLECT_INITPOSE, NULL);
	}
	ROS_INFO("FrontRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}


int FrontRobotArmSM::reloadPlacementRoutes()
{
	Route* pRoute0 = searchRouteByName("ConePlaceInitPose");
	Route* pRoute1 = searchRouteByName("ConePlaceLBExit");
	Route* pRoute2 = searchRouteByName("ConePlaceSBPick");
	Route* pRoute3 = searchRouteByName("ConePlaceLBFill");
	Route* pRoute4 = searchRouteByName("ConePlaceLRPickFill");
	if ((pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL)  && (pRoute4 != NULL))
	{
		conePlaceInitPoseBatchStartBlkNum = ROBOTARM_CONEPLACEMENT_BATCH_START_BLKNO;
		conePlaceInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, conePlaceInitPoseBatchStartBlkNum);
		conePlaceLBExitBatchStartBlkNum = conePlaceInitPoseBatchEndBlkNum + 1;
		conePlaceLBExitBatchEndBlkNum = setRouteBatch(pRoute1, conePlaceLBExitBatchStartBlkNum);
		conePlaceSBPickBatchStartBlkNum = conePlaceLBExitBatchEndBlkNum + 1;
		conePlaceSBPickBatchEndBlkNum = setRouteBatch(pRoute2, conePlaceSBPickBatchStartBlkNum);
		conePlaceLBFillBatchStartBlkNum = conePlaceSBPickBatchEndBlkNum + 1;
		conePlaceLBFillBatchEndBlkNum = setRouteBatch(pRoute3, conePlaceLBFillBatchStartBlkNum);
		conePlaceLRPickFillBatchStartBlkNum = conePlaceLBFillBatchEndBlkNum + 1;
		conePlaceLRPickFillBatchEndBlkNum = setRouteBatch(pRoute4, conePlaceLRPickFillBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("FrontRobotArmSM[%s]: goConePlacement - missing route definition.", armName.c_str());
		return -1;
	}

	return 0;
}

int FrontRobotArmSM::reloadCollectionRoutes()
{
	Route* pRoute0 = searchRouteByName("ConeCollectInitPose");
	Route* pRoute1 = searchRouteByName("ConeCollectSBExit");
	Route* pRoute2 = searchRouteByName("ConeCollectLRPickFill");
	Route* pRoute3 = searchRouteByName("ConeCollectSBExitLRWaypt");
	Route* pRoute4 = searchRouteByName("ConeCollectLBPick");
	Route* pRoute5 = searchRouteByName("ConeCollectSBFill");
	Route* pRoute6 = searchRouteByName("ConeCollectSBExitLRBulk");
	Route* pRoute7 = searchRouteByName("ConeCollectLRPickFillLRBulk");
	if ( (pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL) && (pRoute3 != NULL)
		&& (pRoute4 != NULL) && (pRoute5 != NULL) && (pRoute6 != NULL) && (pRoute7 != NULL) )
	{
		coneCollectInitPoseBatchStartBlkNum = ROBOTARM_CONECOLLECTION_BATCH_START_BLKNO;
		coneCollectInitPoseBatchEndBlkNum = setRouteBatch(pRoute0, coneCollectInitPoseBatchStartBlkNum);
		coneCollectSBExitBatchStartBlkNum = coneCollectInitPoseBatchEndBlkNum + 1;
		coneCollectSBExitBatchEndBlkNum = setRouteBatch(pRoute1, coneCollectSBExitBatchStartBlkNum);
		coneCollectLRPickFillBatchStartBlkNum = coneCollectSBExitBatchEndBlkNum + 1;
		coneCollectLRPickFillBatchEndBlkNum = setRouteBatch(pRoute2, coneCollectLRPickFillBatchStartBlkNum);
		coneCollectSBExitLRWayptBatchStartBlkNum = coneCollectLRPickFillBatchEndBlkNum + 1;
		coneCollectSBExitLRWayptBatchEndBlkNum = setRouteBatch(pRoute3, coneCollectSBExitLRWayptBatchStartBlkNum);
		coneCollectLBPickBatchStartBlkNum = coneCollectSBExitLRWayptBatchEndBlkNum + 1;
		coneCollectLBPickBatchEndBlkNum = setRouteBatch(pRoute4, coneCollectLBPickBatchStartBlkNum);
		coneCollectSBFillBatchStartBlkNum = coneCollectLBPickBatchEndBlkNum + 1;
		coneCollectSBFillBatchEndBlkNum = setRouteBatch(pRoute5, coneCollectSBFillBatchStartBlkNum);
		coneCollectSBExitLRBulkBatchStartBlkNum = coneCollectSBFillBatchEndBlkNum + 1;
		coneCollectSBExitLRBulkBatchEndBlkNum = setRouteBatch(pRoute6, coneCollectSBExitLRBulkBatchStartBlkNum);
		coneCollectLRPickFillLRBulkBatchStartBlkNum = coneCollectSBExitLRBulkBatchEndBlkNum + 1;
		coneCollectLRPickFillLRBulkBatchEndBlkNum = setRouteBatch(pRoute7, coneCollectLRPickFillLRBulkBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("FrontRobotArmSM[%s]: goConeCollection - missing route definition.", armName.c_str());
		return -1;
	}

	return 0;
}

// external event
void FrontRobotArmSM::goConeInventoryCheck()
{
	Route* pRoute0 = searchRouteByName("ConeInventoryCheckA");
	Route* pRoute1 = searchRouteByName("ConeInventoryCheckB");
	Route* pRoute2 = searchRouteByName("ConeInventoryExit");
	if ((pRoute0 != NULL) && (pRoute1 != NULL) && (pRoute2 != NULL))
	{
		coneInventoryCheckPoseABatchStartBlkNum = ROBOTARM_CONECOLLECTION_BATCH_START_BLKNO + 140;
		coneInventoryCheckPoseABatchEndBlkNum = setRouteBatch(pRoute0, coneInventoryCheckPoseABatchStartBlkNum);
		coneInventoryCheckPoseBBatchStartBlkNum = coneInventoryCheckPoseABatchEndBlkNum + 1;
		coneInventoryCheckPoseBBatchEndBlkNum = setRouteBatch(pRoute1, coneInventoryCheckPoseBBatchStartBlkNum);
		coneInventoryCheckExitBatchStartBlkNum = coneInventoryCheckPoseBBatchEndBlkNum + 1;
		coneInventoryCheckExitBatchEndBlkNum = setRouteBatch(pRoute2, coneInventoryCheckExitBatchStartBlkNum);
	}
	else
	{
		ROS_INFO("FrontRobotArmSM[%s]: goConeInventoryCheck - missing route definition.", armName.c_str());
		return;
	}

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

		ExternalEvent(ST_INVENTORYCHECK_POSEA, NULL);
	}
	ROS_INFO("FrontRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

void FrontRobotArmSM::goHomeSafely()
{
	// Download all routes for cone placement/collection to batch blocks (need make use of placement/collection route)
	if (reloadPlacementRoutes())
		return;
	if (reloadCollectionRoutes())
		return;

	Route* pRoute = searchRouteByName("Home");
	if (pRoute != NULL)
	{
		// First point should be MovJByJoint.
		if (pRoute->waypoints[0].BATCH_ACTION != MOVJ_BYJOINTS_ACTION_TYPE)
		{
			ROS_INFO("FrontRobotArmSM[%s]: goHomeSafely - first point should be MovjByJoints.", armName.c_str());
			return;
		}
	}
	else
	{
		ROS_INFO("FrontRobotArmSM[%s]: goHomeSafely - missing route info/definitation.", armName.c_str());
		return;
	}

	if (currentState == ST_IDLE)
		ExternalEvent(ST_SAFEHOME_HANDLEREARSIDE, NULL);
	ROS_INFO("FrontRobotArmSM[%s]: prev=%d, new=%d.", armName.c_str(), previousState, currentState);
}

/* Cone Placement SM ---------------------------------------------------------------------------------*/
void FrontRobotArmSM::ST_ConePlaceInitPose(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceInitPose");
	UpdateCmdTimestampIfChangeOfState();

	insertExitRoute = false;
	insertLRExitRoute = false;

	runRouteBatch(conePlaceInitPoseBatchStartBlkNum, conePlaceInitPoseBatchEndBlkNum);

	if (PlacementConeChainTemplate->size() <= PlacementConeChainCurrIndex)
		InternalEvent(ST_IDLE, NULL);						// set state and do move
}

void FrontRobotArmSM::ST_ConePlaceSBPick(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceSBPick");
	UpdateCmdTimestampIfChangeOfState();

	// Modify to working storage bay entry position
	int SBStackForPlace, SBStackLevelForPlace;
	pConeStorageBaySM->getUpdateSBPosForPlacement(&SBStackForPlace, &SBStackLevelForPlace);
	if (SBStackForPlace == ConeStorageBaySM::SB_NOTAVAL)
	{
		ROS_INFO("No cone in Storage Bay to place. Stop.");
		InternalEvent(ST_IDLE, NULL);						// set state and do move
	    return;
	}

	ROS_INFO("Front Arm pick cone in SB%d current level %d to place.", SBStackForPlace, SBStackLevelForPlace);

	currentWorkingSBStackPos = SBStackForPlace;
	double SBStackPosHeight = (SBStackLevelForPlace-1) * CONE_BASE_HEIGHT_MM;	// calculate additional height to grip
	SBStackPosHeight -= (CONE_BASE_HEIGHT_MM*2);								// grip lower position for better performance
	if (SBStackPosHeight < 0)
		SBStackPosHeight = 0;
	if (currentWorkingSBStackPos >= ConeStorageBaySM::SB_6)
	{
		if (pConeStorageBaySM->sliderPosition == 1)
		{
			currentWorkingSBStackPos -= 6;
			SBStackPosHeight += CONE_SLIDER_HEIGHT_MM;
		}
		else
		{
			ROS_INFO("Storage Bay Slider NOT in extend mode. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
			return;
		}
	}
	else
	{
		if (pConeStorageBaySM->sliderPosition == 1)
		{
			ROS_INFO("Storage Bay Slider NOT in retract mode. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
			return;
		}
	}
	ROS_INFO("Front Arm pick cone in SB Pos %d height %f to place.", currentWorkingSBStackPos, SBStackPosHeight);

	// Modify points of ConePlaceSBPick move by current working SB base position (movj)
	Route* pRoute = searchRouteByName("ConePlaceSBPick");
	Route* pBase_Pos = searchRouteByName("SB_Base_Position");
/*	Route* pTop_Pos = searchRouteByName("SB_Top_Position");*/

	kuka_robot::kr_batch_mv_bypose_Args srv;
	#define SB_PL_WAYPOINT_BLK_NUM		0
	// Modify entry waypoint (cal from base)
	srv.request.pose.X = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.X;
	srv.request.pose.Y = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Y;
	srv.request.pose.Z = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Z;
	// Modify Z to top entry point of current working cone stack level (n....2,1), load rel -z from next block (down)
	double coneGripToEntryPt_Z = -(pRoute->waypoints[SB_PL_WAYPOINT_BLK_NUM+1].BATCH_POS.Z);
	srv.request.pose.Z += (coneGripToEntryPt_Z + SBStackPosHeight);
	srv.request.pose.A = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.A;
	srv.request.pose.B = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.B;
	srv.request.pose.C = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.C;
	srv.request.pose.S = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.S;		// TBD: -1 for flexibility
	srv.request.pose.T = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.T;		// TBD: -1 for flexibility
	srv.request.round = 1.0;
	srv.request.block = conePlaceSBPickBatchStartBlkNum + SB_PL_WAYPOINT_BLK_NUM;
	if (!kr_set_batch_movj_bypose.call(srv))
		ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

	// Run to modified waypoints
	runRouteBatch(conePlaceSBPickBatchStartBlkNum, conePlaceSBPickBatchEndBlkNum);
}

void FrontRobotArmSM::ST_ConePlaceLBExitSBPick(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceLBExitSBPick");
	UpdateCmdTimestampIfChangeOfState();

	// Modify to working storage bay entry position
	int SBStackForPlace, SBStackLevelForPlace;
	pConeStorageBaySM->getUpdateSBPosForPlacement(&SBStackForPlace, &SBStackLevelForPlace);
	if (SBStackForPlace == ConeStorageBaySM::SB_NOTAVAL)
	{
		ROS_INFO("No cone in Storage Bay to place. Stop.");
		InternalEvent(ST_IDLE, NULL);						// set state and do move
	    return;
	}

	ROS_INFO("Front Arm pick cone in SB%d current level %d to place.", SBStackForPlace, SBStackLevelForPlace);

	currentWorkingSBStackPos = SBStackForPlace;
	double SBStackPosHeight = (SBStackLevelForPlace-1) * CONE_BASE_HEIGHT_MM;	// calculate additional height to grip
	SBStackPosHeight -= (CONE_BASE_HEIGHT_MM*2);								// grip lower position for better performance
	if (SBStackPosHeight < 0)
		SBStackPosHeight = 0;
	if (currentWorkingSBStackPos >= ConeStorageBaySM::SB_6)
	{
		if (pConeStorageBaySM->sliderPosition == 1)
		{
			currentWorkingSBStackPos -= 6;
			SBStackPosHeight += CONE_SLIDER_HEIGHT_MM;
		}
		else
		{
			ROS_INFO("Storage Bay Slider NOT in extend mode. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
			return;
		}
	}
	else
	{
		if (pConeStorageBaySM->sliderPosition == 1)
		{
			ROS_INFO("Storage Bay Slider NOT in retract mode. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
			return;
		}
	}
	ROS_INFO("Front Arm pick cone in SB Pos %d height %f to place.", currentWorkingSBStackPos, SBStackPosHeight);

	// Modify points of ConePlaceSBPick move by current working SB base position (movj)
	Route* pRoute = searchRouteByName("ConePlaceSBPick");
	Route* pBase_Pos = searchRouteByName("SB_Base_Position");
/*	Route* pTop_Pos = searchRouteByName("SB_Top_Position");*/

	kuka_robot::kr_batch_mv_bypose_Args srv;
	#define SB_PL_WAYPOINT_BLK_NUM		0
	// Modify entry waypoint (cal from base)
	srv.request.pose.X = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.X;
	srv.request.pose.Y = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Y;
	srv.request.pose.Z = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Z;
	// Modify Z to top entry point of current working cone stack level (n....2,1), load rel -z from next block (down)
	double coneGripToEntryPt_Z = -(pRoute->waypoints[SB_PL_WAYPOINT_BLK_NUM+1].BATCH_POS.Z);
	srv.request.pose.Z += (coneGripToEntryPt_Z + SBStackPosHeight);
	srv.request.pose.A = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.A;
	srv.request.pose.B = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.B;
	srv.request.pose.C = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.C;
	srv.request.pose.S = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.S;		// TBD: -1 for flexibility
	srv.request.pose.T = pBase_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.T;		// TBD: -1 for flexibility
	srv.request.round = 1.0;
	srv.request.block = conePlaceSBPickBatchStartBlkNum + SB_PL_WAYPOINT_BLK_NUM;
	if (!kr_set_batch_movj_bypose.call(srv))
		ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

	// Run to modified waypoints
	runRouteBatch(conePlaceLBExitBatchStartBlkNum, conePlaceSBPickBatchEndBlkNum);
}

void FrontRobotArmSM::ST_ConePlaceWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();

	// check if LB is ready and reserved
//	RobotArmEventData* psmData = new RobotArmEventData();
	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_StorageToLoad();
	if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
		InternalEvent(ST_CONEPLACE_LBFILL, NULL);	// set state and do move
}

void FrontRobotArmSM::ST_ConePlaceLBFill(RobotArmEventData* pData)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceLBFill");
	UpdateCmdTimestampIfChangeOfState();

	int LBPosIndex;
	int LBStateForPlacement = pLoadingBaySM->getReadyLB_StorageToLoad();
	if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
	{
		ROS_INFO("Place to left loading bay.");
		LBPosIndex = 0;
	}
	else if (LBStateForPlacement == LoadingBaySM::LB_RIGHT)
	{
		ROS_INFO("Place to right loading bay.");
		LBPosIndex = 1;
	}
	else
	{
		ROS_INFO("Having error, LBState=%d, return to waiting.", LBStateForPlacement);
		InternalEvent(ST_CONEPLACE_WAITLBREADY, NULL);	// set state and do move
		return;
	}

	// Modify point of ConePlaceLBFill move by current working LB base position (movj)
	Route* pRoute = searchRouteByName("ConePlaceLBFill");
	Route* pTop_Pos = searchRouteByName("SB_Top_Position");
	Route* pBase_Pos = searchRouteByName("LB_Base_Position");

	kuka_robot::kr_batch_mv_bypose_Args srv;
	#define SB_PL_EXIT_BLK_NUM			0
	double exitZPos = robotArmState->pos_setpt.Z + 970.0;
	// Z top at min:1480
	if (exitZPos < 1480.0)
		exitZPos = 1480.0;
	// Modify SB exit waypoint
	srv.request.pose.X = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.X;
	srv.request.pose.Y = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Y;
	srv.request.pose.Z = exitZPos;
	srv.request.pose.A = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.A;
	srv.request.pose.B = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.B;
	srv.request.pose.C = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.C;
	srv.request.pose.S = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.S;
	srv.request.pose.T = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.T;
	srv.request.round = 1.0;
	srv.request.block = conePlaceLBFillBatchStartBlkNum + SB_PL_EXIT_BLK_NUM;
	if (!kr_set_batch_movl_bypose.call(srv))
		ROS_INFO("kr_set_batch_movl_bypose returned error: %ld", (long int)srv.response.response);

	#define LB_PL_WAYPOINT_BLK_NUM		5
	// Modify LB place point
//	double placeInHeight = pRoute->waypoints[LB_PL_WAYPOINT_BLK_NUM].BATCH_POS.Z;
//	if (LBPosIndex == 1)
//		placeInHeight = 1200.0;	// additional height to avoid hit LLB lantern
	srv.request.pose.X = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.X;
	srv.request.pose.Y = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.Y;
	srv.request.pose.Z = pRoute->waypoints[LB_PL_WAYPOINT_BLK_NUM].BATCH_POS.Z;
	srv.request.pose.A = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.A;
	srv.request.pose.B = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.B;
	srv.request.pose.C = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.C;
	srv.request.pose.S = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.S;
	srv.request.pose.T = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.T;
	srv.request.round = 1.0;
	srv.request.block = conePlaceLBFillBatchStartBlkNum + LB_PL_WAYPOINT_BLK_NUM;
	if (!kr_set_batch_movj_bypose.call(srv))
		ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

	// Run to modified waypoints
	runRouteBatch(conePlaceLBFillBatchStartBlkNum, conePlaceLBFillBatchEndBlkNum);
}

void FrontRobotArmSM::ST_ConePlaceLRPickFill(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceLRPickFill");
	UpdateCmdTimestampIfChangeOfState();

	if ((*PlacementConeChainTemplate)[PlacementConeChainCurrIndex].Has_Lantern)
	{
		int LRStateForPlacement, LRStackLevelForPlacement;
		pLanternRackSM->getWorkingLRForPlacement(&LRStateForPlacement, &LRStackLevelForPlacement);
		// Modify to working lantern rack entry position
		if (LRStateForPlacement == LanternRackSM::LR_NOTAVAL)
		{
			ROS_INFO("No lantern in Lantern Rack to place. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
		    return;
		}

		// Modify first point of ConePlaceLRPickFill move by current working Lantern Rack base position (movj)
		// A/B Pos by level
		Route* pTop_Pos;
		if ((LRStackLevelForPlacement%2) == 1)
			pTop_Pos = searchRouteByName("LR_TopA_Position");
		else
			pTop_Pos = searchRouteByName("LR_TopB_Position");

		// Special handling for LR_5
		double addedHeight, pickPlaceHeight;
		if (LRStateForPlacement == LanternRackSM::LR_5)
		{
			addedHeight = 150.0;
			pickPlaceHeight = 300.0 + addedHeight;
		}
		else
		{
			addedHeight = 0;
			pickPlaceHeight = 300.0 + addedHeight;
		}

		kuka_robot::kr_batch_mv_bypose_Args srv;
		#define LR_PL_WAYPOINT_BLK_NUM		2
		srv.request.pose.X = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.X;
		srv.request.pose.Y = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.Y;
		srv.request.pose.Z = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.Z + addedHeight;
		srv.request.pose.A = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.A;
		srv.request.pose.B = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.B;
		srv.request.pose.C = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.C;
		srv.request.pose.S = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.S;
		srv.request.pose.T = pTop_Pos->waypoints[LRStateForPlacement].BATCH_POS.T;
		srv.request.round = 1.0;
		srv.request.block = conePlaceLRPickFillBatchStartBlkNum + LR_PL_WAYPOINT_BLK_NUM;
		if (!kr_set_batch_movj_bypose.call(srv))
			ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

		// Special handling for LR_5
		srv.request.pose.X = 0;
		srv.request.pose.Y = 0;
		srv.request.pose.Z = -pickPlaceHeight;
		srv.request.pose.A = 0;
		srv.request.pose.B = 0;
		srv.request.pose.C = 0;
		srv.request.pose.S = 0;
		srv.request.pose.T = 0;
		srv.request.round = 0;
		srv.request.block = conePlaceLRPickFillBatchStartBlkNum + LR_PL_WAYPOINT_BLK_NUM + 1;
		if (!kr_set_batch_movlrel_bypose.call(srv))
			ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);
		srv.request.pose.Z = pickPlaceHeight;
		srv.request.block = conePlaceLRPickFillBatchStartBlkNum + LR_PL_WAYPOINT_BLK_NUM + 3;
		if (!kr_set_batch_movlrel_bypose.call(srv))
			ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);

		// Modify point of ConePlaceLRPickFill move by current working LB base position (movj)
		int LBPosIndex;
		int LBStateForPlacement = pLoadingBaySM->getReadyLB_StorageToLoad();
		if (LBStateForPlacement == LoadingBaySM::LB_LEFT)
		{
			ROS_INFO("Place to left loading bay.");
			LBPosIndex = 0;
		}
		else if (LBStateForPlacement == LoadingBaySM::LB_RIGHT)
		{
			ROS_INFO("Place to right loading bay.");
			LBPosIndex = 1;
		}
		Route* pRoute = searchRouteByName("ConePlaceLRPickFill");
		// A/B Pos by level
		Route* pLBLanternBase_Pos;
		if ((LRStackLevelForPlacement%2) == 1)
			pLBLanternBase_Pos = searchRouteByName("LB_Lantern_BaseA_Position");
		else
			pLBLanternBase_Pos = searchRouteByName("LB_Lantern_BaseB_Position");
		#define LRLB_PL_WAYPOINT_BLK_NUM		8
		// Modify down waypoint
		srv.request.pose.X = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.X;
		srv.request.pose.Y = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.Y;
		srv.request.pose.Z = pRoute->waypoints[LRLB_PL_WAYPOINT_BLK_NUM].BATCH_POS.Z;
		srv.request.pose.A = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.A;
		srv.request.pose.B = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.B;
		srv.request.pose.C = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.C;
		srv.request.pose.S = -1;		// pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.S;
		srv.request.pose.T = -1;		// pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.T;
		srv.request.round = 0.0;
		srv.request.block = conePlaceLRPickFillBatchStartBlkNum + LRLB_PL_WAYPOINT_BLK_NUM;
		if (!kr_set_batch_movj_bypose.call(srv))
			ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);
		// Modify down to base waypoint
		srv.request.pose.X = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.X;
		srv.request.pose.Y = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.Y;
		srv.request.pose.Z = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.Z + 20.0; //50.0 //80.0 //120.0	// offset insert position
		srv.request.pose.A = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.A;
		srv.request.pose.B = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.B;
		srv.request.pose.C = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.C;
		srv.request.pose.S = -1;		// pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.S;
		srv.request.pose.T = -1;		// pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.T;
		srv.request.round = 0.0;
		srv.request.block = conePlaceLRPickFillBatchStartBlkNum + LRLB_PL_WAYPOINT_BLK_NUM + 1;
		if (!kr_set_batch_movl_bypose.call(srv))
			ROS_INFO("kr_set_batch_movl_bypose returned error: %ld", (long int)srv.response.response);

		#define LRLB_PL_EXIT_BLK_NUM			11
		// Modify down waypoint
		srv.request.pose.X = 0;
		srv.request.pose.Y = 0;
		// If exit from RLB, add height to avoid hit LLB lantern
		if (robotArmState->pos_setpt.Y < 0)
			srv.request.pose.Z = 300.0;
		else
			srv.request.pose.Z = 0;
		srv.request.pose.A = 0;
		srv.request.pose.B = 0;
		srv.request.pose.C = 0;
		srv.request.pose.S = -1;		// pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.S;
		srv.request.pose.T = -1;		// pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.T;
		srv.request.round = 0.0;
		srv.request.block = conePlaceLRPickFillBatchStartBlkNum + LRLB_PL_EXIT_BLK_NUM;
		if (!kr_set_batch_movlrel_bypose.call(srv))
			ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);

		// Run to modified waypoints
		runRouteBatch(conePlaceLRPickFillBatchStartBlkNum, conePlaceLRPickFillBatchEndBlkNum);
	}
}

void FrontRobotArmSM::ST_ConePlaceCompleted(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConePlaceCompleted");
	UpdateCmdTimestampIfChangeOfState();

	// TBD: update by cone counter sensor
	pConeStorageBaySM->decSBStackLevel();

	// Enable release LB exclusive lock by moving out
	pLoadingBaySM->enable_ReleaseLB_ExclusiveLock_IfMovOut(2);

	double cycleTime = ros::Time::now().toSec() - cycleStartTimeStamp;
	cycleStartTimeStamp = ros::Time::now().toSec();
	ROS_INFO("Front Arm placement [%d] cycle time = %.3fs.", PlacementConeChainCurrIndex, cycleTime);

	insertExitRoute = false;
	insertLRExitRoute = false;
	// Check if all placement completed
	PlacementConeChainCurrIndex++;
	if (PlacementConeChainTemplate->size() <= PlacementConeChainCurrIndex)
	{
		runRouteBatch(conePlaceLBExitBatchStartBlkNum, conePlaceLBExitBatchEndBlkNum);
		return;
	}

	// Check if working storage bay available
	int SBStackForPlace, SBStackLevelForPlace;
	pConeStorageBaySM->getUpdateSBPosForPlacement(&SBStackForPlace, &SBStackLevelForPlace);
	if (SBStackForPlace == ConeStorageBaySM::SB_NOTAVAL)
	{
		ROS_INFO("No cone in Storage Bay to place. Stop.");
		runRouteBatch(conePlaceLBExitBatchStartBlkNum, conePlaceLBExitBatchEndBlkNum);
	    return;
	}
	else
	{
		InternalEvent(ST_CONEPLACE_LBEXITSBPICK, NULL);		// set state and do move
	    return;
	}
}


/* Cone Collection SM ---------------------------------------------------------------------------------*/
void FrontRobotArmSM::ST_ConeCollectInitPose(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectInitPose");
	UpdateCmdTimestampIfChangeOfState();

	insertExitRoute = false;
	insertLRExitRoute = false;

	// Skip first waypoint if already close to final position
	if (robotArmState->pos_setpt.X < 0)
		runRouteBatch(coneCollectInitPoseBatchStartBlkNum + 1, coneCollectInitPoseBatchEndBlkNum);
	else
		runRouteBatch(coneCollectInitPoseBatchStartBlkNum, coneCollectInitPoseBatchEndBlkNum);

	if ( (CollectionConeAmount <= CollectionConeCount) &&
			(pLoadingBaySM->getReadyLB_LoadToStorage() == LoadingBaySM::LB_NOTAVAL) )
		InternalEvent(ST_IDLE, NULL);					// set state and do move
}

void FrontRobotArmSM::ST_ConeCollectWaitLBReady(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectWaitLBReady");
	UpdateCmdTimestampIfChangeOfState();

	// check if LB is ready and reserved
//	RobotArmEventData* psmData = new RobotArmEventData();
	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_LoadToStorage();
	if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
		InternalEvent(ST_CONECOLLECT_CHECKLANTERNONCONE, NULL);	// set state and do move
}

void FrontRobotArmSM::ST_ConeCollectCheckLanternOnCone(RobotArmEventData* pData)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectCheckLanternOnCone");
	UpdateCmdTimestampIfChangeOfState();

	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_LoadToStorage();
	if ( (smData.cmd == LoadingBaySM::LB_LEFT) && (detectedLanternInLLB > 0) )
		InternalEvent(ST_CONECOLLECT_LRPICKFILL, NULL);	// set state and do move
	else if ( (smData.cmd == LoadingBaySM::LB_RIGHT) && (detectedLanternInRLB > 0) )
		InternalEvent(ST_CONECOLLECT_LRPICKFILL, NULL);	// set state and do move
	else
		InternalEvent(ST_CONECOLLECT_LBPICK, NULL);		// set state and do move
}

void FrontRobotArmSM::ST_ConeCollectLRPickFill(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectLRPickFill");
	UpdateCmdTimestampIfChangeOfState();

	int LRStateForCollection, LRStackLevelForCollection;
	pLanternRackSM->getWorkingLRForCollection(&LRStateForCollection, &LRStackLevelForCollection);
	// Modify to working lantern rack entry position
	if (LRStateForCollection == LanternRackSM::LR_NOTAVAL)
	{
		ROS_INFO("No space in Lantern Rack for collection. Pending....");
//		InternalEvent(ST_IDLE, NULL);						// set state and do move
		return;
	}

	ROS_INFO("FRA pick to Lantern Rack for collection. LRState=%d, LRStackLevel=%d.", LRStateForCollection, LRStackLevelForCollection);

	// Modify the first point of ConeCollectLRPickFill move by current working LB base position (movj)
	int detectedLanternStateAtLB = 0;
	int LBPosIndex = 0;
	int LBStateForCollection = pLoadingBaySM->getReadyLB_LoadToStorage();
	if (LBStateForCollection == LoadingBaySM::LB_LEFT)
	{
		ROS_INFO("Collect from left loading bay.");
		detectedLanternStateAtLB = detectedLanternInLLB;
		LBPosIndex = 0;
	}
	else if (LBStateForCollection == LoadingBaySM::LB_RIGHT)
	{
		ROS_INFO("Collect from right loading bay.");
		detectedLanternStateAtLB = detectedLanternInRLB;
		LBPosIndex = 1;
	}

	if (bulkColLRMode)
	{
		insertBulkColLRExitRoute = true;

		// Run to modified waypoints
/*		if (insertExitRoute)
		{
			insertExitRoute = false;
			insertLRExitRoute = true;
			runRouteBatch(coneCollectSBExitLRBulkBatchStartBlkNum, coneCollectLRPickFillLRBulkBatchEndBlkNum);
		}
		else
		{
			insertLRExitRoute = true;
			runRouteBatch(coneCollectLRPickFillLRBulkBatchStartBlkNum, coneCollectLRPickFillLRBulkBatchEndBlkNum);
		}*/
	}
	else
	{
		// Detected if lantern hold vertically
		bool IsVertical = false;
		if (detectedLanternStateAtLB > 1)
			IsVertical = true;

		Route* pRoute = searchRouteByName("ConeCollectLRPickFill");
		// A/B Pos by level, bulk collect mode always pos A
		Route* pLBLanternBase_Pos;
		if ((LRStackLevelForCollection%2) == 1)
			pLBLanternBase_Pos = searchRouteByName("LB_Lantern_BaseA_Position");
		else
			pLBLanternBase_Pos = searchRouteByName("LB_Lantern_BaseB_Position");
		// Modify entry waypoint
		kuka_robot::kr_batch_mv_bypose_Args srv;
		#define LRLB_CO_WAYPOINT_BLK_NUM		1
		srv.request.pose.X = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.X;
		srv.request.pose.Y = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.Y;
		srv.request.pose.Z = pRoute->waypoints[LRLB_CO_WAYPOINT_BLK_NUM].BATCH_POS.Z;
		srv.request.pose.A = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.A;
		srv.request.pose.B = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.B;
		srv.request.pose.C = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.C;
		srv.request.pose.S = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.S;
		int turn = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.T;
		srv.request.pose.T = (turn | 0x02);		// Set bit1 as a higher position
		srv.request.round = 1.0;
		srv.request.block = coneCollectLRPickFillBatchStartBlkNum + LRLB_CO_WAYPOINT_BLK_NUM;
		// Modify pick angle if lantern is held vertical
		if (IsVertical)
		{
			srv.request.pose.A -= 30.0;	//27.0 //24.0;			// modifiy this need consider LB_Lantern_BaseB_Position1 and may cause unwanted move
			if (srv.request.pose.A < 63.5)
				srv.request.pose.A = 63.5;
		}
		if (!kr_set_batch_movj_bypose.call(srv))
			ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

		// Modify down to base waypoint
		srv.request.pose.Z = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.Z;
		srv.request.pose.S = -1;
		srv.request.pose.T = -1;
		srv.request.round = 0.0;
		srv.request.block = coneCollectLRPickFillBatchStartBlkNum + LRLB_CO_WAYPOINT_BLK_NUM + 1;
		if (!kr_set_batch_movl_bypose.call(srv))
			ROS_INFO("kr_set_batch_movl_bypose returned error: %ld", (long int)srv.response.response);

		// Modify return waypoint
		srv.request.pose.Z = pLBLanternBase_Pos->waypoints[LBPosIndex].BATCH_POS.Z + 400.0;
		srv.request.pose.S = -1;
		srv.request.pose.T = -1;
		srv.request.round = 1.0;
		srv.request.block = coneCollectLRPickFillBatchStartBlkNum + LRLB_CO_WAYPOINT_BLK_NUM + 3;
		if (!kr_set_batch_movl_bypose.call(srv))
			ROS_INFO("kr_set_batch_movl_bypose returned error: %ld", (long int)srv.response.response);

		// Modify point of ConeCollectLRPickFill move by current working Lantern Rack position (movj)
		// A/B Pos by level
		Route* pTop_Pos;
		if ((LRStackLevelForCollection%2) == 1)
			pTop_Pos = searchRouteByName("LR_TopA_Position");
		else
			pTop_Pos = searchRouteByName("LR_TopB_Position");

		// Special handling for LR_5
		double addedHeight, pickPlaceHeight;
		if (LRStateForCollection == LanternRackSM::LR_5)
		{
			addedHeight = 150.0;
			pickPlaceHeight = 200.0 + addedHeight;
		}
		else
		{
			addedHeight = 0;
			pickPlaceHeight = 200.0 + addedHeight;
		}

		#define LR_CO_WAYPOINT_BLK_NUM		7
		srv.request.pose.X = pTop_Pos->waypoints[LRStateForCollection].BATCH_POS.X;
		srv.request.pose.Y = pTop_Pos->waypoints[LRStateForCollection].BATCH_POS.Y;
		srv.request.pose.Z = pTop_Pos->waypoints[LRStateForCollection].BATCH_POS.Z + addedHeight;
		srv.request.pose.A = pTop_Pos->waypoints[LRStateForCollection].BATCH_POS.A;
		srv.request.pose.B = pTop_Pos->waypoints[LRStateForCollection].BATCH_POS.B;
		srv.request.pose.C = pTop_Pos->waypoints[LRStateForCollection].BATCH_POS.C;
		srv.request.pose.S = -1;			// various C
		srv.request.pose.T = -1;			// various C
		srv.request.round = 0.0;
		srv.request.block = coneCollectLRPickFillBatchStartBlkNum + LR_CO_WAYPOINT_BLK_NUM;
		// Modify pick angle if lantern is held vertical
		if (IsVertical)
		{
			if ((LRStackLevelForCollection%2) == 1)
			{
				srv.request.pose.C -= 20.0;
				if (LRStateForCollection < 5)
					srv.request.pose.X -= 20.0;
				else
					srv.request.pose.X += 20.0;
			}
			else
			{
				srv.request.pose.C += 20.0;
				if (LRStateForCollection < 5)
					srv.request.pose.X += 20.0;
				else
					srv.request.pose.X -= 20.0;
			}
		}
		if (!kr_set_batch_movj_bypose.call(srv))
			ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

		// Special handling for LR_5
		srv.request.pose.X = 0;
		srv.request.pose.Y = 0;
		srv.request.pose.Z = -pickPlaceHeight;
		srv.request.pose.A = 0;
		srv.request.pose.B = 0;
		srv.request.pose.C = 0;
		srv.request.pose.S = 0;
		srv.request.pose.T = 0;
		srv.request.round = 0;
		srv.request.block = coneCollectLRPickFillBatchStartBlkNum + LR_CO_WAYPOINT_BLK_NUM + 1;
		if (!kr_set_batch_movlrel_bypose.call(srv))
			ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);
		srv.request.pose.Z = pickPlaceHeight;
		srv.request.block = coneCollectLRPickFillBatchStartBlkNum + LR_CO_WAYPOINT_BLK_NUM + 3;
		if (!kr_set_batch_movlrel_bypose.call(srv))
			ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);

		// Run to modified waypoints
		if (insertExitRoute)
		{
			insertExitRoute = false;
			insertLRExitRoute = true;
			runRouteBatch(coneCollectSBExitBatchStartBlkNum, coneCollectLRPickFillBatchEndBlkNum);
		}
		else
		{
			insertLRExitRoute = true;
			runRouteBatch(coneCollectLRPickFillBatchStartBlkNum, coneCollectLRPickFillBatchEndBlkNum);
		}
	}
}

void FrontRobotArmSM::ST_ConeCollectLBPick(RobotArmEventData* pData)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectLBPick");
	UpdateCmdTimestampIfChangeOfState();

	int LBPosIndex;
	int LBStateForCollection = pLoadingBaySM->getReadyLB_LoadToStorage();
	if (LBStateForCollection == LoadingBaySM::LB_LEFT)
	{
		ROS_INFO("Collect from left loading bay.");
		LBPosIndex = 0;
	}
	else if (LBStateForCollection == LoadingBaySM::LB_RIGHT)
	{
		ROS_INFO("Collect from right loading bay.");
		LBPosIndex = 1;
	}
	else
	{
		ROS_INFO("Having error, LBState=%d, return to waiting.", LBStateForCollection);
		InternalEvent(ST_CONECOLLECT_WAITLBREADY, NULL);	// set state and do move
		return;
	}

	// Modify point of ConeCollectLBPick move by current working LB base position (movj)
	Route* pRoute = searchRouteByName("ConeCollectLBPick");
	Route* pBase_Pos = searchRouteByName("LB_Base_Position");
	kuka_robot::kr_batch_mv_bypose_Args srv;
	#define LB_CO_WAYPOINT_BLK_NUM		1
	// Modify entry waypoint
	srv.request.pose.X = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.X;
	srv.request.pose.Y = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.Y;
	srv.request.pose.Z = pRoute->waypoints[LB_CO_WAYPOINT_BLK_NUM].BATCH_POS.Z;
	srv.request.pose.A = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.A;
	srv.request.pose.B = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.B;
	srv.request.pose.C = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.C;
	srv.request.pose.S = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.S;
	srv.request.pose.T = pBase_Pos->waypoints[LBPosIndex].BATCH_POS.T;
	srv.request.round = 1.0;
	srv.request.block = coneCollectLBPickBatchStartBlkNum + LB_CO_WAYPOINT_BLK_NUM;
	if (!kr_set_batch_movj_bypose.call(srv))
		ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

	// Run to modified waypoints
	if (insertExitRoute)
	{
		insertExitRoute = false;
		runRouteBatch(coneCollectSBExitLRWayptBatchStartBlkNum, coneCollectLBPickBatchEndBlkNum);
	}
	else if (insertLRExitRoute)
	{
		insertLRExitRoute = false;

		// Modify point according to bulk lantern collect position
		if (insertBulkColLRExitRoute)
		{
			insertBulkColLRExitRoute = false;
			runRouteBatch(coneCollectLBPickBatchStartBlkNum, coneCollectLBPickBatchEndBlkNum);
		}
		else
			runRouteBatch(coneCollectSBExitLRWayptBatchStartBlkNum + 1, coneCollectLBPickBatchEndBlkNum);
	}
	else
		runRouteBatch(coneCollectLBPickBatchStartBlkNum, coneCollectLBPickBatchEndBlkNum);
}

void FrontRobotArmSM::ST_ConeCollectSBFill(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectSBFill");
	UpdateCmdTimestampIfChangeOfState();

	// Enable release LB exclusive lock by moving out
	pLoadingBaySM->enable_ReleaseLB_ExclusiveLock_IfMovOut(2);

	// Modify to working storage bay entry position
	int SBStackForCollect, SBStackLevelForCollect;
	pConeStorageBaySM->getUpdateSBPosForCollection(&SBStackForCollect, &SBStackLevelForCollect);
	if (SBStackForCollect == ConeStorageBaySM::SB_NOTAVAL)
	{
		ROS_INFO("No space in Storage Bay to store. Stop.");
		InternalEvent(ST_IDLE, NULL);						// set state and do move
	    return;
	}

	ROS_INFO("Front Arm fill space in SB%d current level %d to store.", SBStackForCollect, SBStackLevelForCollect);

	currentWorkingSBStackPos = SBStackForCollect;
	double SBStackPosHeight = SBStackLevelForCollect * CONE_BASE_HEIGHT_MM;
	if (currentWorkingSBStackPos >= ConeStorageBaySM::SB_6)
	{
		if (pConeStorageBaySM->sliderPosition == 1)
		{
			currentWorkingSBStackPos -= 6;
			SBStackPosHeight += CONE_SLIDER_HEIGHT_MM;
		}
		else
		{
			ROS_INFO("Storage Bay Slider NOT in extend mode. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
			return;
		}
	}
	else
	{
		if (pConeStorageBaySM->sliderPosition == 1)
		{
			ROS_INFO("Storage Bay Slider NOT in retract mode. Stop.");
			InternalEvent(ST_IDLE, NULL);						// set state and do move
			return;
		}
	}
	ROS_INFO("Front Arm fill space in SB Pos %d height %f to store.", currentWorkingSBStackPos, SBStackPosHeight);

	// Modify first point of ConeCollectSBFill move by current working SB basConeCollectSBFille position (movj)
	Route* pRoute = searchRouteByName("ConeCollectSBFill");
//	Route* pBase_Pos = searchRouteByName("SB_Base_Position");
	Route* pTop_Pos = searchRouteByName("SB_Top_Position");

	kuka_robot::kr_batch_mv_bypose_Args srv;
	#define SB_CO_LBTOP_BLK_NUM		0
	// Modify top waypoint
	srv.request.pose.X = 0;
	srv.request.pose.Y = 0;
	// If pick from RLB, add height to avoid hit LLB lantern
	if (robotArmState->pos_setpt.Y < 0)
		srv.request.pose.Z = pRoute->waypoints[SB_CO_LBTOP_BLK_NUM].BATCH_POS.Z + 700.0;
	else
		srv.request.pose.Z = pRoute->waypoints[SB_CO_LBTOP_BLK_NUM].BATCH_POS.Z;
	srv.request.pose.A = 0;
	srv.request.pose.B = 0;
	srv.request.pose.C = 0;
	srv.request.pose.S = 0;
	srv.request.pose.T = 0;
	srv.request.round = 1.0;
	srv.request.block = coneCollectSBFillBatchStartBlkNum + SB_CO_LBTOP_BLK_NUM;
	if (!kr_set_batch_movlrel_bypose.call(srv))
		ROS_INFO("kr_set_batch_movlrel_bypose returned error: %ld", (long int)srv.response.response);

	#define SB_CO_WAYPOINT_BLK_NUM		5
	double deltaHeightToTop = (CONESTORAGEBAY_1_LEVEL_PER_STACK * CONE_BASE_HEIGHT_MM) - SBStackPosHeight;
	double entryZPos = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Z - deltaHeightToTop + CONE_BASE_HEIGHT_MM + 10.0;
	if (entryZPos < 1480.0)
		entryZPos = 1480.0;
	else if (entryZPos > pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Z)
		entryZPos = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Z;

	// Modify base waypoint (use top as avoid collision with other high stack, and keep cone vertical)
	srv.request.pose.X = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.X;
	srv.request.pose.Y = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.Y;
	srv.request.pose.Z = entryZPos;
	srv.request.pose.A = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.A;
	srv.request.pose.B = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.B;
	srv.request.pose.C = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.C;
	srv.request.pose.S = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.S;
	srv.request.pose.T = pTop_Pos->waypoints[currentWorkingSBStackPos].BATCH_POS.T;
	srv.request.round = 1.0;
	srv.request.block = coneCollectSBFillBatchStartBlkNum + SB_CO_WAYPOINT_BLK_NUM;
	if (!kr_set_batch_movj_bypose.call(srv))
		ROS_INFO("kr_set_batch_movj_bypose returned error: %ld", (long int)srv.response.response);

	// Run to modified waypoints
	runRouteBatch(coneCollectSBFillBatchStartBlkNum, coneCollectSBFillBatchEndBlkNum);
}

void FrontRobotArmSM::ST_ConeCollectCompleted(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_ConeCollectCompleted");
	UpdateCmdTimestampIfChangeOfState();

	// TBD: update by cone counter sensor
	pConeStorageBaySM->incSBStackLevel();

	double cycleTime = ros::Time::now().toSec() - cycleStartTimeStamp;
	cycleStartTimeStamp = ros::Time::now().toSec();
	ROS_INFO("Front Arm collection [%d] cycle time = %.3fs.", CollectionConeCount, cycleTime);

	insertExitRoute = false;
	insertLRExitRoute = false;
	CollectionConeCount++;
	if ( (CollectionConeAmount <= CollectionConeCount) &&
			(pLoadingBaySM->getReadyLB_LoadToStorage() == LoadingBaySM::LB_NOTAVAL) )
	{
		runRouteBatch(coneCollectSBExitBatchStartBlkNum, coneCollectSBExitBatchEndBlkNum);
		return;
	}

	// check if LB is ready and reserved
//	RobotArmEventData* psmData = new RobotArmEventData();
	RobotArmEventData smData;
	smData.cmd = pLoadingBaySM->getReadyLB_LoadToStorage();
	if (smData.cmd != LoadingBaySM::LB_NOTAVAL)
	{
		insertExitRoute = true;
		// Check data ready and if have lantern on cone at decided LB
		if ( (smData.cmd == LoadingBaySM::LB_LEFT) && (detectedLanternInLLB > 0) )
			InternalEvent(ST_CONECOLLECT_LRPICKFILL, NULL);	// set state and do move
		else if ( (smData.cmd == LoadingBaySM::LB_RIGHT) && (detectedLanternInRLB > 0) )
			InternalEvent(ST_CONECOLLECT_LRPICKFILL, NULL);	// set state and do move
		else
			InternalEvent(ST_CONECOLLECT_LBPICK, NULL);		// set state and do move
	}
	else
		runRouteBatch(coneCollectSBExitBatchStartBlkNum, coneCollectSBExitBatchEndBlkNum);
}


/* Inventory Check SM ---------------------------------------------------------------------------------*/
void FrontRobotArmSM::ST_InventoryCheckPoseA(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_InventoryCheckPoseA");
	UpdateCmdTimestampIfChangeOfState();

	runRouteBatch(coneInventoryCheckPoseABatchStartBlkNum, coneInventoryCheckPoseABatchEndBlkNum);
}

void FrontRobotArmSM::ST_InventoryCheckA(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_InventoryCheckA");
	UpdateCmdTimestampIfChangeOfState();

}

void FrontRobotArmSM::ST_InventoryCheckPoseB(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_InventoryCheckPoseB");
	UpdateCmdTimestampIfChangeOfState();

	runRouteBatch(coneInventoryCheckPoseBBatchStartBlkNum, coneInventoryCheckPoseBBatchEndBlkNum);
}

void FrontRobotArmSM::ST_InventoryCheckB(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_InventoryCheckB");
	UpdateCmdTimestampIfChangeOfState();

}

void FrontRobotArmSM::ST_InventoryCheckExit(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_InventoryCheckExit");
	UpdateCmdTimestampIfChangeOfState();

	runRouteBatch(coneInventoryCheckExitBatchStartBlkNum, coneInventoryCheckExitBatchEndBlkNum);
}

/* Safe Home-ing SM ---------------------------------------------------------------------------------*/
void FrontRobotArmSM::ST_SafeHomeHandleRearSide(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_SafeHomeHandleRearSide");
	UpdateCmdTimestampIfChangeOfState();

	kr_state_accesskey.lock();
	double curr_tcp_x = robotArmState->pos_setpt.X;
	int curr_do_port = robotArmState->com_do_port_value;
    kr_state_accesskey.unlock();

    // If TCP at front side
	if (curr_tcp_x > 0)
	{
		InternalEvent(ST_SAFEHOME_HANDLEFRONTSIDE, NULL);			// set state and do move
		return;
	}

	// If TCP at rear side
	if ( (curr_do_port & 0x8000) && (!(curr_do_port & 0x4000)) )
	{
		// Check if upper close lower open, lantern in grip, to LB
		// Open grip, bit 15,14 are upper and lower gripper control pin
		previousMotionCmdTimestamp = ros::Time::now().toSec();	// set timestamp only if call move directly
		kuka_robot::kr_setdo_Args srv;
		srv.request.value = 0x2000;
		srv.request.mask = 0xE000;
		srv.request.settle_sec = 1.0;
		if (!kr_setdigitaloutput.call(srv))
			ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
	}
	else if ( (armDetectObjectInGrip) &&
		((curr_do_port & 0x8000) || (curr_do_port & 0x4000)) )
	{
		// Check if something in grip and grip closed, put to an empty LB, if full, SB
		// Open grip, bit 15,14 are upper and lower gripper control pin
		previousMotionCmdTimestamp = ros::Time::now().toSec();	// set timestamp only if call move directly
		kuka_robot::kr_setdo_Args srv;
		srv.request.value = 0x2000;
		srv.request.mask = 0xE000;
		srv.request.settle_sec = 1.0;
		if (!kr_setdigitaloutput.call(srv))
			ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
	}
	else
		ROS_INFO("Nothing gripped so no need put back.");
}

void FrontRobotArmSM::ST_SafeHomeHandleFrontSide(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_SafeHomeHandleFrontSide");
	UpdateCmdTimestampIfChangeOfState();

	kr_state_accesskey.lock();
	double curr_tcp_x = robotArmState->pos_setpt.X;
	int curr_do_port = robotArmState->com_do_port_value;
    kr_state_accesskey.unlock();

    // If TCP at front side
	if ( (curr_do_port & 0x8000) && (!(curr_do_port & 0x4000)) )
	{
		// Check if upper close lower open, lantern in grip, to LB
		// Open grip, bit 15,14 are upper and lower gripper control pin
		previousMotionCmdTimestamp = ros::Time::now().toSec();	// set timestamp only if call move directly
		kuka_robot::kr_setdo_Args srv;
		srv.request.value = 0x2000;
		srv.request.mask = 0xE000;
		srv.request.settle_sec = 1.0;
		if (!kr_setdigitaloutput.call(srv))
			ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
	}
	else if ( (armDetectObjectInGrip) &&
		((curr_do_port & 0x8000) || (curr_do_port & 0x4000)) )
	{
		// Check if something in grip and grip closed, put to SB
		// Open grip, bit 15,14 are upper and lower gripper control pin
		previousMotionCmdTimestamp = ros::Time::now().toSec();	// set timestamp only if call move directly
		kuka_robot::kr_setdo_Args srv;
		srv.request.value = 0x2000;
		srv.request.mask = 0xE000;
		srv.request.settle_sec = 1.0;
		if (!kr_setdigitaloutput.call(srv))
			ROS_INFO("kr_setdigitaloutput returned error: %ld", (long int)srv.response.response);
	}
	else
		ROS_INFO("Nothing gripped so no need put back.");
}

void FrontRobotArmSM::ST_SafeHomeMoveUpExit(RobotArmEventData*)
{
	ROS_INFO("FrontRobotArmSM::ST_SafeHomeMoveUpExit");
	UpdateCmdTimestampIfChangeOfState();

	kr_state_accesskey.lock();
	double curr_tcp_z = robotArmState->pos_setpt.Z;
    kr_state_accesskey.unlock();

    if (curr_tcp_z < 1100.0)
    {
		// Go movlrel to upper space (exit waypoint)
		previousMotionCmdTimestamp = ros::Time::now().toSec();		// set timestamp only if call move directly
		kuka_robot::kr_mv_bypose_Args srv;
		srv.request.pose.X = 0;
		srv.request.pose.Y = 0;
		srv.request.pose.Z = (1100.0 - curr_tcp_z);
		srv.request.pose.A = 0;
		srv.request.pose.B = 0;
		srv.request.pose.C = 0;
		srv.request.pose.S = -1;
		srv.request.pose.T = -1;
		if (!kr_movlrel_bypose.call(srv))
			ROS_INFO("kr_movlrel_bypose returned error: %ld", (long int)srv.response.response);
		ROS_INFO("Do exit move.");
    }
}


