/*
 * cone_counter.cpp
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
#define fs_DATA_MOV_AVG_SIZE				3 // 2 // MAX_DATA_MOV_AVG_SIZE
#define fs_START_ANGLE_OFFSET				0.000					// Installation calibration, rad
#define fs_SWAP_XY							false					// Installation calibration
#define fs_TO_COORD_X_SCALE				1.000					// Installation calibration
#define fs_TO_COORD_Y_SCALE				1.000					// Installation calibration
#define fs_TO_COORD_X_OFFSET				0.000					// Installation calibration, m
#define fs_TO_COORD_Y_OFFSET				0.000					// Installation calibration, m
#define fs_OBJ_EDGE_THRES_SIZE_M			0.120 // 0.030			// lower stable edge smaller size, higher bigger size for complex obj
#define fs_OBJ_EDGE_SPACE_INT_CNT			4 // 6
#define fs_CONE_OBJ_SIZE_MIN_M				0.060					// Not really used in cone counter algo
#define fs_CONE_OBJ_SIZE_MAX_M				0.200					// Not really used in cone counter algo
#define fs_LOCK_OBJ_MAX_DELTA_DIST_M		0.200					// Not used for cone counter
#define fs_LOCK_OBJ_MAX_DELTA_SIZE_M		0.100					// Not used for cone counter
#define fs_VEL_MOV_AVG_SIZE				MAX_VEL_MOV_AVG_SIZE	// Not used for cone counter
#define fs_ACC_MOV_AVG_SIZE				MAX_ACC_MOV_AVG_SIZE	// Not used for cone counter

class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;
	ros::Publisher pub;
	ros::Subscriber sub;
	LiDAR fs;

	double eval_tol;
	double PosY[8];

public:
	SubscribeAndPublish() : pn("~"),
	fs(fs_DATA_MOV_AVG_SIZE, fs_START_ANGLE_OFFSET, fs_SWAP_XY,
			fs_TO_COORD_X_SCALE, fs_TO_COORD_Y_SCALE, fs_TO_COORD_X_OFFSET, fs_TO_COORD_Y_OFFSET,
			fs_OBJ_EDGE_THRES_SIZE_M, fs_OBJ_EDGE_SPACE_INT_CNT, fs_CONE_OBJ_SIZE_MIN_M, fs_CONE_OBJ_SIZE_MAX_M,
			fs_LOCK_OBJ_MAX_DELTA_DIST_M, fs_LOCK_OBJ_MAX_DELTA_SIZE_M, fs_VEL_MOV_AVG_SIZE, fs_ACC_MOV_AVG_SIZE, 0)
	{
		string ScanNodeName;
		if (!pn.hasParam("scanner"))
			ROS_INFO("Cannot get scanner from param server!");
		pn.param("scanner", ScanNodeName, std::string("fs_scan"));

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

		// Subscribe topics, FIFO = 1
		sub = n.subscribe(ScanNodeName, 1, &SubscribeAndPublish::ScannerCallback, this, ros::TransportHints().tcpNoDelay());
	}
	
	void ScannerCallback(const sensor_msgs::LaserScan::ConstPtr& msg_in)
	{
		// Refresh new data
		const float* laserRanges = &msg_in->ranges[0];
		const float* laserIntensities = &msg_in->intensities[0];
		fs.accesskey.lock();
		fs.updateDataArray(msg_in->header.stamp.toSec(), msg_in->ranges.size(), msg_in->angle_min, msg_in->angle_increment, 0.10, 4.0, laserRanges, laserIntensities, AD_SET_MAX);
		fs.accesskey.unlock();

		// Publish msg
		lidar_tracker::lt_state_Type msg;
		msg.timestamp = msg_in->header.stamp.toSec();
		msg.lidars_difftime = 0.00;
		msg.num_of_fusedobjects = 0;

		// Column scanner output
		fs.accesskey.lock();
		for (int i=0; i<8; i++)
		{
			double dist = fs.getDistByPosY(PosY[i], eval_tol);
			msg.columnscan_up_dist[i] = dist;
			msg.columnscan_down_dist[i] = dist;
		}
		fs.accesskey.unlock();
		pub.publish(msg);
	}
};

int main(int argc, char **argv)
{
	// Initialize ros
	ros::init(argc, argv, "cone_counter");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;
	
	ROS_INFO("Start Lidar Cone Counter.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(2);
	spinner.spin();
	ROS_INFO("Close Lidar Cone Counter.");

	return 0;
}
