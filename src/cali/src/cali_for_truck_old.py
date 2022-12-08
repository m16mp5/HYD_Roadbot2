#!/usr/bin/env python

import os, sys
import rospy
import numpy as np
import math
import tf
import tf2_geometry_msgs
import image_geometry
import copy
import yaml
from python_qt_binding import loadUi
from PyQt5.QtWidgets import QMainWindow, QApplication, QMessageBox
from PyQt5.QtCore import QTimer
from geometry_msgs.msg import Point
from std_msgs.msg import String
from kuka_robot.msg import *
from kuka_robot.srv import *
from geometry_msgs.msg import PoseStamped
from geometry_msgs.msg import Point32
from geometry_msgs.msg import Polygon
from geometry_msgs.msg import TransformStamped
from geometry_msgs.msg import PolygonStamped
from geometry_msgs.msg import PointStamped
from std_msgs.msg import Header
from threading import Thread
#from detect_divider.msg import RmPlane
from visualization_msgs.msg import Marker
from sensor_msgs.msg import CameraInfo
from sensor_msgs.msg import Image
from enum import IntEnum

class MyMainWindow(QMainWindow):
    prevKr1StateTimestamp = 0.0
    timerpz = QTimer()
    timernz = QTimer()
    timerpy = QTimer()
    timerny = QTimer()
    timerpx = QTimer()
    timernx = QTimer()
    timerpa1 = QTimer()
    timerna1 = QTimer()
    timerpa2 = QTimer()
    timerna2 = QTimer()
    timerpa2 = QTimer()
    timerpa3 = QTimer()
    timerna3 = QTimer()
    timerpa4 = QTimer()
    timerna4 = QTimer()
    timerpa5 = QTimer()
    timerna5 = QTimer()
    timerpa6 = QTimer()
    timerna6 = QTimer()

    speed = 5
    use_tool2 = True

    target_pose  = kr_pose_Type()
    cur_pose     = kr_pose_Type()
    trimmer_default_pose = kr_pose_Type()
    robot_state  = kr_robot_state_Type()
    plane_points = []
    update_count = 0
    kr_init   = False # True
    action    = False
    cancel_signal = False

    thread1 = []
    tf_cali = TransformStamped()
    aruco_pixel = PointStamped()
    marker_point = Point()
    model = image_geometry.PinholeCameraModel()
    valid_camera_info = False
    depth_stamp = rospy.rostime.Time()
    aruco_stamp = rospy.rostime.Time()
    tf_cam_robot = []

    filename = os.path.join("/home", os.environ["USER"], "poc", "remover.yaml")
    if os.path.exists(filename):
      with open(filename) as f:
        data = yaml.load(f)
        tf_cam_robot = TransformStamped()
        tf_cam_robot.transform.translation.x = data['x'] 
        tf_cam_robot.transform.translation.y = data['y'] 
        tf_cam_robot.transform.translation.z = data['z'] 
        tf_cam_robot.transform.rotation.x    = data['rx']
        tf_cam_robot.transform.rotation.y    = data['ry']
        tf_cam_robot.transform.rotation.z    = data['rz']
        tf_cam_robot.transform.rotation.w    = data['rw']

    # Init/constructor
    def __init__(self, parent=None):
        super(MyMainWindow, self).__init__(parent)
        # Create HMI/gui - by loadui plugin direct create from .ui
        self_dir = os.path.dirname(os.path.realpath(__file__))
        self.ui_dir = os.path.join(self_dir, './')
        ui_file = os.path.join(self.ui_dir, 'MainWindow.ui')
        loadUi(ui_file, self)

        # Connect HMI events to callbacks
        self.startAutoExButton_1.clicked.connect(self.start_auto_ex_button1_callback)
        self.pauseMoveButton_1.clicked.connect(self.pause_move_button1_callback)
        self.joyModeButton_1.clicked.connect(self.joy_mode_button1_callback)
        self.resumeMoveButton_1.clicked.connect(self.resume_move_button1_callback)
        self.stopMoveButton_1.clicked.connect(self.stop_move_button1_callback)
        self.speedHorizontalSlider_1.valueChanged.connect(self.speed_slider_change_value1_callback)
        self.pushButtonDisableMove.clicked.connect(self.disable_move_button_callback)
        self.pushButtonGetPos.clicked.connect(self.get_pos_button_callback)
        self.pushButtonSetPos.clicked.connect(self.set_pos_button_callback)
        self.pushButtonConfirmMovL.clicked.connect(self.confirm_movl_button_callback)
        self.pushButtonConfirmMovJ.clicked.connect(self.confirm_movj_button_callback)
        self.pushButtonPos0.clicked.connect(self.button_Pos0_callback)
        self.pushButtonPos1.clicked.connect(self.button_Pos1_callback)
        self.pushButtonPos2.clicked.connect(self.button_Pos2_callback)
        self.pushButtonPos3.clicked.connect(self.button_Pos3_callback)
        self.pushButtonPos4.clicked.connect(self.button_Pos4_callback)
        self.pushButtonCal.clicked.connect(self.button_cali_callback)
        self.pushButtonGetMarker.clicked.connect(self.button_cali_get_marker_callback)
        self.radioButtonTool0.clicked.connect(self.button_set_tool_callback)
        self.radioButtonTool1.clicked.connect(self.button_set_tool_callback)
        self.radioButtonTool2.clicked.connect(self.button_set_tool_callback)

        #Init ROS node and subscribe topics
        rospy.init_node('HMINode', anonymous=True)
        rospy.Subscriber("kr1/kr_state", kr_robot_state_Type, self.kr1_krstate_callback)
        #rospy.wait_for_service('kr1/kr_start_autoext_mode')
        rospy.Subscriber("/aruco_single/pixel", PointStamped, self.aruco_pixel_callback)
        rospy.Subscriber("/camera/color/camera_info", CameraInfo, self.camera_info_callback)
        rospy.Subscriber("/camera/aligned_depth_to_color/image_raw", Image, self.depth_image_callback)

        self.speedHorizontalSlider_1.setValue(5)
        #rospy.Timer(rospy.Duration(0.01), self.send_tf)

    # Close/Exit
    def gui_close(self):
        self.close()

    def send_tf(self, msg):
        br = tf.TransformBroadcaster()
        br.sendTransform((self.tf_cam_robot.transform.translation.x,
                          self.tf_cam_robot.transform.translation.y,
                          self.tf_cam_robot.transform.translation.z),
                         (self.tf_cam_robot.transform.rotation.x,
                          self.tf_cam_robot.transform.rotation.y,
                          self.tf_cam_robot.transform.rotation.z,
                          self.tf_cam_robot.transform.rotation.w),
                          rospy.Time.now(),
                          "camera_color_optical_frame",
                          "base_link")

    # HMI event callbacks
    def start_auto_ex_button1_callback(self):
        print "Start auto ext."
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_start_autoext_mode', kr_dummy_Args)
            resp = rosfunc(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def pause_move_button1_callback(self):
        print "Pause move."
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
            resp = rosfunc(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joy_mode_button1_callback(self):
        print "Joy Stick Mode."
        os.system("roslaunch learning_joy joy_stick.launch")

    def resume_move_button1_callback(self):
        print "Resume move."
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
            resp = rosfunc(0)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def stop_move_button1_callback(self):
        self.stop_move()

    def speed_slider_change_value1_callback(self, value):
        self.set_speed(value)

    def disable_move_button_callback(self):
        self.disable_move()

    # ------------------ Joy test ------------------
    # -------Z--------
    def joytest_pz_pressed_button_callback(self):
        self.timerpz.timeout.connect(self.pz)
        self.timerpz.start(50)
    def joytest_pz_released_button_callback(self):
        self.timerpz.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def pz(self):
        print 'mov_test z +10...'
        try:
            if self.joyTestRadioButtonB.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
            if self.joyTestRadioButtonA.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 10
            req.A = 0
            req.B = 0
            req.C = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_nz_pressed_button_callback(self):
        self.timernz.timeout.connect(self.nz)
        self.timernz.start(50)
        #test
        print '!!! nz pressed !!!' 

    def joytest_nz_released_button_callback(self):
        self.timernz.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
        #test
        print '!!! nz released !!!' 

    def nz(self):
        print 'mov_test z -10...'
        try:
            if self.joyTestRadioButtonB.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
            if self.joyTestRadioButtonA.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = -10
            req.A = 0
            req.B = 0
            req.C = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # -------Y--------
    def joytest_py_pressed_button_callback(self):
        self.timerpy.timeout.connect(self.py)
        self.timerpy.start(50)
    def joytest_py_released_button_callback(self):
        self.timerpy.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def py(self):
        print 'mov_test y 10...'
        try:
            if self.joyTestRadioButtonB.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
            if self.joyTestRadioButtonA.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req.X = 0
            req.Y = 10
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_ny_pressed_button_callback(self):
        self.timerny.timeout.connect(self.ny)
        self.timerny.start(50)
    def joytest_ny_released_button_callback(self):
        self.timerny.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def ny(self):
        print 'mov_test y -10...'
        try:
            if self.joyTestRadioButtonB.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
            if self.joyTestRadioButtonA.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req.X = 0
            req.Y = -10
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # -------X--------
    def joytest_px_pressed_button_callback(self):
        self.timerpx.timeout.connect(self.px)
        self.timerpx.start(50)
    def joytest_px_released_button_callback(self):
        self.timerpx.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def px(self):
        print 'mov_test x 10...'
        try:
            if self.joyTestRadioButtonB.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
            if self.joyTestRadioButtonA.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req.X = 10
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_nx_pressed_button_callback(self):
        self.timernx.timeout.connect(self.nx)
        self.timernx.start(50)
    def joytest_nx_released_button_callback(self):
        self.timernx.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def nx(self):
        print 'mov_test x -10...'
        try:
            if self.joyTestRadioButtonB.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
            if self.joyTestRadioButtonA.isChecked() == True:
                rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req.X = -10
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    #------A1---------
    def joytest_pa1_pressed_button_callback(self):
        self.timerpa1.timeout.connect(self.pa1)
        self.timerpa1.start(50)
    def joytest_pa1_released_button_callback(self):
        self.timerpa1.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def pa1(self):
        print 'mov_test a1 0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0.5
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_na1_pressed_button_callback(self):
        self.timerna1.timeout.connect(self.na1)
        self.timerna1.start(50)
    def joytest_na1_released_button_callback(self):
        self.timerna1.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def na1(self):
        print 'mov_test a1 -0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = -0.5
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    #-------A2--------
    def joytest_pa2_pressed_button_callback(self):
        self.timerpa2.timeout.connect(self.pa2)
        self.timerpa2.start(50)

    def joytest_pa2_released_button_callback(self):
        self.timerpa2.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def pa2(self):
        print 'mov_test a2 0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0.5
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_na2_pressed_button_callback(self):
        self.timerna2.timeout.connect(self.na2)
        self.timerna2.start(50)

    def joytest_na2_released_button_callback(self):
        self.timerna2.stop()
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)

    def na2(self):
        print 'mov_test a2 -0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = -0.5
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # ------A3---------
    def joytest_pa3_pressed_button_callback(self):
        self.timerpa3.timeout.connect(self.pa3)
        self.timerpa3.start(50)

    def joytest_pa3_released_button_callback(self):
        self.timerpa3.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def pa3(self):
        print 'mov_test a3 0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0.5
            req.A4 = 0
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_na3_pressed_button_callback(self):
        self.timerna3.timeout.connect(self.na3)
        self.timerna3.start(50)

    def joytest_na3_released_button_callback(self):
        self.timerna3.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)

    def na3(self):
        print 'mov_test a3 -0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = -0.5
            req.A4 = 0
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    # ------A4---------
    def joytest_pa4_pressed_button_callback(self):
        self.timerpa4.timeout.connect(self.pa4)
        self.timerpa4.start(50)

    def joytest_pa4_released_button_callback(self):
        self.timerpa4.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)

    def pa4(self):
        print 'mov_test a4 0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0.5
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_na4_pressed_button_callback(self):
        self.timerna4.timeout.connect(self.na4)
        self.timerna4.start(50)

    def joytest_na4_released_button_callback(self):
        self.timerna4.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def na4(self):
        print 'mov_test a4 -0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = -0.5
            req.A5 = 0
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # ------A5---------
    def joytest_pa5_pressed_button_callback(self):
        self.timerpa5.timeout.connect(self.pa5)
        self.timerpa5.start(50)

    def joytest_pa5_released_button_callback(self):
        self.timerpa5.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)

    def pa5(self):
        print 'mov_test a5 0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0.5
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_na5_pressed_button_callback(self):
        self.timerna5.timeout.connect(self.na5)
        self.timerna5.start(50)

    def joytest_na5_released_button_callback(self):
        self.timerna5.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)

    def na5(self):
        print 'mov_test a5 -0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = -0.5
            req.A4 = 0
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    # ------A6---------
    def joytest_pa6_pressed_button_callback(self):
        self.timerpa6.timeout.connect(self.pa6)
        self.timerpa6.start(50)

    def joytest_pa6_released_button_callback(self):
        self.timerpa6.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)
    def pa6(self):
        print 'mov_test a6 0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0.5
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def joytest_na6_pressed_button_callback(self):
        self.timerna6.timeout.connect(self.na6)
        self.timerna6.start(50)

    def joytest_na6_released_button_callback(self):
        self.timerna6.stop()
        rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        if self.stopCodeLabel_1.text() == "Norm:0":
            rosfunc(2)

    def na6(self):
        print 'mov_test a6 -0.5d...'
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = -0.5
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
 
    def showTargetInfo(self):
        poseTxt = "{:4.0f},{:4.0f},{:4.0f}, A{:4.0f},{:4.0f},{:4.0f}"
        self.labelTarget.setText(poseTxt.format(self.target_pose.X, 
                                                self.target_pose.Y, 
                                                self.target_pose.Z, 
                                                self.target_pose.A, 
                                                self.target_pose.B, 
                                                self.target_pose.C))

    def get_pos_button_callback(self):
        self.target_pose.X = self.cur_pose.X
        self.target_pose.Y = self.cur_pose.Y
        self.target_pose.Z = self.cur_pose.Z
        self.target_pose.A = self.cur_pose.A
        self.target_pose.B = self.cur_pose.B
        self.target_pose.C = self.cur_pose.C
        self.target_pose.S = self.cur_pose.S
        self.target_pose.T = self.cur_pose.T
        self.textAbsX.setPlainText("{:4.0f}".format(self.target_pose.X)) 
        self.textAbsY.setPlainText("{:4.0f}".format(self.target_pose.Y)) 
        self.textAbsZ.setPlainText("{:4.0f}".format(self.target_pose.Z)) 
        self.textAbsA.setPlainText("{:4.0f}".format(self.target_pose.A)) 
        self.textAbsB.setPlainText("{:4.0f}".format(self.target_pose.B)) 
        self.textAbsC.setPlainText("{:4.0f}".format(self.target_pose.C)) 
        self.showTargetInfo()

    def set_pos_button_callback(self):
        self.target_pose.X = float(self.textAbsX.toPlainText()) 
        self.target_pose.Y = float(self.textAbsY.toPlainText()) 
        self.target_pose.Z = float(self.textAbsZ.toPlainText()) 
        self.target_pose.A = float(self.textAbsA.toPlainText()) 
        self.target_pose.B = float(self.textAbsB.toPlainText()) 
        self.target_pose.C = float(self.textAbsC.toPlainText()) 
        self.showTargetInfo()

    def button_Pos0_callback(self):
        self.target_pose.X = float(self.textAbsX_P_0.toPlainText()) 
        self.target_pose.Y = float(self.textAbsY_P_0.toPlainText()) 
        self.target_pose.Z = float(self.textAbsZ_P_0.toPlainText()) 
        self.target_pose.A = float(self.textAbsA_0.toPlainText()) 
        self.target_pose.B = float(self.textAbsB_0.toPlainText()) 
        self.target_pose.C = float(self.textAbsC_0.toPlainText()) 
        self.target_pose.S = int(self.textAbsS_0.toPlainText(), 16)
        self.target_pose.T = int(self.textAbsT_0.toPlainText(), 16)
        self.showTargetInfo()

    def button_Pos1_callback(self):
        self.target_pose.X = float(self.textAbsX_P_1.toPlainText()) 
        self.target_pose.Y = float(self.textAbsY_P_1.toPlainText()) 
        self.target_pose.Z = float(self.textAbsZ_P_1.toPlainText()) 
        self.target_pose.A = float(self.textAbsA_1.toPlainText()) 
        self.target_pose.B = float(self.textAbsB_1.toPlainText()) 
        self.target_pose.C = float(self.textAbsC_1.toPlainText()) 
        self.target_pose.S = int(self.textAbsS_1.toPlainText(), 16)
        self.target_pose.T = int(self.textAbsT_1.toPlainText(), 16)
        self.showTargetInfo()

    def button_Pos2_callback(self):
        self.target_pose.X = float(self.textAbsX_P_2.toPlainText()) 
        self.target_pose.Y = float(self.textAbsY_P_2.toPlainText()) 
        self.target_pose.Z = float(self.textAbsZ_P_2.toPlainText()) 
        self.target_pose.A = float(self.textAbsA_2.toPlainText()) 
        self.target_pose.B = float(self.textAbsB_2.toPlainText()) 
        self.target_pose.C = float(self.textAbsC_2.toPlainText()) 
        self.target_pose.S = int(self.textAbsS_2.toPlainText(), 16)
        self.target_pose.T = int(self.textAbsT_2.toPlainText(), 16)
        self.showTargetInfo()

    def button_Pos3_callback(self):
        self.target_pose.X = float(self.textAbsX_P_3.toPlainText()) 
        self.target_pose.Y = float(self.textAbsY_P_3.toPlainText()) 
        self.target_pose.Z = float(self.textAbsZ_P_3.toPlainText()) 
        self.target_pose.A = float(self.textAbsA_3.toPlainText()) 
        self.target_pose.B = float(self.textAbsB_3.toPlainText()) 
        self.target_pose.C = float(self.textAbsC_3.toPlainText()) 
        self.target_pose.S = int(self.textAbsS_3.toPlainText(), 16)
        self.target_pose.T = int(self.textAbsT_3.toPlainText(), 16)
        self.showTargetInfo()

    def button_Pos4_callback(self):
        self.target_pose.X = float(self.textAbsX_P_4.toPlainText()) 
        self.target_pose.Y = float(self.textAbsY_P_4.toPlainText()) 
        self.target_pose.Z = float(self.textAbsZ_P_4.toPlainText()) 
        self.target_pose.A = float(self.textAbsA_4.toPlainText()) 
        self.target_pose.B = float(self.textAbsB_4.toPlainText()) 
        self.target_pose.C = float(self.textAbsC_4.toPlainText()) 
        self.target_pose.S = int(self.textAbsS_4.toPlainText(), 16)
        self.target_pose.T = int(self.textAbsT_4.toPlainText(), 16)
        self.showTargetInfo()

    def confirm_movl_button_callback(self):
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movl_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req = self.target_pose
            req.S = 0
            req.T = 0
            print req 
            resp = rosfunc(req)
            return resp.response

        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def confirm_movj_button_callback(self):
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_movj_bypose', kr_mv_bypose_Args)
            req = kr_pose_Type()
            req = self.target_pose
            print req 
            resp = rosfunc(req)
            return resp.response

        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    #----------------------- Joint Test ---------------------#
                                          
    def movl_completion(self):
        response = self.confirm_movl_button_callback()

        if response == None:
            print "response = None, aborted"
            return False

        timeout = rospy.Time.now() + rospy.Duration(40)

        start = 0
        while rospy.Time.now() < timeout:

            if self.cancel_signal == True:
                print "[MOVE] stop pressed"
                return False

            if int(self.robot_state.com_error_no) != 0:
                print "[MOVE] error"
                return False
          
            if start == 0:
               if self.action == True:
                  print "\n[MOVE] started"
                  start = 1
            elif self.action == False: # start = 1
                 print "\n[MOVE] motion completed"
                 return True

            if rospy.Time.now() >= timeout:
                print "[MOVE] timeout"

        return False

    def unit_vector(self, v):
        return v / np.linalg.norm(v)

    # ------------------ Joy test ------------------

    # ROS topic subscriber callback for front robot arm (kr1)
    def kr1_krstate_callback(self, msg):
        refreshHz = 1.0 / (msg.timestamp - self.prevKr1StateTimestamp)
        self.prevKr1StateTimestamp = msg.timestamp
	
        if msg.com_action != 0 or (msg.vel_axis_act[0] >= 0.01 or msg.vel_axis_act[0] <= -0.01) or (msg.vel_axis_act[1] >= 0.01 or msg.vel_axis_act[1] <= -0.01) or (msg.vel_axis_act[2] >= 0.01 or msg.vel_axis_act[2] <= -0.01) or (msg.vel_axis_act[3] >= 0.01 or msg.vel_axis_act[3] <= -0.01) or (msg.vel_axis_act[4] >= 0.01 or msg.vel_axis_act[4] <= -0.01) or (msg.vel_axis_act[5] >= 0.01 or msg.vel_axis_act[5] <= -0.01):
            self.action = True
        else:
            self.action = False

        self.init_kuka(msg)

        self.update_count += 1
        if self.update_count < 200 / refreshHz:
            return

        self.update_count = 0

        refreshTxt = "{: 5.2f}Hz"

        self.refreshLabel_1.setText(refreshTxt.format(refreshHz))

        self.krcModeLabel_1.setText("Mode:" + msg.mode_op)
        if msg.com_autext_start == True:
            self.autoExLabel_1.setText("AutoEx:Y")
            self.startAutoExButton_1.setEnabled(False)
        else:
            self.autoExLabel_1.setText("AutoEx:N")
            self.startAutoExButton_1.setEnabled(True)

        self.actionCodeLabel_1.setText("Act:" + str(msg.com_action))

        if msg.com_motstop == 0:
            self.resumeMoveButton_1.setEnabled(False)
            self.stopCodeLabel_1.setText("Norm:0")
        elif msg.com_motstop == 1:
            self.resumeMoveButton_1.setEnabled(True)
            self.stopCodeLabel_1.setText("Pause:1")
        else:
            self.resumeMoveButton_1.setEnabled(False)
            self.stopCodeLabel_1.setText("Stop:2")

        self.errorCodeLabel_1.setText("Err:" + str(msg.com_error_no))

        jointsTxt = "{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f}"
        self.jointsLabel_1.setText(jointsTxt.format(msg.axis_fb.A1, msg.axis_fb.A2, msg.axis_fb.A3, msg.axis_fb.A4, msg.axis_fb.A5, msg.axis_fb.A4))

        poseTxt = "{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f} (ST: 0x{:1X} 0x{:2X})"
        self.poseLabel_1.setText(poseTxt.format(msg.pos_fb.X, msg.pos_fb.Y, msg.pos_fb.Z, msg.pos_fb.A, msg.pos_fb.B, msg.pos_fb.C, (int)(msg.pos_fb.S), (int)(msg.pos_fb.T))) 

        self.cur_pose = msg.pos_fb      
        self.robot_state = msg

        tempTxt = "{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f}"
        self.tempLabel_1.setText(tempTxt.format(msg.mot_temp[0], msg.mot_temp[1], msg.mot_temp[2], msg.mot_temp[3], msg.mot_temp[4], msg.mot_temp[5]))
        currTxt = "{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f},{: 4.0f}"
        self.currentLabel_1.setText(currTxt.format(msg.curr_act[0], msg.curr_act[1], msg.curr_act[2], msg.curr_act[3], msg.curr_act[4], msg.curr_act[5]))
        self.speedLabel_1.setText(str(msg.ov_pro) + "%")
        self.lastMoveTLabel_1.setText(str(msg.com_last_mot_time) + "ms")
    # ROS topic subscriber callback for rear robot arm (kr2)

    def init_kuka(self, msg):
        if self.kr_init == False:
           if msg.ov_pro != self.speed:
              self.speedHorizontalSlider_1.setValue(self.speed)
    
           res = self.set_tool()
           if res == None:
              return
    
           if msg.com_autext_start != True:
              res = self.start_auto_ex()
              if res == None:
                 return
    
           if msg.com_motstop != 0:
              self.stop_move() 
    
           print "kuka setting ok"
           self.kr_init = True 

    def stop_move(self):
        print "Stop move."
        self.cancel_signal = True

        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
            resp = rosfunc(2)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def start_auto_ex(self):
        print "Start auto ext."
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_start_autoext_mode', kr_dummy_Args)
            resp = rosfunc(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    
    def set_speed(self, value):
        print "Set speed scale = " + str(value) + "%"
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_set_speedscale', kr_set_speed_scale_Args)
            resp = rosfunc(value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def disable_move(self):
        print "disable move"
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_set_moveenable_signal',  kr_set_bool_Args)
            resp = rosfunc(False)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def set_cali_tool(self):
        print "set cali_tool"
        self.use_tool2 = False

        req =  kr_pose_Type()
        if(self.radioButtonTool0.isChecked()):
          req.Z = 5
        elif(self.radioButtonTool1.isChecked()):
          req.Z = 290

        req.X = 0 
        req.Y = 0 
        req.A = 0 
        req.B = 0 
        req.C = 0 
        req.S = 0 
        req.T = 0 

        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_set_tool_coord',  kr_mv_bypose_Args)
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def set_tool0(self):
        print "set tool0"
        req =  kr_pose_Type()
        req.X = 0 
        req.Y = 0 
        req.Z = 0
        req.A = 0 
        req.B = 0 
        req.C = 0 
        req.S = 0 
        req.T = 0 
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_set_tool_coord',  kr_mv_bypose_Args)
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def set_tool1(self):
        print "set tool1"
        req =  kr_pose_Type()
        req.X = 0 
        req.Y = 50 
        req.Z = 285/2
        req.A = 0 
        req.B = 0 
        req.C = 0 
        req.S = 0 
        req.T = 0 
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_set_tool_coord',  kr_mv_bypose_Args)
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def set_tool2(self):
        print "set tool2"
        req =  kr_pose_Type()
        req.X = -90 
        req.Y = 0
        req.Z = 260
        req.A = 0 
        req.B = -35
        req.C = 0 
        req.S = 0 
        req.T = 0 
        try:
            rosfunc = rospy.ServiceProxy('/kr1/kr_set_tool_coord',  kr_mv_bypose_Args)
            resp = rosfunc(req)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def get_tf_point(self, point):
        ps = PointStamped()
        ps.point = point
        return tf2_geometry_msgs.do_transform_point(ps, self.tf_cam_robot).point

    def get_data_from_tf(self):
        p0 = self.get_tf_point(Point(x = 0, y = 0, z = 0.6))
        c  = self.get_tf_point(Point(x = 0, y = 0, z = 0.0))
        xd = self.get_tf_point(Point(x = 1, y = 0, z = 0))
        yd = self.get_tf_point(Point(x = 0, y = 1, z = 0))
        zd = self.get_tf_point(Point(x = 0, y = 0, z = 1))

        p0 = np.array([p0.x, p0.y, p0.z])
        c  = np.array([c.x, c.y, c.z])
        xd = (np.array([xd.x, xd.y, xd.z]) - c) * 0.001
        yd = (np.array([yd.x, yd.y, yd.z]) - c) * 0.001
        zd = (np.array([zd.x, zd.y, zd.z]) - c) * 0.001

        return [p0, xd, yd, zd]

    def button_cali_callback(self, arg):
        if not self.thread1 or self.thread1.is_alive() == False:
           self.thread1 = Thread(target = self.cali_task0)
           self.thread1.start()

    def cali_task0(self):
        if(self.radioButtonTool2.isChecked()):
          self.cali_msg("ERROR: Tool 2 selected")
          return

        ret = self.cali_task()
        self.cali_msg(ret)

    def cali_task(self):
        self.set_cali_tool()
        self.cancel_signal = False

        pos0 = kr_pose_Type()
        pos0.X = self.cur_pose.X
        pos0.Y = self.cur_pose.Y
        pos0.Z = self.cur_pose.Z

        self.target_pose.A = 90 #self.cur_pose.A
        self.target_pose.B = 0 #self.cur_pose.B
        self.target_pose.C = -180 #self.cur_pose.C
        self.target_pose.S = self.cur_pose.S
        self.target_pose.T = self.cur_pose.T
 
        p0 = np.array([ 1.200, 0.180,  0.250])
        xd = np.array([-6.81542855e-05, -1.00059779e-03,  5.19577597e-05])
        yd = np.array([-3.17636571e-04, -2.78144165e-05, -9.52299281e-04])
        zd = np.array([ 9.50264466e-04, -8.10615424e-05, -3.14590248e-04])

        robot_pos = np.ones((35, 4))

        robot_pos[0, 0:3] = p0 + zd * 150
        robot_pos[1, 0:3] = p0 + zd * 155 - xd * 100 / 2 + yd * 100 / 2
        robot_pos[2, 0:3] = p0 + zd * 160 - xd * 102 / 2 - yd * 102 / 2
        robot_pos[3, 0:3] = p0 + zd * 165 + xd * 104 / 2 - yd * 104 / 2
        robot_pos[4, 0:3] = p0 + zd * 170 + xd * 106 / 2 + yd * 106 / 2
        robot_pos[5, 0:3] = p0 + zd * 175
        robot_pos[6, 0:3] = p0 + zd * 180 - xd * 108 / 2 + yd * 108 / 2 
        robot_pos[7, 0:3] = p0 + zd * 185 - xd * 110 / 2 - yd * 110 / 2 
        robot_pos[8, 0:3] = p0 + zd * 190 + xd * 112 / 2 - yd * 112 / 2 
        robot_pos[9, 0:3] = p0 + zd * 195 + xd * 114 / 2 + yd * 114 / 2 

        marker_pos = np.ones(robot_pos[0:35].shape)

        new_data = 10
        min_err = 1000
        err = 1000
        tf_result = []

        for i, marker in enumerate(marker_pos):

            if i == new_data:
               [p0, xd, yd, zd] = self.get_data_from_tf()

               robot_pos[new_data + 0, 0:3] = p0 + zd *  0 
               robot_pos[new_data + 1, 0:3] = p0 + zd *  5  - xd * 113 / 2 + yd * 100 / 2
               robot_pos[new_data + 2, 0:3] = p0 + zd *  10 - xd * 116 / 2 - yd * 102 / 2
               robot_pos[new_data + 3, 0:3] = p0 + zd *  15 + xd * 119 / 2 - yd * 104 / 2
               robot_pos[new_data + 4, 0:3] = p0 + zd *  20 + xd * 122 / 2 + yd * 106 / 2
               robot_pos[new_data + 5, 0:3] = p0 + zd *  25 
               robot_pos[new_data + 6, 0:3] = p0 + zd *  30 - xd * 125 / 2 + yd * 108 / 2
               robot_pos[new_data + 7, 0:3] = p0 + zd *  35 - xd * 128 / 2 - yd * 110 / 2
               robot_pos[new_data + 8, 0:3] = p0 + zd *  40 + xd * 131 / 2 - yd * 112 / 2
               robot_pos[new_data + 9, 0:3] = p0 + zd *  45 + xd * 134 / 2 + yd * 114 / 2
               robot_pos[new_data + 10, 0:3] = p0 + zd *  50 
               robot_pos[new_data + 11, 0:3] = p0 + zd *  55 - xd * 137 / 2 + yd * 116 / 2
               robot_pos[new_data + 12, 0:3] = p0 + zd *  60 - xd * 140 / 2 - yd * 118 / 2
               robot_pos[new_data + 13, 0:3] = p0 + zd *  65 + xd * 143 / 2 - yd * 120 / 2
               robot_pos[new_data + 14, 0:3] = p0 + zd *  70 + xd * 146 / 2 + yd * 122 / 2
               robot_pos[new_data + 15, 0:3] = p0 + zd *  75 
               robot_pos[new_data + 16, 0:3] = p0 + zd *  80 - xd * 149 / 2 + yd * 124 / 2
               robot_pos[new_data + 17, 0:3] = p0 + zd *  85 - xd * 152 / 2 - yd * 126 / 2
               robot_pos[new_data + 18, 0:3] = p0 + zd *  90 + xd * 155 / 2 - yd * 128 / 2
               robot_pos[new_data + 19, 0:3] = p0 + zd *  95 + xd * 158 / 2 + yd * 130 / 2
               robot_pos[new_data + 20, 0:3] = p0 + zd * 100
               robot_pos[new_data + 21, 0:3] = p0 + zd * 105 - xd * 161 / 2 + yd * 132 / 2
               robot_pos[new_data + 22, 0:3] = p0 + zd * 110 - xd * 164 / 2 - yd * 134 / 2
               robot_pos[new_data + 23, 0:3] = p0 + zd * 115 + xd * 167 / 2 - yd * 136 / 2
               robot_pos[new_data + 24, 0:3] = p0 + zd * 120 + xd * 170 / 2 + yd * 138 / 2

            self.labelCal.setText("(sample: 0 ~ {:d})\n\nposition {:d}...".format((np.size(marker_pos, 0) - 1), i))

            self.target_pose.X = robot_pos[i, 0] * 1000 
            self.target_pose.Y = robot_pos[i, 1] * 1000 
            self.target_pose.Z = robot_pos[i, 2] * 1000 

            if self.movl_completion() == False:
              return "ERROR: MOVE"

            rospy.sleep(0.5)

            if (rospy.Time.now() - self.aruco_stamp) > rospy.Duration.from_sec(0.2):
              return "ERROR: NO MARKER"

            if (rospy.Time.now() - self.depth_stamp) > rospy.Duration.from_sec(0.2):
              return "ERROR: NO DEPTH CAMERA INFO"

            marker[0:3] = [self.marker_point.x, self.marker_point.y, self.marker_point.z]

            self.get_tf_cali(marker_pos[0:i+1], robot_pos[0:i+1])

            if i >= 6:
              self.set_cali_result()

              err = self.get_marker_error()

              if min_err > err:
                 min_err = err
                 tf_result = copy.deepcopy(self.tf_cam_robot)

            if i == new_data - 1 and err > 300:
               return "ERROR: TF"

        self.speedHorizontalSlider_1.setValue(10)

        self.target_pose.X = robot_pos[0, 0] * 1000 
        self.target_pose.Y = robot_pos[0, 1] * 1000 
        self.target_pose.Z = robot_pos[0, 2] * 1000 

        if self.movl_completion() == False:
            return "ERROR: MOVE"

        self.tf_cali = tf_result
        self.set_cali_result()

        txt = "\nerr(mm): {:3.1f}".format(min_err)
        self.labelCal.setText(txt)

        print "\nTF Result:\n\n" + str(self.tf_cali.transform)
        print txt 

        if min_err > 5:
           return "ERROR: RESULT"

        self.write_yaml()
        return "SUCCESSFUL"

    def write_yaml(self):
        data = {'x':  float(self.tf_cali.transform.translation.x), 
                'y':  float(self.tf_cali.transform.translation.y),
                'z':  float(self.tf_cali.transform.translation.z),
                'rx': float(self.tf_cali.transform.rotation.x),
                'ry': float(self.tf_cali.transform.rotation.y),
                'rz': float(self.tf_cali.transform.rotation.z),
                'rw': float(self.tf_cali.transform.rotation.w)}

        path = os.path.join("/home", os.environ["USER"], "poc")
        if not os.path.exists(path):
            os.makedirs(path)

        filename = os.path.join(path, "remover.yaml")
        with open(filename, "w") as f:
          yaml.dump(data, f)

    def get_tf_cali(self, marker_pos, robot_pos): 
        mat = np.dot(robot_pos.T, np.linalg.pinv(marker_pos.T))
        q = tf.transformations.quaternion_from_matrix(mat)

        self.tf_cali.transform.translation.x = mat[0, 3] 
        self.tf_cali.transform.translation.y = mat[1, 3] 
        self.tf_cali.transform.translation.z = mat[2, 3] 
        euler = tf.transformations.euler_from_quaternion(q)
        q = tf.transformations.quaternion_from_euler(euler[0], euler[1],euler[2])
        self.tf_cali.transform.rotation.x = q[0]  
        self.tf_cali.transform.rotation.y = q[1]  
        self.tf_cali.transform.rotation.z = q[2]  
        self.tf_cali.transform.rotation.w = q[3]  

    def set_cali_result(self):
        self.tf_cam_robot.transform.translation.x = self.tf_cali.transform.translation.x
        self.tf_cam_robot.transform.translation.y = self.tf_cali.transform.translation.y
        self.tf_cam_robot.transform.translation.z = self.tf_cali.transform.translation.z
        self.tf_cam_robot.transform.rotation.x    = self.tf_cali.transform.rotation.x
        self.tf_cam_robot.transform.rotation.y    = self.tf_cali.transform.rotation.y
        self.tf_cam_robot.transform.rotation.z    = self.tf_cali.transform.rotation.z
        self.tf_cam_robot.transform.rotation.w    = self.tf_cali.transform.rotation.w

    def aruco_pixel_callback(self, arg):
        self.aruco_pixel = arg

    def camera_info_callback(self, info):
        if not self.valid_camera_info:
            self.model.fromCameraInfo(info)
            self.valid_camera_info = True

    def depth_image_callback(self, depth_image):
        if self.valid_camera_info == False:
           return

        pixel = self.aruco_pixel.point
        i = int(depth_image.width * int(pixel.y) * 2 + int(pixel.x) * 2)
        depth = int(depth_image.data[i].encode('hex'), 16) + int(depth_image.data[i + 1].encode('hex'), 16) * 256

        if depth == 0:
           return

        self.depth_stamp = depth_image.header.stamp 
        self.aruco_stamp = self.aruco_pixel.header.stamp 

        depth = float(depth) / 1000.0
        ray = self.model.projectPixelTo3dRay((pixel.x, pixel.y))
        ray_z = [el / ray[2] for el in ray]
        pt = [el * depth for el in ray_z]
        self.marker_point.x = pt[0]
        self.marker_point.y = pt[1]
        self.marker_point.z = pt[2]

    def get_marker_error(self):
        p = self.get_tf_point(self.marker_point) 

        dis = math.sqrt((self.cur_pose.X - p.x * 1000) ** 2 +
                        (self.cur_pose.Y - p.y * 1000) ** 2 +
                        (self.cur_pose.Z - p.z * 1000) ** 2)

        marker_error = "\nmarker error(mm):\n\n {: 5.1f}\n".format(dis)
        
        self.labelCal_2.setText(marker_error)

        return dis

    def cali_msg(self, arg):
        msg = QMessageBox()

        if "ERROR" in arg: 
          msg.setIcon(QMessageBox.Critical)
          self.labelCal.setText("")
        else:
          msg.setIcon(QMessageBox.Information)

        msg.setText(arg)
        msg.setWindowTitle("Calibration")
        msg.exec_()

    def button_cali_get_marker_callback(self, arg):

        if (rospy.Time.now() - self.aruco_stamp) > rospy.Duration.from_sec(0.2):
            self.labelCal_2.setText("\nerror: no marker")
            return

        self.get_marker_error()

    def set_tool(self):
        if(self.radioButtonTool0.isChecked()):
          res = self.set_tool0()
          self.use_tool2 = False
        elif(self.radioButtonTool1.isChecked()):
          res = self.set_tool1()
          self.use_tool2 = False
        else:
          res = self.set_tool2()
          self.use_tool2 = True

        if self.use_tool2 == True:
          self.trimmer_default_pose.A =   60
          self.trimmer_default_pose.B =    0
          self.trimmer_default_pose.C =  180
          self.trimmer_default_pose.X = 1330
          self.trimmer_default_pose.Y = -300
          self.trimmer_default_pose.Z =  900
        else:
          self.trimmer_default_pose.A =  90 #30
          self.trimmer_default_pose.B =  0 #180
          self.trimmer_default_pose.C =  -180 #0
          self.trimmer_default_pose.X = 1200 #1420
          self.trimmer_default_pose.Y = 180 #-350
          self.trimmer_default_pose.Z = 250 #1100
        return res

    def button_set_tool_callback(self, arg):
        self.set_tool()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    myWin = MyMainWindow()
    myWin.show()
    #myWin.showMaximized()
    #myWin.showFullScreen()
    sys.exit(app.exec_())

