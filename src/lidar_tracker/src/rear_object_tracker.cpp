/*
 * rear_objects_tracker.cpp
 *
 *  LiDAR Data Processing ROS program.
 *  Created on: 5 Sep 2019 
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
#include "sensor_msgs/LaserScan.h"
#include "visualization_msgs/MarkerArray.h"
#include "lidar_tracker/lt_datapoint_Type.h"
#include "lidar_tracker/lt_object_Type.h"
#include "lidar_tracker/lt_state_Type.h"

#include "LiDAR.h"

using namespace std;
using namespace ros;

// Calibation macros
#define LMSRL_DATA_MOV_AVG_SIZE				MAX_DATA_MOV_AVG_SIZE
#define LMSRL_START_ANGLE_OFFSET			-0.0190					// Installation calibration, rad
#define LMSRL_SWAP_XY						false					// Installation calibration
#define LMSRL_TO_COORD_X_SCALE				1.000					// Installation calibration
#define LMSRL_TO_COORD_Y_SCALE				1.000					// Installation calibration
#define LMSRL_TO_COORD_X_OFFSET				0.000					// Installation calibration, m
#define LMSRL_TO_COORD_Y_OFFSET				-1.095					// Installation calibration, m
#define LMSRL_OBJ_EDGE_THRES_SIZE_M			0.120 // 0.050 //0.080	// lower stable edge smaller size, higher bigger size for complex obj
#define LMSRL_OBJ_EDGE_SPACE_INT_CNT		2 // 8
#define LMSRL_CONE_OBJ_SIZE_MIN_M			0.070 // 0.080
#define LMSRL_CONE_OBJ_SIZE_MAX_M			0.200
#define LMSRL_LOCK_OBJ_MAX_DELTA_DIST_M		0.090 // 0.083 // 0.200		// 15km/hr = 4.16m/s, 4.16m/s / 50Hz = 0.083m
#define LMSRL_LOCK_OBJ_MAX_DELTA_SIZE_M		0.120 // 0.100
#define LMSRL_VEL_MOV_AVG_SIZE				MAX_VEL_MOV_AVG_SIZE
#define LMSRL_ACC_MOV_AVG_SIZE				MAX_ACC_MOV_AVG_SIZE

#define LMSRR_DATA_MOV_AVG_SIZE				MAX_DATA_MOV_AVG_SIZE
#define LMSRR_START_ANGLE_OFFSET			-0.0190					// Installation calibration, rad
#define LMSRR_SWAP_XY						false					// Installation calibration
#define LMSRR_TO_COORD_X_SCALE				1.000					// Installation calibration
#define LMSRR_TO_COORD_Y_SCALE				-1.000					// Installation calibration
#define LMSRR_TO_COORD_X_OFFSET				0.000					// Installation calibration, m
#define LMSRR_TO_COORD_Y_OFFSET				-1.095					// Installation calibration, m
#define LMSRR_OBJ_EDGE_THRES_SIZE_M			LMSRL_OBJ_EDGE_THRES_SIZE_M
#define LMSRR_OBJ_EDGE_SPACE_INT_CNT		LMSRL_OBJ_EDGE_SPACE_INT_CNT
#define LMSRR_CONE_OBJ_SIZE_MIN_M			LMSRL_CONE_OBJ_SIZE_MIN_M
#define LMSRR_CONE_OBJ_SIZE_MAX_M			LMSRL_CONE_OBJ_SIZE_MAX_M
#define LMSRR_LOCK_OBJ_MAX_DELTA_DIST_M		LMSRL_LOCK_OBJ_MAX_DELTA_DIST_M
#define LMSRR_LOCK_OBJ_MAX_DELTA_SIZE_M		LMSRL_LOCK_OBJ_MAX_DELTA_SIZE_M
#define LMSRR_VEL_MOV_AVG_SIZE				MAX_VEL_MOV_AVG_SIZE
#define LMSRR_ACC_MOV_AVG_SIZE				MAX_ACC_MOV_AVG_SIZE

#define LMS_FUSE_OBJ_MAX_DELTA_DIST_M		0.220
#define LMS_FUSE_OBJ_MAX_DELTA_SIZE_M		0.150

class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
	ros::Publisher pub, pubFused, pubRvizL, pubRvizR;
	ros::Subscriber subL, subR;
	LiDAR lmsRL, lmsRR;
	LiDAR* firstL;
	LiDAR* secondL;

public:
	SubscribeAndPublish() : pn("~"),
	lmsRL(LMSRL_DATA_MOV_AVG_SIZE, LMSRL_START_ANGLE_OFFSET, LMSRL_SWAP_XY,
			LMSRL_TO_COORD_X_SCALE, LMSRL_TO_COORD_Y_SCALE, LMSRL_TO_COORD_X_OFFSET, LMSRL_TO_COORD_Y_OFFSET,
			LMSRL_OBJ_EDGE_THRES_SIZE_M, LMSRL_OBJ_EDGE_SPACE_INT_CNT, LMSRL_CONE_OBJ_SIZE_MIN_M, LMSRL_CONE_OBJ_SIZE_MAX_M,
			LMSRL_LOCK_OBJ_MAX_DELTA_DIST_M, LMSRL_LOCK_OBJ_MAX_DELTA_SIZE_M, LMSRL_VEL_MOV_AVG_SIZE, LMSRL_VEL_MOV_AVG_SIZE, 10000),
	lmsRR(LMSRR_DATA_MOV_AVG_SIZE, LMSRR_START_ANGLE_OFFSET, LMSRR_SWAP_XY,
			LMSRR_TO_COORD_X_SCALE, LMSRR_TO_COORD_Y_SCALE, LMSRR_TO_COORD_X_OFFSET, LMSRR_TO_COORD_Y_OFFSET,
			LMSRR_OBJ_EDGE_THRES_SIZE_M, LMSRR_OBJ_EDGE_SPACE_INT_CNT, LMSRR_CONE_OBJ_SIZE_MIN_M, LMSRR_CONE_OBJ_SIZE_MAX_M,
			LMSRR_LOCK_OBJ_MAX_DELTA_DIST_M, LMSRR_LOCK_OBJ_MAX_DELTA_SIZE_M, LMSRR_VEL_MOV_AVG_SIZE, LMSRR_ACC_MOV_AVG_SIZE, 20000)
	{
		firstL = secondL = NULL;

		// Register services (function calls)

		// Register Publish Topics (stream/pipe data), FIFO size = 5 //3
		pub = pn.advertise<lidar_tracker::lt_state_Type>("lt_state", 5);
		// Register Publish Topics (stream/pipe data), FIFO = 100
		pubFused = pn.advertise<visualization_msgs::MarkerArray>("lmsFused_markers", 100);
		pubRvizL = pn.advertise<visualization_msgs::MarkerArray>("lmsRL_markers", 100);
		pubRvizR = pn.advertise<visualization_msgs::MarkerArray>("lmsRR_markers", 100);
		// Subscribe topics, FIFO = 1
		subL = n.subscribe("lmsRL_scan", 1, &SubscribeAndPublish::lmsRLCallback, this, ros::TransportHints().tcpNoDelay());
		subR = n.subscribe("lmsRR_scan", 1, &SubscribeAndPublish::lmsRRCallback, this, ros::TransportHints().tcpNoDelay());
	}

	void lmsRLCallback(const sensor_msgs::LaserScan::ConstPtr& msg_in)
	{
		// Refresh new data of LMSRL
		lmsRL.accesskey.lock();
		const float* laserRanges = &msg_in->ranges[0];
		const float* laserIntensities = &msg_in->intensities[0];
		lmsRL.updateDataArray(msg_in->header.stamp.toSec(), msg_in->ranges.size(), msg_in->angle_min, msg_in->angle_increment, msg_in->range_min, msg_in->range_max, laserRanges, laserIntensities, AD_SET_MAX);
		lmsRL.trackObjects();
		lmsRL.accesskey.unlock();

		lmsRR.accesskey.lock();
		fuseLiDAR(&lmsRL);
		lmsRR.accesskey.unlock();

		// Publish Rviz MarkerArray
		pubRviz(0, &pubRvizL, &lmsRL);
	}

	void lmsRRCallback(const sensor_msgs::LaserScan::ConstPtr& msg_in)
	{
		// Refresh new data of LMSRR
		lmsRR.accesskey.lock();
		const float* laserRanges = &msg_in->ranges[0];
		const float* laserIntensities = &msg_in->intensities[0];
		lmsRR.updateDataArray(msg_in->header.stamp.toSec(), msg_in->ranges.size(), msg_in->angle_min, msg_in->angle_increment, msg_in->range_min, msg_in->range_max, laserRanges, laserIntensities, AD_SET_MAX);
		lmsRR.trackObjects();
		lmsRR.accesskey.unlock();

		lmsRL.accesskey.lock();
		fuseLiDAR(&lmsRR);
		lmsRL.accesskey.unlock();

		// Publish Rviz MarkerArray
		pubRviz(1000, &pubRvizR, &lmsRR);
	}

	void fuseLiDAR(LiDAR* currentL)
	{
		if (firstL == NULL)
			firstL = currentL;

		if ((secondL == NULL) && (firstL != currentL))
			secondL = currentL;

		if ((secondL == NULL) || (firstL == NULL))
			return;

/*		double DiffTS = abs(secondL->DataUpdateTimestamp - firstL->DataUpdateTimestamp);
		if (fuseLMinDiffTS > DiffTS)
		{
			fuseLMinDiffTS = DiffTS;
			// Ensure secondL > firstL
			if (firstL->DataUpdateTimestamp > secondL->DataUpdateTimestamp)
			{
				LiDAR* swapL = firstL;
				firstL = secondL;
				secondL = swapL;
			}

			LiDAR* rL = &lmsRR;
			if (rL == secondL)
				ROS_INFO("FuseL-lms: diffTS=%.3f, L->R", DiffTS);
			else
				ROS_INFO("FuseL-lms: diffTS=%.3f, R->L", DiffTS);
		}*/

/*		LiDAR* prevL = firstL;
		if (currentL != secondL)
			prevL = secondL;
		double diffTS = currentL->DataUpdateTimestamp - prevL->DataUpdateTimestamp;
		double halfInterval = currentL->DataUpdateInterval / 2.0;
		if (diffTS < 0)
			return;
		if (diffTS < halfInterval)
		{
			firstL = prevL;
			secondL = currentL;
		}*/

/*		if (currentL == secondL)
		{
			double diffTS = secondL->DataUpdateTimestamp - firstL->DataUpdateTimestamp;
			double halfInterval = secondL->DataUpdateInterval * 0.7;
			if (diffTS > halfInterval)
			{
				LiDAR* swapL = firstL;
				firstL = secondL;
				secondL = swapL;

				LiDAR* rL = &lmsRR;
				if (rL == secondL)
					ROS_INFO("FuseL-lms: diffTS=%.3f, L->R", diffTS);
				else
					ROS_INFO("FuseL-lms: diffTS=%.3f, R->L", diffTS);
			}
		}*/

		// Do fusion at outputL
		if (currentL == secondL)
		{
			// Do fusion / fission LiDAR data
			int numOfFusedObjects = 0;
			for (int i=0; i<firstL->Num_of_Objects; i++)
				firstL->Objects[i].Is_Fused = false;
			for (int i=0; i<secondL->Num_of_Objects; i++)
			{
				LiDARObject* sLObj = &secondL->Objects[i];
				int sLObjID = sLObj->ID;
				sLObj->Is_Fused = false;

				// Search if found best match
				double dist = 9999.9, dsize = 9999.9;
				LiDARObject* fLObj = firstL->getObjectNearAPointNoFused_StablePt(sLObj->StableRefPoint.x, sLObj->StableRefPoint.y, &dist);
				if (fLObj != NULL)
				{
					dsize = abs(fLObj->Size - sLObj->Size);
					// If found best match, must fuse
					if ( (dist <= LMS_FUSE_OBJ_MAX_DELTA_DIST_M) && (dsize <= LMS_FUSE_OBJ_MAX_DELTA_SIZE_M) )
					{
						// If the fusion still valid (same ID at best match object), mark and go next
						if (fLObj->ID == sLObjID)
						{
							fLObj->Is_Fused = sLObj->Is_Fused = true;
							numOfFusedObjects++;
							continue;
						}
						// If best match NOT at same ID object, best match at other object
						else
						{
							// If found other same ID (prev fused) in fL
							LiDARObject* fLObjSID = firstL->getObjectByID(sLObjID);
							if (fLObjSID != NULL)
							{
								// Exchange same ID object to best match object
								int sID = sLObj->ID;
								double sTS = sLObj->IDTimestamp;
								int nID = fLObj->ID;
								double nTS = fLObj->IDTimestamp;
								fLObjSID->Is_Fused = fLObj->Is_Fused;
								firstL->setObjectWithCustomID(nID, 999, 999.0);
								firstL->setObjectWithCustomID(sID, nID, nTS);
								firstL->setObjectWithCustomID(999, sID, sTS);
								fLObj->Is_Fused = sLObj->Is_Fused = true;
								numOfFusedObjects++;
								//ROS_INFO("Found same ID (prev fused) in fL but best match at others: %d", sLObjID);
								continue;
							}
							// If NO other same ID (prev fused) in fL
							else
							{
								// Fuse new object, compare timestamp keep older ID
								int sID = sLObj->ID;
								double sTS = sLObj->IDTimestamp;
								int nID = fLObj->ID;
								double nTS = fLObj->IDTimestamp;
								int fusedID = sID;
								double fusedTS = sTS;
								if (sTS > nTS)
								{
									fusedID = nID;
									fusedTS = nTS;
								}
								firstL->setObjectWithCustomID(nID, fusedID, fusedTS);
								secondL->setObjectWithCustomID(sID, fusedID, fusedTS);
								fLObj->Is_Fused = sLObj->Is_Fused = true;
								numOfFusedObjects++;
								continue;
							}
						}
					}
				}

				// Search if found same ID (prev fused) in fL but NO best match
				LiDARObject* fLObjSID = firstL->getObjectByID(sLObjID);
				if (fLObjSID != NULL)
				{
					// Cancel the record of prev fused object (Fission) (TBD: old ID keep by dist of object)
					int IDStartR = (sLObjID / 10000) * 10000;
					if (IDStartR != firstL->IDStartRange)
						firstL->setObjectWithIndependentID(sLObjID);
					else
						secondL->setObjectWithIndependentID(sLObjID);

					fLObjSID->Is_Fused = sLObj->Is_Fused = false;
					//ROS_INFO("Found same ID (prev fused) in fL but NO best match: %d", sLObjID);
				}
				else
				{
					// No ID nor best match found
					sLObj->Is_Fused = false;
				}
			}

			// Prepare topic msg to publish
			lidar_tracker::lt_state_Type msg;
			msg.timestamp = firstL->DataUpdateTimestamp;
			msg.lidars_difftime = secondL->DataUpdateTimestamp - firstL->DataUpdateTimestamp;
			// For fused objects
			for (int i=0; i<secondL->Num_of_Objects; i++)
			{
				LiDARObject* sLObj = &secondL->Objects[i];
				if (!sLObj->Is_Fused)
					continue;

				LiDARObject* fLObj = firstL->getObjectByID(sLObj->ID);
				if (fLObj == NULL)
				{
					//ROS_INFO("Found problem, no fused SL ID in FL: %d", sLObj->ID);
					sLObj->Is_Fused = false;
					continue;
				}

				lidar_tracker::lt_object_Type mObj;
				mObj.ID = sLObj->ID;
				mObj.IDTimestamp = sLObj->IDTimestamp;
				mObj.UpdateInterval = sLObj->UpdateInterval;
				mObj.RatioM = sLObj->RatioM;

				mObj.Is_Fused = true;
				double distFirst = sqrt(fLObj->MinPoint.x*fLObj->MinPoint.x + fLObj->MinPoint.y*fLObj->MinPoint.y);
				double distSecond = sqrt(sLObj->MinPoint.x*sLObj->MinPoint.x + sLObj->MinPoint.y*sLObj->MinPoint.y);
				if (distFirst > distSecond)
				{
					mObj.DecEdge.x = sLObj->DecEdge.x;
					mObj.DecEdge.y = sLObj->DecEdge.y;
					mObj.DecEdge.Angle = sLObj->DecEdge.Angle;
					mObj.DecEdge.Dist = sLObj->DecEdge.Dist;
					mObj.DecEdge.intensity = sLObj->DecEdge.intensity;
					mObj.IncEdge.x = sLObj->IncEdge.x;
					mObj.IncEdge.y = sLObj->IncEdge.y;
					mObj.IncEdge.Angle = sLObj->IncEdge.Angle;
					mObj.IncEdge.Dist = sLObj->IncEdge.Dist;
					mObj.IncEdge.intensity = sLObj->IncEdge.intensity;
					mObj.MinPoint.x = sLObj->MinPoint.x;
					mObj.MinPoint.y = sLObj->MinPoint.y;
					mObj.MinPoint.Angle = sLObj->MinPoint.Angle;
					mObj.MinPoint.Dist = sLObj->MinPoint.Dist;
					mObj.MinPoint.intensity = sLObj->MinPoint.intensity;
				}
				else
				{
					mObj.DecEdge.x = fLObj->DecEdge.x;
					mObj.DecEdge.y = fLObj->DecEdge.y;
					mObj.DecEdge.Angle = fLObj->DecEdge.Angle;
					mObj.DecEdge.Dist = fLObj->DecEdge.Dist;
					mObj.DecEdge.intensity = fLObj->DecEdge.intensity;
					mObj.IncEdge.x = fLObj->IncEdge.x;
					mObj.IncEdge.y = fLObj->IncEdge.y;
					mObj.IncEdge.Angle = fLObj->IncEdge.Angle;
					mObj.IncEdge.Dist = fLObj->IncEdge.Dist;
					mObj.IncEdge.intensity = fLObj->IncEdge.intensity;
					mObj.MinPoint.x = fLObj->MinPoint.x;
					mObj.MinPoint.y = fLObj->MinPoint.y;
					mObj.MinPoint.Angle = fLObj->MinPoint.Angle;
					mObj.MinPoint.Dist = fLObj->MinPoint.Dist;
					mObj.MinPoint.intensity = fLObj->MinPoint.intensity;
				}
				mObj.CenterPoint.x = (sLObj->CenterPoint.x + fLObj->CenterPoint.x)/2.0;
				mObj.CenterPoint.y = (sLObj->CenterPoint.y + fLObj->CenterPoint.y)/2.0;
				mObj.CenterPoint.Angle = atan(mObj.CenterPoint.x / mObj.CenterPoint.y);
				mObj.CenterPoint.Dist = sqrt(mObj.CenterPoint.x * mObj.CenterPoint.x + mObj.CenterPoint.y * mObj.CenterPoint.y);
				mObj.CenterPoint.intensity = (sLObj->CenterPoint.intensity + fLObj->CenterPoint.intensity)/2.0;
				mObj.StableRefPoint.x = (sLObj->StableRefPoint.x + fLObj->StableRefPoint.x)/2.0;
				mObj.StableRefPoint.y = (sLObj->StableRefPoint.y + fLObj->StableRefPoint.y)/2.0;
				mObj.StableRefPoint.Angle = atan(mObj.StableRefPoint.x / mObj.StableRefPoint.y);
				mObj.StableRefPoint.Dist = sqrt(mObj.StableRefPoint.x * mObj.StableRefPoint.x + mObj.StableRefPoint.y * mObj.StableRefPoint.y);
				mObj.StableRefPoint.intensity = (sLObj->StableRefPoint.intensity + fLObj->StableRefPoint.intensity)/2.0;
				mObj.Size = (sLObj->Size + fLObj->Size)/2.0;
				mObj.Est_Vel.x = (sLObj->Est_Vel.x + fLObj->Est_Vel.x)/2.0;
				mObj.Est_Vel.y = (sLObj->Est_Vel.y + fLObj->Est_Vel.y)/2.0;
				mObj.Est_Acc.x = (sLObj->Est_Acc.x + fLObj->Est_Acc.x)/2.0;
				mObj.Est_Acc.y = (sLObj->Est_Acc.y + fLObj->Est_Acc.y)/2.0;

				if ((fLObj->Is_Tracked) || (sLObj->Is_Tracked))
					mObj.Is_Tracked = true;
				else
					mObj.Is_Tracked = false;
				if ((fLObj->Is_Cone) || (sLObj->Is_Cone))
					mObj.Is_Cone = true;
				else
					mObj.Is_Cone = false;

				msg.objects.push_back(mObj);
			}
			// For SL not fused objects
			for (int i=0; i<secondL->Num_of_Objects; i++)
			{
				LiDARObject* sLObj = &secondL->Objects[i];
				if (sLObj->Is_Fused)
					continue;

				lidar_tracker::lt_object_Type mObj;
				mObj.ID = sLObj->ID;
				mObj.IDTimestamp = sLObj->IDTimestamp;
				mObj.UpdateInterval = sLObj->UpdateInterval;
				mObj.RatioM = sLObj->RatioM;

				mObj.Is_Fused = false;
				mObj.DecEdge.x = sLObj->DecEdge.x;
				mObj.DecEdge.y = sLObj->DecEdge.y;
				mObj.DecEdge.Angle = sLObj->DecEdge.Angle;
				mObj.DecEdge.Dist = sLObj->DecEdge.Dist;
				mObj.DecEdge.intensity = sLObj->DecEdge.intensity;
				mObj.IncEdge.x = sLObj->IncEdge.x;
				mObj.IncEdge.y = sLObj->IncEdge.y;
				mObj.IncEdge.Angle = sLObj->IncEdge.Angle;
				mObj.IncEdge.Dist = sLObj->IncEdge.Dist;
				mObj.IncEdge.intensity = sLObj->IncEdge.intensity;
				mObj.MinPoint.x = sLObj->MinPoint.x;
				mObj.MinPoint.y = sLObj->MinPoint.y;
				mObj.MinPoint.Angle = sLObj->MinPoint.Angle;
				mObj.MinPoint.Dist = sLObj->MinPoint.Dist;
				mObj.MinPoint.intensity = sLObj->MinPoint.intensity;
				mObj.CenterPoint.x = sLObj->CenterPoint.x;
				mObj.CenterPoint.y = sLObj->CenterPoint.y;
				mObj.CenterPoint.Angle = sLObj->CenterPoint.Angle;
				mObj.CenterPoint.Dist = sLObj->CenterPoint.Dist;
				mObj.CenterPoint.intensity = sLObj->CenterPoint.intensity;
				mObj.StableRefPoint.x = sLObj->StableRefPoint.x;
				mObj.StableRefPoint.y = sLObj->StableRefPoint.y;
				mObj.StableRefPoint.Angle = sLObj->StableRefPoint.Angle;
				mObj.StableRefPoint.Dist = sLObj->StableRefPoint.Dist;
				mObj.StableRefPoint.intensity = sLObj->StableRefPoint.intensity;
				mObj.Size = sLObj->Size;
				mObj.Est_Vel.x = sLObj->Est_Vel.x;
				mObj.Est_Vel.y = sLObj->Est_Vel.y;
				mObj.Est_Acc.x = sLObj->Est_Acc.x;
				mObj.Est_Acc.y = sLObj->Est_Acc.y;

				mObj.Is_Tracked = sLObj->Is_Tracked;
				mObj.Is_Cone = sLObj->Is_Cone;

				msg.objects.push_back(mObj);
			}
			// For FL not fused objects
			for (int i=0; i<firstL->Num_of_Objects; i++)
			{
				LiDARObject* fLObj = &firstL->Objects[i];
				if (fLObj->Is_Fused)
					continue;

				lidar_tracker::lt_object_Type mObj;
				mObj.ID = fLObj->ID;
				mObj.IDTimestamp = fLObj->IDTimestamp;
				mObj.UpdateInterval = fLObj->UpdateInterval;
				mObj.RatioM = fLObj->RatioM;

				mObj.Is_Fused = false;
				mObj.DecEdge.x = fLObj->DecEdge.x;
				mObj.DecEdge.y = fLObj->DecEdge.y;
				mObj.DecEdge.Angle = fLObj->DecEdge.Angle;
				mObj.DecEdge.Dist = fLObj->DecEdge.Dist;
				mObj.DecEdge.intensity = fLObj->DecEdge.intensity;
				mObj.IncEdge.x = fLObj->IncEdge.x;
				mObj.IncEdge.y = fLObj->IncEdge.y;
				mObj.IncEdge.Angle = fLObj->IncEdge.Angle;
				mObj.IncEdge.Dist = fLObj->IncEdge.Dist;
				mObj.IncEdge.intensity = fLObj->IncEdge.intensity;
				mObj.MinPoint.x = fLObj->MinPoint.x;
				mObj.MinPoint.y = fLObj->MinPoint.y;
				mObj.MinPoint.Angle = fLObj->MinPoint.Angle;
				mObj.MinPoint.Dist = fLObj->MinPoint.Dist;
				mObj.MinPoint.intensity = fLObj->MinPoint.intensity;
				mObj.CenterPoint.x = fLObj->CenterPoint.x;
				mObj.CenterPoint.y = fLObj->CenterPoint.y;
				mObj.CenterPoint.Angle = fLObj->CenterPoint.Angle;
				mObj.CenterPoint.Dist = fLObj->CenterPoint.Dist;
				mObj.CenterPoint.intensity = fLObj->CenterPoint.intensity;
				mObj.StableRefPoint.x = fLObj->StableRefPoint.x;
				mObj.StableRefPoint.y = fLObj->StableRefPoint.y;
				mObj.StableRefPoint.Angle = fLObj->StableRefPoint.Angle;
				mObj.StableRefPoint.Dist = fLObj->StableRefPoint.Dist;
				mObj.StableRefPoint.intensity = fLObj->StableRefPoint.intensity;
				mObj.Size = fLObj->Size;
				mObj.Est_Vel.x = fLObj->Est_Vel.x;
				mObj.Est_Vel.y = fLObj->Est_Vel.y;
				mObj.Est_Acc.x = fLObj->Est_Acc.x;
				mObj.Est_Acc.y = fLObj->Est_Acc.y;

				mObj.Is_Tracked = fLObj->Is_Tracked;
				mObj.Is_Cone = fLObj->Is_Cone;

				msg.objects.push_back(mObj);
			}

			msg.num_of_fusedobjects = numOfFusedObjects;

			// Find out all tracked cone objects index
			for (int i=0; i<msg.objects.size(); i++)
			{
				if ((msg.objects[i].Is_Cone) && (msg.objects[i].Is_Tracked))
					msg.trackedcone_indexes.push_back(i);
				else if (!msg.objects[i].Is_Cone)
					msg.noncone_indexes.push_back(i);
			}

			pub.publish(msg);
		}

//		if (currentL == secondL)
//			pubFusedRviz(5000, &msg);
	}

	void pubFusedRviz(int marker_id, const lidar_tracker::lt_state_Type* pmObj)
	{
		visualization_msgs::MarkerArray MA;
        for (int i=0; i<pmObj->objects.size(); i++)
        {
    		visualization_msgs::Marker line_strip, points, cylinder, text;
			line_strip.header.frame_id = points.header.frame_id = cylinder.header.frame_id = text.header.frame_id = "LiDAR";
			line_strip.header.stamp = points.header.stamp = cylinder.header.stamp = text.header.stamp = ros::Time::now();
			line_strip.ns = points.ns = cylinder.ns = text.ns = "object_points_and_lines";
			line_strip.action = points.action = cylinder.action = text.action = visualization_msgs::Marker::MODIFY;
			line_strip.pose.orientation.x = points.pose.orientation.x = cylinder.pose.orientation.x = text.pose.orientation.x = 0.0;
			line_strip.pose.orientation.y = points.pose.orientation.y = cylinder.pose.orientation.y = text.pose.orientation.y = 0.0;
			line_strip.pose.orientation.z = points.pose.orientation.z = cylinder.pose.orientation.z = text.pose.orientation.z = 0.0;
			line_strip.pose.orientation.w = points.pose.orientation.w = cylinder.pose.orientation.w = text.pose.orientation.w = 1.0;
			line_strip.id = marker_id++;
			line_strip.type = visualization_msgs::Marker::LINE_STRIP;
			line_strip.scale.x = 0.01;
			line_strip.scale.y = 0;
			line_strip.scale.z = 0;
			line_strip.color.r = 0.0;
			line_strip.color.g = 1.0;
			line_strip.color.b = 0.0;
			line_strip.color.a = 1.0;
			points.id = marker_id++;
			points.type = visualization_msgs::Marker::POINTS;
			points.scale.x = 0.02;
			points.scale.y = 0.02;
			points.scale.z = 0;
			points.color.r = 0.0;
			points.color.g = 1.0;
			points.color.b = 1.0;
			points.color.a = 1.0;
			cylinder.id = marker_id++;
			cylinder.type = visualization_msgs::Marker::CYLINDER;
			cylinder.scale.x = pmObj->objects[i].Size;
			cylinder.scale.y = pmObj->objects[i].Size;
			cylinder.scale.z = 1;
			cylinder.color.r = 1.0;
			cylinder.color.g = 1.0;
			cylinder.color.b = 0.0;
			cylinder.color.a = 1.0;
			text.id = marker_id++;
			text.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
			text.scale.x = 0.05;
			text.scale.y = 0.05;
			text.scale.z = 0.05;
			text.color.r = 1.0;
			text.color.g = 1.0;
			text.color.b = 1.0;
			text.color.a = 1.0;

			// line_strip obtains points, cylinder, text
			geometry_msgs::Point p, q, cen;
			p.x = pmObj->objects[i].DecEdge.x;
			p.y = pmObj->objects[i].DecEdge.y;
			p.z = -0.5;
			q.x = pmObj->objects[i].IncEdge.x;
			q.y = pmObj->objects[i].IncEdge.y;
			q.z = -0.5;
			cen.x = pmObj->objects[i].CenterPoint.x;
			cen.y = pmObj->objects[i].CenterPoint.y;
			cen.z = -0.5;
			line_strip.points.push_back(p);
			line_strip.points.push_back(q);
			points.points.push_back(p);
			points.points.push_back(cen);
			points.points.push_back(q);
			cylinder.pose.position.x = pmObj->objects[i].CenterPoint.x;
			cylinder.pose.position.y = pmObj->objects[i].CenterPoint.y;
			cylinder.pose.position.z = -0.5;
			text.pose.position.x = pmObj->objects[i].CenterPoint.x;
			text.pose.position.y = pmObj->objects[i].CenterPoint.y;
			text.pose.position.z = -0.5;
			if (pmObj->objects[i].Is_Tracked)
			{
				std::stringstream stream;
    			stream << std::fixed << std::setprecision(3) << pmObj->objects[i].Size;
    			text.text = "ID:" + to_string(pmObj->objects[i].ID) + "-Sz:" + stream.str();
				std::stringstream streamx;
    			streamx << std::fixed << std::setprecision(2) << pmObj->objects[i].Est_Vel.x;
				std::stringstream streamy;
    			streamy << std::fixed << std::setprecision(2) << pmObj->objects[i].Est_Vel.y;
    			text.text += "-Vx:" + streamx.str() + "-Vy:" + streamy.str();
				std::stringstream streamM;
    			streamM << std::fixed << std::setprecision(2) << pmObj->objects[i].RatioM;
    			text.text += "-Rm:" + streamM.str();
			}
			else
			{
				std::stringstream stream;
				stream << std::fixed << std::setprecision(3) << pmObj->objects[i].Size;
				text.text = "Sz:" + stream.str();
				std::stringstream streamM;
    			streamM << std::fixed << std::setprecision(2) << pmObj->objects[i].RatioM;
    			text.text += "-Rm:" + streamM.str();
			}

            MA.markers.push_back(line_strip);
            MA.markers.push_back(points);
            if (pmObj->objects[i].Is_Cone)
            {
                if (pmObj->objects[i].Is_Fused)
                {
        			cylinder.color.r = 0.0;
        			cylinder.color.g = 1.0;
        			cylinder.color.b = 0.0;
                	MA.markers.push_back(cylinder);
        			text.pose.position.z = -1.2;
                }
                else if (pmObj->objects[i].Is_Tracked)
                {
        			cylinder.color.r = 1.0;
        			cylinder.color.g = 0.0;
        			cylinder.color.b = 0.0;
                	MA.markers.push_back(cylinder);
        			text.pose.position.z = -1.2;
                }
                else
                {
					cylinder.color.r = 1.0;
					cylinder.color.g = 1.0;
					cylinder.color.b = 0.0;
					MA.markers.push_back(cylinder);
					text.pose.position.z = -1.2;
                }
            }
            else
            {
            	cylinder.action = visualization_msgs::Marker::DELETE;
            	MA.markers.push_back(cylinder);
            }
            MA.markers.push_back(text);
        }
        pubFused.publish(MA);
	}

	void pubRviz(int marker_id, const ros::Publisher* pubX, const LiDAR* lidarX)
	{
		visualization_msgs::MarkerArray MA;
		visualization_msgs::Marker line_strip, points, text;
		line_strip.header.frame_id = points.header.frame_id = text.header.frame_id = "LiDAR";
		line_strip.header.stamp = points.header.stamp = text.header.stamp = ros::Time::now();
		line_strip.ns = points.ns = text.ns = "object_points_and_lines";
		line_strip.action = points.action = text.action = visualization_msgs::Marker::MODIFY;
		line_strip.pose.orientation.x = points.pose.orientation.x = text.pose.orientation.x = 0.0;
		line_strip.pose.orientation.y = points.pose.orientation.y = text.pose.orientation.y = 0.0;
		line_strip.pose.orientation.z = points.pose.orientation.z = text.pose.orientation.z = 0.0;
		line_strip.pose.orientation.w = points.pose.orientation.w = text.pose.orientation.w = 1.0;
		line_strip.id = marker_id++;
		line_strip.type = visualization_msgs::Marker::LINE_STRIP;
		line_strip.scale.x = 0.01;
		line_strip.scale.y = 0;
		line_strip.scale.z = 0;
		line_strip.color.r = 0.0;
		line_strip.color.g = 0.0;
		line_strip.color.b = 1.0;
		line_strip.color.a = 1.0;
		points.id = marker_id++;
		points.type = visualization_msgs::Marker::POINTS;
		points.scale.x = 0.015;
		points.scale.y = 0.015;
		points.scale.z = 0;
		points.color.r = 1.0;
		points.color.g = 0.0;
		points.color.b = 1.0;
		points.color.a = 1.0;
		for (int i=0; i<lidarX->DataArraySize; i++)
        {
			// line_strip obtains points
			geometry_msgs::Point p;
			p.x = lidarX->DataArray[i].x;
			p.y = lidarX->DataArray[i].y;
			p.z = 0;
			line_strip.points.push_back(p);
			points.points.push_back(p);
        }
        MA.markers.push_back(line_strip);
        MA.markers.push_back(points);
        text.id = marker_id++;
		text.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
		text.scale.x = 0.05;
		text.scale.y = 0.05;
		text.scale.z = 0.05;
		text.color.r = 1.0;
		text.color.g = 1.0;
		text.color.b = 1.0;
		text.color.a = 1.0;
		text.pose.position.x = 0.0;
        text.pose.position.y = 0.0;
        text.pose.position.z = 0.0;
        text.text = "Drop:" + to_string(lidarX->DataDrop) + " #Obj:" + to_string(lidarX->Num_of_Objects) + " #Cones:" + to_string(lidarX->Num_of_ConeObjects) + " #Tracked:" + to_string(lidarX->Num_of_TrackedObjects);
        MA.markers.push_back(text);

        for (int i=0; i<lidarX->Num_of_Objects; i++)
        {
    		visualization_msgs::Marker line_strip, points, cylinder, text;
			line_strip.header.frame_id = points.header.frame_id = cylinder.header.frame_id = text.header.frame_id = "LiDAR";
			line_strip.header.stamp = points.header.stamp = cylinder.header.stamp = text.header.stamp = ros::Time::now();
			line_strip.ns = points.ns = cylinder.ns = text.ns = "object_points_and_lines";
			line_strip.action = points.action = cylinder.action = text.action = visualization_msgs::Marker::MODIFY;
			line_strip.pose.orientation.x = points.pose.orientation.x = cylinder.pose.orientation.x = text.pose.orientation.x = 0.0;
			line_strip.pose.orientation.y = points.pose.orientation.y = cylinder.pose.orientation.y = text.pose.orientation.y = 0.0;
			line_strip.pose.orientation.z = points.pose.orientation.z = cylinder.pose.orientation.z = text.pose.orientation.z = 0.0;
			line_strip.pose.orientation.w = points.pose.orientation.w = cylinder.pose.orientation.w = text.pose.orientation.w = 1.0;
			line_strip.id = marker_id++;
			line_strip.type = visualization_msgs::Marker::LINE_STRIP;
			line_strip.scale.x = 0.01;
			line_strip.scale.y = 0;
			line_strip.scale.z = 0;
			line_strip.color.r = 0.0;
			line_strip.color.g = 1.0;
			line_strip.color.b = 0.0;
			line_strip.color.a = 1.0;
			points.id = marker_id++;
			points.type = visualization_msgs::Marker::POINTS;
			points.scale.x = 0.02;
			points.scale.y = 0.02;
			points.scale.z = 0;
			points.color.r = 0.0;
			points.color.g = 1.0;
			points.color.b = 1.0;
			points.color.a = 1.0;
			cylinder.id = marker_id++;
			cylinder.type = visualization_msgs::Marker::CYLINDER;
			cylinder.scale.x = lidarX->Objects[i].Size;
			cylinder.scale.y = lidarX->Objects[i].Size;
			cylinder.scale.z = 1;
			cylinder.color.r = 1.0;
			cylinder.color.g = 1.0;
			cylinder.color.b = 0.0;
			cylinder.color.a = 1.0;
			text.id = marker_id++;
			text.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
			text.scale.x = 0.05;
			text.scale.y = 0.05;
			text.scale.z = 0.05;
			text.color.r = 1.0;
			text.color.g = 1.0;
			text.color.b = 1.0;
			text.color.a = 1.0;

			// line_strip obtains points, cylinder, text
			geometry_msgs::Point p, q, cen;
			p.x = lidarX->Objects[i].DecEdge.x;
			p.y = lidarX->Objects[i].DecEdge.y;
			p.z = -0.5;
			q.x = lidarX->Objects[i].IncEdge.x;
			q.y = lidarX->Objects[i].IncEdge.y;
			q.z = -0.5;
			cen.x = lidarX->Objects[i].CenterPoint.x;
			cen.y = lidarX->Objects[i].CenterPoint.y;
			cen.z = -0.5;
			line_strip.points.push_back(p);        
			line_strip.points.push_back(q);
			points.points.push_back(p);
			points.points.push_back(cen);
			points.points.push_back(q);
			cylinder.pose.position.x = lidarX->Objects[i].CenterPoint.x;
			cylinder.pose.position.y = lidarX->Objects[i].CenterPoint.y;
			cylinder.pose.position.z = -0.5;
			text.pose.position.x = lidarX->Objects[i].CenterPoint.x;
			text.pose.position.y = lidarX->Objects[i].CenterPoint.y;
			text.pose.position.z = -0.5;
			if (lidarX->Objects[i].Is_Tracked)
			{
				std::stringstream stream;
    			stream << std::fixed << std::setprecision(3) << lidarX->Objects[i].Size;
    			text.text = "ID:" + to_string(lidarX->Objects[i].ID) + "-Sz:" + stream.str();
				std::stringstream streamx;
    			streamx << std::fixed << std::setprecision(2) << lidarX->Objects[i].Est_Vel.x;
				std::stringstream streamy;
    			streamy << std::fixed << std::setprecision(2) << lidarX->Objects[i].Est_Vel.y;
    			text.text += "-Vx:" + streamx.str() + "-Vy:" + streamy.str();
				std::stringstream streamM;
    			streamM << std::fixed << std::setprecision(2) << lidarX->Objects[i].RatioM;
    			text.text += "-Rm:" + streamM.str();
			}
			else
			{
				std::stringstream stream;
				stream << std::fixed << std::setprecision(3) << lidarX->Objects[i].Size;
				text.text = "Sz:" + stream.str();
				std::stringstream streamM;
    			streamM << std::fixed << std::setprecision(2) << lidarX->Objects[i].RatioM;
    			text.text += "-Rm:" + streamM.str();
			}

            MA.markers.push_back(line_strip);
            MA.markers.push_back(points);
            if (lidarX->Objects[i].Is_Cone)
            {
                if (lidarX->Objects[i].Is_Tracked)
                {
        			cylinder.color.r = 1.0;
        			cylinder.color.g = 0.0;
        			cylinder.color.b = 0.0;
                	MA.markers.push_back(cylinder);
        			text.pose.position.z = -1.2;
                }
                else
                {
					cylinder.color.r = 1.0;
					cylinder.color.g = 1.0;
					cylinder.color.b = 0.0;
					MA.markers.push_back(cylinder);
					text.pose.position.z = -1.2;
                }
            }
            else
            {
            	cylinder.action = visualization_msgs::Marker::DELETE;
            	MA.markers.push_back(cylinder);
            }
            MA.markers.push_back(text);
        }
        pubX->publish(MA);
	}
};

int main(int argc, char **argv)
{
	// Initialize ros
	ros::init(argc, argv, "rear_object_tracker");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;
	
	ROS_INFO("Start Rear Lidar Objects Tracker.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(2);
	spinner.spin();
	ROS_INFO("Close Rear Lidar Objects Tracker.");

	return 0;
}
