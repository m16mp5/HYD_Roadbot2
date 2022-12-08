#ifndef _ROBOTARMSM_H
#define _ROBOTARMSM_H
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

#include "lidar_tracker/lt_datapoint_Type.h"
#include "lidar_tracker/lt_object_Type.h"
#include "lidar_tracker/lt_state_Type.h"

#include "StateMachine.h"

using namespace std;


// Marco defined in KRC4 Rob_MotServer
#define MOVJ_BYJOINTS_ACTION_TYPE				2
#define MOVL_BYJOINTS_ACTION_TYPE				4
#define MOVJREL_BYJOINTS_ACTION_TYPE			6
//#define MOVLREL_BYJOINTS_ACTION_TYPE			00		// not possible
#define MOVJRELTOOL_BYJOINTS_ACTION_TYPE		106
//#define MOVLRELTOOL_BYJOINTS_ACTION_TYPE		00		// not possible
#define MOVJ_BYPOSE_ACTION_TYPE					1
#define MOVL_BYPOSE_ACTION_TYPE					3
#define MOVJREL_BYPOSE_ACTION_TYPE				5
#define MOVLREL_BYPOSE_ACTION_TYPE				7
#define MOVJRELTOOL_BYPOSE_ACTION_TYPE			105
#define MOVLRELTOOL_BYPOSE_ACTION_TYPE			107
#define DO_ACTION_TYPE							51

// Batch block define
#define ROBOTARM_CUSTOM_BATCH_START_BLKNO					1
#define ROBOTARM_CONEPLACEMENT_CUSTOM_BATCH_START_BLKNO		50
#define ROBOTARM_CONEPLACEMENT_BATCH_START_BLKNO			ROBOTARM_CONEPLACEMENT_CUSTOM_BATCH_START_BLKNO + 10
#define ROBOTARM_CONECOLLECTION_CUSTOM_BATCH_START_BLKNO	250
#define ROBOTARM_CONECOLLECTION_BATCH_START_BLKNO			ROBOTARM_CONECOLLECTION_CUSTOM_BATCH_START_BLKNO + 10

// Gripping point to TCP define
#define ROBOTARM_GRIPPOINT_TO_TCP_DIST_MM		250.0

// Jerk time from experiment of jerk of kr60
#define ROBOTARM_SHORTEST_JERK_TIME_SEC			0.130 // 0.330


// Struct/Class define
struct E6AXIS
{
	double A1;
	double A2;
	double A3;
	double A4;
	double A5;
	double A6;
	double E1;
	double E2;
	double E3;
	double E4;
	double E5;
	double E6;
};

struct POS
{
	double X;
	double Y;
	double Z;
	double A;
	double B;
	double C;
	double S;
	double T;
};

struct BATCH_MOV_BLK
{
	E6AXIS BATCH_E6AXIS;
	POS BATCH_POS;
	int DO_MASK;
	int DO_VALUE;
	double DO_SETSEC;
	int BATCH_ACTION;
	double BATCH_ROUNDM;
};

struct Route
{
	string name;
	vector<BATCH_MOV_BLK> waypoints;
};

struct ConeSet
{
	double relativeX;			// in mm
	double relativeY;			// in mm
	bool Has_Lantern;
	bool Is_1mCone;
};

// structure to hold event data passed into state machine
struct RobotArmEventData : public EventData
{
	string eventName;
	int cmd;
	double x;
	double y;
	double z;
	double a;
	double b;
	double c;
	int id;
};

// the robot arm state machine class
class RobotArmSM : public StateMachine
{
public:
	ros::ServiceClient kr_movj_bypose;
	ros::ServiceClient kr_movj_byjoint;
	ros::ServiceClient kr_movl_bypose;
	ros::ServiceClient kr_movl_byjoint;
	ros::ServiceClient kr_movjrel_bypose;
	ros::ServiceClient kr_movjrel_byjoint;
	ros::ServiceClient kr_movlrel_bypose;
	ros::ServiceClient kr_movjreltool_bypose;
	ros::ServiceClient kr_movjreltool_byjoint;
	ros::ServiceClient kr_movlreltool_bypose;
	ros::ServiceClient kr_setdigitaloutput;

	ros::ServiceClient kr_set_batch_movj_bypose;
	ros::ServiceClient kr_set_batch_movj_byjoint;
	ros::ServiceClient kr_set_batch_movl_bypose;
	ros::ServiceClient kr_set_batch_movl_byjoint;
	ros::ServiceClient kr_set_batch_movjrel_bypose;
	ros::ServiceClient kr_set_batch_movjrel_byjoint;
	ros::ServiceClient kr_set_batch_movlrel_bypose;
	ros::ServiceClient kr_set_batch_movjreltool_bypose;;
	ros::ServiceClient kr_set_batch_movjreltool_byjoint;
	ros::ServiceClient kr_set_batch_movlreltool_bypose;
	ros::ServiceClient kr_set_batch_setdigitaloutput;
	ros::ServiceClient kr_batch_mov_run;

	ros::ServiceClient kr_rampdown_stop;
	ros::ServiceClient kr_check_mov_completed;
	ros::ServiceClient kr_set_speedscale;
	ros::ServiceClient kr_set_payload;
	ros::ServiceClient kr_set_base_coord;
	ros::ServiceClient kr_set_tool_coord;
	ros::ServiceClient kr_conv_joints_to_pose;
	ros::ServiceClient kr_set_default_accvel;
	ros::ServiceClient kr_set_default_round;
	ros::ServiceClient kr_start_autoext_mode;
	ros::ServiceClient kr_set_moveenable_signal;

	vector<Route> Routes;

	string armName;

	bool IsEmergencyStopActivatedPrev;
	bool IsEmergencyStopActivated;

	double previousMotionCmdTimestamp;

	RobotArmSM() : StateMachine(ST_MAX_STATES), previousStateBeforePause(CANNOT_HAPPEN), previousMotionCmdTimestamp(0),
			previousDLCustomBatchStartBlkno(0), previousDLCustomBatchEndBlkno(0),
			IsEmergencyStopActivatedPrev(false), IsEmergencyStopActivated(false) {}

	void UpdateCmdTimestampIfChangeOfState();

	virtual bool checkHitBoundaryZone();

	// external events taken by this state machine
	virtual void OnUpdateRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
	virtual void OnUpdateArmDetectorState(const lidar_tracker::lt_state_Type::ConstPtr&);

	virtual void cmdResumeMove();
	virtual void disableHWMoveSignal();
	virtual void stopAutoControl();
	virtual void goHome();
	virtual void goDemo(Route*);
	virtual void goConePlacement();
	virtual void goConeCollection();

protected:
	kuka_robot::kr_robot_state_Type::ConstPtr robotArmState;
	lidar_tracker::lt_state_Type::ConstPtr armDetectState;
	mutex kr_state_accesskey;
	mutex arm_lt_state_accesskey;

	unsigned char previousStateBeforePause;

	double calLinProfileTime(double distToGo, double acc, double vel, double* pmaxVel);
	double calLinProfileTimeWithSpeedScale(double distToGo, double acc, double vel, double* pmaxVel);
	double calLinProfileTimeToDest(double destX, double destY, double destZ, double acc, double vel, double* pmaxVel);

	void getCurrentGripPointPosition_mm(double* gripPointX, double* gripPointY, double* gripPointZ);		// in mm
	double calPointDist(double Point1X, double Point1Y, double Point1Z,double Point2X, double Point2Y, double Point2Z);
	double calPointDistToRobotArmGripPoint_mm(double PointX_mm, double PointY_mm, double PointZ_mm);		// out mm, in mm
	double calPointDistToRobotArmGripPoint2D_mm(double PointX_mm, double PointY_mm);						// out mm, in mm

	int previousDLCustomBatchStartBlkno;
	int previousDLCustomBatchEndBlkno;

	Route* searchRouteByName(string name);
	int setRouteBatch(Route* route, int startBlockNum);			// return endBlockNum or error -1/-2
	int runRouteBatch(int startBlockNum, int endBlockNum);
	int runRouteSingle(Route* route, int elementNum);

	// state machine state functions
	virtual void ST_Disable(RobotArmEventData*);
	virtual void ST_Idle(RobotArmEventData*);
	virtual void ST_Stop(RobotArmEventData*);
	virtual void ST_Pause(RobotArmEventData*);
	virtual void ST_Resume(RobotArmEventData*);
	virtual void ST_Error(RobotArmEventData*);
	virtual void ST_Home(RobotArmEventData*);
	virtual void ST_Demo(RobotArmEventData*);
	virtual void ST_ConePlacementInitPose(RobotArmEventData*);
	virtual void ST_ConeCollectionInitPose(RobotArmEventData*);

	// state map to define state function order
	BEGIN_STATE_MAP
		STATE_MAP_ENTRY(&RobotArmSM::ST_Disable)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Idle)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Stop)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Pause)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Resume)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Error)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Home)
		STATE_MAP_ENTRY(&RobotArmSM::ST_Demo)
		STATE_MAP_ENTRY(&RobotArmSM::ST_ConePlacementInitPose)
		STATE_MAP_ENTRY(&RobotArmSM::ST_ConeCollectionInitPose)
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

		ST_CONEPLACEMENT_INITPOSE,
		ST_CONECOLLECTION_INITPOSE,

		ST_MAX_STATES
	};
};
#endif // _ROBOTARMSM_H
