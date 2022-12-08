/*
 * LiDAR.h
 *
 *  Created on: 23 Sep 2019
 *      Author: IY
 */

#ifndef LIDAR_TRACKER_SRC_LIDAR_H_
#define LIDAR_TRACKER_SRC_LIDAR_H_

#include <mutex>

using namespace std;

#define MAX_DATAARRAY_SIZE					3000
#define MAX_DATA_MOV_AVG_SIZE				4
#define MAX_NUM_OF_OBJ						64
#define MAX_NUM_OF_TRACKER_SLOT				32

#define MAX_VEL_MOV_AVG_SIZE				40		// 25
#define MAX_ACC_MOV_AVG_SIZE				40		// 25

typedef struct {
	double Dist;						// m
	double Angle;						// rad
	double x;							// m
	double y;							// m
	double intensity;					// rssi
	bool scanProtected;
} LiDARDataPoint;

typedef struct {
	// Init by updateObjectsList()
	int ID;
	double IDTimestamp;

	double UpdateInterval;

	int MinIndex;
	int IncEdgeIndex;
	int DecEdgeIndex;
	double RatioM;

	LiDARDataPoint MinPoint;
	LiDARDataPoint IncEdge;
	LiDARDataPoint DecEdge;
	LiDARDataPoint CenterPoint;
	LiDARDataPoint StableRefPoint;
	double Size;						// m

	bool Is_Cone;

	bool Is_Tracked;
	LiDARDataPoint Est_Vel;					// m/s
	LiDARDataPoint Est_Acc;					// m/s2
	bool Is_Fused;

	// Init by new trackObjects(); trackObjects() also update Est_Vel, Est_Acc
	double VelXMovAvgBuff[MAX_VEL_MOV_AVG_SIZE];
	double VelYMovAvgBuff[MAX_VEL_MOV_AVG_SIZE];
	int VelMovAvgBuffIndex;
	double AccXMovAvgBuff[MAX_ACC_MOV_AVG_SIZE];
	double AccYMovAvgBuff[MAX_ACC_MOV_AVG_SIZE];
	int AccMovAvgBuffIndex;
} LiDARObject;

enum LiDAR_AD_HANDLE {
	AD_SET_MAX = 0,
	AD_SET_IGN
};

class LiDAR
{
private:
	double DataMovAvgBuff[MAX_DATA_MOV_AVG_SIZE][MAX_DATAARRAY_SIZE];
	int DataMovAvgBuffIndex;

public:
	LiDARDataPoint DataArray[MAX_DATAARRAY_SIZE];
	double DataUpdateTimestamp;
	double DataUpdateInterval;
	bool DataMovAvgBuffInited;
	int DataArraySize;
	int DataMax;
	int DataMin;
	int DataDrop;

	int CalData_Data_Mov_Avg_Size;
	double CalData_Start_Angle_Offset;
	bool CalData_SwapXY;
	double CalData_To_CoordX_Scale;
	double CalData_To_CoordY_Scale;
	double CalData_To_CoordX_Offset;
	double CalData_To_CoordY_Offset;

	double CalData_Obj_Edge_Thres_Size;
	int CalData_Obj_Edge_Space_Int_Cnt;
	double CalData_Cone_Obj_Size_Min_M;
	double CalData_Cone_Obj_Size_Max_M;
	double CalData_Track_Obj_Max_Delta_Dist_M;
	double CalData_Track_Obj_Max_Delta_Size_M;

	int CalData_Vel_Mov_Avg_Size;
	int CalData_Acc_Mov_Avg_Size;

	int IDSeed;
	int IDStartRange;					// multiple of 10000

	LiDARObject Objects[MAX_NUM_OF_OBJ];
	int Num_of_Objects;
	int Num_of_ConeObjects;

	LiDARObject TrackObject[MAX_NUM_OF_TRACKER_SLOT];
	int Num_of_TrackedObjects;

	mutex accesskey;

private:
	int findMin();
	int findIncEdge(int startIndex);
	int findDecEdge(int startIndex);
	void bestApproximateLine(int startIndex, int endIndex, double* m, double* c);
	void bestApproximateCircle(int startIndex, int endIndex, double* a, double* b, double* r);
	double findDistanceBetween(LiDARObject* obj1, LiDARObject* obj2);
	double compareSimilarity(LiDARObject* obj1, LiDARObject* obj2);
	int createNewObjectID();
	void updateObjectsList();

public:
	LiDAR(int movAvgSize, double startAngleOffset, bool swapXY,
			double toCoordXScale, double toCoordYScale, double toCoordXOffset, double toCoordYOffset,
			double objEdgeSize, int objSpaceCnt, double coneObjSizeMin, double coneObjSizeMax,
			double trackObjDeltaDist, double trackObjDeltaSize,
			int velMovAvgSize, int accMovAvgSize, int idStartRange);
	virtual ~LiDAR();

	void updateDataArray(const double timestamp, const int data_size, const float angle_min, const float angle_increment, const float range_min, const float range_max, const float* ranges, const float* intensities, const LiDAR_AD_HANDLE abnormal_handle);
	int trackObjects();

	LiDARObject* getNearestConeObject(int rank);
	LiDARObject* getObjectNearAPoint(double x, double y, double* dist);
	LiDARObject* getNearestObject(double limitY, double minDist, double minSize, int rank);

	LiDARObject* getObjectByID(int ID);
	LiDARObject* getObjectNearAPointNoFused_StablePt(double x, double y, double* dist);
	LiDARObject* getNearestObject_StablePt(double limitY, double minX, double minSize, int rank);

	void setObjectWithCustomID(int objID, int customID, double customTimestamp);
	void setObjectWithIndependentID(int objID);

	double getDistByPosY(double posY, double tol);
};



#endif /* LIDAR_TRACKER_SRC_LIDAR_H_ */
