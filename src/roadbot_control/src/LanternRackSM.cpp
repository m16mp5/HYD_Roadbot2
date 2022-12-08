#include <assert.h>
#include <iostream>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "LanternRackSM.h"


// external event
/*void LanternRackSM::OnUpdateFrontRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
	kr2_state_accesskey.lock();
	frontRobotArmState = msg;
	double tcpx = frontRobotArmState->pos_fb.X;
	double tcpy = frontRobotArmState->pos_fb.Y;
	double tcpz = frontRobotArmState->pos_fb.Z;
    kr2_state_accesskey.unlock();
}*/

// external event
void LanternRackSM::OnUpdateLanternRackState(const lantern_rack::lr_state_Type::ConstPtr& msg)
{
/*	msg->state;
	msg->sensor_state[10];
	// Lantern rack current working mode state [0-down 1-placement 2-collect]
	msg->mode[10];
	// 10 Lantern rack sensors states
	msg->level[10];*/

	numOfLanternsInTotal = 0;
	for (int i=0; i<LANTERNRACK_NUMOFSTACK; i++)
	{
		numOfLanternsInStack[i] = msg->level[i];
		numOfLanternsInTotal += numOfLanternsInStack[i];

		stackSensorState[i] = msg->sensor_state[i];
	}
}

int LanternRackSM::getWorkingLRForPlacement(int* stackN, int* stackLevel)
{
	*stackLevel = -9999;
	*stackN = LR_NOTAVAL;

	// Start with any lantern in 0,1,2
	if ( (numOfLanternsInStack[LR_0] > 0) || (numOfLanternsInStack[LR_1] > 0) || (numOfLanternsInStack[LR_2] > 0) )
	{
		if ( (numOfLanternsInStack[LR_2] > *stackLevel) && (numOfLanternsInStack[LR_2] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_2];
			*stackN = LR_2;
		}
		if ( (numOfLanternsInStack[LR_1] > *stackLevel) && (numOfLanternsInStack[LR_1] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_1];
			*stackN = LR_1;
		}
		if ( (numOfLanternsInStack[LR_0] > *stackLevel) && (numOfLanternsInStack[LR_0] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_0];
			*stackN = LR_0;
		}
	}
/*
	// then 3,4
	else if ( (numOfLanternsInStack[LR_3] > 0) || (numOfLanternsInStack[LR_4] > 0) )
	{
		if ( (numOfLanternsInStack[LR_3] > *stackLevel) && (numOfLanternsInStack[LR_3] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_3];
			*stackN = LR_3;
		}
		if ( (numOfLanternsInStack[LR_4] > *stackLevel) && (numOfLanternsInStack[LR_4] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_4];
			*stackN = LR_4;
		}
	}

	// then 5,6
	else if ( (numOfLanternsInStack[LR_5] > 0) || (numOfLanternsInStack[LR_6] > 0) )
	{
		if ( (numOfLanternsInStack[LR_5] > *stackLevel) && (numOfLanternsInStack[LR_5] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_5];
			*stackN = LR_5;
		}
		if ( (numOfLanternsInStack[LR_6] > *stackLevel) && (numOfLanternsInStack[LR_6] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_6];
			*stackN = LR_6;
		}
	}
	*/
	// then 3,4,5,6
	else if ( (numOfLanternsInStack[LR_3] > 0) || (numOfLanternsInStack[LR_4] > 0) ||
			(numOfLanternsInStack[LR_5] > 0) || (numOfLanternsInStack[LR_6] > 0) )
	{
		if ( (numOfLanternsInStack[LR_3] > *stackLevel) && (numOfLanternsInStack[LR_3] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_3];
			*stackN = LR_3;
		}
		if ( (numOfLanternsInStack[LR_4] > *stackLevel) && (numOfLanternsInStack[LR_4] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_4];
			*stackN = LR_4;
		}
		if ( (numOfLanternsInStack[LR_5] > *stackLevel) && (numOfLanternsInStack[LR_5] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_5];
			*stackN = LR_5;
		}
		if ( (numOfLanternsInStack[LR_6] > *stackLevel) && (numOfLanternsInStack[LR_6] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_6];
			*stackN = LR_6;
		}
	}
	// then 7,8,9
	else if ( (numOfLanternsInStack[LR_7] > 0) || (numOfLanternsInStack[LR_8] > 0) || (numOfLanternsInStack[LR_9] > 0) )
	{
		if ( (numOfLanternsInStack[LR_7] > *stackLevel) && (numOfLanternsInStack[LR_7] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_7];
			*stackN = LR_7;
		}
		if ( (numOfLanternsInStack[LR_8] > *stackLevel) && (numOfLanternsInStack[LR_8] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_8];
			*stackN = LR_8;
		}
		if ( (numOfLanternsInStack[LR_9] > *stackLevel) && (numOfLanternsInStack[LR_9] >= 0) )
		{
			*stackLevel = numOfLanternsInStack[LR_9];
			*stackN = LR_9;
		}
	}
	else
	{
		currentStackLevel = *stackLevel;
		currentStack = *stackN;
		ROS_INFO("Lantern Rack no more lanterns!");
		return -1;
	}

	currentStackLevel = *stackLevel;
	currentStack = *stackN;
	return 0;
}

int LanternRackSM::getWorkingLRForCollection(int* stackN, int* stackLevel)
{
	*stackLevel = 9999;
	*stackN = LR_NOTAVAL;

	// Start with any lantern space in 0,1,2 then 3,4 then 5,6 then 7,8,9
	if ( ((numOfLanternsInStack[LR_0] < LANTERNRACK_1_LEVEL_PER_STACK) ||
			(numOfLanternsInStack[LR_1] < LANTERNRACK_1_LEVEL_PER_STACK) ||
			(numOfLanternsInStack[LR_2] < LANTERNRACK_1_LEVEL_PER_STACK)) &&
			(numOfLanternsInStack[LR_0] >= 0) && (numOfLanternsInStack[LR_1] >= 0) && (numOfLanternsInStack[LR_2] >= 0) )
	{
		if ( (numOfLanternsInStack[LR_2] < *stackLevel) && !stackSensorState[LR_2] )
		{
			*stackLevel = numOfLanternsInStack[LR_2];
			*stackN = LR_2;
		}
		if ( (numOfLanternsInStack[LR_1] < *stackLevel) && !stackSensorState[LR_1] )
		{
			*stackLevel = numOfLanternsInStack[LR_1];
			*stackN = LR_1;
		}
		if ( (numOfLanternsInStack[LR_0] < *stackLevel) && !stackSensorState[LR_0] )
		{
			*stackLevel = numOfLanternsInStack[LR_0];
			*stackN = LR_0;
		}
	}
/*
	// then 3,4
	else if ( ((numOfLanternsInStack[LR_3] < LANTERNRACK_2_LEVEL_PER_STACK) ||
				(numOfLanternsInStack[LR_4] < LANTERNRACK_2_LEVEL_PER_STACK)) &&
				(numOfLanternsInStack[LR_3] >= 0) && (numOfLanternsInStack[LR_4] >= 0) )
	{
		if ( (numOfLanternsInStack[LR_3] < *stackLevel) && !stackSensorState[LR_3] )
		{
			*stackLevel = numOfLanternsInStack[LR_3];
			*stackN = LR_3;
		}
		if ( (numOfLanternsInStack[LR_4] < *stackLevel) && !stackSensorState[LR_4] )
		{
			*stackLevel = numOfLanternsInStack[LR_4];
			*stackN = LR_4;
		}
	}
	// then 5,6
	else if ( ((numOfLanternsInStack[LR_5] < LANTERNRACK_3_LEVEL_PER_STACK) ||
				(numOfLanternsInStack[LR_6] < LANTERNRACK_3_LEVEL_PER_STACK)) &&
				(numOfLanternsInStack[LR_5] >= 0) && (numOfLanternsInStack[LR_6] >= 0) )
	{
		if ( (numOfLanternsInStack[LR_5] < *stackLevel) && !stackSensorState[LR_5] )
		{
			*stackLevel = numOfLanternsInStack[LR_5];
			*stackN = LR_5;
		}
		if ( (numOfLanternsInStack[LR_6] < *stackLevel) && !stackSensorState[LR_6] )
		{
			*stackLevel = numOfLanternsInStack[LR_6];
			*stackN = LR_6;
		}
	}
	*/
	// then 3,4,5,6
	else if ( ((numOfLanternsInStack[LR_3] < LANTERNRACK_2_LEVEL_PER_STACK) ||
				(numOfLanternsInStack[LR_4] < LANTERNRACK_2_LEVEL_PER_STACK) ||
				(numOfLanternsInStack[LR_5] < LANTERNRACK_3_LEVEL_PER_STACK) ||
				(numOfLanternsInStack[LR_6] < LANTERNRACK_3_LEVEL_PER_STACK)) &&
				(numOfLanternsInStack[LR_3] >= 0) && (numOfLanternsInStack[LR_4] >= 0) &&
				(numOfLanternsInStack[LR_5] >= 0) && (numOfLanternsInStack[LR_6] >= 0) )
	{
		if ( (numOfLanternsInStack[LR_3] < *stackLevel) && !stackSensorState[LR_3] )
		{
			*stackLevel = numOfLanternsInStack[LR_3];
			*stackN = LR_3;
		}
		if ( (numOfLanternsInStack[LR_4] < *stackLevel) && !stackSensorState[LR_4] )
		{
			*stackLevel = numOfLanternsInStack[LR_4];
			*stackN = LR_4;
		}
		if ( (numOfLanternsInStack[LR_5] < *stackLevel) && !stackSensorState[LR_5] )
		{
			*stackLevel = numOfLanternsInStack[LR_5];
			*stackN = LR_5;
		}
		if ( (numOfLanternsInStack[LR_6] < *stackLevel) && !stackSensorState[LR_6] )
		{
			*stackLevel = numOfLanternsInStack[LR_6];
			*stackN = LR_6;
		}
	}
	// then 7,8,9
	else if ( ((numOfLanternsInStack[LR_7] < LANTERNRACK_4_LEVEL_PER_STACK) ||
			(numOfLanternsInStack[LR_8] < LANTERNRACK_4_LEVEL_PER_STACK) ||
			(numOfLanternsInStack[LR_9] < LANTERNRACK_4_LEVEL_PER_STACK)) &&
			(numOfLanternsInStack[LR_7] >= 0) && (numOfLanternsInStack[LR_8] >= 0) && (numOfLanternsInStack[LR_9] >= 0) )
	{
		if ( (numOfLanternsInStack[LR_7] < *stackLevel) && !stackSensorState[LR_7] )
		{
			*stackLevel = numOfLanternsInStack[LR_7];
			*stackN = LR_7;
		}
		if ( (numOfLanternsInStack[LR_8] < *stackLevel) && !stackSensorState[LR_8] )
		{
			*stackLevel = numOfLanternsInStack[LR_8];
			*stackN = LR_8;
		}
		if ( (numOfLanternsInStack[LR_9] < *stackLevel) && !stackSensorState[LR_9] )
		{
			*stackLevel = numOfLanternsInStack[LR_9];
			*stackN = LR_9;
		}
	}
	else
	{
		currentStackLevel = *stackLevel;
		currentStack = *stackN;
		ROS_INFO("Lantern Rack no more space to store lantern!");
		return -1;
	}

	*stackLevel += 1;			// Output the "to become" level number after collection
	currentStackLevel = *stackLevel;
	currentStack = *stackN;
	return 0;
}


void LanternRackSM::ST_HaveLantern(EventData* pData)
{
	ROS_INFO("LanternRackSM::ST_HaveLantern");
}

void LanternRackSM::ST_Sliding(EventData* pData)
{
	ROS_INFO("LanternRackSM::ST_Sliding");
}

void LanternRackSM::ST_Empty(EventData* pData)
{
	ROS_INFO("LanternRackSM::ST_Empty");
}

void LanternRackSM::ST_Error(EventData* pData)
{
	ROS_INFO("LanternRackSM::ST_Error");
}


