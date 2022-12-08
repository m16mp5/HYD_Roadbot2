/*
 * arm_object_detector.cpp
 *
 *  LiDAR Data Processing ROS program.
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
#include "sensor_msgs/LaserScan.h"
#include "visualization_msgs/MarkerArray.h"
#include "lidar_tracker/lt_datapoint_Type.h"
#include "lidar_tracker/lt_object_Type.h"
#include "lidar_tracker/lt_state_Type.h"

#include "LiDAR.h"

using namespace std;
using namespace ros;

// Calibation macros
#define TIMU_DATA_MOV_AVG_SIZE				3 // 2 					// Will be overridden by config file
#define TIMU_START_ANGLE_OFFSET				0.000					// Will be overridden by config file, rad
#define TIMU_SWAP_XY						false					// Will be overridden by config file
#define TIMU_TO_COORD_X_SCALE				1.000					// Will be overridden by config file
#define TIMU_TO_COORD_Y_SCALE				1.000					// Will be overridden by config file
#define TIMU_TO_COORD_X_OFFSET				0.000					// Will be overridden by config file, m
#define TIMU_TO_COORD_Y_OFFSET				0.035					// Will be overridden by config file, m
#define TIMU_OBJ_EDGE_THRES_SIZE_M			0.120 // 0.030			// lower stable edge smaller size, higher bigger size for complex obj
#define TIMU_OBJ_EDGE_SPACE_INT_CNT			4 // 6
#define TIMU_CONE_OBJ_SIZE_MIN_M			0.060					// Not really used in arm algo
#define TIMU_CONE_OBJ_SIZE_MAX_M			0.200					// Not really used in arm algo
#define TIMU_LOCK_OBJ_MAX_DELTA_DIST_M		0.200					// Not used for arm
#define TIMU_LOCK_OBJ_MAX_DELTA_SIZE_M		0.100					// Not used for arm
#define TIMU_VEL_MOV_AVG_SIZE				MAX_VEL_MOV_AVG_SIZE	// Not used for arm
#define TIMU_ACC_MOV_AVG_SIZE				MAX_ACC_MOV_AVG_SIZE	// Not used for arm

#define TIMD_DATA_MOV_AVG_SIZE				3 // 2					// Will be overridden by config file
#define TIMD_START_ANGLE_OFFSET				0.000					// Will be overridden by config file, rad
#define TIMD_SWAP_XY						false					// Will be overridden by config file
#define TIMD_TO_COORD_X_SCALE				1.000					// Will be overridden by config file
#define TIMD_TO_COORD_Y_SCALE				-1.000					// Will be overridden by config file
#define TIMD_TO_COORD_X_OFFSET				0.000					// Will be overridden by config file, m
#define TIMD_TO_COORD_Y_OFFSET				0.035					// Will be overridden by config file, m
#define TIMD_OBJ_EDGE_THRES_SIZE_M			TIMU_OBJ_EDGE_THRES_SIZE_M
#define TIMD_OBJ_EDGE_SPACE_INT_CNT			TIMU_OBJ_EDGE_SPACE_INT_CNT
#define TIMD_CONE_OBJ_SIZE_MIN_M			TIMU_CONE_OBJ_SIZE_MIN_M
#define TIMD_CONE_OBJ_SIZE_MAX_M			TIMU_CONE_OBJ_SIZE_MAX_M
#define TIMD_LOCK_OBJ_MAX_DELTA_DIST_M		TIMU_LOCK_OBJ_MAX_DELTA_DIST_M
#define TIMD_LOCK_OBJ_MAX_DELTA_SIZE_M		TIMU_LOCK_OBJ_MAX_DELTA_SIZE_M
#define TIMD_VEL_MOV_AVG_SIZE				MAX_VEL_MOV_AVG_SIZE
#define TIMD_ACC_MOV_AVG_SIZE				MAX_ACC_MOV_AVG_SIZE

#define FUSEDL_Z_DIST_M						0.090

#define FUSEDL_DETECT_WIDTH_M				0.300
#define FUSEDL_OBJ_MIN_DIST_M				0.060	// 0.080
#define FUSEDL_OBJ_MIN_SIZE_M				0.030	// 0.050

#define FUSEDL_LOOSE_DETECT_WIDTH_M			1.000
#define FUSEDL_LOOSE_OBJ_MIN_DIST_M			0.080
#define FUSEDL_LOOSE_OBJ_MIN_SIZE_M			0.010


class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
	ros::Publisher pub, pubFused, pubRvizU, pubRvizD;
	ros::Subscriber subU, subD;
	LiDAR timU, timD;
	LiDAR* firstL;
	LiDAR* secondL;

	double eval_tol;
	double PosY[8];

public:
	SubscribeAndPublish() : pn("~"),
	timU(TIMU_DATA_MOV_AVG_SIZE, TIMU_START_ANGLE_OFFSET, TIMU_SWAP_XY,
			TIMU_TO_COORD_X_SCALE, TIMU_TO_COORD_Y_SCALE, TIMU_TO_COORD_X_OFFSET, TIMU_TO_COORD_Y_OFFSET,
			TIMU_OBJ_EDGE_THRES_SIZE_M, TIMU_OBJ_EDGE_SPACE_INT_CNT, TIMU_CONE_OBJ_SIZE_MIN_M, TIMU_CONE_OBJ_SIZE_MAX_M,
			TIMU_LOCK_OBJ_MAX_DELTA_DIST_M, TIMU_LOCK_OBJ_MAX_DELTA_SIZE_M, TIMU_VEL_MOV_AVG_SIZE, TIMU_ACC_MOV_AVG_SIZE, 0),
	timD(TIMD_DATA_MOV_AVG_SIZE, TIMD_START_ANGLE_OFFSET, TIMD_SWAP_XY,
			TIMD_TO_COORD_X_SCALE, TIMD_TO_COORD_Y_SCALE, TIMD_TO_COORD_X_OFFSET, TIMD_TO_COORD_Y_OFFSET,
			TIMD_OBJ_EDGE_THRES_SIZE_M, TIMD_OBJ_EDGE_SPACE_INT_CNT, TIMD_CONE_OBJ_SIZE_MIN_M, TIMD_CONE_OBJ_SIZE_MAX_M,
			TIMD_LOCK_OBJ_MAX_DELTA_DIST_M, TIMD_LOCK_OBJ_MAX_DELTA_SIZE_M, TIMD_VEL_MOV_AVG_SIZE, TIMD_ACC_MOV_AVG_SIZE, 0)
	{
		firstL = secondL = NULL;

		string U_Scan, D_Scan;
		if (!pn.hasParam("U_Scan"))
			ROS_INFO("Cannot get U_Scan from param server!");
		pn.param("U_Scan", U_Scan, std::string("NA"));
		// Overridden by config file as installation diff
		pn.getParam("U_Scan_Data_Avg_Size", timU.CalData_Data_Mov_Avg_Size);
		pn.getParam("U_Scan_Start_Angle", timU.CalData_Start_Angle_Offset);
		pn.getParam("U_Scan_Swap_XY", timU.CalData_SwapXY);
		pn.getParam("U_Scan_X_Scale", timU.CalData_To_CoordX_Scale);
		pn.getParam("U_Scan_Y_Scale", timU.CalData_To_CoordY_Scale);
		pn.getParam("U_Scan_X_Offset", timU.CalData_To_CoordX_Offset);
		pn.getParam("U_Scan_Y_Offset", timU.CalData_To_CoordY_Offset);

		if (!pn.hasParam("D_Scan"))
			ROS_INFO("Cannot get D_Scan from param server!");
		pn.param("D_Scan", D_Scan, std::string("NA"));
		// Overridden by config file as installation diff
		pn.getParam("D_Scan_Data_Avg_Size", timD.CalData_Data_Mov_Avg_Size);
		pn.getParam("D_Scan_Start_Angle", timD.CalData_Start_Angle_Offset);
		pn.getParam("D_Scan_Swap_XY", timD.CalData_SwapXY);
		pn.getParam("D_Scan_X_Scale", timD.CalData_To_CoordX_Scale);
		pn.getParam("D_Scan_Y_Scale", timD.CalData_To_CoordY_Scale);
		pn.getParam("D_Scan_X_Offset", timD.CalData_To_CoordX_Offset);
		pn.getParam("D_Scan_Y_Offset", timD.CalData_To_CoordY_Offset);

		pn.getParam("eval_tol", eval_tol);
		pn.getParam("Y0", PosY[0]);
		pn.getParam("Y1", PosY[1]);
		pn.getParam("Y2", PosY[2]);
		pn.getParam("Y3", PosY[3]);
		pn.getParam("Y4", PosY[4]);
		pn.getParam("Y5", PosY[5]);
		pn.getParam("Y6", PosY[6]);
		pn.getParam("Y7", PosY[7]);

		// Register services (function calls)

		// Register Publish Topics (stream/pipe data), FIFO size = 5 //3
		pub = pn.advertise<lidar_tracker::lt_state_Type>("lt_state", 5);
		// Register Publish Topics (stream/pipe data), FIFO = 100
//		pubFused = pn.advertise<visualization_msgs::MarkerArray>("timFused_markers", 100);
//		pubRvizU = pn.advertise<visualization_msgs::MarkerArray>(std::string(U_Scan+"_markers"), 100);
//		pubRvizD = pn.advertise<visualization_msgs::MarkerArray>(std::string(D_Scan+"_markers"), 100);
		// Subscribe topics, FIFO = 1
		if (U_Scan.length() > 2)
			subU = n.subscribe(U_Scan, 1, &SubscribeAndPublish::timUCallback, this, ros::TransportHints().tcpNoDelay());
		if (D_Scan.length() > 2)
			subD = n.subscribe(D_Scan, 1, &SubscribeAndPublish::timDCallback, this, ros::TransportHints().tcpNoDelay());
	}
	
	void timUCallback(const sensor_msgs::LaserScan::ConstPtr& msg_in)
	{
		// Refresh new data
		const float* laserRanges = &msg_in->ranges[0];
		const float* laserIntensities = &msg_in->intensities[0];
		timU.accesskey.lock();
		timU.updateDataArray(msg_in->header.stamp.toSec(), msg_in->ranges.size(), msg_in->angle_min, msg_in->angle_increment, msg_in->range_min, msg_in->range_max, laserRanges, laserIntensities, AD_SET_MAX);
		timU.accesskey.unlock();
	}

	void timDCallback(const sensor_msgs::LaserScan::ConstPtr& msg_in)
	{
		// Refresh new data
		const float* laserRanges = &msg_in->ranges[0];
		const float* laserIntensities = &msg_in->intensities[0];
		timD.updateDataArray(msg_in->header.stamp.toSec(), msg_in->ranges.size(), msg_in->angle_min, msg_in->angle_increment, msg_in->range_min, msg_in->range_max, laserRanges, laserIntensities, AD_SET_MAX);

		timU.accesskey.lock();
		fuseLiDAR();
		timU.accesskey.unlock();
	}

	void fuseLiDAR()
	{
		firstL = &timU;
		secondL = &timD;

		// Do fusion at outputL
		lidar_tracker::lt_state_Type msg;
		msg.timestamp = firstL->DataUpdateTimestamp;
		msg.lidars_difftime = secondL->DataUpdateTimestamp - firstL->DataUpdateTimestamp;
		msg.num_of_fusedobjects = 1;

		// focus on closest object
		LiDARObject* sLObj = NULL;
		LiDARObject* fLObj = NULL;

		LiDARObject emptyObj;
		emptyObj.MinPoint.x = 9999.9;
		emptyObj.MinPoint.y = 9999.9;
		emptyObj.MinPoint.Angle = 90.0;
		emptyObj.MinPoint.Dist = 9999.9;
		emptyObj.MinPoint.intensity = 1;
		emptyObj.CenterPoint.x = 9999.9;
		emptyObj.CenterPoint.y = 9999.9;
		emptyObj.CenterPoint.Angle = 90.0;
		emptyObj.CenterPoint.Dist = 9999.9;
		emptyObj.CenterPoint.intensity = 1;
		emptyObj.StableRefPoint.x = 9999.9;
		emptyObj.StableRefPoint.y = 9999.9;
		emptyObj.StableRefPoint.Angle = 90.0;
		emptyObj.StableRefPoint.Dist = 9999.9;
		emptyObj.StableRefPoint.intensity = 1;
		emptyObj.Size = 1;
		emptyObj.Is_Tracked = false;
		emptyObj.Is_Cone = false;
		sLObj = secondL->getNearestObject_StablePt(FUSEDL_DETECT_WIDTH_M, FUSEDL_OBJ_MIN_DIST_M, FUSEDL_OBJ_MIN_SIZE_M, 1);
		fLObj = firstL->getNearestObject_StablePt(FUSEDL_DETECT_WIDTH_M, FUSEDL_OBJ_MIN_DIST_M, FUSEDL_OBJ_MIN_SIZE_M, 1);
		// Check valid
		if (fLObj == NULL)
			fLObj = &emptyObj;
		if (sLObj == NULL)
			sLObj = &emptyObj;

		// mObj[0]:fused obj, mObj[1]:upper lidar obj, mObj[2]:lower lider obj
		lidar_tracker::lt_object_Type mObj;
		mObj.ID = 1;
		mObj.IDTimestamp = sLObj->IDTimestamp;
		mObj.UpdateInterval = sLObj->UpdateInterval;
		mObj.Is_Fused = true;
		double distFirst = sqrt(fLObj->MinPoint.x*fLObj->MinPoint.x + fLObj->MinPoint.y*fLObj->MinPoint.y);
		double distSecond = sqrt(sLObj->MinPoint.x*sLObj->MinPoint.x + sLObj->MinPoint.y*sLObj->MinPoint.y);
		LiDARObject* fuseLObj = fLObj;
		if (distFirst > distSecond)
			fuseLObj = sLObj;
		mObj.DecEdge.x = fuseLObj->DecEdge.x;
		mObj.DecEdge.y = fuseLObj->DecEdge.y;
		mObj.DecEdge.Angle = fuseLObj->DecEdge.Angle;
		mObj.DecEdge.Dist = fuseLObj->DecEdge.Dist;
		mObj.DecEdge.intensity = fuseLObj->DecEdge.intensity;
		mObj.IncEdge.x = fuseLObj->IncEdge.x;
		mObj.IncEdge.y = fuseLObj->IncEdge.y;
		mObj.IncEdge.Angle = fuseLObj->IncEdge.Angle;
		mObj.IncEdge.Dist = fuseLObj->IncEdge.Dist;
		mObj.IncEdge.intensity = fuseLObj->IncEdge.intensity;
		mObj.MinPoint.x = fuseLObj->MinPoint.x;
		mObj.MinPoint.y = fuseLObj->MinPoint.y;
		mObj.MinPoint.Angle = fuseLObj->MinPoint.Angle;
		mObj.MinPoint.Dist = fuseLObj->MinPoint.Dist;
		mObj.MinPoint.intensity = fuseLObj->MinPoint.intensity;
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
		mObj.Is_Tracked = false;
		mObj.Is_Cone = false;
		double dx = sLObj->CenterPoint.x - fLObj->CenterPoint.x;
		double dy = sLObj->CenterPoint.y - fLObj->CenterPoint.y;
		double dz = FUSEDL_Z_DIST_M;
		double a, b;
		if (dy == 0)
			a = 1.570796327;
		else
			a = atan(dz/dy);
		if (dx == 0)
			b = 1.570796327;
		else
			b = atan(dz/dx);
		mObj.Incline.x = a;
		mObj.Incline.y = b;
		LiDAR* uL = &timD;
		if (uL == secondL)
			mObj.Rotate = sLObj->RatioM;
		else
			mObj.Rotate = fLObj->RatioM;
		mObj.RatioM = mObj.Rotate;
		// mObj[0]:fused obj
		msg.objects.push_back(mObj);

		LiDARObject* uLObj = fLObj;
		LiDARObject* dLObj = sLObj;
		if (uL == secondL)
		{
			uLObj = sLObj;
			dLObj = fLObj;
		}
		for (int i=0; i<2; i++)
		{
			LiDARObject* cObj;
			if (i == 0)	cObj = uLObj;
			else        cObj = dLObj;
			lidar_tracker::lt_object_Type mObj;
			mObj.ID = i+2;
			mObj.IDTimestamp = cObj->IDTimestamp;
			mObj.UpdateInterval = cObj->UpdateInterval;
			mObj.RatioM = cObj->RatioM;
			mObj.Is_Fused = false;
			mObj.DecEdge.x = cObj->DecEdge.x;
			mObj.DecEdge.y = cObj->DecEdge.y;
			mObj.DecEdge.Angle = cObj->DecEdge.Angle;
			mObj.DecEdge.Dist = cObj->DecEdge.Dist;
			mObj.DecEdge.intensity = cObj->DecEdge.intensity;
			mObj.IncEdge.x = cObj->IncEdge.x;
			mObj.IncEdge.y = cObj->IncEdge.y;
			mObj.IncEdge.Angle = cObj->IncEdge.Angle;
			mObj.IncEdge.Dist = cObj->IncEdge.Dist;
			mObj.IncEdge.intensity = cObj->IncEdge.intensity;
			mObj.MinPoint.x = cObj->MinPoint.x;
			mObj.MinPoint.y = cObj->MinPoint.y;
			mObj.MinPoint.Angle = cObj->MinPoint.Angle;
			mObj.MinPoint.Dist = cObj->MinPoint.Dist;
			mObj.MinPoint.intensity = cObj->MinPoint.intensity;
			mObj.CenterPoint.x = cObj->CenterPoint.x;
			mObj.CenterPoint.y = cObj->CenterPoint.y;
			mObj.CenterPoint.Angle = cObj->CenterPoint.Angle;
			mObj.CenterPoint.Dist = cObj->CenterPoint.Dist;
			mObj.CenterPoint.intensity = cObj->CenterPoint.intensity;
			mObj.StableRefPoint.x = cObj->StableRefPoint.x;
			mObj.StableRefPoint.y = cObj->StableRefPoint.y;
			mObj.StableRefPoint.Angle = cObj->StableRefPoint.Angle;
			mObj.StableRefPoint.Dist = cObj->StableRefPoint.Dist;
			mObj.StableRefPoint.intensity = cObj->StableRefPoint.intensity;
			mObj.Size = cObj->Size;
			mObj.Is_Tracked = cObj->Is_Tracked;
			mObj.Is_Cone = cObj->Is_Cone;
			// mObj[1]:upper lidar obj, mObj[2]:lower lider obj
			msg.objects.push_back(mObj);
		}

		// Column scanner output
		for (int i=0; i<8; i++)
		{
			double dist;
			dist = firstL->getDistByPosY(PosY[i], eval_tol);
			msg.columnscan_up_dist[i] = dist;

			dist = secondL->getDistByPosY(PosY[i], eval_tol);
			msg.columnscan_down_dist[i] = dist;
		}

		pub.publish(msg);
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
		// Publish Rviz MarkerArray
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
        text.text = "Drop:" + to_string(lidarX->DataDrop) + " #Obj:" + to_string(lidarX->Num_of_Objects) + " #Cones:" + to_string(lidarX->Num_of_ConeObjects);
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
			}
			else
			{
				std::stringstream stream;
				stream << std::fixed << std::setprecision(3) << lidarX->Objects[i].Size;
				text.text = "Sz:" + stream.str();
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
	ros::init(argc, argv, "arm_object_detector");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;
	
	ROS_INFO("Start Arm Lidar Objects Detector.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(2);
	spinner.spin();
	ROS_INFO("Close Arm Lidar Objects Detector.");

	return 0;
}
