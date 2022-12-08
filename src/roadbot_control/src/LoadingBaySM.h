#ifndef _LOADINGBAYSM_H
#define _LOADINGBAYSM_H
#include "kuka_robot/kr_robot_state_Type.h"
#include "system_io/sio_state_Type.h"

#include "StateMachine.h"

using namespace std;

/*#define LEFT_LOADINGBAY_REARARMTCP_POS_X		-1180.0
#define LEFT_LOADINGBAY_REARARMTCP_POS_Y		-364.0
#define RIGHT_LOADINGBAY_REARARMTCP_POS_X		-1180.0
#define RIGHT_LOADINGBAY_REARARMTCP_POS_Y		364.0
#define LEFT_LOADINGBAY_REARARMTCP_POS_Z		1280.0
#define RIGHT_LOADINGBAY_REARARMTCP_POS_Z		1280.0

#define LEFT_LOADINGBAY_FRONTARMTCP_POS_X		-1219.0
#define LEFT_LOADINGBAY_FRONTARMTCP_POS_Y		364.0
#define RIGHT_LOADINGBAY_FRONTARMTCP_POS_X		-1219.0
#define RIGHT_LOADINGBAY_FRONTARMTCP_POS_Y		-364.0
#define LEFT_LOADINGBAY_FRONTARMTCP_POS_Z		-270.0
#define RIGHT_LOADINGBAY_FRONTARMTCP_POS_Z		-270.0*/

#define LOADINGBAY_INBOUND_RADIUS				300.0
#define LOADINGBAY_OUTBOUND_RADIUS				400.0

// the loading bay state machine class
class LoadingBaySM : public StateMachine
{
public:
	LoadingBaySM() : StateMachine(ST_MAX_STATES), leftLoadingBayRearArmIn(0), leftLoadingBayFrontArmIn(0),
					rightLoadingBayRearArmIn(0), rightLoadingBayFrontArmIn(0),
					leftLoadingBayLoaded(0), rightLoadingBayLoaded(0),
					left_loadingbay_reararmtcp_pos_x(0), left_loadingbay_reararmtcp_pos_y(0),
					right_loadingbay_reararmtcp_pos_x(0), right_loadingbay_reararmtcp_pos_y(0),
					left_loadingbay_reararmtcp_pos_z(0), right_loadingbay_reararmtcp_pos_z(0),
					left_loadingbay_frontarmtcp_pos_x(0), left_loadingbay_frontarmtcp_pos_y(0),
					right_loadingbay_frontarmtcp_pos_x(0), right_loadingbay_frontarmtcp_pos_y(0),
					left_loadingbay_frontarmtcp_pos_z(0), right_loadingbay_frontarmtcp_pos_z(0),
					llbExclusiveLockOwner(0), rlbExclusiveLockOwner(0),
					llbExclusiveLock_MovOutUnlock(0), rlbExclusiveLock_MovOutUnlock(0), lastRRAWorkingLB(LB_LEFT) {}

	// external events taken by this state machine
	virtual void OnUpdateRearRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
	virtual void OnUpdateFrontRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
	virtual void OnUpdateSioState(const system_io::sio_state_Type::ConstPtr&);

	virtual int getReadyLB_StorageToLoad();
	virtual int getReadyLB_LoadToPlace();
	virtual int getReadyLB_CollectToLoad();
	virtual int getReadyLB_LoadToStorage();

	// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
	virtual bool acquireLLB_ExclusiveLock(int fromArm);
	virtual bool acquireRLB_ExclusiveLock(int fromArm);
	virtual bool releaseLLB_ExclusiveLock(int fromArm);
	virtual bool releaseRLB_ExclusiveLock(int fromArm);
	virtual bool checkLLB_ExclusiveLock_Owner(int byArm);
	virtual bool checkRLB_ExclusiveLock_Owner(int byArm);

	virtual bool enable_ReleaseLB_ExclusiveLock_IfMovOut(int byArm);

	enum LB_ID {
		LB_NOTAVAL = 0,
		LB_LEFT,
		LB_RIGHT,
	};

	double left_loadingbay_reararmtcp_pos_x;
	double left_loadingbay_reararmtcp_pos_y;
	double right_loadingbay_reararmtcp_pos_x;
	double right_loadingbay_reararmtcp_pos_y;
	double left_loadingbay_reararmtcp_pos_z;
	double right_loadingbay_reararmtcp_pos_z;
	double left_loadingbay_frontarmtcp_pos_x;
	double left_loadingbay_frontarmtcp_pos_y;
	double right_loadingbay_frontarmtcp_pos_x;
	double right_loadingbay_frontarmtcp_pos_y;
	double left_loadingbay_frontarmtcp_pos_z;
	double right_loadingbay_frontarmtcp_pos_z;

	bool leftLoadingBayRearArmIn;
	bool leftLoadingBayFrontArmIn;
	int leftLoadingBayLoaded;

	bool rightLoadingBayRearArmIn;
	bool rightLoadingBayFrontArmIn;
	int rightLoadingBayLoaded;
	mutex lb_accesskey;

protected:
	kuka_robot::kr_robot_state_Type::ConstPtr rearRobotArmState;
	kuka_robot::kr_robot_state_Type::ConstPtr frontRobotArmState;
	mutex kr1_state_accesskey;
	mutex kr2_state_accesskey;

	system_io::sio_state_Type::ConstPtr lbSensorState;
	mutex sio_state_accesskey;

	int llbExclusiveLockOwner;
	int rlbExclusiveLockOwner;
	mutex llbExclusiveLock_accesskey;
	mutex rlbExclusiveLock_accesskey;

	bool llbExclusiveLock_MovOutUnlock;
	bool rlbExclusiveLock_MovOutUnlock;

	int lastRRAWorkingLB;

	// state machine state functions
	virtual void ST_HaveSpace(EventData*);
	virtual void ST_Full(EventData*);
	virtual void ST_Error(EventData*);

	// state map to define state function order
	BEGIN_STATE_MAP
		STATE_MAP_ENTRY(&LoadingBaySM::ST_HaveSpace)
		STATE_MAP_ENTRY(&LoadingBaySM::ST_Full)
		STATE_MAP_ENTRY(&LoadingBaySM::ST_Error)
	END_STATE_MAP

	// state enumeration order must match the order of state
	// method entries in the state map
	enum E_States {
		ST_HAVESPACE = 0,
		ST_FULL,
		ST_ERROR,
		ST_MAX_STATES
	};
};
#endif // _LOADINGBAYSM_H
