#ifndef _CONESTORAGEBAYSM_H
#define _CONESTORAGEBAYSM_H
#include "kuka_robot/kr_robot_state_Type.h"
#include "lidar_tracker/lt_state_Type.h"
#include "system_io/sio_state_Type.h"

#include "StateMachine.h"

using namespace std;

#define CONE_BASE_HEIGHT_MM							47.0
#define CONE_SLIDER_HEIGHT_MM						355.0

#define CONESTORAGEBAY_1_LEVEL_PER_STACK			23		// top 23 level
#define CONESTORAGEBAY_SLIDER_REDUCED_STACKLEVEL	7		// 355mm / 47mm = 7.55
#define CONESTORAGEBAY_2_LEVEL_PER_STACK			(CONESTORAGEBAY_1_LEVEL_PER_STACK-CONESTORAGEBAY_SLIDER_REDUCED_STACKLEVEL)
#define CONESTORAGEBAY_NUMOFSTACK					12

/*#define CONESTORAGEBAY_FIRST_CONESENSOR_SLOTNUM		2		// slot number in cone sensor node msg array
#define CONESTORAGEBAY_WEIGHT_PER_CONE_MAX			7.73
#define CONESTORAGEBAY_WEIGHT_PER_CONE_MIN			7.41
#define CONESTORAGEBAY_WEIGHT_PER_CONE				((CONESTORAGEBAY_WEIGHT_PER_CONE_MAX + CONESTORAGEBAY_WEIGHT_PER_CONE_MIN)/2.0)
#define CONESTORAGEBAY_WEIGHT_PER_CONE_THES			(CONESTORAGEBAY_WEIGHT_PER_CONE/3.0)*/
/*
#define TOP_STACK_1									(double)(CONESTORAGEBAY_1_LEVEL_PER_STACK-1)
#define CONESTORAGEBAY_WEIGHT_PER_CONE_DIV_RATIO	(CONESTORAGEBAY_WEIGHT_PER_CONE - (CONESTORAGEBAY_WEIGHT_PER_CONE_THES/TOP_STACK_1 + 0.01))
*/
//#define CONESTORAGEBAY_WEIGHT_PER_CONE_DIV_RATIO	(CONESTORAGEBAY_WEIGHT_PER_CONE_MIN - 0.001)


// the cone storage bay state machine class
class ConeStorageBaySM : public StateMachine
{
public:
	ConeStorageBaySM() : StateMachine(ST_MAX_STATES), /*coneSensorTotal(0),*/
			currentStack(SB_0), currentStackLevel(1), sliderPosition(0), numOfConesInTotal(-1), sliderSettled(true),
			coneCounterLeftMvAvgBuffWrIndex(0), coneCounterCenterMvAvgBuffWrIndex(0), coneCounterRightMvAvgBuffWrIndex(0)
	{
		for (int i=0; i<CONESTORAGEBAY_NUMOFSTACK; i++)
			numOfConesInStack[i] = -1;

		for (int i=0; i<4; i++)
			for (int j=0; j<32; j++)
			{
				coneCounterLeftMvAvgBuff[i][j] = 0;
				coneCounterCenterMvAvgBuff[i][j] = 0;
				coneCounterRightMvAvgBuff[i][j] = 0;
			}
	}

	// external events taken by this state machine
//	virtual void OnUpdateFrontRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr&);
//	virtual void OnUpdateConeSensorsState(const cone_sensor::cs_state_Type::ConstPtr&);
//	virtual void OnUpdateRearSlidersState(const system_io::sio_state_Type::ConstPtr& msg);
	virtual void OnUpdateConeCounterLeftState(const lidar_tracker::lt_state_Type::ConstPtr& msg);
	virtual void OnUpdateConeCounterCenterState(const lidar_tracker::lt_state_Type::ConstPtr& msg);
	virtual void OnUpdateConeCounterRightState(const lidar_tracker::lt_state_Type::ConstPtr& msg);

	virtual int updateSBNumOfCones();

	virtual int setSBStackLevel(double* stackHeightArray, int firstStackPos, int lastStackPos);
	virtual int incSBStackLevel();
	virtual int decSBStackLevel();

	virtual bool checkSBState();
	virtual int getUpdateSBPosForPlacement(int* stackN, int* stackLevel);		// return 0-ok, <0-error, >0-need moving slider
	virtual int getUpdateSBPosForCollection(int* stackN, int* stackLevel);		// return 0-ok, <0-error, >0-need moving slider

	int currentStack;
	int currentStackLevel;
	int sliderPosition;				// 0=retracted, 1=extended
	int numOfConesInTotal;
	int numOfConesInStack[CONESTORAGEBAY_NUMOFSTACK];

	bool sliderSettled;

	double coneCounterLeftMvAvgBuff[4][32];
	double coneCounterCenterMvAvgBuff[4][32];
	double coneCounterRightMvAvgBuff[4][32];
	int coneCounterLeftMvAvgBuffWrIndex;
	int coneCounterCenterMvAvgBuffWrIndex;
	int coneCounterRightMvAvgBuffWrIndex;

	enum SB_ID {
		SB_0 = 0,
		SB_1,
		SB_2,
		SB_3,
		SB_4,
		SB_5,
		SB_6,
		SB_7,
		SB_8,
		SB_9,
		SB_10,
		SB_11,
		SB_NOTAVAL = 255,
	};

protected:
//	kuka_robot::kr_robot_state_Type::ConstPtr frontRobotArmState;
//	mutex kr2_state_accesskey;

	// state machine state functions
	virtual void ST_HaveCone(EventData*);
	virtual void ST_Sliding(EventData*);
	virtual void ST_Empty(EventData*);
	virtual void ST_Error(EventData*);

	// state map to define state function order
	BEGIN_STATE_MAP
		STATE_MAP_ENTRY(&ConeStorageBaySM::ST_HaveCone)
		STATE_MAP_ENTRY(&ConeStorageBaySM::ST_Sliding)
		STATE_MAP_ENTRY(&ConeStorageBaySM::ST_Empty)
		STATE_MAP_ENTRY(&ConeStorageBaySM::ST_Error)
	END_STATE_MAP

	// state enumeration order must match the order of state
	// method entries in the state map
	enum E_States {
		ST_HAVECONE = 0,
		ST_SLIDING,
		ST_EMPTY,
		ST_ERROR,
		ST_MAX_STATES
	};
};
#endif // _CONESTORAGEBAYSM_H
