#ifndef _REARROBOTARMSM_H
#define _REARROBOTARMSM_H

#include "RobotArmSM.h"
#include "LoadingBaySM.h"
#include "autocone.h"

#include "vision_system/vs_check_position_has_cone_Args.h"
#include "vision_system/vs_get_white_marking_position_Args.h"

using namespace std;

// the rear robot arm state machine class
class RearRobotArmSM : public RobotArmSM
{
public:
	ros::ServiceClient vs_check_position_has_cone;
	ros::ServiceClient vs_get_white_marking_position;

	RearRobotArmSM();
	~RearRobotArmSM();

	double left_loadingbay_reararmtcp_pos_x;
	double left_loadingbay_reararmtcp_pos_y;
	double right_loadingbay_reararmtcp_pos_x;
	double right_loadingbay_reararmtcp_pos_y;
	double left_loadingbay_reararmtcp_pos_z;
	double right_loadingbay_reararmtcp_pos_z;
	void loadLBBasePosition();
	LoadingBaySM* pLoadingBaySM;

	void coord_FrontRobotArm_RobotArmTCP(double fa_x, double fa_y, double fa_z, double* ra_x, double* ra_y, double* ra_z);
	void coord_RearDetect_RobotArmTCP(double lmm_x, double lmm_y, double lmm_z, double* amm_x, double* amm_y);
	void orient_RearDetect_RobotArmTCP(double l_x, double l_y, double l_z, double* a_x, double* a_y);

	double frontArmCurrTCP_X;
	double frontArmCurrTCP_Y;
	double frontArmCurrTCP_Z;
	bool checkHitBoundaryZone();

	int getObjectIndexByID(int ID);
	int getNearestConeObjectIndex(double limitY_lid_m, double minX_lid_m, bool printlog);
	int getObjectIndexNearAPoint(double x_tcp_mm, double y_tcp_mm, double* dist_mm);
	int getObjectIndexInZone(double limitY1_lid_m, double limitY2_lid_m, double limitX_lid_m);
	int getObjectPositionInRobotSpace(int objectIndex, double pred_t, double shf_x_lid_mm, double shf_y_lid_mm, double* x_lid_mm, double* y_lid_mm, double* x_tcp_mm, double* y_tcp_mm);
	int getTargetPositionInRobotSpace(double pred_t, double* x_lid_mm, double* y_lid_mm, double* x_tcp_mm, double* y_tcp_mm);

	bool checkOperationZone(double grip_x_mm, double grip_y_mm);
	void calProjectedStandbyZone(double obj_y_mm, double* grip_x_mm, double* grip_y_mm);

	// external events taken by this state machine
	void OnUpdateRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
	void OnUpdateArmDetectorState(const lidar_tracker::lt_state_Type::ConstPtr&);
	void OnUpdateRearDetectorState(const lidar_tracker::lt_state_Type::ConstPtr&);
	void OnUpdateLoadingBayState();

	double calData_rearDetectToRearRobotTCP_Angle;
	double calData_rearDetectToRearRobotTCP_OffsetX;
	double calData_rearDetectToRearRobotTCP_OffsetY;

	POS targetObjectCmdTracePose;

	int targetObjectID;
	int targetFused;
	double targetAge;
	POS targetObjectPose;
	POS targetObjectPoseAtLid;	// in mm
	POS targetObjectVelAtLid;	// in m/s
	POS targetObjectAccAtLid;	// in m/s2

	bool rearDetectObjectInDeadZone;
	bool rearDetectObjectInPlaceZoneRight;
	bool rearDetectObjectInPlaceZoneCenter;
	bool rearDetectObjectInPlaceZoneLeft;
	bool rearDetectNonLockObjectInOperationZone;

	bool armDetectObjectInGrip;

	double roadmarkLineX;
	double roadmarkLineY;
	int placementRefToLineMode;

	vector<ConeSet>* PlacementConeChainTemplate;
	int PlacementConeChainCurrIndex;
	void goConePlacement(vector<ConeSet>* PlacementConeChain, int mode);
	int CollectionConeAmount;
	int CollectionConeCount;
	void goConeCollection(int numOfCones, int mode);

	void goHomeSafely();

	void goStandPlacement(int LBLocation, double x, double y);
	void goStandCollection(int LBLocation, double x, double y);
	void goSignPlacement(int LBLocation, double x, double y);
	void goSignCollection(int LBLocation, double x, double y);

	void changeAutolockTarget(int num);
	void changeRoadmarkLineTrack(double x, double y);

private:
	std::thread autolockTh;
	static void autolockThreadRun(RearRobotArmSM* self);
	std::thread lineTrackTh;
	static void lineTrackThreadRun(RearRobotArmSM* self);

	lidar_tracker::lt_state_Type::ConstPtr rearDetectState;
	mutex rear_lt_state_accesskey;

	mutex roadmarkLine_accesskey;

	int predictArmGripPositionWithTarget(double* x_lid_mm, double* y_lid_mm, double* x_tcp_mm, double* y_tcp_mm);

	double collectFloorZHeight;
	int collectCatchCanReach;
	int collectCancelCmdCount;
	bool collectAtStationary;

	double cycleStartTimeStamp;

	int signStandLBLocation;
	double signStandPosX;
	double signStandPosY;

	int conePlaceInitPoseBatchStartBlkNum;
	int conePlaceInitPoseBatchEndBlkNum;
	int conePlaceLLBExitFloorBatchStartBlkNum;
	int conePlaceLLBExitFloorBatchEndBlkNum;
	int conePlaceLLBPickBatchStartBlkNum;
	int conePlaceLLBPickBatchEndBlkNum;
	int conePlaceRLBExitFloorBatchStartBlkNum;
	int conePlaceRLBExitFloorBatchEndBlkNum;
	int conePlaceRLBPickBatchStartBlkNum;
	int conePlaceRLBPickBatchEndBlkNum;
	int conePlaceLLBFloorBatchStartBlkNum;
	int conePlaceLLBFloorBatchEndBlkNum;
	int conePlaceRLBFloorBatchStartBlkNum;
	int conePlaceRLBFloorBatchEndBlkNum;

	int coneCollectInitPoseBatchStartBlkNum;
	int coneCollectInitPoseBatchEndBlkNum;
	int coneCollectAimBatchStartBlkNum;
	int coneCollectAimBatchEndBlkNum;
	int coneCollectTraceGripEntryBatchStartBlkNum;
	int coneCollectTraceGripEntryBatchEndBlkNum;
	int coneCollectConeGripBatchStartBlkNum;
	int coneCollectConeGripBatchEndBlkNum;
	int coneCollectGripUpBatchStartBlkNum;
	int coneCollectGripUpBatchEndBlkNum;
	int coneCollectWaitLBPoseBatchStartBlkNum;
	int coneCollectWaitLBPoseBatchEndBlkNum;
	int coneCollectLLBFillBatchStartBlkNum;
	int coneCollectLLBFillBatchEndBlkNum;
	int coneCollectRLBFillBatchStartBlkNum;
	int coneCollectRLBFillBatchEndBlkNum;
	int coneCollectLLBExitBatchStartBlkNum;
	int coneCollectLLBExitBatchEndBlkNum;
	int coneCollectRLBExitBatchStartBlkNum;
	int coneCollectRLBExitBatchEndBlkNum;
	int coneCollectConeGripFailBatchStartBlkNum;
	int coneCollectConeGripFailBatchEndBlkNum;

	int standPlaceLLBInitPoseBatchStartBlkNum;
	int standPlaceLLBInitPoseBatchEndBlkNum;
	int standPlaceLLBPickBatchStartBlkNum;
	int standPlaceLLBPickBatchEndBlkNum;
	int standPlaceLLBFloorBatchStartBlkNum;
	int standPlaceLLBFloorBatchEndBlkNum;
	int standPlaceRLBInitPoseBatchStartBlkNum;
	int standPlaceRLBInitPoseBatchEndBlkNum;
	int standPlaceRLBPickBatchStartBlkNum;
	int standPlaceRLBPickBatchEndBlkNum;
	int standPlaceRLBFloorBatchStartBlkNum;
	int standPlaceRLBFloorBatchEndBlkNum;
	int standPlaceRLB2InitPoseBatchStartBlkNum;
	int standPlaceRLB2InitPoseBatchEndBlkNum;
	int standPlaceRLB2PickBatchStartBlkNum;
	int standPlaceRLB2PickBatchEndBlkNum;
	int standPlaceRLB2FloorBatchStartBlkNum;
	int standPlaceRLB2FloorBatchEndBlkNum;

	int standCollectInitPoseBatchStartBlkNum;
	int standCollectInitPoseBatchEndBlkNum;
	int standCollectTraceGripEntryBatchStartBlkNum;
	int standCollectTraceGripEntryBatchEndBlkNum;
	int standCollectStandGripBatchStartBlkNum;
	int standCollectStandGripBatchEndBlkNum;
	int standCollectLLBFillBatchStartBlkNum;
	int standCollectLLBFillBatchEndBlkNum;
	int standCollectRLBFillBatchStartBlkNum;
	int standCollectRLBFillBatchEndBlkNum;
	int standCollectRLB2FillBatchStartBlkNum;
	int standCollectRLB2FillBatchEndBlkNum;

	int signPlaceLBInitPoseBatchStartBlkNum;
	int signPlaceLBInitPoseBatchEndBlkNum;
	int signPlaceLBPickBatchStartBlkNum;
	int signPlaceLBPickBatchEndBlkNum;
	int signPlaceLBFloorBatchStartBlkNum;
	int signPlaceLBFloorBatchEndBlkNum;

	int signCollectInitPoseBatchStartBlkNum;
	int signCollectInitPoseBatchEndBlkNum;
	int signCollectTraceGripEntryBatchStartBlkNum;
	int signCollectTraceGripEntryBatchEndBlkNum;
	int signCollectSignGripBatchStartBlkNum;
	int signCollectSignGripBatchEndBlkNum;
	int signCollectLBFillBatchStartBlkNum;
	int signCollectLBFillBatchEndBlkNum;

	int reloadPlacementRoutes();
	int reloadCollectionRoutes();

	// state machine state functions
	void ST_ConePlaceInitPose(RobotArmEventData*);
	void ST_ConePlaceWaitLBReady(RobotArmEventData*);
	void ST_ConePlaceLBPick(RobotArmEventData*);
	void ST_ConePlaceFloorExitLBPick(RobotArmEventData*);
	void ST_ConePlaceWaitForCond(RobotArmEventData*);
	void ST_ConePlaceFloor(RobotArmEventData*);
	void ST_ConePlaceCompleted(RobotArmEventData*);

	void ST_ConeCollectInitPose(RobotArmEventData*);
	void ST_ConeCollectAim(RobotArmEventData*);
	void ST_ConeCollectTraceGripEntry(RobotArmEventData*);
	void ST_ConeCollectConeGrip(RobotArmEventData*);
	void ST_ConeCollectGripUp(RobotArmEventData*);
	void ST_ConeCollectCheckGripOK(RobotArmEventData*);
	void ST_ConeCollectWaitLBPose(RobotArmEventData*);
	void ST_ConeCollectWaitLBReady(RobotArmEventData*);
	void ST_ConeCollectLBFill(RobotArmEventData*);
	void ST_ConeCollectLost(RobotArmEventData*);
	void ST_ConeCollectConeGripFail(RobotArmEventData*);
	void ST_ConeCollectCompleted(RobotArmEventData*);

	void ST_SafeHomeHandleRearSide(RobotArmEventData*);
	void ST_SafeHomeHandleTruckSide(RobotArmEventData*);
	void ST_SafeHomeCheckGripCenterExit(RobotArmEventData*);

	void ST_StandPlaceInitPose(RobotArmEventData*);
	void ST_StandPlaceWaitLBReady(RobotArmEventData*);
	void ST_StandPlaceLBPick(RobotArmEventData*);
	void ST_StandPlaceWaitForCond(RobotArmEventData*);
	void ST_StandPlaceFloor(RobotArmEventData*);
	void ST_StandPlaceCompleted(RobotArmEventData*);

	void ST_StandCollectInitPose(RobotArmEventData*);
	void ST_StandCollectAim(RobotArmEventData*);
	void ST_StandCollectTraceGripEntry(RobotArmEventData*);
	void ST_StandCollectStandGrip(RobotArmEventData*);
	void ST_StandCollectGripUp(RobotArmEventData*);
	void ST_StandCollectWaitLBPose(RobotArmEventData*);
	void ST_StandCollectWaitLBReady(RobotArmEventData*);
	void ST_StandCollectLBFill(RobotArmEventData*);
	void ST_StandCollectCompleted(RobotArmEventData*);

	void ST_SignPlaceInitPose(RobotArmEventData*);
	void ST_SignPlaceWaitLBReady(RobotArmEventData*);
	void ST_SignPlaceLBPick(RobotArmEventData*);
	void ST_SignPlaceWaitForCond(RobotArmEventData*);
	void ST_SignPlaceFloor(RobotArmEventData*);
	void ST_SignPlaceCompleted(RobotArmEventData*);

	void ST_SignCollectInitPose(RobotArmEventData*);
	void ST_SignCollectAim(RobotArmEventData*);
	void ST_SignCollectTraceGripEntry(RobotArmEventData*);
	void ST_SignCollectSignGrip(RobotArmEventData*);
	void ST_SignCollectGripUp(RobotArmEventData*);
	void ST_SignCollectWaitLBPose(RobotArmEventData*);
	void ST_SignCollectWaitLBReady(RobotArmEventData*);
	void ST_SignCollectLBFill(RobotArmEventData*);
	void ST_SignCollectCompleted(RobotArmEventData*);

	// state map to define state function order
	BEGIN_STATE_MAP
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Disable)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Idle)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Stop)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Pause)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Resume)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Error)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Home)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_Demo)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceInitPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceWaitLBReady)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceLBPick)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceFloorExitLBPick)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceWaitForCond)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceFloor)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConePlaceCompleted)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectInitPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectAim)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectTraceGripEntry)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectConeGrip)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectGripUp)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectCheckGripOK)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectWaitLBPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectWaitLBReady)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectLBFill)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectLost)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectConeGripFail)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_ConeCollectCompleted)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SafeHomeHandleRearSide)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SafeHomeHandleTruckSide)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SafeHomeCheckGripCenterExit)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandPlaceInitPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandPlaceWaitLBReady)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandPlaceLBPick)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandPlaceWaitForCond)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandPlaceFloor)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandPlaceCompleted)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectInitPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectAim)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectTraceGripEntry)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectStandGrip)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectGripUp)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectWaitLBPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectWaitLBReady)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectLBFill)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_StandCollectCompleted)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignPlaceInitPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignPlaceWaitLBReady)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignPlaceLBPick)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignPlaceWaitForCond)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignPlaceFloor)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignPlaceCompleted)

		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectInitPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectAim)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectTraceGripEntry)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectSignGrip)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectGripUp)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectWaitLBPose)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectWaitLBReady)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectLBFill)
		STATE_MAP_ENTRY(&RearRobotArmSM::ST_SignCollectCompleted)
	END_STATE_MAP

	// state enumeration order must match the order of state
	// method entries in the state map
	enum E_States {
		ST_DISABLE = 0,
		ST_IDLE,
		ST_STOP,
		ST_PAUSE,
		ST_RESUME,
		ST_ERROR,
		ST_HOME,
		ST_DEMO,

		ST_CONEPLACE_INITPOSE,
		ST_CONEPLACE_WAITLBREADY,
		ST_CONEPLACE_LBPICK,
		ST_CONEPLACE_FLOOREXITLBPICK,
		ST_CONEPLACE_WAITFORCOND,
		ST_CONEPLACE_FLOOR,
		ST_CONEPLACE_COMPLETED,

		ST_CONECOLLECT_INITPOSE,
		ST_CONECOLLECT_AIM,
		ST_CONECOLLECT_TRACEGRIPENTRY,
		ST_CONECOLLECT_CONEGRIP,
		ST_CONECOLLECT_GRIPUP,
		ST_CONECOLLECT_CHECKGRIPOK,
		ST_CONECOLLECT_WAITLBPOSE,
		ST_CONECOLLECT_WAITLBREADY,
		ST_CONECOLLECT_LBFILL,
		ST_CONECOLLECT_LOST,
		ST_CONECOLLECT_CONEGRIPFAIL,
		ST_CONECOLLECT_COMPLETED,

		ST_SAFEHOME_HANDLEREARSIDE,
		ST_SAFEHOME_HANDLETRUCKSIDE,
		ST_SAFEHOME_CHECKGRIPCENTEREXIT,

		ST_STANDPLACE_INITPOSE,
		ST_STANDPLACE_WAITLBREADY,
		ST_STANDPLACE_LBPICK,
		ST_STANDPLACE_WAITFORCOND,
		ST_STANDPLACE_FLOOR,
		ST_STANDPLACE_COMPLETED,

		ST_STANDCOLLECT_INITPOSE,
		ST_STANDCOLLECT_AIM,
		ST_STANDCOLLECT_TRACEGRIPENTRY,
		ST_STANDCOLLECT_STANDGRIP,
		ST_STANDCOLLECT_GRIPUP,
		ST_STANDCOLLECT_WAITLBPOSE,
		ST_STANDCOLLECT_WAITLBREADY,
		ST_STANDCOLLECT_LBFILL,
		ST_STANDCOLLECT_COMPLETED,

		ST_SIGNPLACE_INITPOSE,
		ST_SIGNPLACE_WAITLBREADY,
		ST_SIGNPLACE_LBPICK,
		ST_SIGNPLACE_WAITFORCOND,
		ST_SIGNPLACE_FLOOR,
		ST_SIGNPLACE_COMPLETED,

		ST_SIGNCOLLECT_INITPOSE,
		ST_SIGNCOLLECT_AIM,
		ST_SIGNCOLLECT_TRACEGRIPENTRY,
		ST_SIGNCOLLECT_SIGNGRIP,
		ST_SIGNCOLLECT_GRIPUP,
		ST_SIGNCOLLECT_WAITLBPOSE,
		ST_SIGNCOLLECT_WAITLBREADY,
		ST_SIGNCOLLECT_LBFILL,
		ST_SIGNCOLLECT_COMPLETED,

		ST_REARARM_MAX_STATES
	};
};
#endif // _REARROBOTARMSM_H
