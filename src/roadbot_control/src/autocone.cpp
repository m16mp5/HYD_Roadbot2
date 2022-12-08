/*
 * autocone.cpp
 *
 *  AutoCone Control ROS program.
 *  Created on: 30 Sep 2019
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

#include "lidar_tracker/lt_datapoint_Type.h"
#include "lidar_tracker/lt_object_Type.h"
#include "lidar_tracker/lt_state_Type.h"

#include "lantern_rack/lr_state_Type.h"
#include "lantern_rack/lr_set_mode_Args.h"
#include "system_io/sio_state_Type.h"
#include "power_system/ps_state_Type.h"

#include "roadbot_control/ac_state_Type.h"
#include "roadbot_control/ac_set_bool_Args.h"
#include "roadbot_control/ac_set_double_Args.h"
#include "roadbot_control/ac_go_place_Args.h"
#include "roadbot_control/ac_go_collect_Args.h"
#include "roadbot_control/ac_go_signstand_Args.h"

#include "autocone.h"

#include "RearRobotArmSM.h"
#include "FrontRobotArmSM.h"

#include "LoadingBaySM.h"
#include "ConeStorageBaySM.h"
#include "LanternRackSM.h"

using namespace std;
using namespace ros;

// Calibation macros

class SubscribeAndPublish
{
private:
	ros::NodeHandle n, pn;

	ros::Subscriber rearArmSub, rearArmDetectorSub, frontArmSub, frontArmDetectorSub;
	ros::Subscriber rearDetectorSub, coneCounterLeftSub, coneCounterCenterSub, coneCounterRightSub, lanternRackSub, systemIOSub, powerSystemSub;
	ros::ServiceClient lr_set_lantern_rack_mode;

	ros::Publisher pub;
	ros::ServiceServer reloadEventService, stopEventService, demoEventService, homeEventService;
	ros::ServiceServer conePlaceEventService, coneCollectEventService, changeTargetEventService, changeLineTrackEventService;
	ros::ServiceServer coneInventoryCheckEventService;
	ros::ServiceServer standPlaceEventService, standCollectEventService, signPlaceEventService, signCollectEventService;

	RearRobotArmSM rearArmSM;
	FrontRobotArmSM frontArmSM;

	LoadingBaySM loadingBaySM;
	ConeStorageBaySM coneStorageBaySM;
	LanternRackSM lanternRackSM;

	vector<ConeSet> PlacementConeChain;

	int resumeErr32001Counter;

public:
	SubscribeAndPublish() : pn("~")
	{
		// Load configuration
		rearArmSM.armName = "reararm";
		frontArmSM.armName = "frontarm";
		updateRouteListByRosParam("reararm", &rearArmSM.Routes);
		updateRouteListByRosParam("frontarm", &frontArmSM.Routes);

		resumeErr32001Counter = 0;

		pn.getParam("rearDetectToRearRobotTCP_Angle", rearArmSM.calData_rearDetectToRearRobotTCP_Angle);
		pn.getParam("rearDetectToRearRobotTCP_OffsetX", rearArmSM.calData_rearDetectToRearRobotTCP_OffsetX);
		pn.getParam("rearDetectToRearRobotTCP_OffsetY", rearArmSM.calData_rearDetectToRearRobotTCP_OffsetY);

		rearArmSM.loadLBBasePosition();
		frontArmSM.loadLBBasePosition();
		loadingBaySM.left_loadingbay_reararmtcp_pos_x = rearArmSM.left_loadingbay_reararmtcp_pos_x;
		loadingBaySM.left_loadingbay_reararmtcp_pos_y = rearArmSM.left_loadingbay_reararmtcp_pos_y;
		loadingBaySM.left_loadingbay_reararmtcp_pos_z = rearArmSM.left_loadingbay_reararmtcp_pos_z;
		loadingBaySM.right_loadingbay_reararmtcp_pos_x = rearArmSM.right_loadingbay_reararmtcp_pos_x;
		loadingBaySM.right_loadingbay_reararmtcp_pos_y = rearArmSM.right_loadingbay_reararmtcp_pos_y;
		loadingBaySM.right_loadingbay_reararmtcp_pos_z = rearArmSM.right_loadingbay_reararmtcp_pos_z;
		loadingBaySM.left_loadingbay_frontarmtcp_pos_x = frontArmSM.left_loadingbay_frontarmtcp_pos_x;
		loadingBaySM.left_loadingbay_frontarmtcp_pos_y = frontArmSM.left_loadingbay_frontarmtcp_pos_y;
		loadingBaySM.left_loadingbay_frontarmtcp_pos_z = frontArmSM.left_loadingbay_frontarmtcp_pos_z;
		loadingBaySM.right_loadingbay_frontarmtcp_pos_x = frontArmSM.right_loadingbay_frontarmtcp_pos_x;
		loadingBaySM.right_loadingbay_frontarmtcp_pos_y = frontArmSM.right_loadingbay_frontarmtcp_pos_y;
		loadingBaySM.right_loadingbay_frontarmtcp_pos_z = frontArmSM.right_loadingbay_frontarmtcp_pos_z;

		rearArmSM.pLoadingBaySM = &loadingBaySM;
		frontArmSM.pLoadingBaySM = &loadingBaySM;
		frontArmSM.pConeStorageBaySM = &coneStorageBaySM;
		frontArmSM.pLanternRackSM = &lanternRackSM;

		// Subscribe topics, FIFO = 1
		// TBD: try buff=2 try fixing vel,acc=0 bug
		rearArmSub = n.subscribe("kr1/kr_state", 2, &SubscribeAndPublish::rearArmStateCallback, this, ros::TransportHints().tcpNoDelay());
		rearArmDetectorSub = n.subscribe("kr1_detector/lt_state", 2, &SubscribeAndPublish::rearArmDetectStateCallback, this, ros::TransportHints().tcpNoDelay());
		frontArmSub = n.subscribe("kr2/kr_state", 2, &SubscribeAndPublish::frontArmStateCallback, this, ros::TransportHints().tcpNoDelay());
		frontArmDetectorSub = n.subscribe("kr2_detector/lt_state", 2, &SubscribeAndPublish::frontArmDetectStateCallback, this, ros::TransportHints().tcpNoDelay());
		rearDetectorSub = n.subscribe("rear_detector/lt_state", 2, &SubscribeAndPublish::rearDetectStateCallback, this, ros::TransportHints().tcpNoDelay());
		coneCounterLeftSub = n.subscribe("cone_counter_left/lt_state", 2, &SubscribeAndPublish::coneCounterLeftStateCallback, this, ros::TransportHints().tcpNoDelay());
		coneCounterCenterSub = n.subscribe("cone_counter_center/lt_state", 2, &SubscribeAndPublish::coneCounterCenterStateCallback, this, ros::TransportHints().tcpNoDelay());
		coneCounterRightSub = n.subscribe("cone_counter_right/lt_state", 2, &SubscribeAndPublish::coneCounterRightStateCallback, this, ros::TransportHints().tcpNoDelay());
		lanternRackSub = n.subscribe("lantern_plc/lr_state", 2, &SubscribeAndPublish::lanternRacksStateCallback, this, ros::TransportHints().tcpNoDelay());
		powerSystemSub = n.subscribe("pwr_sys/ps_state", 2, &SubscribeAndPublish::powerSystemStateCallback, this, ros::TransportHints().tcpNoDelay());
		systemIOSub = n.subscribe("sys_io/sio_state", 2, &SubscribeAndPublish::systemIOStateCallback, this, ros::TransportHints().tcpNoDelay());

		// Create clients for using services (function calls)
	    rearArmSM.kr_movj_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movj_bypose");
		rearArmSM.kr_movj_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr1/kr_movj_byjoint");
		rearArmSM.kr_movl_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movl_bypose");
		rearArmSM.kr_movl_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr1/kr_movl_byjoint");
		rearArmSM.kr_movjrel_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movjrel_bypose");
		rearArmSM.kr_movjrel_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr1/kr_movjrel_byjoint");
		rearArmSM.kr_movlrel_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movlrel_bypose");
		rearArmSM.kr_movjreltool_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movjreltool_bypose");
		rearArmSM.kr_movjreltool_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr1/kr_movjreltool_byjoint");
		rearArmSM.kr_movlreltool_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_movlreltool_bypose");
		rearArmSM.kr_setdigitaloutput = n.serviceClient<kuka_robot::kr_setdo_Args>("/kr1/kr_setdigitaloutput");
		rearArmSM.kr_set_batch_movj_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr1/kr_set_batch_movj_bypose");
		rearArmSM.kr_set_batch_movj_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr1/kr_set_batch_movj_byjoint");
		rearArmSM.kr_set_batch_movl_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr1/kr_set_batch_movl_bypose");
		rearArmSM.kr_set_batch_movl_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr1/kr_set_batch_movl_byjoint");
		rearArmSM.kr_set_batch_movjrel_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr1/kr_set_batch_movjrel_bypose");
		rearArmSM.kr_set_batch_movjrel_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr1/kr_set_batch_movjrel_byjoint");
		rearArmSM.kr_set_batch_movlrel_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr1/kr_set_batch_movlrel_bypose");
		rearArmSM.kr_set_batch_movjreltool_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr1/kr_set_batch_movjreltool_bypose");
		rearArmSM.kr_set_batch_movjreltool_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr1/kr_set_batch_movjreltool_byjoint");
		rearArmSM.kr_set_batch_movlreltool_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr1/kr_set_batch_movlreltool_bypose");
		rearArmSM.kr_set_batch_setdigitaloutput = n.serviceClient<kuka_robot::kr_batch_setdo_Args>("/kr1/kr_set_batch_setdigitaloutput");
		rearArmSM.kr_batch_mov_run = n.serviceClient<kuka_robot::kr_batch_mv_run_Args>("/kr1/kr_batch_mov_run");
		rearArmSM.kr_rampdown_stop = n.serviceClient<kuka_robot::kr_rampstop_Args>("/kr1/kr_rampdown_stop");
		rearArmSM.kr_check_mov_completed = n.serviceClient<kuka_robot::kr_dummy_Args>("/kr1/kr_check_mov_completed");
		rearArmSM.kr_set_speedscale = n.serviceClient<kuka_robot::kr_set_speed_scale_Args>("/kr1/kr_set_speedscale");
		rearArmSM.kr_set_payload = n.serviceClient<kuka_robot::kr_set_load_Args>("/kr1/kr_set_payload");
		rearArmSM.kr_set_base_coord = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_set_base_coord");
		rearArmSM.kr_set_tool_coord = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr1/kr_set_tool_coord");
		rearArmSM.kr_conv_joints_to_pose = n.serviceClient<kuka_robot::kr_cov_joint_pose_Args>("/kr1/kr_conv_joints_to_pose");
		rearArmSM.kr_set_default_accvel = n.serviceClient<kuka_robot::kr_set_accvel_Args>("/kr1/kr_set_default_accvel");
		rearArmSM.kr_set_default_round = n.serviceClient<kuka_robot::kr_set_real_Args>("/kr1/kr_set_default_round");
		rearArmSM.kr_start_autoext_mode = n.serviceClient<kuka_robot::kr_dummy_Args>("/kr1/kr_start_autoext_mode");
		rearArmSM.kr_set_moveenable_signal = n.serviceClient<kuka_robot::kr_set_bool_Args>("/kr1/kr_set_moveenable_signal");

		rearArmSM.vs_check_position_has_cone = n.serviceClient<vision_system::vs_check_position_has_cone_Args>("/rearview_vision/vs_check_position_has_cone");
		rearArmSM.vs_get_white_marking_position = n.serviceClient<vision_system::vs_get_white_marking_position_Args>("/birdview_vision/vs_get_white_marking_position");

		frontArmSM.kr_movj_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_movj_bypose");
		frontArmSM.kr_movj_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr2/kr_movj_byjoint");
		frontArmSM.kr_movl_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_movl_bypose");
		frontArmSM.kr_movl_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr2/kr_movl_byjoint");
		frontArmSM.kr_movjrel_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_movjrel_bypose");
		frontArmSM.kr_movjrel_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr2/kr_movjrel_byjoint");
		frontArmSM.kr_movlrel_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_movlrel_bypose");
		frontArmSM.kr_movjreltool_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_movjreltool_bypose");
		frontArmSM.kr_movjreltool_byjoint = n.serviceClient<kuka_robot::kr_mv_byjoint_Args>("/kr2/kr_movjreltool_byjoint");
		frontArmSM.kr_movlreltool_bypose = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_movlreltool_bypose");
		frontArmSM.kr_setdigitaloutput = n.serviceClient<kuka_robot::kr_setdo_Args>("/kr2/kr_setdigitaloutput");
		frontArmSM.kr_set_batch_movj_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr2/kr_set_batch_movj_bypose");
		frontArmSM.kr_set_batch_movj_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr2/kr_set_batch_movj_byjoint");
		frontArmSM.kr_set_batch_movl_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr2/kr_set_batch_movl_bypose");
		frontArmSM.kr_set_batch_movl_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr2/kr_set_batch_movl_byjoint");
		frontArmSM.kr_set_batch_movjrel_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr2/kr_set_batch_movjrel_bypose");
		frontArmSM.kr_set_batch_movjrel_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr2/kr_set_batch_movjrel_byjoint");
		frontArmSM.kr_set_batch_movlrel_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr2/kr_set_batch_movlrel_bypose");
		frontArmSM.kr_set_batch_movjreltool_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr2/kr_set_batch_movjreltool_bypose");
		frontArmSM.kr_set_batch_movjreltool_byjoint = n.serviceClient<kuka_robot::kr_batch_mv_byjoint_Args>("/kr2/kr_set_batch_movjreltool_byjoint");
		frontArmSM.kr_set_batch_movlreltool_bypose = n.serviceClient<kuka_robot::kr_batch_mv_bypose_Args>("/kr2/kr_set_batch_movlreltool_bypose");
		frontArmSM.kr_set_batch_setdigitaloutput = n.serviceClient<kuka_robot::kr_batch_setdo_Args>("/kr2/kr_set_batch_setdigitaloutput");
		frontArmSM.kr_batch_mov_run = n.serviceClient<kuka_robot::kr_batch_mv_run_Args>("/kr2/kr_batch_mov_run");
		frontArmSM.kr_rampdown_stop = n.serviceClient<kuka_robot::kr_rampstop_Args>("/kr2/kr_rampdown_stop");
		frontArmSM.kr_check_mov_completed = n.serviceClient<kuka_robot::kr_dummy_Args>("/kr2/kr_check_mov_completed");
		frontArmSM.kr_set_speedscale = n.serviceClient<kuka_robot::kr_set_speed_scale_Args>("/kr2/kr_set_speedscale");
		frontArmSM.kr_set_payload = n.serviceClient<kuka_robot::kr_set_load_Args>("/kr2/kr_set_payload");
		frontArmSM.kr_set_base_coord = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_set_base_coord");
		frontArmSM.kr_set_tool_coord = n.serviceClient<kuka_robot::kr_mv_bypose_Args>("/kr2/kr_set_tool_coord");
		frontArmSM.kr_conv_joints_to_pose = n.serviceClient<kuka_robot::kr_cov_joint_pose_Args>("/kr2/kr_conv_joints_to_pose");
		frontArmSM.kr_set_default_accvel = n.serviceClient<kuka_robot::kr_set_accvel_Args>("/kr2/kr_set_default_accvel");
		frontArmSM.kr_set_default_round = n.serviceClient<kuka_robot::kr_set_real_Args>("/kr2/kr_set_default_round");
		frontArmSM.kr_start_autoext_mode = n.serviceClient<kuka_robot::kr_dummy_Args>("/kr2/kr_start_autoext_mode");
		frontArmSM.kr_set_moveenable_signal = n.serviceClient<kuka_robot::kr_set_bool_Args>("/kr2/kr_set_moveenable_signal");

		lr_set_lantern_rack_mode = n.serviceClient<lantern_rack::lr_set_mode_Args>("/lantern_plc/lr_set_lantern_rack_mode");

		// Register Publish Topics (stream/pipe data), FIFO size = 5 //3
		pub = pn.advertise<roadbot_control::ac_state_Type>("ac_state", 5);

		// Register services (function calls)
		reloadEventService = pn.advertiseService("ac_reload_routes", &SubscribeAndPublish::reloadRoutesCallback, this);
		stopEventService = pn.advertiseService("ac_stop_autocontrol", &SubscribeAndPublish::stopAutoControlCallback, this);
		demoEventService = pn.advertiseService("ac_go_demo", &SubscribeAndPublish::goDemoCallback, this);
		homeEventService = pn.advertiseService("ac_go_home", &SubscribeAndPublish::goHomeCallback, this);
		conePlaceEventService = pn.advertiseService("ac_go_coneplace", &SubscribeAndPublish::goConePlaceCallback, this);
		coneCollectEventService = pn.advertiseService("ac_go_conecollect", &SubscribeAndPublish::goConeCollectCallback, this);
		changeTargetEventService = pn.advertiseService("ac_change_target", &SubscribeAndPublish::changeAutolockTargetCallback, this);
		changeLineTrackEventService = pn.advertiseService("ac_change_line", &SubscribeAndPublish::changeRoadmarkLineTrackCallback, this);
		coneInventoryCheckEventService = pn.advertiseService("ac_go_coneinvcheck", &SubscribeAndPublish::goConeInventoryCheckCallback, this);
		standPlaceEventService = pn.advertiseService("ac_go_standplace", &SubscribeAndPublish::goStandPlaceCallback, this);
		standCollectEventService = pn.advertiseService("ac_go_standcollect", &SubscribeAndPublish::goStandCollectCallback, this);
		signPlaceEventService = pn.advertiseService("ac_go_signplace", &SubscribeAndPublish::goSignPlaceCallback, this);
		signCollectEventService = pn.advertiseService("ac_go_signcollect", &SubscribeAndPublish::goSignCollectCallback, this);
	}

	void updateRouteListByRosParam(string basename, vector<Route>* pRoutes)
	{
		vector<string> route_list;
		pn.getParam(string(basename + "/routelist"), route_list);
		pRoutes->clear();
		pRoutes->resize(route_list.size());
		for(int i=0; i<route_list.size(); i++)
		{
			string Route_Name = route_list[i];
			pRoutes->at(i).name = Route_Name;
			pRoutes->at(i).waypoints.clear();
			int j = 0;
			while (1)
			{
				string Waypoint_Base = basename + "/" + Route_Name + to_string(j);
				string Waypoint_Name = Waypoint_Base + "/type";
				string Type;
				if (pn.getParam(Waypoint_Name, Type))
				{
					ROS_INFO("---Read %s-%s", Waypoint_Name.c_str(), Type.c_str());
					BATCH_MOV_BLK waypoint;
					string Waypoint_A1_Name = Waypoint_Base + "/A1";
					string Waypoint_X_Name = Waypoint_Base + "/X";
					double dtemp;
					if (pn.getParam(Waypoint_X_Name, dtemp))	// by Pose type
					{
						waypoint.BATCH_POS.X = dtemp;
						pn.getParam(string(Waypoint_Base + "/Y"), dtemp);
						waypoint.BATCH_POS.Y = dtemp;
						pn.getParam(string(Waypoint_Base + "/Z"), dtemp);
						waypoint.BATCH_POS.Z = dtemp;
						pn.getParam(string(Waypoint_Base + "/A"), dtemp);
						waypoint.BATCH_POS.A = dtemp;
						pn.getParam(string(Waypoint_Base + "/B"), dtemp);
						waypoint.BATCH_POS.B = dtemp;
						pn.getParam(string(Waypoint_Base + "/C"), dtemp);
						waypoint.BATCH_POS.C = dtemp;
						pn.getParam(string(Waypoint_Base + "/S"), dtemp);
						waypoint.BATCH_POS.S = dtemp;
						pn.getParam(string(Waypoint_Base + "/T"), dtemp);
						waypoint.BATCH_POS.T = dtemp;
						pn.getParam(string(Waypoint_Base + "/R"), dtemp);
						waypoint.BATCH_ROUNDM = dtemp;

						if (Type == "movj")
							waypoint.BATCH_ACTION = MOVJ_BYPOSE_ACTION_TYPE;
						else if (Type == "movl")
							waypoint.BATCH_ACTION = MOVL_BYPOSE_ACTION_TYPE;
						else if (Type == "movjrel")
							waypoint.BATCH_ACTION = MOVJREL_BYPOSE_ACTION_TYPE;
						else if (Type == "movlrel")
							waypoint.BATCH_ACTION = MOVLREL_BYPOSE_ACTION_TYPE;
						else if (Type == "movjreltool")
							waypoint.BATCH_ACTION = MOVJRELTOOL_BYPOSE_ACTION_TYPE;
						else if (Type == "movlreltool")
							waypoint.BATCH_ACTION = MOVLRELTOOL_BYPOSE_ACTION_TYPE;
						else
							waypoint.BATCH_ACTION = 0;		// unknown
					}
					else if (pn.getParam(Waypoint_A1_Name, dtemp))		// by Joints type
					{
						waypoint.BATCH_E6AXIS.A1 = dtemp;
						pn.getParam(string(Waypoint_Base + "/A2"), dtemp);
						waypoint.BATCH_E6AXIS.A2 = dtemp;
						pn.getParam(string(Waypoint_Base + "/A3"), dtemp);
						waypoint.BATCH_E6AXIS.A3 = dtemp;
						pn.getParam(string(Waypoint_Base + "/A4"), dtemp);
						waypoint.BATCH_E6AXIS.A4 = dtemp;
						pn.getParam(string(Waypoint_Base + "/A5"), dtemp);
						waypoint.BATCH_E6AXIS.A5 = dtemp;
						pn.getParam(string(Waypoint_Base + "/A6"), dtemp);
						waypoint.BATCH_E6AXIS.A6 = dtemp;
						pn.getParam(string(Waypoint_Base + "/R"), dtemp);
						waypoint.BATCH_ROUNDM = dtemp;

						if (Type == "movj")
							waypoint.BATCH_ACTION = MOVJ_BYJOINTS_ACTION_TYPE;
						else if (Type == "movl")
							waypoint.BATCH_ACTION = MOVL_BYJOINTS_ACTION_TYPE;
						else if (Type == "movjrel")
							waypoint.BATCH_ACTION = MOVJREL_BYJOINTS_ACTION_TYPE;
						else if (Type == "movlrel")
							waypoint.BATCH_ACTION = 0; 		// not possible
						else if (Type == "movjreltool")
							waypoint.BATCH_ACTION = MOVJRELTOOL_BYJOINTS_ACTION_TYPE;
						else if (Type == "movlreltool")
							waypoint.BATCH_ACTION = 0;		// not possible
						else
							waypoint.BATCH_ACTION = 0;		// unknown
					}
					else
					{
						dtemp = 0;
						pn.getParam(string(Waypoint_Base + "/DO_VALUE"), dtemp);
						waypoint.DO_VALUE = dtemp;
						pn.getParam(string(Waypoint_Base + "/DO_MASK"), dtemp);
						waypoint.DO_MASK = dtemp;
						pn.getParam(string(Waypoint_Base + "/DO_SETSEC"), dtemp);
						waypoint.DO_SETSEC = dtemp;

						if (Type == "do")
							waypoint.BATCH_ACTION = DO_ACTION_TYPE;
						else
							waypoint.BATCH_ACTION = 0;		// unknown
					}
					pRoutes->at(i).waypoints.push_back(waypoint);
				}
				else
					break;
				j++;
			}
		}
	}

	void publishAcStateTopic()
	{
		// Copy object data state publish to the topic
		roadbot_control::ac_state_Type msg;
		msg.timestamp = ros::Time::now().toSec();

		msg.reararm_sm = rearArmSM.currentState;
		msg.frontarm_sm = frontArmSM.currentState;

		msg.target_id = rearArmSM.targetObjectID;
		msg.target_pos_X = rearArmSM.targetObjectPose.X;
		msg.target_pos_Y = rearArmSM.targetObjectPose.Y;
		msg.target_pos_Z = rearArmSM.targetObjectPose.Z;
		msg.target_vel_X = rearArmSM.targetObjectVelAtLid.X;
		msg.target_vel_Y = rearArmSM.targetObjectVelAtLid.Y;
		msg.target_vel_Z = rearArmSM.targetObjectVelAtLid.Z;
		msg.target_acc_X = rearArmSM.targetObjectAccAtLid.X;
		msg.target_acc_Y = rearArmSM.targetObjectAccAtLid.Y;
		msg.target_acc_Z = rearArmSM.targetObjectAccAtLid.Z;

		msg.roadmarkline_pos_X = rearArmSM.roadmarkLineX;
		msg.roadmarkline_pos_Y = rearArmSM.roadmarkLineY;

		msg.rearDetectObjectInDeadZone = rearArmSM.rearDetectObjectInDeadZone;
		msg.rearDetectObjectInPlaceZoneRight = rearArmSM.rearDetectObjectInPlaceZoneRight;
		msg.rearDetectObjectInPlaceZoneCenter = rearArmSM.rearDetectObjectInPlaceZoneCenter;
		msg.rearDetectObjectInPlaceZoneLeft = rearArmSM.rearDetectObjectInPlaceZoneLeft;
		msg.rearDetectNonLockObjectInOperationZone = rearArmSM.rearDetectNonLockObjectInOperationZone;

		msg.progress_place_count = rearArmSM.PlacementConeChainCurrIndex;
		if (rearArmSM.PlacementConeChainTemplate != NULL)
			msg.progress_place_in_total = rearArmSM.PlacementConeChainTemplate->size();
		else
			msg.progress_place_in_total = 0;
		msg.progress_collect_count = rearArmSM.CollectionConeCount;
		msg.progress_collect_in_total = rearArmSM.CollectionConeAmount;

		msg.sb_slider_position = coneStorageBaySM.sliderPosition;
		msg.sb_cones_in_total = coneStorageBaySM.numOfConesInTotal;
		for (int i=0; i<12; i++)
			msg.sb_cones_in_stack.push_back(coneStorageBaySM.numOfConesInStack[i]);
		msg.sb_current_stack = coneStorageBaySM.currentStack;
		msg.sb_current_stacklevel = coneStorageBaySM.currentStackLevel;

		msg.lb_left_slot = loadingBaySM.leftLoadingBayLoaded;
		msg.lb_right_slot = loadingBaySM.rightLoadingBayLoaded;

		msg.lr_lanterns_in_total = lanternRackSM.numOfLanternsInTotal;
		for (int i=0; i<10; i++)
			msg.lr_lanterns_in_stack.push_back(lanternRackSM.numOfLanternsInStack[i]);
		msg.lr_current_stack = lanternRackSM.currentStack;
		msg.lr_current_stacklevel = lanternRackSM.currentStackLevel;

		pub.publish(msg);
	}

	void rearArmStateCallback(const kuka_robot::kr_robot_state_Type::ConstPtr& msg_in)
	{
		rearArmSM.OnUpdateRobotArmState(msg_in);
		frontArmSM.rearArmCurrTCP_X = msg_in->pos_fb.X;
		frontArmSM.rearArmCurrTCP_Y = msg_in->pos_fb.Y;
		frontArmSM.rearArmCurrTCP_Z = msg_in->pos_fb.Z;

		if ((!rearArmSM.IsEmergencyStopActivatedPrev) && (rearArmSM.IsEmergencyStopActivated))
		{
			// Disable move_enable signal and so terminate AutoExt mode at false->true transition
			rearArmSM.disableHWMoveSignal();
			frontArmSM.disableHWMoveSignal();
			lantern_rack::lr_set_mode_Args srv;
			srv.request.mode = 99;				// Any other than 0~2
			lr_set_lantern_rack_mode.call(srv);
			ROS_INFO("AutoCone Controller detected Emergency Stop just activated. Disable Arms AutoExt Mode and Lantern Rack.");
		}

		if (msg_in->com_error_no == 32001)
		{
			resumeErr32001Counter++;
//			if (resumeErr32001Counter == 50)
//			{
//				rearArmSM.cmdResumeMove();
//				ROS_INFO("Auto resumed move at counter = 50.");
//			}
			ROS_INFO("AutoCone Controller detected rear arm error code 32001. Counter: %d.", resumeErr32001Counter);
		}

		loadingBaySM.OnUpdateRearRobotArmState(msg_in);

		publishAcStateTopic();
	}

	void rearArmDetectStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		rearArmSM.OnUpdateArmDetectorState(msg_in);

		publishAcStateTopic();
	}

	void frontArmStateCallback(const kuka_robot::kr_robot_state_Type::ConstPtr& msg_in)
	{
		frontArmSM.OnUpdateRobotArmState(msg_in);
		rearArmSM.frontArmCurrTCP_X = msg_in->pos_fb.X;
		rearArmSM.frontArmCurrTCP_Y = msg_in->pos_fb.Y;
		rearArmSM.frontArmCurrTCP_Z = msg_in->pos_fb.Z;

		if ((!frontArmSM.IsEmergencyStopActivatedPrev) && (frontArmSM.IsEmergencyStopActivated))
		{
			// Disable move_enable signal and so terminate AutoExt mode at false->true transition
			rearArmSM.disableHWMoveSignal();
			frontArmSM.disableHWMoveSignal();
			lantern_rack::lr_set_mode_Args srv;
			srv.request.mode = 99;				// Any other than 0~2
			lr_set_lantern_rack_mode.call(srv);
			ROS_INFO("AutoCone Controller detected front arm Emergency Stop just activated. Disable Arms AutoExt Mode and Lantern Rack.");
		}

		if (msg_in->com_error_no == 32001)
		{
			resumeErr32001Counter++;
//			if (resumeErr32001Counter == 50)
//			{
//				frontArmSM.cmdResumeMove();
//				ROS_INFO("Auto resumed move at counter = 50.");
//			}
			ROS_INFO("AutoCone Controller detected front arm error code 32001. Counter: %d.", resumeErr32001Counter);
		}

		loadingBaySM.OnUpdateFrontRobotArmState(msg_in);
//		coneStorageBaySM.OnUpdateFrontRobotArmState(msg_in);
//		lanternRackSM.OnUpdateFrontRobotArmState(msg_in);

		publishAcStateTopic();
	}

	void frontArmDetectStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		frontArmSM.OnUpdateArmDetectorState(msg_in);

		publishAcStateTopic();
	}

	void rearDetectStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		rearArmSM.OnUpdateRearDetectorState(msg_in);

		publishAcStateTopic();
	}

	void coneCounterLeftStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		// Update only when frontarm is idle, or other stopped state
		if (frontArmSM.currentState < FrontRobotArmSM::ST_HOME)
			coneStorageBaySM.OnUpdateConeCounterLeftState(msg_in);
	}

	void coneCounterCenterStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		// Update only when frontarm is idle, or other stopped state
		if (frontArmSM.currentState < FrontRobotArmSM::ST_HOME)
			coneStorageBaySM.OnUpdateConeCounterCenterState(msg_in);
	}

	void coneCounterRightStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		// Update only when frontarm is idle, or other stopped state
		if (frontArmSM.currentState < FrontRobotArmSM::ST_HOME)
			coneStorageBaySM.OnUpdateConeCounterRightState(msg_in);
	}

	void lanternRacksStateCallback(const lantern_rack::lr_state_Type::ConstPtr& msg_in)
	{
		lanternRackSM.OnUpdateLanternRackState(msg_in);

		publishAcStateTopic();
	}

	void systemIOStateCallback(const system_io::sio_state_Type::ConstPtr& msg_in)
	{
		loadingBaySM.OnUpdateSioState(msg_in);
//		coneStorageBaySM.OnUpdateRearSlidersState(msg_in);

/*		rearArmSM.OnUpdateSystemMonitorState(msg_in);
		frontArmSM.OnUpdateSystemMonitorState(msg_in);*/

		// Safety, Air Compressor, any other fault
		publishAcStateTopic();
	}

	void powerSystemStateCallback(const power_system::ps_state_Type::ConstPtr& msg_in)
	{
//		rearArmSM.OnUpdatePowerSystemState(msg_in);
//		frontArmSM.OnUpdatePowerSystemState(msg_in);

		// Power System
//		publishAcStateTopic();
	}

/*	void visionDetectStateCallback(const lidar_tracker::lt_state_Type::ConstPtr& msg_in)
	{
		rearArmSM.OnUpdateVisionDetectState(msg_in);

		publishAcStateTopic();
	}*/

	bool reloadRoutesCallback(roadbot_control::ac_set_bool_Args::Request &req,
			roadbot_control::ac_set_bool_Args::Response &res)
	{
		int retval = 0;
		bool state = req.state;
		updateRouteListByRosParam("reararm", &rearArmSM.Routes);
		updateRouteListByRosParam("frontarm", &frontArmSM.Routes);
		res.response = retval;
		return true;
	}

	bool stopAutoControlCallback(roadbot_control::ac_set_bool_Args::Request &req,
			roadbot_control::ac_set_bool_Args::Response &res)
	{
		int retval = 0;
		bool state = req.state;
		rearArmSM.stopAutoControl();
		frontArmSM.stopAutoControl();

//		lantern_rack::lr_set_mode_Args srv;
//		srv.request.mode = 99;				// Any other than 0~2
//		lr_set_lantern_rack_mode.call(srv);

		res.response = retval;
		return true;
	}

	bool goHomeCallback(roadbot_control::ac_set_double_Args::Request &req,
			roadbot_control::ac_set_double_Args::Response &res)
	{
		int retval = 0;
		if (req.num == 1)
			rearArmSM.goHome();
		else if (req.num == 2)
			frontArmSM.goHome();
		else if (req.num == 3)
		{
			rearArmSM.goHome();
			frontArmSM.goHome();
		}
		else if (req.num == -1)
			rearArmSM.goHomeSafely();
		else if (req.num == -2)
			frontArmSM.goHomeSafely();
		else if (req.num == -3)
		{
			rearArmSM.goHomeSafely();
			frontArmSM.goHomeSafely();
		}
		res.response = retval;
		return true;
	}

	bool goDemoCallback(roadbot_control::ac_set_double_Args::Request &req,
			roadbot_control::ac_set_double_Args::Response &res)
	{
		int retval = 0;
		double number = req.num;

		resumeErr32001Counter = 0;
		rearArmSM.goDemo(NULL);
		frontArmSM.goDemo(NULL);
		res.response = retval;
		return true;
	}

	bool goConePlaceCallback(roadbot_control::ac_go_place_Args::Request &req,
			roadbot_control::ac_go_place_Args::Response &res)
	{
		int retval = 0;

		// If in motion
		if ( (rearArmSM.currentState != RearRobotArmSM::ST_IDLE) ||
			(frontArmSM.currentState != FrontRobotArmSM::ST_IDLE) )
		{
			res.response = -1;
			return false;
		}

		// If num of cone in sb not known
		if (!coneStorageBaySM.checkSBState())
		{
			res.response = -2;
			return false;
		}

		int mode = req.mode;
		int numOfSet = req.number_of_cones.size();

		int totalNumOfCone = 0;
		for (int i=0; i<numOfSet; i++)
			totalNumOfCone += req.number_of_cones[i];
		PlacementConeChain.clear();
		PlacementConeChain.resize(totalNumOfCone);

		int coneIndex = 0;
		for (int i=0; i<numOfSet; i++)
		{
			int numOfCones = req.number_of_cones[i];
			double spacing = req.cone_spacing[i] * 1000.0;				// m to mm
			double startPosY = req.start_position_y[i] * 1000.0;		// m to mm
	//		double startPosX = req.start_position_x[i] * 1000.0;		// m to mm
			double endPosY = req.end_position_y[i] * 1000.0;			// m to mm
	//		double endPosX = req.end_position_x[i] * 1000.0;			// m to mm
			int lanternPattern = req.lantern_pattern[i];

			ROS_INFO("Place S%d: numOfCones=%d, spacing=%.3f, startPosY=%.3f, endPosY=%.3f, patt=%d, mode=%d.",
					i+1, numOfCones, spacing, startPosY, endPosY, lanternPattern, mode);

			if (startPosY > 1500.0)
				startPosY = 1500.0;
			else if (startPosY < -1500.0)
				startPosY = -1500.0;
			if (endPosY > 1500.0)
				endPosY = 1500.0;
			else if (endPosY < -1500.0)
				endPosY = -1500.0;

			double step = (numOfCones-1);
			if (step <= 0)
				step = 1;
			double Y_step = (endPosY - startPosY) / step;

			double referenceLineY;
			if (mode == 0)
				referenceLineY = 0;
			else
				referenceLineY = rearArmSM.roadmarkLineY;

			for (int j=0; j<numOfCones; j++)
			{
				PlacementConeChain[coneIndex].Is_1mCone = true;
				if (lanternPattern == 1)
				{
//					if ((coneIndex%2) == 0)									// every 2 cone with a lantern
//						PlacementConeChain[coneIndex].Has_Lantern = true;
					if (coneIndex == 0)										// if first one no prev, put lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
					else if (!PlacementConeChain[coneIndex-1].Has_Lantern)	// if previous no lantern, put lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
					else
						PlacementConeChain[coneIndex].Has_Lantern = false;

					if (j == 0)												// override: start section with a lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
					else if (j == (numOfCones-1))							// override: and end section cone with a lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
				}
				else if (lanternPattern == 2)								// every cone with a lantern
					PlacementConeChain[coneIndex].Has_Lantern = true;
				else if (lanternPattern == 3)
				{
					if ((coneIndex%4) == 0)									// every 4 cone with a lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
					else
						PlacementConeChain[coneIndex].Has_Lantern = false;

					if (j == 0)												// override: start section with a lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
					else if (j == (numOfCones-1))							// override: and end section cone with a lantern
						PlacementConeChain[coneIndex].Has_Lantern = true;
				}
				else														// every cone no lantern
					PlacementConeChain[coneIndex].Has_Lantern = false;

				PlacementConeChain[coneIndex].Has_Lantern = false;			// Javier, Disable cone with a lantern at all time

				PlacementConeChain[coneIndex].relativeX = spacing;											// separation, in mm
				PlacementConeChain[coneIndex].relativeY = (endPosY - referenceLineY) - (step-j) * Y_step;	// final cone posY relative to refY, in mm
				coneIndex++;
			}
		}

		// Clear loading bay lock state and counter
		loadingBaySM.releaseLLB_ExclusiveLock(1);
		loadingBaySM.releaseRLB_ExclusiveLock(1);
		loadingBaySM.releaseLLB_ExclusiveLock(2);
		loadingBaySM.releaseRLB_ExclusiveLock(2);
		resumeErr32001Counter = 0;

		// For lantern rack test, be careful for neg pos of pick on level inc, TBD: to be removed
		lanternRackSM.currentStack = 2;
		lanternRackSM.currentStackLevel = 1;

		rearArmSM.goConePlacement(&PlacementConeChain, mode);
		frontArmSM.goConePlacement(&PlacementConeChain);

		res.response = retval;
		return true;
	}

	bool goConeCollectCallback(roadbot_control::ac_go_collect_Args::Request &req,
			roadbot_control::ac_go_collect_Args::Response &res)
	{
		int retval = 0;
		int numOfCones = req.number_of_cones;
		int mode = req.mode;

		// If in motion
		if ( (rearArmSM.currentState != RearRobotArmSM::ST_IDLE) ||
			(frontArmSM.currentState != FrontRobotArmSM::ST_IDLE) )
		{
			res.response = -1;
			return false;
		}

		// If num of cone in sb not known
		if (!coneStorageBaySM.checkSBState())
		{
			res.response = -2;
			return false;
		}

		// Clear loading bay lock state and counters
		loadingBaySM.releaseLLB_ExclusiveLock(1);
		loadingBaySM.releaseRLB_ExclusiveLock(1);
		loadingBaySM.releaseLLB_ExclusiveLock(2);
		loadingBaySM.releaseRLB_ExclusiveLock(2);
		resumeErr32001Counter = 0;

		// For lantern rack test, be careful for neg pos of pick on level inc, TBD: to be removed
		lanternRackSM.currentStack = 2;
		lanternRackSM.currentStackLevel = 1;

		rearArmSM.goConeCollection(numOfCones, mode);
		frontArmSM.goConeCollection(numOfCones);

		res.response = retval;
		return true;
	}

	bool changeAutolockTargetCallback(roadbot_control::ac_set_double_Args::Request &req,
			roadbot_control::ac_set_double_Args::Response &res)
	{
		int retval = 0;
		int number = req.num;		// ID or tracked cone array index

		rearArmSM.changeAutolockTarget(number);
		res.response = retval;
		return true;
	}

	bool changeRoadmarkLineTrackCallback(roadbot_control::ac_set_double_Args::Request &req,
			roadbot_control::ac_set_double_Args::Response &res)
	{
		int retval = 0;
		double PosY = req.num * 1000.0;		// to mm

		rearArmSM.changeRoadmarkLineTrack(1550.0, PosY);
		res.response = retval;
		return true;
	}

	bool goConeInventoryCheckCallback(roadbot_control::ac_set_bool_Args::Request &req,
			roadbot_control::ac_set_bool_Args::Response &res)
	{
		int retval = 0;
		int number = req.state;		// don't care

		frontArmSM.goConeInventoryCheck();
		res.response = retval;
		return true;
	}

	bool goStandPlaceCallback(roadbot_control::ac_go_signstand_Args::Request &req,
			roadbot_control::ac_go_signstand_Args::Response &res)
	{
		int retval = 0;
		int LBLocation = req.lb_location;
		double x = req.position_x;
		double y = req.position_y;

		rearArmSM.goStandPlacement(LBLocation, x, y);
		res.response = retval;
		return true;
	}

	bool goStandCollectCallback(roadbot_control::ac_go_signstand_Args::Request &req,
			roadbot_control::ac_go_signstand_Args::Response &res)
	{
		int retval = 0;
		int LBLocation = req.lb_location;
		double x = req.position_x;
		double y = req.position_y;

		rearArmSM.goStandCollection(LBLocation, x, y);
		res.response = retval;
		return true;
	}

	bool goSignPlaceCallback(roadbot_control::ac_go_signstand_Args::Request &req,
			roadbot_control::ac_go_signstand_Args::Response &res)
	{
		int retval = 0;
		int LBLocation = req.lb_location;
		double x = req.position_x;
		double y = req.position_y;

		rearArmSM.goSignPlacement(LBLocation, x, y);
		res.response = retval;
		return true;
	}

	bool goSignCollectCallback(roadbot_control::ac_go_signstand_Args::Request &req,
			roadbot_control::ac_go_signstand_Args::Response &res)
	{
		int retval = 0;
		int LBLocation = req.lb_location;
		double x = req.position_x;
		double y = req.position_y;

		rearArmSM.goSignCollection(LBLocation, x, y);
		res.response = retval;
		return true;
	}
};

int main(int argc, char **argv)
{
	// Initialize ros
	ros::init(argc, argv, "autocone_control");
	
	//Create an object of class SubscribeAndPublish
	SubscribeAndPublish SAPObject;

	ROS_INFO("Start AutoCone Controller.");
	// Loop execute service calls / publish / Listen here
	ros::MultiThreadedSpinner spinner(10);
	spinner.spin();
	ROS_INFO("Close AutoCone Controller.");

	return 0;
}
