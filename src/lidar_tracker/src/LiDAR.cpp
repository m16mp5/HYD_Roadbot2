/*
 * LiDAR.cpp
 *
 *  Created on: 23 Sep 2019
 *      Author: IY
 */
#include <sstream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <cmath>

#include "ros/ros.h"
#include "std_msgs/String.h"
#include "LiDAR.h"

using namespace std;
using namespace ros;

// Function to find the circle on which the given three points lie
void findCircle(double x1, double y1, double x2, double y2, double x3, double y3, double* h, double* k, double* r)
{
	double x12 = x1 - x2;
	double x13 = x1 - x3;

	double y12 = y1 - y2;
	double y13 = y1 - y3;

	double y31 = y3 - y1;
	double y21 = y2 - y1;

	double x31 = x3 - x1;
	double x21 = x2 - x1;

	// x1^2 - x3^2
	double sx13 = pow(x1, 2) - pow(x3, 2);

	// y1^2 - y3^2
	double sy13 = pow(y1, 2) - pow(y3, 2);

	double sx21 = pow(x2, 2) - pow(x1, 2);
	double sy21 = pow(y2, 2) - pow(y1, 2);

	double f = ((sx13) * (x12)
			 + (sy13) * (x12)
			 + (sx21) * (x13)
			 + (sy21) * (x13))
			/ (2 * ((y31) * (x12) - (y21) * (x13)));
	double g = ((sx13) * (y12)
			 + (sy13) * (y12)
			 + (sx21) * (y13)
			 + (sy21) * (y13))
			/ (2 * ((x31) * (y12) - (x21) * (y13)));

	double c = -pow(x1, 2) - pow(y1, 2) - 2 * g * x1 - 2 * f * y1;

	// eqn of circle be x^2 + y^2 + 2*g*x + 2*f*y + c = 0
	// where centre is (h = -g, k = -f) and radius r
	// as r^2 = h^2 + k^2 - c
	*h = -g;
	*k = -f;
	double sqr_of_r = *h * *h + *k * *k - c;

	// r is the radius
	*r = sqrt(sqr_of_r);
}

LiDAR::~LiDAR()
{

}

LiDAR::LiDAR(int movAvgSize, double startAngleOffset, bool swapXY,
		double toCoordXScale, double toCoordYScale, double toCoordXOffset, double toCoordYOffset,
		double objEdgeSize, int objSpaceCnt, double coneObjSizeMin, double coneObjSizeMax,
		double trackObjDeltaDist, double trackObjDeltaSize,
		int velMovAvgSize, int accMovAvgSize, int idStartRange)
{
	CalData_Data_Mov_Avg_Size = movAvgSize;
	CalData_Start_Angle_Offset = startAngleOffset;
	CalData_SwapXY = swapXY;
	CalData_To_CoordX_Scale = toCoordXScale;
	CalData_To_CoordY_Scale = toCoordYScale;
	CalData_To_CoordX_Offset = toCoordXOffset;
	CalData_To_CoordY_Offset = toCoordYOffset;

	CalData_Obj_Edge_Thres_Size = objEdgeSize;
	CalData_Obj_Edge_Space_Int_Cnt = objSpaceCnt;
	CalData_Cone_Obj_Size_Min_M = coneObjSizeMin;
	CalData_Cone_Obj_Size_Max_M = coneObjSizeMax;
	CalData_Track_Obj_Max_Delta_Dist_M = trackObjDeltaDist;
	CalData_Track_Obj_Max_Delta_Size_M = trackObjDeltaSize;

	CalData_Vel_Mov_Avg_Size = velMovAvgSize;
	CalData_Acc_Mov_Avg_Size = accMovAvgSize;

	IDSeed = 1;
	IDStartRange = idStartRange;

	DataUpdateTimestamp = 0;
	DataUpdateInterval = 0.02;
	DataArraySize = 0;
	DataMax = 0;
	DataMin = 0;
	DataDrop = 0;
	Num_of_Objects = 0;
	Num_of_ConeObjects = 0;

	DataMovAvgBuffInited = false;
	DataMovAvgBuffIndex = 0;
	for (int i=0; i<MAX_DATA_MOV_AVG_SIZE; i++)
		for (int j=0; j<MAX_DATAARRAY_SIZE; j++)
			DataMovAvgBuff[i][j] = 0;

	for (int j=0; j<MAX_NUM_OF_TRACKER_SLOT; j++)
		TrackObject[j].Is_Tracked = false;
	Num_of_TrackedObjects = 0;
}

void LiDAR::updateDataArray(const double timestamp, const int data_size, const float angle_min, const float angle_increment, const float range_min, const float range_max, const float* ranges, const float* intensities, const LiDAR_AD_HANDLE abnormal_handle)
{
	// protected by caller	accesskey.lock();

	DataUpdateInterval = timestamp - DataUpdateTimestamp;
	DataUpdateTimestamp = timestamp;
	DataArraySize = data_size;
	DataMax = range_max;
	DataMin = range_min;
	double data = range_max;
	double intensity = intensities[0];
	DataDrop = 0;
	for (int i=0; i<data_size; i++)
	{
		// Abnormal
		if (ranges[i] <= 0)
		{
			// data now equal to previous sliding
			if (abnormal_handle == AD_SET_MAX)
				data = range_max;
			else if (abnormal_handle == AD_SET_IGN)
				data = 0;

			intensity = 0;
			DataDrop++;
		}
		else if (ranges[i] <= range_min)
		{
//			DataDrop++;
			data = range_min;
			intensity = intensities[i];
		}
		else if (ranges[i] > range_max)
		{
//			DataDrop++;
			data = range_max;
			intensity = intensities[i];
		}
		else
		{
			data = ranges[i];
			intensity = intensities[i];
		}

		DataMovAvgBuff[DataMovAvgBuffIndex][i] = data;
		bool bWithRangeMax = false;
		double avgData = 0;
		double numOfAccm = 0;
		for (int j = 0; j < CalData_Data_Mov_Avg_Size; j++)
		{
			double dTemp = DataMovAvgBuff[j][i];
			if (dTemp >= range_max)
				bWithRangeMax = true;
			else if (dTemp > 0)
			{
				avgData += dTemp;
				numOfAccm += 1;
			}
		}
		if (numOfAccm > 0)
			avgData = avgData / numOfAccm;
		else
		{
			if (bWithRangeMax)
				avgData = range_max;
			else
				avgData = 0;
		}

		DataArray[i].Dist = avgData; //data;
		DataArray[i].Angle = CalData_Start_Angle_Offset + angle_min + (angle_increment * i);
		if(CalData_SwapXY)
		{
			DataArray[i].x = (CalData_To_CoordX_Offset + DataArray[i].Dist * sin(DataArray[i].Angle)) * CalData_To_CoordX_Scale;
			DataArray[i].y = (CalData_To_CoordY_Offset + DataArray[i].Dist * cos(DataArray[i].Angle)) * CalData_To_CoordY_Scale;
		}
		else
		{
			DataArray[i].x = (CalData_To_CoordX_Offset + DataArray[i].Dist * cos(DataArray[i].Angle)) * CalData_To_CoordX_Scale;
			DataArray[i].y = (CalData_To_CoordY_Offset + DataArray[i].Dist * sin(DataArray[i].Angle)) * CalData_To_CoordY_Scale;
		}
		DataArray[i].intensity = intensity;
		DataArray[i].scanProtected = false;
	}
	DataMovAvgBuffIndex++;
	if (DataMovAvgBuffIndex >= CalData_Data_Mov_Avg_Size)
	{
		DataMovAvgBuffIndex = 0;
		DataMovAvgBuffInited = true;
	}
	updateObjectsList();

	// protected by caller	accesskey.unlock();
}

int LiDAR::findMin()
{
	double data_min = DataMax;
	int min_index = -1;
	for (int i=0; i<DataArraySize; i++)
	{
		if (DataArray[i].scanProtected)
			continue;
		if (DataArray[i].Dist < data_min)
		{
			data_min = DataArray[i].Dist;
			min_index = i;
		}
	}
	return min_index;
}

int LiDAR::findIncEdge(int startIndex)
{
	int IncEdge_Index = DataArraySize -1;
	for (int i = startIndex; i < DataArraySize; i++)
	{
		int nextIndex = i + 1;
		if (nextIndex >= DataArraySize)
			break;
		if (abs(DataArray[i].Dist - DataArray[nextIndex].Dist) > CalData_Obj_Edge_Thres_Size)
		{
			IncEdge_Index = i;
			break;
		}
		if (DataArray[nextIndex].scanProtected)
		{
			IncEdge_Index = i;
			break;
		}
	}
	return IncEdge_Index;
}

int LiDAR::findDecEdge(int startIndex)
{
	int DecEdge_Index = 0;
	for (int i = startIndex; i > 0; i--)
	{
		int nextIndex = i - 1;
		if (nextIndex < 0)
			break;
		if (abs(DataArray[i].Dist - DataArray[nextIndex].Dist) > CalData_Obj_Edge_Thres_Size)
		{
			DecEdge_Index = i;
			break;
		}
		if (DataArray[nextIndex].scanProtected)
		{
			DecEdge_Index = i;
			break;
		}
	}
	return DecEdge_Index;
}

int LiDAR::createNewObjectID()
{
	int NewID;
	bool NewIDValid;
	do
	{
//		NewID = IDStartRange + rand()%10000;
		NewID = IDStartRange + IDSeed%10000;
		IDSeed++;
		NewIDValid = true;
		for (int i=0; i<MAX_NUM_OF_TRACKER_SLOT; i++)
		{
			if (TrackObject[i].ID == NewID)
			{
				NewIDValid = false;
				break;
			}
		}
	}
	while (!NewIDValid);

//	ROS_INFO("Created new ID: %d.", NewID);
	return NewID;
}

void LiDAR::updateObjectsList()
{
	Num_of_Objects = 0;
	Num_of_ConeObjects = 0;
	memset(&Objects, 0, sizeof(LiDARObject)*MAX_NUM_OF_OBJ);
	for (int j = 0; j < MAX_NUM_OF_OBJ; j++)
	{
		LiDARObject* NewObj = &Objects[j];
		int min_index = findMin();
		if (min_index < 0)
			return;
		int inc_edge = findIncEdge(min_index);
		int dec_edge = findDecEdge(min_index);
		int numOfIndex = inc_edge - dec_edge + 1;
		Num_of_Objects++;

		int inc_protect_edge = inc_edge + CalData_Obj_Edge_Space_Int_Cnt;
		int dec_protect_edge = dec_edge - CalData_Obj_Edge_Space_Int_Cnt;
		if (inc_protect_edge >= DataArraySize)
			inc_protect_edge = DataArraySize - 1;
		if (dec_protect_edge < 0)
			dec_protect_edge = 0;
		for (int i = dec_protect_edge; i <= inc_protect_edge; i++)
			DataArray[i].scanProtected = true;

		NewObj->ID = createNewObjectID();
		NewObj->IDTimestamp = DataUpdateTimestamp;
		NewObj->UpdateInterval = DataUpdateInterval;
		NewObj->MinIndex = min_index;
		NewObj->IncEdgeIndex = inc_edge;
		NewObj->DecEdgeIndex = dec_edge;

		// TBD: smooth out within object before processing
		double fM = min_index - dec_edge;
		double fT = inc_edge - dec_edge;
		if (fT == 0)
			NewObj->RatioM = 0.5;
		else
			NewObj->RatioM = fM/fT;

		// filter out edge unstable points for calculation
		if (numOfIndex >= 4)
		{
			inc_edge -= 1;
			dec_edge += 1;
			numOfIndex -= 2;
		}
		memcpy(&(NewObj->MinPoint), &(DataArray[min_index]), sizeof(LiDARDataPoint));
		memcpy(&(NewObj->IncEdge), &(DataArray[inc_edge]), sizeof(LiDARDataPoint));
		memcpy(&(NewObj->DecEdge), &(DataArray[dec_edge]), sizeof(LiDARDataPoint));
		double x = 0;
		double y = 0;
		double avgIntensity = 0;
		for (int i = dec_edge; i <= inc_edge; i++)
		{
			x += DataArray[i].x;
			y += DataArray[i].y;
			avgIntensity += DataArray[i].intensity;
		}
		NewObj->StableRefPoint.x = x/numOfIndex;
		NewObj->StableRefPoint.y = y/numOfIndex;
		NewObj->StableRefPoint.intensity = avgIntensity/numOfIndex;
		double x2 = NewObj->StableRefPoint.x * NewObj->StableRefPoint.x;
		double y2 = NewObj->StableRefPoint.y * NewObj->StableRefPoint.y;
		if (NewObj->StableRefPoint.y != 0.0)
			NewObj->StableRefPoint.Angle = atan(NewObj->StableRefPoint.x / NewObj->StableRefPoint.y);
		else
			NewObj->StableRefPoint.Angle = atan(NewObj->StableRefPoint.x / 0.00000000001);
		NewObj->StableRefPoint.Dist = sqrt(x2 + y2);
		NewObj->StableRefPoint.scanProtected = false;

		NewObj->CenterPoint.x = (DataArray[inc_edge].x + DataArray[dec_edge].x)/2;
		NewObj->CenterPoint.y = (DataArray[inc_edge].y + DataArray[dec_edge].y)/2;
		NewObj->CenterPoint.intensity = avgIntensity/numOfIndex;
		x2 = NewObj->CenterPoint.x * NewObj->CenterPoint.x;
		y2 = NewObj->CenterPoint.y * NewObj->CenterPoint.y;
		if (NewObj->CenterPoint.y != 0.0)
			NewObj->CenterPoint.Angle = atan(NewObj->CenterPoint.x / NewObj->CenterPoint.y);
		else
			NewObj->CenterPoint.Angle = atan(NewObj->CenterPoint.x / 0.00000000001);
		NewObj->CenterPoint.Dist = sqrt(x2 + y2);
		NewObj->CenterPoint.scanProtected = false;

		double dx = DataArray[inc_edge].x - DataArray[dec_edge].x;
		double dy = DataArray[inc_edge].y - DataArray[dec_edge].y;
		NewObj->Size = sqrt(dx*dx + dy*dy);

		NewObj->Is_Cone = false;
		// Identify in func of distance
		double checkDist = NewObj->StableRefPoint.Dist;
		double checkSize = NewObj->Size;
		double checkMaxSize = CalData_Cone_Obj_Size_Max_M;
		double checkMinSize = CalData_Cone_Obj_Size_Min_M;
		if (checkDist > 3.0)
		{
			if (checkDist >= 10.0)
				checkMinSize = 0.020;
			else
			{
				double m = (CalData_Cone_Obj_Size_Min_M - 0.02)/(3.0 - 10.0);
				double c = CalData_Cone_Obj_Size_Min_M - m*3.0;
				checkMinSize = m*checkDist + c;
			}
		}
		if ( (checkSize >= checkMinSize) && (checkSize <= checkMaxSize)
			/*&& (NewObj->RatioM >= 0.35) && (NewObj->RatioM <=0.65)*/	)
		{
			NewObj->Is_Cone = true;
			Num_of_ConeObjects++;

			// use circle fit
//			double h, k, r;
//			bestApproximateCircle(dec_edge, inc_edge, &h, &k, &r);
			//NewObj->CenterPoint.x = h;
			//NewObj->CenterPoint.y = k;
			//NewObj->Size = r*2;
			// Stabilize
//			NewObj->CenterPoint.x = (NewObj->CenterPoint.x + h)/2.0;
//			NewObj->CenterPoint.y = (NewObj->CenterPoint.y + k)/2.0;
//			NewObj->Size = (NewObj->Size + r*2)/2.0;
		}

		NewObj->Is_Tracked = false;
		NewObj->Est_Vel.x = 0.00001314;
		NewObj->Est_Vel.y = 0.00001314;
		NewObj->Est_Acc.x = 0.00001314;
		NewObj->Est_Acc.y = 0.00001314;

		NewObj->Is_Fused = false;
	}
}

double LiDAR::findDistanceBetween(LiDARObject* obj1, LiDARObject* obj2)
{
	double dx = obj1->StableRefPoint.x - obj2->StableRefPoint.x;
	double dy = obj1->StableRefPoint.y - obj2->StableRefPoint.y;
	return sqrt(dx*dx + dy*dy);
}

double LiDAR::compareSimilarity(LiDARObject* obj1, LiDARObject* obj2)
{
	double ddist = findDistanceBetween(obj1, obj2);		// in m, normally 0.XXX
	double dsize = abs(obj1->Size - obj2->Size);		// in m, normally 0.XXX
	double dintensity = abs(obj1->StableRefPoint.intensity - obj2->StableRefPoint.intensity)/100.0;

	double index = ddist*0.80 + dsize*0.10 + dintensity*0.10;
	return index;
}

int LiDAR::trackObjects()
{
	// protected by caller	accesskey.lock();
	int NumofTrackedObjects_tmp = 0;
	// Track all tracked objects and update the status of objects list, TBD: apply mutex
	for (int j=0; j<MAX_NUM_OF_TRACKER_SLOT; j++)
	{
		if (TrackObject[j].Is_Tracked)
		{
			double similarityIndex[MAX_NUM_OF_OBJ];
			for (int i=0; i<Num_of_Objects; i++)
				similarityIndex[i] = compareSimilarity(&TrackObject[j], &Objects[i]);

			double min_similarityIndex = 9999.0;
			int min_i;
			for (int i=0; i<Num_of_Objects; i++)
			{
				if (min_similarityIndex > similarityIndex[i])
				{
					min_similarityIndex = similarityIndex[i];
					min_i = i;
				}
			}

			// TBD: use better untrack condition
			double untrack_index = CalData_Track_Obj_Max_Delta_Dist_M*0.8 + CalData_Track_Obj_Max_Delta_Size_M*0.1;
			if (min_similarityIndex > untrack_index)
			{
				TrackObject[j].Is_Tracked = false;
				continue;
			}

			LiDARObject* TrackObj = &TrackObject[j];
			LiDARObject* MatchObj = &Objects[min_i];
			int PrevID = TrackObj->ID;
			double PrevIDTimestamp = TrackObj->IDTimestamp;
//			double PrevFusedState = TrackObj->Is_Fused;
			double PrevStableRefPointX = TrackObj->StableRefPoint.x;
			double PrevStableRefPointY = TrackObj->StableRefPoint.y;
			double PrevEst_Vel_X = TrackObj->Est_Vel.x;
			double PrevEst_Vel_Y = TrackObj->Est_Vel.y;

			MatchObj->ID = PrevID;
			MatchObj->IDTimestamp = PrevIDTimestamp;
//			MatchObj->Is_Fused = PrevFusedState;
			MatchObj->Is_Tracked = true;
//			MatchObj->Est_Vel.x = (MatchObj->StableRefPoint.x - PrevStableRefPointX) / MatchObj->UpdateInterval;
//			MatchObj->Est_Vel.y = (MatchObj->StableRefPoint.y - PrevStableRefPointY) / MatchObj->UpdateInterval;
//			MatchObj->Est_Acc.x = (MatchObj->Est_Vel.x - PrevEst_Vel_X) / MatchObj->UpdateInterval;
//			MatchObj->Est_Acc.y = (MatchObj->Est_Vel.y - PrevEst_Vel_Y) / MatchObj->UpdateInterval;

			MatchObj->VelMovAvgBuffIndex = TrackObj->VelMovAvgBuffIndex;
			MatchObj->AccMovAvgBuffIndex = TrackObj->AccMovAvgBuffIndex;
			memcpy(MatchObj->VelXMovAvgBuff, TrackObj->VelXMovAvgBuff, sizeof(double)*MAX_VEL_MOV_AVG_SIZE);
			memcpy(MatchObj->VelYMovAvgBuff, TrackObj->VelYMovAvgBuff, sizeof(double)*MAX_VEL_MOV_AVG_SIZE);
			memcpy(MatchObj->AccXMovAvgBuff, TrackObj->AccXMovAvgBuff, sizeof(double)*MAX_ACC_MOV_AVG_SIZE);
			memcpy(MatchObj->AccYMovAvgBuff, TrackObj->AccYMovAvgBuff, sizeof(double)*MAX_ACC_MOV_AVG_SIZE);

			double Vel_X = (MatchObj->StableRefPoint.x - PrevStableRefPointX) / MatchObj->UpdateInterval;
			double Vel_Y = (MatchObj->StableRefPoint.y - PrevStableRefPointY) / MatchObj->UpdateInterval;
			MatchObj->VelXMovAvgBuff[MatchObj->VelMovAvgBuffIndex] = Vel_X;
			MatchObj->VelYMovAvgBuff[MatchObj->VelMovAvgBuffIndex] = Vel_Y;
			double avgVel_X = 0;
			double avgVel_Y = 0;
			for (int i = 0; i < CalData_Vel_Mov_Avg_Size; i++)
			{
				avgVel_X += MatchObj->VelXMovAvgBuff[i];
				avgVel_Y += MatchObj->VelYMovAvgBuff[i];
			}
			avgVel_X = avgVel_X / CalData_Vel_Mov_Avg_Size;
			avgVel_Y = avgVel_Y / CalData_Vel_Mov_Avg_Size;
			MatchObj->VelMovAvgBuffIndex++;
			if (MatchObj->VelMovAvgBuffIndex >= CalData_Vel_Mov_Avg_Size)
				MatchObj->VelMovAvgBuffIndex = 0;
			MatchObj->Est_Vel.x = avgVel_X;
			MatchObj->Est_Vel.y = avgVel_Y;

			double Acc_X = (avgVel_X - PrevEst_Vel_X) / MatchObj->UpdateInterval;
			double Acc_Y = (avgVel_Y - PrevEst_Vel_Y) / MatchObj->UpdateInterval;
			MatchObj->AccXMovAvgBuff[MatchObj->AccMovAvgBuffIndex] = Acc_X;
			MatchObj->AccYMovAvgBuff[MatchObj->AccMovAvgBuffIndex] = Acc_Y;
			double avgAcc_X = 0;
			double avgAcc_Y = 0;
			for (int i = 0; i < CalData_Acc_Mov_Avg_Size; i++)
			{
				avgAcc_X += MatchObj->AccXMovAvgBuff[i];
				avgAcc_Y += MatchObj->AccYMovAvgBuff[i];
			}
			avgAcc_X = avgAcc_X / CalData_Acc_Mov_Avg_Size;
			avgAcc_Y = avgAcc_Y / CalData_Acc_Mov_Avg_Size;
			MatchObj->AccMovAvgBuffIndex++;
			if (MatchObj->AccMovAvgBuffIndex >= CalData_Acc_Mov_Avg_Size)
				MatchObj->AccMovAvgBuffIndex = 0;
			MatchObj->Est_Acc.x = avgAcc_X;
			MatchObj->Est_Acc.y = avgAcc_Y;

			memcpy(TrackObj, MatchObj, sizeof(LiDARObject));

			NumofTrackedObjects_tmp++;
		}
	}
	Num_of_TrackedObjects = NumofTrackedObjects_tmp;

	// Auto track new objects if tracker slots available
	if (!DataMovAvgBuffInited)
	{
		// protected by caller	accesskey.unlock();
		return 1;
	}
	for (int j=0; j<MAX_NUM_OF_TRACKER_SLOT; j++)
	{
		if (TrackObject[j].Is_Tracked == false)
		{
			int nextUntrackedObjIndex = MAX_NUM_OF_OBJ;
			// Select Untracked Cone 1st
			for (int i=0; i<Num_of_Objects; i++)
			{
				if ((Objects[i].Is_Tracked == false) && (Objects[i].Is_Cone))
				{
					nextUntrackedObjIndex = i;
					break;
				}
			}
			// Select Untracked Size>10mm Objs 2nd
			if (nextUntrackedObjIndex == MAX_NUM_OF_OBJ)
			{
				for (int i=0; i<Num_of_Objects; i++)
					if ((Objects[i].Is_Tracked == false) && (Objects[i].Size >= 0.01))
					{
						nextUntrackedObjIndex = i;
						break;
					}
			}
			// No more
			if (nextUntrackedObjIndex == MAX_NUM_OF_OBJ)
			{
				// protected by caller	accesskey.unlock();
				return -1;
			}

			Objects[nextUntrackedObjIndex].Is_Tracked = true;
			memcpy(&TrackObject[j], &Objects[nextUntrackedObjIndex], sizeof(LiDARObject));

			// Init vel/acc moving avg, new trackObjects()
			TrackObject[j].VelMovAvgBuffIndex = 0;
			TrackObject[j].AccMovAvgBuffIndex = 0;
			memset(TrackObject[j].VelXMovAvgBuff, 0, sizeof(double)*MAX_VEL_MOV_AVG_SIZE);
			memset(TrackObject[j].VelYMovAvgBuff, 0, sizeof(double)*MAX_VEL_MOV_AVG_SIZE);
			memset(TrackObject[j].AccXMovAvgBuff, 0, sizeof(double)*MAX_ACC_MOV_AVG_SIZE);
			memset(TrackObject[j].AccYMovAvgBuff, 0, sizeof(double)*MAX_ACC_MOV_AVG_SIZE);
		}
	}

	// protected by caller	accesskey.unlock();
	return 0;
}

void LiDAR::bestApproximateLine(int startIndex, int endIndex, double* m, double* c)
{
    int i, j, n;
    double dm, dc, sum_x = 0, sum_y = 0, sum_xy = 0, sum_x2 = 0;
    n = endIndex - startIndex + 1;
    for (i = startIndex; i <= endIndex; i++)
    {
        sum_x += DataArray[i].x;
        sum_y += DataArray[i].y;
        sum_xy += DataArray[i].x * DataArray[i].y;
        sum_x2 += (DataArray[i].x * DataArray[i].x);
    }

    dm = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - (sum_x * sum_x));
    dc = (sum_y - dm * sum_x) / n;

    *m = dm;
    *c = dc;
}

void LiDAR::bestApproximateCircle(int startIndex, int endIndex, double* a, double* b, double* r)
{
	const double One=1.0,Two=2.0,Three=3.0,Four=4.0,Five=5.0,Six=6.0,Ten=10.0;
    int i, iter, IterMAX = 99;

    double Xi,Yi,Zi;
    double Mz,Mxy,Mxx,Myy,Mxz,Myz,Mzz,Cov_xy,Var_z;
    double A0,A1,A2,A22;
    double Dy,xnew,x,ynew,y;
    double DET,Xcenter,Ycenter;

    double num_of_points = endIndex - startIndex + 1;
    double meanX = 0;
    double meanY = 0;
    for (i=startIndex; i<=endIndex; i++)
    {
    	meanX += DataArray[i].x;
    	meanY += DataArray[i].y;
	}
	meanX /= num_of_points;
	meanY /= num_of_points;

    // computing moments
    Mxx=Myy=Mxy=Mxz=Myz=Mzz=0.;
    for (i=startIndex; i<=endIndex; i++)
    {
        Xi = DataArray[i].x - meanX;   //  centered x-coordinates
        Yi = DataArray[i].y - meanY;   //  centered y-coordinates
        Zi = Xi*Xi + Yi*Yi;

        Mxy += Xi*Yi;
        Mxx += Xi*Xi;
        Myy += Yi*Yi;
        Mxz += Xi*Zi;
        Myz += Yi*Zi;
        Mzz += Zi*Zi;
    }
    Mxx /= num_of_points;
    Myy /= num_of_points;
    Mxy /= num_of_points;
    Mxz /= num_of_points;
    Myz /= num_of_points;
    Mzz /= num_of_points;

    // computing the coefficients of the characteristic polynomial
    Mz = Mxx + Myy;
    Cov_xy = Mxx*Myy - Mxy*Mxy;
    Var_z = Mzz - Mz*Mz;

    A2 = Four*Cov_xy - Three*Mz*Mz - Mzz;
    A1 = Var_z*Mz + Four*Cov_xy*Mz - Mxz*Mxz - Myz*Myz;
    A0 = Mxz*(Mxz*Myy - Myz*Mxy) + Myz*(Myz*Mxx - Mxz*Mxy) - Var_z*Cov_xy;
    A22 = A2 + A2;

    // finding the root of the characteristic polynomial
    // using Newton's method starting at x=0
    // (it is guaranteed to converge to the right root)
	for (x=0.,y=A0,iter=0; iter<IterMAX; iter++)  // usually, 4-6 iterations are enough
    {
        Dy = A1 + x*(A22 + 16.*x*x);
        xnew = x - y/Dy;
        if ((xnew == x)||(!isfinite(xnew))) break;
        ynew = A0 + xnew*(A1 + xnew*(A2 + Four*xnew*xnew));
        if (abs(ynew)>=abs(y))  break;
        x = xnew;  y = ynew;
    }

	// computing parameters of the fitting circle
    DET = x*x - x*Mz + Cov_xy;
    Xcenter = (Mxz*(Myy - x) - Myz*Mxy)/DET/Two;
    Ycenter = (Myz*(Mxx - x) - Mxz*Mxy)/DET/Two;

    // assembling the output
    *a = Xcenter + meanX;
    *b = Ycenter + meanY;
    *r = sqrt(Xcenter*Xcenter + Ycenter*Ycenter + Mz - x - x);
//    circle.s = Sigma(data,circle);
//    circle.i = 0;
//    circle.j = iter;  //  return the number of iterations, too

//    return circle;
}

LiDARObject* LiDAR::getNearestConeObject(int rank)
{
	LiDARObject* nearConeObj = NULL;
	// protected by caller	accesskey.lock();
	for (int i=0; i<Num_of_Objects; i++)
	{
		if (rank <= 0)
			break;
		if (Objects[i].Is_Cone)
		{
			nearConeObj = &Objects[i];
			rank--;
		}
	}
	// protected by caller	accesskey.unlock();
	return nearConeObj;
}

// get foreign point relationship,  x,y use center point in calculation
LiDARObject* LiDAR::getObjectNearAPoint(double x, double y, double* dist)
{
	LiDARObject* minDObj = NULL;
	// protected by caller	accesskey.lock();
	double minD = 9999.9;
	for (int i=0; i<Num_of_Objects; i++)
	{
		double dx = x - Objects[i].CenterPoint.x;
		double dy = y - Objects[i].CenterPoint.y;
		double D = sqrt(dx*dx + dy*dy);
		if (D < minD)
		{
			minD = D;
			minDObj = &Objects[i];
		}
	}
	*dist = minD;
	// protected by caller	accesskey.unlock();
	return minDObj;
}

LiDARObject* LiDAR::getNearestObject(double limitY, double minDist, double minSize, int rank)
{
	LiDARObject* nearObj = NULL;
	// protected by caller	accesskey.lock();
	for (int i=0; i<Num_of_Objects; i++)
	{
		if (rank <= 0)
			break;

		double absY = abs(Objects[i].CenterPoint.y);
		if ((Objects[i].CenterPoint.Dist >= minDist) && (Objects[i].Size >= minSize) &&
				(absY <= limitY))
		{
			nearObj = &Objects[i];
			rank--;
		}
	}
	// protected by caller	accesskey.unlock();
	return nearObj;
}

LiDARObject* LiDAR::getObjectByID(int ID)
{
	LiDARObject* idObj = NULL;
	// protected by caller	accesskey.lock();
	for (int i=0; i<Num_of_Objects; i++)
		if (Objects[i].ID == ID)
		{
			idObj = &Objects[i];
			break;
		}
	// protected by caller	accesskey.unlock();
	return idObj;
}

// get foreign point relationship,  x,y use center point in calculation
LiDARObject* LiDAR::getObjectNearAPointNoFused_StablePt(double x, double y, double* dist)
{
	LiDARObject* minDObj = NULL;
	// protected by caller	accesskey.lock();
	double minD = 9999.9;
	for (int i=0; i<Num_of_Objects; i++)
	{
		if (Objects[i].Is_Fused)
			continue;
		double dx = x - Objects[i].StableRefPoint.x;
		double dy = y - Objects[i].StableRefPoint.y;
		double D = sqrt(dx*dx + dy*dy);
		if (D < minD)
		{
			minD = D;
			minDObj = &Objects[i];
		}
	}
	*dist = minD;
	// protected by caller	accesskey.unlock();
	return minDObj;
}

LiDARObject* LiDAR::getNearestObject_StablePt(double limitY, double minX, double minSize, int rank)
{
	LiDARObject* nearObj = NULL;
	// protected by caller	accesskey.lock();
	for (int i=0; i<Num_of_Objects; i++)
	{
		if (rank <= 0)
			break;

		double absY = abs(Objects[i].StableRefPoint.y);
		if ((Objects[i].StableRefPoint.x >= minX) && (Objects[i].Size >= minSize) &&
				(absY <= limitY))
		{
			nearObj = &Objects[i];
			rank--;
		}
	}
	// protected by caller	accesskey.unlock();
	return nearObj;
}

void LiDAR::setObjectWithCustomID(int objID, int customID, double customTimestamp)
{
	// protected by caller	accesskey.lock();
	for (int i=0; i<Num_of_Objects; i++)
	{
		if (Objects[i].ID == objID)
		{
			Objects[i].ID = customID;
			Objects[i].IDTimestamp = customTimestamp;
			break;
		}
	}

	for (int i=0; i<MAX_NUM_OF_TRACKER_SLOT; i++)
		if (TrackObject[i].Is_Tracked)
			if (TrackObject[i].ID == objID)
			{
				TrackObject[i].ID = customID;
				TrackObject[i].IDTimestamp = customTimestamp;
				break;
			}
	// protected by caller	accesskey.unlock();
}

void LiDAR::setObjectWithIndependentID(int objID)
{
	// protected by caller	accesskey.lock();
	int newID = createNewObjectID();
	double newIDTimestamp = DataUpdateTimestamp;
	for (int i=0; i<Num_of_Objects; i++)
	{
		if (Objects[i].ID == objID)
		{
			Objects[i].ID = newID;
			Objects[i].IDTimestamp = newIDTimestamp;
			break;
		}
	}

	for (int i=0; i<MAX_NUM_OF_TRACKER_SLOT; i++)
		if (TrackObject[i].Is_Tracked)
			if (TrackObject[i].ID == objID)
			{
				TrackObject[i].ID = newID;
				TrackObject[i].IDTimestamp = newIDTimestamp;
				break;
			}
	// protected by caller	accesskey.unlock();
}

double LiDAR::getDistByPosY(double posY, double tol)
{
	double avgScanPosX = 0;
	int numOfAccum = 0;
	for (int i=0; i<DataArraySize; i++)
	{
		if ( (abs(DataArray[i].y - posY) <= tol) &&
				(DataArray[i].intensity > 0) &&
				(DataArray[i].x > 0.100) )				// TBD: correct thres ignore closer than 10cm
		{
			avgScanPosX += DataArray[i].x;
			numOfAccum++;
		}
	}

	if (numOfAccum > 0)
		avgScanPosX = avgScanPosX / numOfAccum;

	return avgScanPosX;
}

