#ifndef _LANTERNRACKSM_H
#define _LANTERNRACKSM_H
#include "kuka_robot/kr_robot_state_Type.h"
#include "lantern_rack/lr_state_Type.h"

#include "StateMachine.h"

using namespace std;

#define LANTERNRACK_NUMOFSTACK					10
#define LANTERNRACK_1_LEVEL_PER_STACK			4
#define LANTERNRACK_2_LEVEL_PER_STACK			18
#define LANTERNRACK_3_LEVEL_PER_STACK			18
#define LANTERNRACK_4_LEVEL_PER_STACK			7

// the lantern rack state machine class
class LanternRackSM : public StateMachine
{
public:
	LanternRackSM() : StateMachine(ST_MAX_STATES), currentStack(LR_0), currentStackLevel(0), numOfLanternsInTotal(0)
	{
		for (int i=0; i<LANTERNRACK_NUMOFSTACK; i++)
			numOfLanternsInStack[i] = 1;
	}

	// external events taken by this state machine
//	virtual void OnUpdateFrontRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
	virtual void OnUpdateLanternRackState(const lantern_rack::lr_state_Type::ConstPtr&);

	virtual int getWorkingLRForPlacement(int* stackN, int* stackLevel);
	virtual int getWorkingLRForCollection(int* stackN, int* stackLevel);

	int currentStack;
	int currentStackLevel;
	int numOfLanternsInTotal;
	int numOfLanternsInStack[10];
	int stackSensorState[10];

	enum LR_ID {
		LR_0 = 0,
		LR_1,
		LR_2,
		LR_3,
		LR_4,
		LR_5,
		LR_6,
		LR_7,
		LR_8,
		LR_9,
		LR_NOTAVAL = 255,
	};

protected:
//	kuka_robot::kr_robot_state_Type::ConstPtr frontRobotArmState;
//	mutex kr2_state_accesskey;

//	lantern_rack::lr_state_Type::ConstPtr lanternRackState;
//	mutex lr_accesskey;

	// state machine state functions
	virtual void ST_HaveLantern(EventData*);
	virtual void ST_Sliding(EventData*);
	virtual void ST_Empty(EventData*);
	virtual void ST_Error(EventData*);

	// state map to define state function order
	BEGIN_STATE_MAP
		STATE_MAP_ENTRY(&LanternRackSM::ST_HaveLantern)
		STATE_MAP_ENTRY(&LanternRackSM::ST_Sliding)
		STATE_MAP_ENTRY(&LanternRackSM::ST_Empty)
		STATE_MAP_ENTRY(&LanternRackSM::ST_Error)
	END_STATE_MAP

	// state enumeration order must match the order of state
	// method entries in the state map
	enum E_States {
		ST_HAVELANTERN = 0,
		ST_SLIDING,
		ST_EMPTY,
		ST_ERROR,
		ST_MAX_STATES
	};
};
#endif // _LANTERNRACKSM_H
