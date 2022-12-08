#ifndef _FRONTROBOTARMSM_H
#define _FRONTROBOTARMSM_H

#include "RobotArmSM.h"
#include "LoadingBaySM.h"
#include "ConeStorageBaySM.h"
#include "LanternRackSM.h"
#include "autocone.h"

using namespace std;

// the rear robot arm state machine class
class FrontRobotArmSM : public RobotArmSM
{
public:
	FrontRobotArmSM();

	double left_loadingbay_frontarmtcp_pos_x;
	double left_loadingbay_frontarmtcp_pos_y;
	double right_loadingbay_frontarmtcp_pos_x;
	double right_loadingbay_frontarmtcp_pos_y;
	double left_loadingbay_frontarmtcp_pos_z;
	double right_loadingbay_frontarmtcp_pos_z;
	void loadLBBasePosition();
	LoadingBaySM* pLoadingBaySM;
	LanternRackSM* pLanternRackSM;
	ConeStorageBaySM* pConeStorageBaySM;

	void coord_RearRobotArm_RobotArmTCP(double ra_x, double ra_y, double ra_z, double* fa_x, double* fa_y, double* fa_z);

	double rearArmCurrTCP_X;
	double rearArmCurrTCP_Y;
	double rearArmCurrTCP_Z;
	bool checkHitBoundaryZone();

	// external events taken by this state machine
	void OnUpdateRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
	void OnUpdateArmDetectorState(const lidar_tracker::lt_state_Type::ConstPtr&);
	void OnUpdateLoadingBayState();
	void OnUpdateLanternRackState();
	void OnUpdateConeStorageSliderState();

	vector<ConeSet>* PlacementConeChainTemplate;
	int PlacementConeChainCurrIndex;
	int CollectionConeAmount;
	int CollectionConeCount;
	double cycleStartTimeStamp;

	bool insertExitRoute;
	bool insertLRExitRoute;
	bool insertBulkColLRExitRoute;

	bool bulkColLRMode;

	int currentWorkingSBStackPos;
	int currentWorkingLBPos;
	int currentWorkingLRStackPos;

	int detectedLanternInLLB;
	int detectedLanternInRLB;

	bool armDetectObjectInGrip;

	void goConePlacement(vector<ConeSet>* PlacementConeChain);
	void goConeCollection(int numOfCones);

	void goConeInventoryCheck();
	void goHomeSafely();

private:
	int conePlaceInitPoseBatchStartBlkNum;
	int conePlaceInitPoseBatchEndBlkNum;
	int conePlaceLBExitBatchStartBlkNum;
	int conePlaceLBExitBatchEndBlkNum;
	int conePlaceSBPickBatchStartBlkNum;
	int conePlaceSBPickBatchEndBlkNum;
	int conePlaceLBFillBatchStartBlkNum;
	int conePlaceLBFillBatchEndBlkNum;
	int conePlaceLRPickFillBatchStartBlkNum;
	int conePlaceLRPickFillBatchEndBlkNum;

	int coneCollectInitPoseBatchStartBlkNum;
	int coneCollectInitPoseBatchEndBlkNum;
	int coneCollectSBExitBatchStartBlkNum;
	int coneCollectSBExitBatchEndBlkNum;
	int coneCollectLRPickFillBatchStartBlkNum;
	int coneCollectLRPickFillBatchEndBlkNum;
	int coneCollectSBExitLRWayptBatchStartBlkNum;
	int coneCollectSBExitLRWayptBatchEndBlkNum;
	int coneCollectLBPickBatchStartBlkNum;
	int coneCollectLBPickBatchEndBlkNum;
	int coneCollectSBFillBatchStartBlkNum;
	int coneCollectSBFillBatchEndBlkNum;
	int coneCollectSBExitLRBulkBatchStartBlkNum;
	int coneCollectSBExitLRBulkBatchEndBlkNum;
	int coneCollectLRPickFillLRBulkBatchStartBlkNum;
	int coneCollectLRPickFillLRBulkBatchEndBlkNum;

	int coneInventoryCheckPoseABatchStartBlkNum;
	int coneInventoryCheckPoseABatchEndBlkNum;
	int coneInventoryCheckPoseBBatchStartBlkNum;
	int coneInventoryCheckPoseBBatchEndBlkNum;
	int coneInventoryCheckExitBatchStartBlkNum;
	int coneInventoryCheckExitBatchEndBlkNum;

	int reloadPlacementRoutes();
	int reloadCollectionRoutes();

	// state machine state functions
	void ST_ConePlaceInitPose(RobotArmEventData*);
	void ST_ConePlaceSBPick(RobotArmEventData*);
	void ST_ConePlaceLBExitSBPick(RobotArmEventData*);
	void ST_ConePlaceWaitLBReady(RobotArmEventData*);
	void ST_ConePlaceLBFill(RobotArmEventData*);
	void ST_ConePlaceLRPickFill(RobotArmEventData*);
	void ST_ConePlaceCompleted(RobotArmEventData*);

	void ST_ConeCollectInitPose(RobotArmEventData*);
	void ST_ConeCollectWaitLBReady(RobotArmEventData*);
	void ST_ConeCollectCheckLanternOnCone(RobotArmEventData*);
	void ST_ConeCollectLRPickFill(RobotArmEventData*);
	void ST_ConeCollectLBPick(RobotArmEventData*);
	void ST_ConeCollectSBFill(RobotArmEventData*);
	void ST_ConeCollectCompleted(RobotArmEventData*);

	void ST_InventoryCheckPoseA(RobotArmEventData*);
	void ST_InventoryCheckA(RobotArmEventData*);
	void ST_InventoryCheckPoseB(RobotArmEventData*);
	void ST_InventoryCheckB(RobotArmEventData*);
	void ST_InventoryCheckExit(RobotArmEventData*);

	void ST_SafeHomeHandleRearSide(RobotArmEventData*);
	void ST_SafeHomeHandleFrontSide(RobotArmEventData*);
	void ST_SafeHomeMoveUpExit(RobotArmEventData*);

	// state map to define state function order
	BEGIN_STATE_MAP
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Disable)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Idle)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Stop)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Pause)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Resume)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Error)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Home)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_Demo)

		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceInitPose)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceSBPick)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceLBExitSBPick)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceWaitLBReady)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceLBFill)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceLRPickFill)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConePlaceCompleted)

		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectInitPose)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectWaitLBReady)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectCheckLanternOnCone)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectLRPickFill)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectLBPick)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectSBFill)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_ConeCollectCompleted)

		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_InventoryCheckPoseA)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_InventoryCheckA)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_InventoryCheckPoseB)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_InventoryCheckB)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_InventoryCheckExit)

		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_SafeHomeHandleRearSide)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_SafeHomeHandleFrontSide)
		STATE_MAP_ENTRY(&FrontRobotArmSM::ST_SafeHomeMoveUpExit)
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
		ST_CONEPLACE_SBPICK,
		ST_CONEPLACE_LBEXITSBPICK,
		ST_CONEPLACE_WAITLBREADY,
		ST_CONEPLACE_LBFILL,
		ST_CONEPLACE_LRPICKFILL,
		ST_CONEPLACE_COMPLETED,

		ST_CONECOLLECT_INITPOSE,
		ST_CONECOLLECT_WAITLBREADY,
		ST_CONECOLLECT_CHECKLANTERNONCONE,
		ST_CONECOLLECT_LRPICKFILL,
		ST_CONECOLLECT_LBPICK,
		ST_CONECOLLECT_SBFILL,
		ST_CONECOLLECT_COMPLETED,

		ST_INVENTORYCHECK_POSEA,
		ST_INVENTORYCHECK_CHECKA,
		ST_INVENTORYCHECK_POSEB,
		ST_INVENTORYCHECK_CHECKB,
		ST_INVENTORYCHECK_EXIT,

		ST_SAFEHOME_HANDLEREARSIDE,
		ST_SAFEHOME_HANDLEFRONTSIDE,
		ST_SAFEHOME_MOVEUPEXIT,

		ST_FRONTARM_MAX_STATES
	};
};
#endif // _FRONTROBOTARMSM_H
