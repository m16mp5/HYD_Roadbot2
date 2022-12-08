#include <assert.h>
#include <iostream>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "ConeStorageBaySM.h"

#define SENSOR_R_TO_FLOOR_HEIGHT_MM			3232.0
#define SENSOR_C_TO_FLOOR_HEIGHT_MM			3240.0
#define SENSOR_L_TO_FLOOR_HEIGHT_MM			3205.0

#define CONE_SLIDER_R_HEIGHT_MM				350.0 //CONE_SLIDER_HEIGHT_MM
#define CONE_SLIDER_C_HEIGHT_MM				360.0 //CONE_SLIDER_HEIGHT_MM
#define CONE_SLIDER_L_HEIGHT_MM				270.0 //CONE_SLIDER_HEIGHT_MM

// external event
/*void ConeStorageBaySM::OnUpdateFrontRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
	kr2_state_accesskey.lock();
	frontRobotArmState = msg;
	double tcpx = frontRobotArmState->pos_fb.X;
	double tcpy = frontRobotArmState->pos_fb.Y;
	double tcpz = frontRobotArmState->pos_fb.Z;
    kr2_state_accesskey.unlock();
}

// external event
void ConeStorageBaySM::OnUpdateConeSensorsState(const cone_sensor::cs_state_Type::ConstPtr& msg)
{
	sb_accesskey.lock();
	coneSensorState = msg;

	coneSensorTotal = 0;
	for (int i=0; i<12; i++)
	{
		coneSensorValues[i] = msg->weight_slots[CONESTORAGEBAY_FIRST_CONESENSOR_SLOTNUM + i];
		coneSensorTotal += coneSensorValues[i];
	}

	// Calculate number of cones
	numOfConesInTotal = 0;
	for (int i=0; i<12; i++)
	{
		double reduced = coneSensorValues[i] - CONESTORAGEBAY_WEIGHT_PER_CONE_THES;

		if (reduced <= 0)
			numOfConesInStack[i] = 0;
		else
			numOfConesInStack[i] = (int)(reduced/CONESTORAGEBAY_WEIGHT_PER_CONE_DIV_RATIO) + 1;

		numOfConesInTotal += numOfConesInStack[i];
	}
	sb_accesskey.unlock();
}*/

// external event
/*void ConeStorageBaySM::OnUpdateRearSlidersState(const system_io::sio_state_Type::ConstPtr& msg)
{
	if (msg->cone_slider_extend)
		sliderPosition = 1;
	else
		sliderPosition = 0;
}*/

// external event
void ConeStorageBaySM::OnUpdateConeCounterLeftState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
	double X0 = msg->columnscan_up_dist[1] * 1000.0;
	double X1 = msg->columnscan_up_dist[2] * 1000.0;
	double X2 = msg->columnscan_up_dist[5] * 1000.0;
	double X3 = msg->columnscan_up_dist[6] * 1000.0;

	coneCounterLeftMvAvgBuff[0][coneCounterLeftMvAvgBuffWrIndex] = X0;
	coneCounterLeftMvAvgBuff[1][coneCounterLeftMvAvgBuffWrIndex] = X1;
	coneCounterLeftMvAvgBuff[2][coneCounterLeftMvAvgBuffWrIndex] = X2;
	coneCounterLeftMvAvgBuff[3][coneCounterLeftMvAvgBuffWrIndex] = X3;
	coneCounterLeftMvAvgBuffWrIndex++;
	if (coneCounterLeftMvAvgBuffWrIndex >=32)
		coneCounterLeftMvAvgBuffWrIndex = 0;
	double accumX0 = 0;
	double accumX1 = 0;
	double accumX2 = 0;
	double accumX3 = 0;
	for (int i=0; i<8; i++)
	{
		accumX0 += coneCounterLeftMvAvgBuff[0][i];
		accumX1 += coneCounterLeftMvAvgBuff[1][i];
		accumX2 += coneCounterLeftMvAvgBuff[2][i];
		accumX3 += coneCounterLeftMvAvgBuff[3][i];
	}
	X0 = accumX0/8;
	X1 = accumX1/8;
	X2 = accumX2/8;
	X3 = accumX3/8;

//	ROS_INFO("Cone Storage Left  :  %.3f, %.3f, %.3f, %.3f", X0, X1, X2, X3);

	//double distAtMaxStack = SENSOR_L_TO_FLOOR_HEIGHT_MM - (CONESTORAGEBAY_1_LEVEL_PER_STACK * CONE_BASE_HEIGHT_MM * 1.20);
	if (X0 <= 0) X0 = SENSOR_L_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_L_HEIGHT_MM;
	if (X1 <= 0) X1 = SENSOR_L_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_L_HEIGHT_MM;
	if (X2 <= 0) X2 = SENSOR_L_TO_FLOOR_HEIGHT_MM;
	if (X3 <= 0) X3 = SENSOR_L_TO_FLOOR_HEIGHT_MM;

	// No update state if not slider not in settled state
	if (!sliderSettled)
		return;

	if (sliderPosition == 0)
	{
		numOfConesInStack[SB_9] = round((SENSOR_L_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_L_HEIGHT_MM - X0) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_6] = round((SENSOR_L_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_L_HEIGHT_MM - X1) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_3] = round((SENSOR_L_TO_FLOOR_HEIGHT_MM - X2) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_0] = round((SENSOR_L_TO_FLOOR_HEIGHT_MM - X3) / CONE_BASE_HEIGHT_MM);
	}
	else
	{
		numOfConesInStack[SB_9] = round((SENSOR_L_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_L_HEIGHT_MM - X2) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_6] = round((SENSOR_L_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_L_HEIGHT_MM - X3) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_3] = 0;
		numOfConesInStack[SB_0] = 0;
	}

//	ROS_INFO("Cone Storage Left  : [%d, %d, %d, %d]", numOfConesInStack[SB_9], numOfConesInStack[SB_6], numOfConesInStack[SB_3], numOfConesInStack[SB_0]);
}

// external event
void ConeStorageBaySM::OnUpdateConeCounterCenterState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
	double X0 = msg->columnscan_up_dist[1] * 1000.0;
	double X1 = msg->columnscan_up_dist[2] * 1000.0;
	double X2 = msg->columnscan_up_dist[5] * 1000.0;
	double X3 = msg->columnscan_up_dist[6] * 1000.0;

	coneCounterCenterMvAvgBuff[0][coneCounterCenterMvAvgBuffWrIndex] = X0;
	coneCounterCenterMvAvgBuff[1][coneCounterCenterMvAvgBuffWrIndex] = X1;
	coneCounterCenterMvAvgBuff[2][coneCounterCenterMvAvgBuffWrIndex] = X2;
	coneCounterCenterMvAvgBuff[3][coneCounterCenterMvAvgBuffWrIndex] = X3;
	coneCounterCenterMvAvgBuffWrIndex++;
	if (coneCounterCenterMvAvgBuffWrIndex >=32)
		coneCounterCenterMvAvgBuffWrIndex = 0;
	double accumX0 = 0;
	double accumX1 = 0;
	double accumX2 = 0;
	double accumX3 = 0;
	for (int i=0; i<8; i++)
	{
		accumX0 += coneCounterCenterMvAvgBuff[0][i];
		accumX1 += coneCounterCenterMvAvgBuff[1][i];
		accumX2 += coneCounterCenterMvAvgBuff[2][i];
		accumX3 += coneCounterCenterMvAvgBuff[3][i];
	}
	X0 = accumX0/8;
	X1 = accumX1/8;
	X2 = accumX2/8;
	X3 = accumX3/8;

	double XF = msg->columnscan_up_dist[3] * 1000.0;
	double XR = msg->columnscan_up_dist[4] * 1000.0;

//	ROS_INFO("Cone Storage Center: %.3f, %.3f, %.3f, %.3f", X0, X1, X2, X3);

	//double distAtMaxStack = SENSOR_C_TO_FLOOR_HEIGHT_MM - (CONESTORAGEBAY_1_LEVEL_PER_STACK * CONE_BASE_HEIGHT_MM * 1.20);
	if (X0 <= 0) X0 = SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM;
	if (X1 <= 0) X1 = SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM;
	if (X2 <= 0) X2 = SENSOR_C_TO_FLOOR_HEIGHT_MM;
	if (X3 <= 0) X3 = SENSOR_C_TO_FLOOR_HEIGHT_MM;

	// Update SB status on center sensor msg
	int sliderSensor0 = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM + CONE_BASE_HEIGHT_MM - X0) / CONE_BASE_HEIGHT_MM);
	int sliderSensor1 = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM + CONE_BASE_HEIGHT_MM - X1) / CONE_BASE_HEIGHT_MM);
	int sliderSensor2 = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM + CONE_BASE_HEIGHT_MM - XF) / CONE_BASE_HEIGHT_MM);
	if ( (sliderSensor0 < 0) && (sliderSensor1 < 0) && (sliderSensor2 < 0) )
	{
		sliderPosition = 1;									// 0=retracted, 1=extended
		sliderSettled = true;
	}
	else if ( (sliderSensor0 >= 0) && (sliderSensor1 >= 0) && (sliderSensor2 >= 0) )
	{
		sliderPosition = 0;									// 0=retracted, 1=extended
		sliderSettled = true;
	}
	else
	{
		sliderSettled = false;
		ROS_INFO("Cone Storage Slider not settled: %d, %d, %d", sliderSensor0, sliderSensor1, sliderSensor2);
	}

	// No update state if not slider not in settled state
	if (!sliderSettled)
		return;

	if (sliderPosition == 0)
	{
		numOfConesInStack[SB_10] = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM - X0) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_7] = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM - X1) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_4] = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - X2) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_1] = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - X3) / CONE_BASE_HEIGHT_MM);
	}
	else
	{
		numOfConesInStack[SB_10] = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM - X2) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_7] = round((SENSOR_C_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_C_HEIGHT_MM - X3) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_4] = 0;
		numOfConesInStack[SB_1] = 0;
	}

//	ROS_INFO("Cone Storage Center: [%d, %d, %d, %d]", numOfConesInStack[SB_10], numOfConesInStack[SB_7], numOfConesInStack[SB_4], numOfConesInStack[SB_1]);

	// Update SB status on center sensor msg
	updateSBNumOfCones();
//	ROS_INFO("Cone Storage Total: [%d], Slider: %d", numOfConesInTotal, sliderPosition);
}

// external event
void ConeStorageBaySM::OnUpdateConeCounterRightState(const lidar_tracker::lt_state_Type::ConstPtr& msg)
{
	double X0 = msg->columnscan_up_dist[1] * 1000.0;
	double X1 = msg->columnscan_up_dist[2] * 1000.0;
	double X2 = msg->columnscan_up_dist[5] * 1000.0;
	double X3 = msg->columnscan_up_dist[6] * 1000.0;

	coneCounterRightMvAvgBuff[0][coneCounterRightMvAvgBuffWrIndex] = X0;
	coneCounterRightMvAvgBuff[1][coneCounterRightMvAvgBuffWrIndex] = X1;
	coneCounterRightMvAvgBuff[2][coneCounterRightMvAvgBuffWrIndex] = X2;
	coneCounterRightMvAvgBuff[3][coneCounterRightMvAvgBuffWrIndex] = X3;
	coneCounterRightMvAvgBuffWrIndex++;
	if (coneCounterRightMvAvgBuffWrIndex >=32)
		coneCounterRightMvAvgBuffWrIndex = 0;
	double accumX0 = 0;
	double accumX1 = 0;
	double accumX2 = 0;
	double accumX3 = 0;
	for (int i=0; i<8; i++)
	{
		accumX0 += coneCounterRightMvAvgBuff[0][i];
		accumX1 += coneCounterRightMvAvgBuff[1][i];
		accumX2 += coneCounterRightMvAvgBuff[2][i];
		accumX3 += coneCounterRightMvAvgBuff[3][i];
	}
	X0 = accumX0/8;
	X1 = accumX1/8;
	X2 = accumX2/8;
	X3 = accumX3/8;

//	ROS_INFO("Cone Storage Right : %.3f, %.3f, %.3f, %.3f", X0, X1, X2, X3);

	//double distAtMaxStack = SENSOR_R_TO_FLOOR_HEIGHT_MM - (CONESTORAGEBAY_1_LEVEL_PER_STACK * CONE_BASE_HEIGHT_MM * 1.20);
	if (X0 <= 0) X0 = SENSOR_R_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_R_HEIGHT_MM;
	if (X1 <= 0) X1 = SENSOR_R_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_R_HEIGHT_MM;
	if (X2 <= 0) X2 = SENSOR_R_TO_FLOOR_HEIGHT_MM;
	if (X3 <= 0) X3 = SENSOR_R_TO_FLOOR_HEIGHT_MM;

	// No update state if not slider not in settled state
	if (!sliderSettled)
		return;

	if (sliderPosition == 0)
	{
		numOfConesInStack[SB_11] = round((SENSOR_R_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_R_HEIGHT_MM - X0) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_8] = round((SENSOR_R_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_R_HEIGHT_MM - X1) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_5] = round((SENSOR_R_TO_FLOOR_HEIGHT_MM - X2) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_2] = round((SENSOR_R_TO_FLOOR_HEIGHT_MM - X3) / CONE_BASE_HEIGHT_MM);
	}
	else
	{
		numOfConesInStack[SB_11] = round((SENSOR_R_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_R_HEIGHT_MM - X2) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_8] = round((SENSOR_R_TO_FLOOR_HEIGHT_MM - CONE_SLIDER_R_HEIGHT_MM - X3) / CONE_BASE_HEIGHT_MM);
		numOfConesInStack[SB_5] = 0;
		numOfConesInStack[SB_2] = 0;
	}

//	ROS_INFO("Cone Storage Right : [%d, %d, %d, %d]", numOfConesInStack[SB_11], numOfConesInStack[SB_8], numOfConesInStack[SB_5], numOfConesInStack[SB_2]);
}

int ConeStorageBaySM::updateSBNumOfCones()
{
	numOfConesInTotal = 0;
	for (int i=0; i<CONESTORAGEBAY_NUMOFSTACK; i++)
	{
		if (numOfConesInStack[i] > 0)
			numOfConesInTotal += numOfConesInStack[i];
	}
	return numOfConesInTotal;
}

int ConeStorageBaySM::setSBStackLevel(double* stackHeightArray, int firstStackPos, int lastStackPos)
{
	if (sliderPosition == 0)
	{
		// cone slider retracted
		int j = 0;
		int k = firstStackPos;
		while (k <= lastStackPos)
		{
			double stack_height = stackHeightArray[j];
			if (k >= SB_6)
				stack_height -= CONE_SLIDER_HEIGHT_MM;
			numOfConesInStack[k] = round(stack_height / CONE_BASE_HEIGHT_MM);
			k++;
			j++;
		}
	}
	else
	{
		// cone slider extended, SB_6 ~ SB_11 == SB_0 ~ SB_5 position
		int j = 0;
		int k = firstStackPos;
		while (k <= lastStackPos)
		{
			double stack_height = stackHeightArray[j];
			stack_height -= CONE_SLIDER_HEIGHT_MM;
			numOfConesInStack[k+6] = round(stack_height / CONE_BASE_HEIGHT_MM);
			k++;
			j++;
		}

		// cone slider extended, SB_0 ~ SB_5 must be 0
		for (int i=0; i<6; i++)
			numOfConesInStack[i] = 0;
	}

	return updateSBNumOfCones();
}

int ConeStorageBaySM::incSBStackLevel()
{
	numOfConesInStack[currentStack]++;
	updateSBNumOfCones();
	return numOfConesInStack[currentStack];
}

int ConeStorageBaySM::decSBStackLevel()
{
	numOfConesInStack[currentStack]--;
	updateSBNumOfCones();
	return numOfConesInStack[currentStack];
}

bool ConeStorageBaySM::checkSBState()
{
	if (sliderPosition == 0)
	{
		// cone slider retracted
		if ( (numOfConesInStack[SB_0] < 0) ||
			(numOfConesInStack[SB_1] < 0) ||
			(numOfConesInStack[SB_2] < 0) ||
			(numOfConesInStack[SB_3] < 0) ||
			(numOfConesInStack[SB_4] < 0) ||
			(numOfConesInStack[SB_5] < 0) )
			return false;
	}
	else
	{
		// cone slider extended
		if ( (numOfConesInStack[SB_6] < 0) ||
			(numOfConesInStack[SB_7] < 0) ||
			(numOfConesInStack[SB_8] < 0) ||
			(numOfConesInStack[SB_9] < 0) ||
			(numOfConesInStack[SB_10] < 0) ||
			(numOfConesInStack[SB_11] < 0) )
			return false;
	}

	return true;
}

int ConeStorageBaySM::getUpdateSBPosForPlacement(int* stackN, int* stackLevel)
{
	*stackLevel = -9999;
	*stackN = SB_NOTAVAL;

	// Make sure having states
	if (!checkSBState())
	{
		currentStackLevel = -9999;
		currentStack = SB_NOTAVAL;
		return -2;
	}

	if (sliderPosition == 0)
	{
		// cone slider retracted
		// If storage space1 (SB0~5) is empty
		if ( (numOfConesInStack[SB_0] == 0) &&
				(numOfConesInStack[SB_1] == 0) &&
				(numOfConesInStack[SB_2] == 0) &&
				(numOfConesInStack[SB_3] == 0) &&
				(numOfConesInStack[SB_4] == 0) &&
				(numOfConesInStack[SB_5] == 0) )
		{
			// If storage space2 (SB6~11) is empty, all empty
			if ( (numOfConesInStack[SB_6] == 0) &&
					(numOfConesInStack[SB_7] == 0) &&
					(numOfConesInStack[SB_8] == 0) &&
					(numOfConesInStack[SB_9] == 0) &&
					(numOfConesInStack[SB_10] == 0) &&
					(numOfConesInStack[SB_11] == 0) )
			{
				currentStackLevel = -9999;
				currentStack = SB_NOTAVAL;
				ROS_INFO("Cone Storage Bay no more cones!");
				return -1;
			}
			else
			{
				currentStackLevel = -9999;
				currentStack = SB_NOTAVAL;
				ROS_INFO("Cone Storage Bay no more cones in SB0~5! Please extend cone slider (use SB6~11)!");
				return 1;
			}
		}
	}
	else
	{
		// cone slider extended, SB0~5 should be 0
		// If storage space2 (SB6~11) is empty, all empty
		if ( (numOfConesInStack[SB_6] == 0) &&
				(numOfConesInStack[SB_7] == 0) &&
				(numOfConesInStack[SB_8] == 0) &&
				(numOfConesInStack[SB_9] == 0) &&
				(numOfConesInStack[SB_10] == 0) &&
				(numOfConesInStack[SB_11] == 0) )
		{
			currentStackLevel = -9999;
			currentStack = SB_NOTAVAL;
			ROS_INFO("Cone Storage Bay no more cones!");
			return -1;
		}
	}

	// Start with any cone in 0,1,2 then 3,4,5 then 6,7,8 then 9,10,11
	if ( (numOfConesInStack[SB_0] > 0) || (numOfConesInStack[SB_1] > 0) || (numOfConesInStack[SB_2] > 0) )
	{
		if (numOfConesInStack[SB_0] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_0];
			*stackN = SB_0;
		}
		if (numOfConesInStack[SB_1] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_1];
			*stackN = SB_1;
		}
		if (numOfConesInStack[SB_2] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_2];
			*stackN = SB_2;
		}
	}
	else if ( (numOfConesInStack[SB_3] > 0) || (numOfConesInStack[SB_4] > 0) || (numOfConesInStack[SB_5] > 0) )
	{
		if (numOfConesInStack[SB_3] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_3];
			*stackN = SB_3;
		}
		if (numOfConesInStack[SB_4] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_4];
			*stackN = SB_4;
		}
		if (numOfConesInStack[SB_5] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_5];
			*stackN = SB_5;
		}
	}
	else if ( (numOfConesInStack[SB_6] > 0) || (numOfConesInStack[SB_7] > 0) || (numOfConesInStack[SB_8] > 0) )
	{
		if (numOfConesInStack[SB_6] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_6];
			*stackN = SB_6;
		}
		if (numOfConesInStack[SB_7] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_7];
			*stackN = SB_7;
		}
		if (numOfConesInStack[SB_8] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_8];
			*stackN = SB_8;
		}
	}
	else if ( (numOfConesInStack[SB_9] > 0) || (numOfConesInStack[SB_10] > 0) || (numOfConesInStack[SB_11] > 0) )
	{
		if (numOfConesInStack[SB_9] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_9];
			*stackN = SB_9;
		}
		if (numOfConesInStack[SB_10] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_10];
			*stackN = SB_10;
		}
		if (numOfConesInStack[SB_11] > *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_11];
			*stackN = SB_11;
		}
	}

	currentStackLevel = *stackLevel;
	currentStack = *stackN;
	return 0;
}

int ConeStorageBaySM::getUpdateSBPosForCollection(int* stackN, int* stackLevel)
{
	*stackLevel = 9999;
	*stackN = SB_NOTAVAL;

	// Make sure having states
	if (!checkSBState())
	{
		currentStackLevel = 9999;
		currentStack = SB_NOTAVAL;
		return -2;
	}

	if (sliderPosition == 1)
	{
		// If storage space2 if full
		if ( (numOfConesInStack[SB_6] >= CONESTORAGEBAY_2_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_7] >= CONESTORAGEBAY_2_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_8] >= CONESTORAGEBAY_2_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_9] >= CONESTORAGEBAY_2_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_10] >= CONESTORAGEBAY_2_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_11] >= CONESTORAGEBAY_2_LEVEL_PER_STACK) )
		{
			currentStackLevel = 9999;
			currentStack = SB_NOTAVAL;
			ROS_INFO("Cone Storage Bay no more space in SB6~11! Please retract cone slider (use SB0~5)!");
			return 1;
		}
	}
	else
	{
		// If storage space1 is full, slider unable to extend, all full
		if ( (numOfConesInStack[SB_0] >= CONESTORAGEBAY_1_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_1] >= CONESTORAGEBAY_1_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_2] >= CONESTORAGEBAY_1_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_3] >= CONESTORAGEBAY_1_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_4] >= CONESTORAGEBAY_1_LEVEL_PER_STACK) &&
				(numOfConesInStack[SB_5] >= CONESTORAGEBAY_1_LEVEL_PER_STACK) )
		{
			currentStackLevel = 9999;
			currentStack = SB_NOTAVAL;
			ROS_INFO("Cone Storage Bay no more space in SB0~5! (SB6~11 not checked)");
			return -1;
		}
	}

	// Start with any cone in 2,1,0 then 5,4,3 then 8,7,6 then 11,10,9
	// Store SB0~2 if already occupied. Will not consider other as route to SB3~11 are blocked
	if (numOfConesInStack[SB_0] || numOfConesInStack[SB_1] || numOfConesInStack[SB_2])
	{
		if (numOfConesInStack[SB_2] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_2];
			*stackN = SB_2;
		}
		if (numOfConesInStack[SB_1] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_1];
			*stackN = SB_1;
		}
		if (numOfConesInStack[SB_0] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_0];
			*stackN = SB_0;
		}

		if (*stackLevel >= CONESTORAGEBAY_1_LEVEL_PER_STACK)
		{
			// SB0~2 full
			*stackLevel = currentStackLevel = 9999;
			*stackN = currentStack = SB_NOTAVAL;
			ROS_INFO("Cone Storage Bay no more space in SB0~2! (SB3~11 not checked)");
			return -1;
		}
		else
		{
			currentStackLevel = *stackLevel;
			currentStack = *stackN;
			return 0;
		}
	}
	// Store SB3~5 if already occupied. Will not consider other as route to SB6~11 are blocked
	else if (numOfConesInStack[SB_3] || numOfConesInStack[SB_4] || numOfConesInStack[SB_5])
	{
		if (numOfConesInStack[SB_5] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_5];
			*stackN = SB_5;
		}
		if (numOfConesInStack[SB_4] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_4];
			*stackN = SB_4;
		}
		if (numOfConesInStack[SB_3] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_3];
			*stackN = SB_3;
		}

		if (*stackLevel >= CONESTORAGEBAY_1_LEVEL_PER_STACK)
		{
			// SB3~5 full, to SB_2 as it should be 0
			*stackLevel = currentStackLevel = numOfConesInStack[SB_2];
			*stackN = currentStack = SB_2;
			return 0;
		}
		else
		{
			currentStackLevel = *stackLevel;
			currentStack = *stackN;
			return 0;
		}
	}
	// Store SB6~8 if already occupied. Will not consider other as route to SB9~11 are blocked
	else if (numOfConesInStack[SB_6] || numOfConesInStack[SB_7] || numOfConesInStack[SB_8])
	{
		if (numOfConesInStack[SB_8] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_8];
			*stackN = SB_8;
		}
		if (numOfConesInStack[SB_7] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_7];
			*stackN = SB_7;
		}
		if (numOfConesInStack[SB_6] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_6];
			*stackN = SB_6;
		}

		if (*stackLevel >= CONESTORAGEBAY_2_LEVEL_PER_STACK)
		{
			// SB6~8 full, need to retract cone slider to SB_5 as it should be 0
			if (sliderPosition == 1)
			{
				*stackLevel = currentStackLevel = 9999;
				*stackN = currentStack = SB_NOTAVAL;
				ROS_INFO("Cone Storage Bay no more space in SB6~8! Please retract cone slider (use SB0~5)!");
				return 1;
			}
			else
			{
				// Slider retracted, to SB_5 as it should be 0
				*stackLevel = currentStackLevel = numOfConesInStack[SB_5];
				*stackN = currentStack = SB_5;
				return 0;
			}
		}
		else
		{
			if (sliderPosition == 1)
			{
				currentStackLevel = *stackLevel;
				currentStack = *stackN;
				return 0;
			}
			else
			{
				*stackLevel = currentStackLevel = 9999;
				*stackN = currentStack = SB_NOTAVAL;
				ROS_INFO("Cone Storage Bay need to use SB6~8! Please extend cone slider!");
				return 1;
			}
		}
	}
	// Store SB9~11 if already occupied
	else if (numOfConesInStack[SB_9] || numOfConesInStack[SB_10] || numOfConesInStack[SB_11])
	{
		if (numOfConesInStack[SB_9] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_9];
			*stackN = SB_9;
		}
		if (numOfConesInStack[SB_10] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_10];
			*stackN = SB_10;
		}
		if (numOfConesInStack[SB_11] < *stackLevel)
		{
			*stackLevel = numOfConesInStack[SB_11];
			*stackN = SB_11;
		}

		if (*stackLevel >= CONESTORAGEBAY_2_LEVEL_PER_STACK)
		{
			if (sliderPosition == 1)
			{
				// SB9~11 full, to SB_8 as it should be 0
				*stackLevel = currentStackLevel = numOfConesInStack[SB_8];
				*stackN = currentStack = SB_8;
				return 0;
			}
			else
			{
				*stackLevel = currentStackLevel = 9999;
				*stackN = currentStack = SB_NOTAVAL;
				ROS_INFO("Cone Storage Bay need to use SB9~11! Please extend cone slider!");
				return 1;
			}
		}
		else
		{
			if (sliderPosition == 1)
			{
				currentStackLevel = *stackLevel;
				currentStack = *stackN;
				return 0;
			}
			else
			{
				*stackLevel = currentStackLevel = 9999;
				*stackN = currentStack = SB_NOTAVAL;
				ROS_INFO("Cone Storage Bay need to use SB9~11! Please extend cone slider!");
				return 1;
			}
		}
	}

	if (sliderPosition == 0)
	{
		// Nothing in SB0~11 and slider retracted
		// Any space available in SB6~8, try extend slider and use SB6~11 first
		if ( (numOfConesInStack[SB_6] < CONESTORAGEBAY_2_LEVEL_PER_STACK) ||
				(numOfConesInStack[SB_7] < CONESTORAGEBAY_2_LEVEL_PER_STACK) ||
				(numOfConesInStack[SB_8] < CONESTORAGEBAY_2_LEVEL_PER_STACK) )
		{
			*stackLevel = currentStackLevel = 9999;
			*stackN = currentStack = SB_NOTAVAL;
			ROS_INFO("Cone Storage Bay try to use SB6~11 first! Please extend cone slider!");
			return 1;
		}
		else
		{
			*stackLevel = currentStackLevel = numOfConesInStack[SB_5];
			*stackN = currentStack = SB_5;
			return 0;
		}
	}
	else if (sliderPosition == 1)
	{
		// Nothing in SB0~11 and slider extended
		*stackLevel = currentStackLevel = numOfConesInStack[SB_11];
		*stackN = currentStack = SB_11;
		return 0;
	}

	ROS_INFO("Cone Storage Bay error!");
	return -2;
}


void ConeStorageBaySM::ST_HaveCone(EventData* pData)
{
	ROS_INFO("ConeStorageBaySM::ST_HaveCone");
}

void ConeStorageBaySM::ST_Sliding(EventData* pData)
{
	ROS_INFO("ConeStorageBaySM::ST_Sliding");
}

void ConeStorageBaySM::ST_Empty(EventData* pData)
{
	ROS_INFO("ConeStorageBaySM::ST_Empty");
}

void ConeStorageBaySM::ST_Error(EventData* pData)
{
	ROS_INFO("ConeStorageBaySM::ST_Error");
}


