#!/usr/bin/env python
# -*- coding: utf-8 -*

import struct, os, sys
import rospy, roslaunch
from python_qt_binding import loadUi
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5 import QtGui, uic
from PyQt5.QtMultimedia import QAudio, QAudioDeviceInfo, QAudioFormat, QAudioOutput
from threading import Thread, Lock

#from PyQt5 import QtWidgets, uic
#from pyqtgraph import PlotWidget
#import pyqtgraph as pg

import yaml
import copy
from datetime import datetime
import signal
import gc
import math
import time
from math import pi, sin

#import pygame, pygame.sndarray
#import numpy
#import scipy.signal

from std_msgs.msg import String
from sensor_msgs.msg import Image
from visualization_msgs.msg import MarkerArray
import cv2
from cv_bridge import CvBridge, CvBridgeError

from kuka_robot.msg import *
from kuka_robot.srv import *
from roadbot_control.msg import *
from roadbot_control.srv import *
from lidar_tracker.msg import *
#from lidar_tracker.srv import *
from system_io.msg import *
from system_io.srv import *
from power_system.msg import *
from power_system.srv import *
from lantern_rack.msg import *
from lantern_rack.srv import *
from vision_system.srv import *

from autocone_hmi import bb, cc

class MyMainWindow(QMainWindow):
    # Init/constructor
    def __init__(self, parent=None):
        super(MyMainWindow, self).__init__(parent)

        # Init variables
        self.prevKr1StateTimestamp = -0.01
        self.prevKr2StateTimestamp = -0.01
        self.prevBirdViewImageTimestamp = -0.01
        self.prevRearViewImageTimestamp = -0.01
        self.prevRadarImageTimestamp = -0.01
        self.prevAcStateTimestamp = -0.01
        self.timerpz = QTimer()
        self.timernz = QTimer()
        self.timerpy = QTimer()
        self.timerny = QTimer()
        self.timerpx = QTimer()
        self.timernx = QTimer()
        self.timerpa = QTimer()
        self.timerna = QTimer()
        self.timerpb = QTimer()
        self.timernb = QTimer()
        self.timerpc = QTimer()
        self.timernc = QTimer()
        self.timerpa1 = QTimer()
        self.timerna1 = QTimer()
        self.timerpa2 = QTimer()
        self.timerna2 = QTimer()
        self.timerpa3 = QTimer()
        self.timerna3 = QTimer()
        self.timerpa4 = QTimer()
        self.timerna4 = QTimer()
        self.timerpa5 = QTimer()
        self.timerna5 = QTimer()
        self.timerpa6 = QTimer()
        self.timerna6 = QTimer()
        self.joyModeIncStep = 0
        self.clone_kr1lt_timestamp = 0
        self.clone_kr2lt_timestamp = 0
        self.clone_kr1_msg = kr_robot_state_Type()
        self.clone_kr2_msg = kr_robot_state_Type()
        self.clone_ac_msg = ac_state_Type()
        self.clone_sio_msg = sio_state_Type()
        self.memStore_msg = []
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.memStore_msg.append(kr_robot_state_Type())
        self.msgKr1BuffMutex = Lock()
        self.msgKr2BuffMutex = Lock()
        self.msgAcBuffMutex = Lock()
        self.run_SystemOnProcedureSkipTime = 0.0
        self.speedPlotDivCounter = 0

        # Load files. Create HMI/gui - by loadui plugin direct create from .ui
        self_dir = os.path.dirname(os.path.realpath(__file__))
        self.ui_dir = os.path.join(self_dir, './')
        ui_file = os.path.join(self.ui_dir, 'MainWindowManual.ui')
        loadUi(ui_file, self)

        # Enable mouse event
        self.setMouseTracking(True)

        # Connect UI events to callbacks
        # ------------------ All Tab ------------------
        self.allMoveStopPushButton_1.clicked.connect(self.allMoveStopPushButton_callback)

        # ------------------ Manual Tab ------------------
        self.startAutoExButton_1.clicked.connect(self.start_auto_ex_button1_callback)
        self.pauseMoveButton_1.clicked.connect(self.pause_move_button1_callback)
        self.resumeMoveButton_1.clicked.connect(self.resume_move_button1_callback)
        self.stopMoveButton_1.clicked.connect(self.stop_move_button1_callback)
        self.disablebutton_1.clicked.connect(self.disable_move_button1_callback)
        self.doUpPushButton_1.clicked.connect(self.doUp_button1_callback)
        self.doLoPushButton_1.clicked.connect(self.doLo_button1_callback)
        self.doValvePushButton_1.clicked.connect(self.doValve_button1_callback)
        self.speedHorizontalSlider_1.valueChanged.connect(self.speed_slider_change_value1_callback)
        self.saveWaypointButton_1.clicked.connect(self.save_waypoint_button1_callback)
        self.goHomeButton_1.clicked.connect(self.goHome_button1_callback)

        self.startAutoExButton_2.clicked.connect(self.start_auto_ex_button2_callback)
        self.pauseMoveButton_2.clicked.connect(self.pause_move_button2_callback)
        self.resumeMoveButton_2.clicked.connect(self.resume_move_button2_callback)
        self.stopMoveButton_2.clicked.connect(self.stop_move_button2_callback)
        self.disablebutton_2.clicked.connect(self.disable_move_button2_callback)
        self.doUpPushButton_2.clicked.connect(self.doUp_button2_callback)
        self.doLoPushButton_2.clicked.connect(self.doLo_button2_callback)
        self.doValvePushButton_2.clicked.connect(self.doValve_button2_callback)
        self.speedHorizontalSlider_2.valueChanged.connect(self.speed_slider_change_value2_callback)
        self.saveWaypointButton_2.clicked.connect(self.save_waypoint_button2_callback)
        self.goHomeButton_2.clicked.connect(self.goHome_button2_callback)
        self.goInvCheckButton.clicked.connect(self.goInvCheck_button_callback)

        self.moveArmSelDial.valueChanged.connect(self.moveArmSelDial_callback)
        self.PA1PushButton.pressed.connect(self.pa1_pressed_button_callback)
        self.PA1PushButton.released.connect(self.pa1_released_button_callback)
        self.NA1PushButton.pressed.connect(self.na1_pressed_button_callback)
        self.NA1PushButton.released.connect(self.na1_released_button_callback)
        self.PA2PushButton.pressed.connect(self.pa2_pressed_button_callback)
        self.PA2PushButton.released.connect(self.pa2_released_button_callback)
        self.NA2PushButton.pressed.connect(self.na2_pressed_button_callback)
        self.NA2PushButton.released.connect(self.na2_released_button_callback)
        self.PA3PushButton.pressed.connect(self.pa3_pressed_button_callback)
        self.PA3PushButton.released.connect(self.pa3_released_button_callback)
        self.NA3PushButton.pressed.connect(self.na3_pressed_button_callback)
        self.NA3PushButton.released.connect(self.na3_released_button_callback)
        self.PA4PushButton.pressed.connect(self.pa4_pressed_button_callback)
        self.PA4PushButton.released.connect(self.pa4_released_button_callback)
        self.NA4PushButton.pressed.connect(self.na4_pressed_button_callback)
        self.NA4PushButton.released.connect(self.na4_released_button_callback)
        self.PA5PushButton.pressed.connect(self.pa5_pressed_button_callback)
        self.PA5PushButton.released.connect(self.pa5_released_button_callback)
        self.NA5PushButton.pressed.connect(self.na5_pressed_button_callback)
        self.NA5PushButton.released.connect(self.na5_released_button_callback)
        self.PA6PushButton.pressed.connect(self.pa6_pressed_button_callback)
        self.PA6PushButton.released.connect(self.pa6_released_button_callback)
        self.NA6PushButton.pressed.connect(self.na6_pressed_button_callback)
        self.NA6PushButton.released.connect(self.na6_released_button_callback)
        self.timerpa1.timeout.connect(self.pa1)
        self.timerna1.timeout.connect(self.na1)
        self.timerpa2.timeout.connect(self.pa2)
        self.timerna2.timeout.connect(self.na2)
        self.timerpa3.timeout.connect(self.pa3)
        self.timerna3.timeout.connect(self.na3)
        self.timerpa4.timeout.connect(self.pa4)
        self.timerna4.timeout.connect(self.na4)
        self.timerpa5.timeout.connect(self.pa5)
        self.timerna5.timeout.connect(self.na5)
        self.timerpa6.timeout.connect(self.pa6)
        self.timerna6.timeout.connect(self.na6)
        self.PXPushButton.pressed.connect(self.px_pressed_button_callback)
        self.PXPushButton.released.connect(self.px_released_button_callback)
        self.NXPushButton.pressed.connect(self.nx_pressed_button_callback)
        self.NXPushButton.released.connect(self.nx_released_button_callback)
        self.PYPushButton.pressed.connect(self.py_pressed_button_callback)
        self.PYPushButton.released.connect(self.py_released_button_callback)
        self.NYPushButton.pressed.connect(self.ny_pressed_button_callback)
        self.NYPushButton.released.connect(self.ny_released_button_callback)
        self.PZPushButton.pressed.connect(self.pz_pressed_button_callback)
        self.PZPushButton.released.connect(self.pz_released_button_callback)
        self.NZPushButton.pressed.connect(self.nz_pressed_button_callback)
        self.NZPushButton.released.connect(self.nz_released_button_callback)
        self.NAPushButton.pressed.connect(self.na_pressed_button_callback)
        self.NAPushButton.released.connect(self.na_released_button_callback)
        self.PAPushButton.pressed.connect(self.pa_pressed_button_callback)
        self.PAPushButton.released.connect(self.pa_released_button_callback)
        self.NBPushButton.pressed.connect(self.nb_pressed_button_callback)
        self.NBPushButton.released.connect(self.nb_released_button_callback)
        self.PBPushButton.pressed.connect(self.pb_pressed_button_callback)
        self.PBPushButton.released.connect(self.pb_released_button_callback)
        self.NCPushButton.pressed.connect(self.nc_pressed_button_callback)
        self.NCPushButton.released.connect(self.nc_released_button_callback)
        self.PCPushButton.pressed.connect(self.pc_pressed_button_callback)
        self.PCPushButton.released.connect(self.pc_released_button_callback)
        self.timerpx.timeout.connect(self.px)
        self.timernx.timeout.connect(self.nx)
        self.timerpy.timeout.connect(self.py)
        self.timerny.timeout.connect(self.ny)
        self.timerpz.timeout.connect(self.pz)
        self.timernz.timeout.connect(self.nz)
        self.timerna.timeout.connect(self.na)
        self.timerpa.timeout.connect(self.pa)
        self.timernb.timeout.connect(self.nb)
        self.timerpb.timeout.connect(self.pb)
        self.timernc.timeout.connect(self.nc)
        self.timerpc.timeout.connect(self.pc)

        self.getCurrentToByPosePushButton.clicked.connect(self.getCurrentToByPosePushButton_callback)
        self.getCurrentToByAnglePushButton.clicked.connect(self.getCurrentToByAnglePushButton_callback)
        self.movJByPosePushButton.clicked.connect(self.movJByPosePushButton_callback)
        self.movLByPosePushButton.clicked.connect(self.movLByPosePushButton_callback)
        self.movJByAnglePushButton.clicked.connect(self.movJByAnglePushButton_callback)
        self.movLByAnglePushButton.clicked.connect(self.movLByAnglePushButton_callback)

        self.memStorePushButton_0.clicked.connect(lambda: self.memStorePushButton_callback(0))
        self.memStorePushButton_1.clicked.connect(lambda: self.memStorePushButton_callback(1))
        self.memStorePushButton_2.clicked.connect(lambda: self.memStorePushButton_callback(2))
        self.memStorePushButton_3.clicked.connect(lambda: self.memStorePushButton_callback(3))
        self.memStorePushButton_4.clicked.connect(lambda: self.memStorePushButton_callback(4))
        self.memStorePushButton_5.clicked.connect(lambda: self.memStorePushButton_callback(5))
        self.memStorePushButton_6.clicked.connect(lambda: self.memStorePushButton_callback(6))
        self.memStorePushButton_7.clicked.connect(lambda: self.memStorePushButton_callback(7))
        self.memStorePushButton_8.clicked.connect(lambda: self.memStorePushButton_callback(8))
        self.memStorePushButton_9.clicked.connect(lambda: self.memStorePushButton_callback(9))
        self.memStorePushButton_10.clicked.connect(lambda: self.memStorePushButton_callback(10))
        self.memStorePushButton_11.clicked.connect(lambda: self.memStorePushButton_callback(11))
        self.memRecallPushButton_0.clicked.connect(lambda: self.memRecallPushButton_callback(0))
        self.memRecallPushButton_1.clicked.connect(lambda: self.memRecallPushButton_callback(1))
        self.memRecallPushButton_2.clicked.connect(lambda: self.memRecallPushButton_callback(2))
        self.memRecallPushButton_3.clicked.connect(lambda: self.memRecallPushButton_callback(3))
        self.memRecallPushButton_4.clicked.connect(lambda: self.memRecallPushButton_callback(4))
        self.memRecallPushButton_5.clicked.connect(lambda: self.memRecallPushButton_callback(5))
        self.memRecallPushButton_6.clicked.connect(lambda: self.memRecallPushButton_callback(6))
        self.memRecallPushButton_7.clicked.connect(lambda: self.memRecallPushButton_callback(7))
        self.memRecallPushButton_8.clicked.connect(lambda: self.memRecallPushButton_callback(8))
        self.memRecallPushButton_9.clicked.connect(lambda: self.memRecallPushButton_callback(9))
        self.memRecallPushButton_10.clicked.connect(lambda: self.memRecallPushButton_callback(10))
        self.memRecallPushButton_11.clicked.connect(lambda: self.memRecallPushButton_callback(11))
        self.memStoreToFilePushButton.clicked.connect(self.memStoreToFilePushButton_callback)
        self.memRecallFromFilePushButton.clicked.connect(self.memRecallFromFilePushButton_callback)

        self.sysOutputPushButton_0.clicked.connect(lambda: self.sysOutputPushButton_callback(0))
        self.sysOutputPushButton_1.clicked.connect(lambda: self.sysOutputPushButton_callback(1))
        self.sysOutputPushButton_2.clicked.connect(lambda: self.sysOutputPushButton_callback(2))
        self.sysOutputPushButton_3.clicked.connect(lambda: self.sysOutputPushButton_callback(3))
        self.sysOutputPushButton_4.clicked.connect(lambda: self.sysOutputPushButton_callback(4))
        self.sysOutputPushButton_5.clicked.connect(lambda: self.sysOutputPushButton_callback(5))
        self.sysOutputPushButton_6.clicked.connect(lambda: self.sysOutputPushButton_callback(6))
        self.sysOutputPushButton_7.clicked.connect(lambda: self.sysOutputPushButton_callback(7))
        self.sysOutputPushButton_8.clicked.connect(lambda: self.sysOutputPushButton_callback(8))
        self.sysOutputPushButton_9.clicked.connect(lambda: self.sysOutputPushButton_callback(9))
        self.sysOutputPushButton_10.clicked.connect(lambda: self.sysOutputPushButton_callback(10))
        self.sysOutputPushButton_11.clicked.connect(lambda: self.sysOutputPushButton_callback(11))
        self.sysOutputPushButton_12.clicked.connect(lambda: self.sysOutputPushButton_callback(12))
        self.sysOutputPushButton_13.clicked.connect(lambda: self.sysOutputPushButton_callback(13))
        self.sysOutputPushButton_14.clicked.connect(lambda: self.sysOutputPushButton_callback(14))
        self.sysOutputPushButton_15.clicked.connect(lambda: self.sysOutputPushButton_callback(15))
        self.sysOutputPushButton_16.clicked.connect(lambda: self.sysOutputPushButton_callback(16))
        self.sysOutputPushButton_17.clicked.connect(lambda: self.sysOutputPushButton_callback(17))

        # Init ROS node, get services and subscribe topics
        rospy.init_node('RoadbotHMINode', anonymous=True, disable_signals=True)
        #rospy.wait_for_service('kr1/kr_start_autoext_mode')
        global kr1_start_autoext_mode
        kr1_start_autoext_mode = rospy.ServiceProxy('/kr1/kr_start_autoext_mode', kr_dummy_Args)
        global kr1_rampdown_stop
        kr1_rampdown_stop = rospy.ServiceProxy('/kr1/kr_rampdown_stop', kr_rampstop_Args)
        global kr1_set_moveenable_signal
        kr1_set_moveenable_signal = rospy.ServiceProxy('/kr1/kr_set_moveenable_signal', kr_set_bool_Args)
        global kr1_set_speedscale
        kr1_set_speedscale = rospy.ServiceProxy('/kr1/kr_set_speedscale', kr_set_speed_scale_Args)
        global kr1_setdigitaloutput
        kr1_setdigitaloutput = rospy.ServiceProxy('/kr1/kr_setdigitaloutput', kr_setdo_Args)
        global kr1_movjreltool_bypose
        kr1_movjreltool_bypose = rospy.ServiceProxy('/kr1/kr_movjreltool_bypose', kr_mv_bypose_Args)
        global kr1_movjrel_bypose
        kr1_movjrel_bypose = rospy.ServiceProxy('/kr1/kr_movjrel_bypose', kr_mv_bypose_Args)
        global kr1_movjrel_byjoint
        kr1_movjrel_byjoint = rospy.ServiceProxy('/kr1/kr_movjrel_byjoint', kr_mv_byjoint_Args)
        global kr1_movj_bypose
        kr1_movj_bypose = rospy.ServiceProxy('/kr1/kr_movj_bypose', kr_mv_bypose_Args)
        global kr1_movl_bypose
        kr1_movl_bypose = rospy.ServiceProxy('/kr1/kr_movl_bypose', kr_mv_bypose_Args)
        global kr1_movj_byjoint
        kr1_movj_byjoint = rospy.ServiceProxy('/kr1/kr_movj_byjoint', kr_mv_byjoint_Args)
        global kr1_movl_byjoint
        kr1_movl_byjoint = rospy.ServiceProxy('/kr1/kr_movl_byjoint', kr_mv_byjoint_Args)
        #rospy.wait_for_service('kr2/kr_start_autoext_mode')
        global kr2_start_autoext_mode
        kr2_start_autoext_mode = rospy.ServiceProxy('/kr2/kr_start_autoext_mode', kr_dummy_Args)
        global kr2_rampdown_stop
        kr2_rampdown_stop = rospy.ServiceProxy('/kr2/kr_rampdown_stop', kr_rampstop_Args)
        global kr2_set_moveenable_signal
        kr2_set_moveenable_signal = rospy.ServiceProxy('/kr2/kr_set_moveenable_signal', kr_set_bool_Args)
        global kr2_set_speedscale
        kr2_set_speedscale = rospy.ServiceProxy('/kr2/kr_set_speedscale', kr_set_speed_scale_Args)
        global kr2_setdigitaloutput
        kr2_setdigitaloutput = rospy.ServiceProxy('/kr2/kr_setdigitaloutput', kr_setdo_Args)
        global kr2_movjreltool_bypose
        kr2_movjreltool_bypose = rospy.ServiceProxy('/kr2/kr_movjreltool_bypose', kr_mv_bypose_Args)
        global kr2_movjrel_bypose
        kr2_movjrel_bypose = rospy.ServiceProxy('/kr2/kr_movjrel_bypose', kr_mv_bypose_Args)
        global kr2_movjrel_byjoint
        kr2_movjrel_byjoint = rospy.ServiceProxy('/kr2/kr_movjrel_byjoint', kr_mv_byjoint_Args)
        global kr2_movj_bypose
        kr2_movj_bypose = rospy.ServiceProxy('/kr2/kr_movj_bypose', kr_mv_bypose_Args)
        global kr2_movl_bypose
        kr2_movl_bypose = rospy.ServiceProxy('/kr2/kr_movl_bypose', kr_mv_bypose_Args)
        global kr2_movj_byjoint
        kr2_movj_byjoint = rospy.ServiceProxy('/kr2/kr_movj_byjoint', kr_mv_byjoint_Args)
        global kr2_movl_byjoint
        kr2_movl_byjoint = rospy.ServiceProxy('/kr2/kr_movl_byjoint', kr_mv_byjoint_Args)
        #rospy.wait_for_service('/control/ac_reload_routes')
        global ac_reload_routes
        ac_reload_routes = rospy.ServiceProxy('/control/ac_reload_routes', ac_set_bool_Args)
        global ac_go_home
        ac_go_home = rospy.ServiceProxy('/control/ac_go_home', ac_set_double_Args)
        global ac_stop_autocontrol
        ac_stop_autocontrol = rospy.ServiceProxy('/control/ac_stop_autocontrol', ac_set_bool_Args)
        global ac_go_coneplace
        ac_go_coneplace = rospy.ServiceProxy('/control/ac_go_coneplace', ac_go_place_Args)
        global ac_go_conecollect
        ac_go_conecollect = rospy.ServiceProxy('/control/ac_go_conecollect', ac_go_collect_Args)
        global ac_change_target
        ac_change_target = rospy.ServiceProxy('/control/ac_change_target', ac_set_double_Args)
        global ac_go_coneinvcheck
        ac_go_coneinvcheck = rospy.ServiceProxy('/control/ac_go_coneinvcheck', ac_set_bool_Args)
        #rospy.wait_for_service('/sys_io/sio_set_system_do')
        global sio_set_system_do
        sio_set_system_do = rospy.ServiceProxy('/sys_io/sio_set_system_do', sio_set_value_Args)
        global sio_set_rear_slider
        sio_set_rear_slider = rospy.ServiceProxy('/sys_io/sio_set_rear_slider', sio_set_bool_Args)
        global sio_set_cone_slider
        sio_set_cone_slider = rospy.ServiceProxy('/sys_io/sio_set_cone_slider', sio_set_bool_Args)
        global sio_set_airpump
        sio_set_airpump = rospy.ServiceProxy('/sys_io/sio_set_airpump', sio_set_bool_Args)
        global sio_set_arrowlight
        sio_set_arrowlight = rospy.ServiceProxy('/sys_io/sio_set_arrowlight', sio_set_bool_Args)
        #rospy.wait_for_service('/pwr_sys/ps_switchon_invertermcb')
        global ps_switchon_invertermcb
        ps_switchon_invertermcb = rospy.ServiceProxy('/pwr_sys/ps_switchon_invertermcb', ps_set_double_Args)
        global ps_switchoff_invertermcb
        ps_switchoff_invertermcb = rospy.ServiceProxy('/pwr_sys/ps_switchoff_invertermcb', ps_set_double_Args)
        #rospy.wait_for_service('/lantern_plc/lr_set_lantern_rack_mode')
        global lr_set_lantern_rack_mode
        lr_set_lantern_rack_mode = rospy.ServiceProxy('/lantern_plc/lr_set_lantern_rack_mode', lr_set_mode_Args)

        rospy.Subscriber("kr1/kr_state_drop", kr_robot_state_Type, self.OnRxKr1StateMsg_callback)
        rospy.Subscriber("kr2/kr_state_drop", kr_robot_state_Type, self.OnRxKr2StateMsg_callback)
        rospy.Subscriber("control/ac_state_drop", ac_state_Type, self.OnRxAcStateMsg_callback)
        rospy.Subscriber("sys_io/sio_state", sio_state_Type, self.OnRxSioStateMsg_callback)

        # Timer for sync GUI update, at 50 Hz
        self.timerBgPE = QTimer()
        self.timerBgPE.timeout.connect(self.bgGUISyncProcessEvent)
        self.timerBgPE.start(20)

    # Callback handling for rx topics msg (tasks created by ROS), to avoid QT GUI cross task accessing
    def OnRxKr1StateMsg_callback(self, msg):
        self.msgKr1BuffMutex.acquire()
        self.clone_kr1_msg = copy.deepcopy(msg)
        self.msgKr1BuffMutex.release()

    def OnRxKr2StateMsg_callback(self, msg):
        self.msgKr2BuffMutex.acquire()
        self.clone_kr2_msg = copy.deepcopy(msg)
        self.msgKr2BuffMutex.release()

    def OnRxAcStateMsg_callback(self, msg):
        self.msgAcBuffMutex.acquire()
        self.clone_ac_msg = copy.deepcopy(msg)
        self.msgAcBuffMutex.release()

    def OnRxSioStateMsg_callback(self, msg):
        self.clone_sio_msg = copy.deepcopy(msg)


    # Timer handling (in GUI task) for sync GUI update, at 50 Hz
    def bgGUISyncProcessEvent(self):
        now_ts = rospy.Time.now()
        now_sec = now_ts.secs + (now_ts.nsecs/1000000000.0)
        if (now_sec - self.clone_sio_msg.timestamp) < 1.0:
            self.updateGUI_SioState()

        if (now_sec - self.clone_kr1_msg.timestamp) < 0.3:
            self.reararmgroupBox.setEnabled(True)
            self.updateGUI_Kr1State()
        else:
            self.reararmgroupBox.setEnabled(False)
        if (now_sec - self.clone_kr2_msg.timestamp) < 0.3:
            self.frontarmgroupBox.setEnabled(True)
            self.updateGUI_Kr2State()
        else:
            self.frontarmgroupBox.setEnabled(False)

        if (now_sec - self.clone_ac_msg.timestamp) < 1.0:
            self.updateGUI_AcState()
        app.processEvents()

    # ROS topic subscriber callback for front robot arm (kr1)
    def updateGUI_Kr1State(self):
        self.msgKr1BuffMutex.acquire()
        msg = copy.copy(self.clone_kr1_msg)
        self.msgKr1BuffMutex.release()
        timeElapsed = msg.timestamp - self.prevKr1StateTimestamp
        self.prevKr1StateTimestamp = msg.timestamp
        if timeElapsed <= 0:
            return
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
        jointsTxt = "{: 6.3f},{: 6.3f},{: 6.3f},{: 6.3f},{: 6.3f},{: 6.3f}"
        self.jointsLabel_1.setText(jointsTxt.format(msg.axis_fb.A1, msg.axis_fb.A2, msg.axis_fb.A3, msg.axis_fb.A4, msg.axis_fb.A5, msg.axis_fb.A6))
        poseTxt = "{: 6.0f},{: 6.0f},{: 6.0f},{: 6.3f},{: 6.3f},{: 6.3f},{: 3.0f},{: 3.0f}"
        self.poseLabel_1.setText(poseTxt.format(msg.pos_fb.X, msg.pos_fb.Y, msg.pos_fb.Z, msg.pos_fb.A, msg.pos_fb.B, msg.pos_fb.C, msg.pos_fb.S, msg.pos_fb.T))
        tempTxt = "{: 6.2f},{: 6.2f},{: 6.2f},{: 6.2f},{: 6.2f},{: 6.2f}"
        self.tempLabel_1.setText(tempTxt.format(msg.mot_temp[0], msg.mot_temp[1], msg.mot_temp[2], msg.mot_temp[3], msg.mot_temp[4], msg.mot_temp[5]))
        currTxt = "{: 6.2f}%,{: 6.2f}%,{: 6.2f}%,{: 6.2f}%,{: 6.2f}%,{: 6.2f}%"
        self.currentLabel_1.setText(currTxt.format(msg.curr_act[0], msg.curr_act[1], msg.curr_act[2], msg.curr_act[3], msg.curr_act[4], msg.curr_act[5]))
        self.speedLabel_1.setText(str(msg.ov_pro) + "%")
        self.lastMoveTLabel_1.setText(str(msg.com_last_mot_time) + "ms")
        if msg.com_do_port_value & 0x8000 != 0:
            self.doUpPushButton_1.setText("Upper:1")
        else:
            self.doUpPushButton_1.setText("Upper:0")
        if msg.com_do_port_value & 0x4000 != 0:
            self.doLoPushButton_1.setText("Lower:1")
        else:
            self.doLoPushButton_1.setText("Lower:0")
        if msg.com_do_port_value & 0x2000 != 0:
            self.doValvePushButton_1.setText("Valve:1")
        else:
            self.doValvePushButton_1.setText("Valve:0")
        refreshHz = 1.0 / timeElapsed
        refreshTxt = "{: 5.2f}fps"
        self.refreshLabel_1.setText(refreshTxt.format(refreshHz))

    # ROS topic subscriber callback for rear robot arm (kr2)
    def updateGUI_Kr2State(self):
        self.msgKr2BuffMutex.acquire()
        msg = copy.copy(self.clone_kr2_msg)
        self.msgKr2BuffMutex.release()
        timeElapsed = msg.timestamp - self.prevKr2StateTimestamp
        self.prevKr2StateTimestamp = msg.timestamp
        if timeElapsed <= 0:
            return
        self.krcModeLabel_2.setText("Mode:" + msg.mode_op)
        if msg.com_autext_start == True:
            self.autoExLabel_2.setText("AutoEx:Y")
            self.startAutoExButton_2.setEnabled(False)
            #self.krcModeStateLabel_1.setText("Mode:" + msg.mode_op + " On")
            #self.autoExPushButton_1.setEnabled(False)
        else:
            self.autoExLabel_2.setText("AutoEx:N")
            self.startAutoExButton_2.setEnabled(True)
        self.actionCodeLabel_2.setText("Act:" + str(msg.com_action))
        if msg.com_motstop == 0:
            self.resumeMoveButton_2.setEnabled(False)
            self.stopCodeLabel_2.setText("Norm:0")
        elif msg.com_motstop == 1:
            self.resumeMoveButton_2.setEnabled(True)
            self.stopCodeLabel_2.setText("Pause:1")
        else:
            self.resumeMoveButton_2.setEnabled(False)
            self.stopCodeLabel_2.setText("Stop:2")
        self.errorCodeLabel_2.setText("Err:" + str(msg.com_error_no))
        jointsTxt = "{: 6.3f},{: 6.3f},{: 6.3f},{: 6.3f},{: 6.3f},{: 6.3f}"
        self.jointsLabel_2.setText(jointsTxt.format(msg.axis_fb.A1, msg.axis_fb.A2, msg.axis_fb.A3, msg.axis_fb.A4, msg.axis_fb.A5, msg.axis_fb.A6))
        poseTxt = "{: 6.0f},{: 6.0f},{: 6.0f},{: 6.3f},{: 6.3f},{: 6.3f},{: 3.0f},{: 3.0f}"
        self.poseLabel_2.setText(poseTxt.format(msg.pos_fb.X, msg.pos_fb.Y, msg.pos_fb.Z, msg.pos_fb.A, msg.pos_fb.B, msg.pos_fb.C, msg.pos_fb.S, msg.pos_fb.T))
        tempTxt = "{: 6.2f},{: 6.2f},{: 6.2f},{: 6.2f},{: 6.2f},{: 6.2f}"
        self.tempLabel_2.setText(tempTxt.format(msg.mot_temp[0], msg.mot_temp[1], msg.mot_temp[2], msg.mot_temp[3], msg.mot_temp[4], msg.mot_temp[5]))
        currTxt = "{: 6.2f}%,{: 6.2f}%,{: 6.2f}%,{: 6.2f}%,{: 6.2f}%,{: 6.2f}%"
        self.currentLabel_2.setText(currTxt.format(msg.curr_act[0], msg.curr_act[1], msg.curr_act[2], msg.curr_act[3], msg.curr_act[4], msg.curr_act[5]))
        self.speedLabel_2.setText(str(msg.ov_pro) + "%")
        self.lastMoveTLabel_2.setText(str(msg.com_last_mot_time) + "ms")
        if msg.com_do_port_value & 0x8000 != 0:
            self.doUpPushButton_2.setText("Upper:1")
        else:
            self.doUpPushButton_2.setText("Upper:0")
        if msg.com_do_port_value & 0x4000 != 0:
            self.doLoPushButton_2.setText("Lower:1")
        else:
            self.doLoPushButton_2.setText("Lower:0")
        if msg.com_do_port_value & 0x2000 != 0:
            self.doValvePushButton_2.setText("Valve:1")
        else:
            self.doValvePushButton_2.setText("Valve:0")
        refreshHz = 1.0 / timeElapsed
        refreshTxt = "{: 5.2f}fps"
        self.refreshLabel_2.setText(refreshTxt.format(refreshHz))

    # ROS topic subscriber callback for auto control SM (ac_state)
    def updateGUI_AcState(self):
        self.msgAcBuffMutex.acquire()
        msg = copy.copy(self.clone_ac_msg)
        self.msgAcBuffMutex.release()
        timeElapsed = msg.timestamp - self.prevAcStateTimestamp
        self.prevAcStateTimestamp = msg.timestamp
        if timeElapsed <= 0:
            return
        rearState = "Idle"
        frontState = "Idle"
        if msg.reararm_sm != 1:
            rearState = "RSM:" + str(msg.reararm_sm)
        if msg.frontarm_sm != 1:
            frontState = "FSM:" + str(msg.frontarm_sm)
        #self.autoControlStateLabel_1.setText(rearState + "," + frontState)
        if self.moveArmSelDial.value() == 1:
            if msg.reararm_sm != 1:
                self.joyMovGroupBox.setEnabled(False)
                self.cmdMovGroupBox.setEnabled(False)
            else:
                self.joyMovGroupBox.setEnabled(True)
                self.cmdMovGroupBox.setEnabled(True)
        elif self.moveArmSelDial.value() == 2:
            if msg.frontarm_sm != 1:
                self.joyMovGroupBox.setEnabled(False)
                self.cmdMovGroupBox.setEnabled(False)
            else:
                self.joyMovGroupBox.setEnabled(True)
                self.cmdMovGroupBox.setEnabled(True)

    # ROS topic subscriber callback for system io (sio_state)
    def updateGUI_SioState(self):
        msg = copy.copy(self.clone_sio_msg)
        self.sysInputPortLabel_0.setText(str(msg.input_pin[0]))
        self.sysInputPortLabel_1.setText(str(msg.input_pin[1]))
        self.sysInputPortLabel_2.setText(str(msg.input_pin[2]))
        self.sysInputPortLabel_3.setText(str(msg.input_pin[3]))
        self.sysInputPortLabel_4.setText(str(msg.input_pin[4]))
        self.sysInputPortLabel_5.setText(str(msg.input_pin[5]))
        self.sysInputPortLabel_6.setText(str(msg.input_pin[6]))
        self.sysInputPortLabel_7.setText(str(msg.input_pin[7]))
        self.sysInputPortLabel_8.setText(str(msg.input_pin[8]))
        self.sysInputPortLabel_9.setText(str(msg.input_pin[9]))
        self.sysInputPortLabel_10.setText(str(msg.input_pin[10]))
        self.sysInputPortLabel_11.setText(str(msg.input_pin[11]))
        self.sysInputPortLabel_12.setText(str(msg.input_pin[12]))
        self.sysInputPortLabel_13.setText(str(msg.input_pin[13]))
        self.sysInputPortLabel_14.setText(str(msg.input_pin[14]))
        self.sysInputPortLabel_15.setText(str(msg.input_pin[15]))
        self.sysInputPortLabel_16.setText(str(msg.input_pin[16]))
        self.sysInputPortLabel_17.setText(str(msg.input_pin[17]))
        self.sysOutputPushButton_0.setText(str(msg.output_pin[0]))
        self.sysOutputPushButton_1.setText(str(msg.output_pin[1]))
        self.sysOutputPushButton_2.setText(str(msg.output_pin[2]))
        self.sysOutputPushButton_3.setText(str(msg.output_pin[3]))
        self.sysOutputPushButton_4.setText(str(msg.output_pin[4]))
        self.sysOutputPushButton_5.setText(str(msg.output_pin[5]))
        self.sysOutputPushButton_6.setText(str(msg.output_pin[6]))
        self.sysOutputPushButton_7.setText(str(msg.output_pin[7]))
        self.sysOutputPushButton_8.setText(str(msg.output_pin[8]))
        self.sysOutputPushButton_9.setText(str(msg.output_pin[9]))
        self.sysOutputPushButton_10.setText(str(msg.output_pin[10]))
        self.sysOutputPushButton_11.setText(str(msg.output_pin[11]))
        self.sysOutputPushButton_12.setText(str(msg.output_pin[12]))
        self.sysOutputPushButton_13.setText(str(msg.output_pin[13]))
        self.sysOutputPushButton_14.setText(str(msg.output_pin[14]))
        self.sysOutputPushButton_15.setText(str(msg.output_pin[15]))
        self.sysOutputPushButton_16.setText(str(msg.output_pin[16]))
        self.sysOutputPushButton_17.setText(str(msg.output_pin[17]))

    # Close/Exit
    def closeEvent(self, event):
    #def gui_close(self):
        rospy.loginfo("GUI close.")
        #roslaunch.parent.ROSLaunchParent.shutdown()
        #self.close()
        reply = QMessageBox.information(self, "關機", "您要關機嗎？", QMessageBox.Yes | QMessageBox.No)
        if reply == QMessageBox.Yes:
            os.system("systemctl poweroff")
            #os.system("systemctl halt")

    # HMI user trigger event callbacks
    # Mouse input event
    def mousePressEvent(self, event):
        rospy.loginfo("Mouse event")

    def sysOutputPushButton_callback(self, n):
        rospy.loginfo("Toggle system output port " + str(n) + ".")
        mask = pow(2, n)
        value = 0
        if self.clone_sio_msg.output_pin[n] == 0:
            value = 0xFFFF
        try:
            resp = sio_set_system_do(mask, value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def allMoveStopPushButton_callback(self):
        rospy.loginfo("Stop auto control")
        try:
            resp = ac_stop_autocontrol(True)
            #resp = kr1_rampdown_stop(2)
            #resp = kr2_rampdown_stop(2)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def start_auto_ex_button1_callback(self):
        rospy.loginfo("Start kr1 auto ext.")
        try:
            resp = kr1_start_autoext_mode(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def pause_move_button1_callback(self):
        rospy.loginfo("Pause kr1 move.")
        try:
            resp = kr1_rampdown_stop(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def save_waypoint_button1_callback(self):
        rospy.loginfo("Save kr1 point into waypoints.yaml.")
        waypoint_name, ok = QInputDialog.getText(self, "Waypoint Name Input Dialog", "Name:")
        if ok and waypoint_name:
            now = datetime.now()
            date_time = now.strftime("%d%m%y-%H:%M:%S")
            data1 = dict(
                at=date_time, name=str(waypoint_name), byjoints=dict(type='movj', A1=self.clone_kr1_msg.axis_setpt.A1, A2=self.clone_kr1_msg.axis_setpt.A2, A3=self.clone_kr1_msg.axis_setpt.A3, A4=self.clone_kr1_msg.axis_setpt.A4, A5=self.clone_kr1_msg.axis_setpt.A5, A6=self.clone_kr1_msg.axis_setpt.A6, R=0.0))
            data2 = dict(
                at=date_time, name=str(waypoint_name), bypose=dict(type='movj', X=self.clone_kr1_msg.pos_setpt.X, Y=self.clone_kr1_msg.pos_setpt.Y, Z=self.clone_kr1_msg.pos_setpt.Z, A=self.clone_kr1_msg.pos_setpt.A, B=self.clone_kr1_msg.pos_setpt.B, C=self.clone_kr1_msg.pos_setpt.C, S=self.clone_kr1_msg.pos_setpt.S, T=self.clone_kr1_msg.pos_setpt.T, R=0.0))
            with open('kr1_waypoints.yaml', 'a') as outfile:
                yaml.dump_all([data1, data2], outfile, default_flow_style=True, width=1000)


    def resume_move_button1_callback(self):
        rospy.loginfo("Resume kr1 move.")
        try:
            resp = kr1_rampdown_stop(0)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def stop_move_button1_callback(self):
        rospy.loginfo("Stop kr1 move.")
        try:
            resp = kr1_rampdown_stop(2)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def disable_move_button1_callback(self):
        rospy.loginfo("Disable kr1 move.")
        try:
            resp = kr1_set_moveenable_signal(False)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def speed_slider_change_value1_callback(self, value):
        rospy.loginfo("Set kr1 speed scale = " + str(value) + "%")
        try:
            resp = kr1_set_speedscale(value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doUp_button1_callback(self):
        rospy.loginfo("Toggle kr1 DO Up.")
        try:
            if self.doUpPushButton_1.text() == "Upper:1":
                resp = kr1_setdigitaloutput(32768, 0, 0.1)
            else:
                resp = kr1_setdigitaloutput(32768, 32768, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doLo_button1_callback(self):
        rospy.loginfo("Toggle kr1 DO Lo.")
        try:
            if self.doLoPushButton_1.text() == "Lower:1":
                resp = kr1_setdigitaloutput(16384, 0, 0.1)
            else:
                resp = kr1_setdigitaloutput(16384, 16384, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doValve_button1_callback(self):
        rospy.loginfo("Toggle kr1 DO Valve.")
        try:
            if self.doValvePushButton_1.text() == "Valve:1":
                resp = kr1_setdigitaloutput(8192, 0, 0.1)
            else:
                resp = kr1_setdigitaloutput(8192, 8192, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def start_auto_ex_button2_callback(self):
        rospy.loginfo("Start kr2 auto ext.")
        try:
            resp = kr2_start_autoext_mode(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def pause_move_button2_callback(self):
        rospy.loginfo("Pause kr2 move.")
        try:
            resp = kr2_rampdown_stop(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def save_waypoint_button2_callback(self):
        rospy.loginfo("Save kr2 point into waypoints.yaml.")
        waypoint_name, ok = QInputDialog.getText(self, "Waypoint Name Input Dialog", "Name:")
        if ok and waypoint_name:
            now = datetime.now()
            date_time = now.strftime("%d%m%y-%H:%M:%S")
            data1 = dict(
                at=date_time, name=str(waypoint_name), byjoints=dict(type='movj', A1=self.clone_kr2_msg.axis_setpt.A1, A2=self.clone_kr2_msg.axis_setpt.A2, A3=self.clone_kr2_msg.axis_setpt.A3, A4=self.clone_kr2_msg.axis_setpt.A4, A5=self.clone_kr2_msg.axis_setpt.A5, A6=self.clone_kr2_msg.axis_setpt.A6, R=0.0))
            data2 = dict(
                at=date_time, name=str(waypoint_name), bypose=dict(type='movj', X=self.clone_kr2_msg.pos_setpt.X, Y=self.clone_kr2_msg.pos_setpt.Y, Z=self.clone_kr2_msg.pos_setpt.Z, A=self.clone_kr2_msg.pos_setpt.A, B=self.clone_kr2_msg.pos_setpt.B, C=self.clone_kr2_msg.pos_setpt.C, S=self.clone_kr2_msg.pos_setpt.S, T=self.clone_kr2_msg.pos_setpt.T, R=0.0))
            with open('kr2_waypoints.yaml', 'a') as outfile:
                yaml.dump_all([data1, data2], outfile, default_flow_style=True, width=1000)


    def resume_move_button2_callback(self):
        rospy.loginfo("Resume kr2 move.")
        try:
            resp = kr2_rampdown_stop(0)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def stop_move_button2_callback(self):
        rospy.loginfo("Stop kr2 move.")
        try:
            resp = kr2_rampdown_stop(2)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def disable_move_button2_callback(self):
        rospy.loginfo("Disable kr2 move.")
        try:
            resp = kr2_set_moveenable_signal(False)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def speed_slider_change_value2_callback(self, value):
        rospy.loginfo("Set kr2 speed scale = " + str(value) + "%")
        try:
            resp = kr2_set_speedscale(value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doUp_button2_callback(self):
        rospy.loginfo("Toggle kr2 DO Up.")
        try:
            if self.doUpPushButton_2.text() == "Upper:1":
                resp = kr2_setdigitaloutput(32768, 0, 0.1)
            else:
                resp = kr2_setdigitaloutput(32768, 32768, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doLo_button2_callback(self):
        rospy.loginfo("Toggle kr2 DO Lo.")
        try:
            if self.doLoPushButton_2.text() == "Lower:1":
                resp = kr2_setdigitaloutput(16384, 0, 0.1)
            else:
                resp = kr2_setdigitaloutput(16384, 16384, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doValve_button2_callback(self):
        rospy.loginfo("Toggle kr2 DO Valve.")
        try:
            if self.doValvePushButton_2.text() == "Valve:1":
                resp = kr2_setdigitaloutput(8192, 0, 0.1)
            else:
                resp = kr2_setdigitaloutput(8192, 8192, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def goHome_button1_callback(self):
        rospy.loginfo("Move kr1 to home position.")
        try:
            resp = kr1_set_speedscale(10)
            resp = ac_go_home(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def goHome_button2_callback(self):
        rospy.loginfo("Move kr2 to home position.")
        try:
            resp = kr2_set_speedscale(10)
            resp = ac_go_home(2)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def goInvCheck_button_callback(self):
        rospy.loginfo("Move kr2 to inventory check.")
        try:
            resp = kr2_set_speedscale(10)
            resp = ac_go_coneinvcheck(True)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    # ------------------ Manual Move Joy Start ------------------
    def moveArmSelDial_callback(self, value):
        rospy.loginfo("Set target arm = " + str(value))
        if value == 1:
            self.moveArmSelLabel.setText("Rear Arm (kr1)")
        else:
            self.moveArmSelLabel.setText("Front Arm (kr2)")
        self.getCurrentToByPosePushButton_callback()
        self.getCurrentToByAnglePushButton_callback()
        gc.collect()


    def ensureLowSpeedScale(self):
        if self.moveArmSelDial.value() == 1:
            if self.clone_kr1_msg.ov_pro > 10:
                resp = kr1_set_speedscale(10)
        elif self.moveArmSelDial.value() == 2:
            if self.clone_kr2_msg.ov_pro > 10:
                resp = kr2_set_speedscale(10)

    def ensureCancelAndStop(self):
        if self.stopCodeLabel_1.text() == "Norm:0" and self.moveArmSelDial.value() == 1:
            kr1_rampdown_stop(2)
        elif self.stopCodeLabel_2.text() == "Norm:0" and self.moveArmSelDial.value() == 2:
            kr2_rampdown_stop(2)

    # -------Z--------
    def pz_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpz.start(350)
        self.pz()
    def pz_released_button_callback(self):
        self.timerpz.stop()
        self.ensureCancelAndStop()
    def pz(self):
        print 'mov_test z +50...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 50 * self.joyModeIncStep
            req.A = 0
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def nz_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timernz.start(350)
        self.nz()
    def nz_released_button_callback(self):
        self.timernz.stop()
        self.ensureCancelAndStop()
    def nz(self):
        print 'mov_test z -50...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = -50 * self.joyModeIncStep
            req.A = 0
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # -------Y--------
    def py_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpy.start(350)
        self.py()
    def py_released_button_callback(self):
        self.timerpy.stop()
        self.ensureCancelAndStop()
    def py(self):
        print 'mov_test y +50...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 50 * self.joyModeIncStep
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def ny_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerny.start(350)
        self.ny()
    def ny_released_button_callback(self):
        self.timerny.stop()
        self.ensureCancelAndStop()
    def ny(self):
        print 'mov_test y -50...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = -50 * self.joyModeIncStep
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # -------X--------
    def px_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpx.start(350)
        self.px()
    def px_released_button_callback(self):
        self.timerpx.stop()
        self.ensureCancelAndStop()
    def px(self):
        print 'mov_test x +50...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 50 * self.joyModeIncStep
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def nx_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timernx.start(350)
        self.nx()
    def nx_released_button_callback(self):
        self.timernx.stop()
        self.ensureCancelAndStop()
    def nx(self):
        print 'mov_test x -50...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = -50 * self.joyModeIncStep
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    #------A----------
    def na_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna.start(350)
        self.na()
    def na_released_button_callback(self):
        self.timerna.stop()
        self.ensureCancelAndStop()
    def na(self):
        print 'mov_test A -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 0
            req.A = -5 * self.joyModeIncStep
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def pa_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa.start(350)
        self.pa()
    def pa_released_button_callback(self):
        self.timerpa.stop()
        self.ensureCancelAndStop()
    def pa(self):
        print 'mov_test A +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 0
            req.A = 5 * self.joyModeIncStep
            req.B = 0
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    #------B----------
    def nb_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timernb.start(350)
        self.nb()
    def nb_released_button_callback(self):
        self.timernb.stop()
        self.ensureCancelAndStop()
    def nb(self):
        print 'mov_test B -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = -5 * self.joyModeIncStep
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def pb_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpb.start(350)
        self.pb()
    def pb_released_button_callback(self):
        self.timerpb.stop()
        self.ensureCancelAndStop()
    def pb(self):
        print 'mov_test B +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 5 * self.joyModeIncStep
            req.C = 0
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    #------c----------
    def nc_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timernc.start(350)
        self.nc()
    def nc_released_button_callback(self):
        self.timernc.stop()
        self.ensureCancelAndStop()
    def nc(self):
        print 'mov_test C -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = -5 * self.joyModeIncStep
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def pc_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpc.start(350)
        self.pc()
    def pc_released_button_callback(self):
        self.timerpc.stop()
        self.ensureCancelAndStop()
    def pc(self):
        print 'mov_test C +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_pose_Type()
            req.X = 0
            req.Y = 0
            req.Z = 0
            req.A = 0
            req.B = 0
            req.C = 5 * self.joyModeIncStep
            if self.moveTestRadioButtonB.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjreltool_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjreltool_bypose(req)
            elif self.moveTestRadioButtonA.isChecked() == True:
                if self.moveArmSelDial.value() == 1:
                    resp = kr1_movjrel_bypose(req)
                elif self.moveArmSelDial.value() == 2:
                    resp = kr2_movjrel_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    #------A1---------
    def pa1_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa1.start(350)
        self.pa1()
    def pa1_released_button_callback(self):
        self.timerpa1.stop()
        self.ensureCancelAndStop()
    def pa1(self):
        print 'mov_test a1 +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 5 * self.joyModeIncStep
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def na1_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna1.start(350)
        self.na1()
    def na1_released_button_callback(self):
        self.timerna1.stop()
        self.ensureCancelAndStop()
    def na1(self):
        print 'mov_test a1 -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = -5 * self.joyModeIncStep
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    #-------A2--------
    def pa2_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa2.start(350)
        self.pa2()
    def pa2_released_button_callback(self):
        self.timerpa2.stop()
        self.ensureCancelAndStop()
    def pa2(self):
        print 'mov_test a2 +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 5 * self.joyModeIncStep
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def na2_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna2.start(350)
        self.na2()
    def na2_released_button_callback(self):
        self.timerna2.stop()
        self.ensureCancelAndStop()
    def na2(self):
        print 'mov_test a2 -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = -5 * self.joyModeIncStep
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # ------A3---------
    def pa3_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa3.start(350)
        self.pa3()
    def pa3_released_button_callback(self):
        self.timerpa3.stop()
        self.ensureCancelAndStop()
    def pa3(self):
        print 'mov_test a3 +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 5 * self.joyModeIncStep
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def na3_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna3.start(350)
        self.na3()
    def na3_released_button_callback(self):
        self.timerna3.stop()
        self.ensureCancelAndStop()
    def na3(self):
        print 'mov_test a3 -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = -5 * self.joyModeIncStep
            req.A4 = 0
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # ------A4---------
    def pa4_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa4.start(350)
        self.pa4()
    def pa4_released_button_callback(self):
        self.timerpa4.stop()
        self.ensureCancelAndStop()
    def pa4(self):
        print 'mov_test a4 +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 5 * self.joyModeIncStep
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def na4_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna4.start(350)
        self.na4()
    def na4_released_button_callback(self):
        self.timerna4.stop()
        self.ensureCancelAndStop()
    def na4(self):
        print 'mov_test a4 -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = -5 * self.joyModeIncStep
            req.A5 = 0
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # ------A5---------
    def pa5_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa5.start(350)
        self.pa5()
    def pa5_released_button_callback(self):
        self.timerpa5.stop()
        self.ensureCancelAndStop()
    def pa5(self):
        print 'mov_test a5 +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 5 * self.joyModeIncStep
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def na5_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna5.start(350)
        self.na5()
    def na5_released_button_callback(self):
        self.timerna5.stop()
        self.ensureCancelAndStop()
    def na5(self):
        print 'mov_test a5 -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = -5 * self.joyModeIncStep
            req.A6 = 0
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    # ------A6---------
    def pa6_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerpa6.start(350)
        self.pa6()
    def pa6_released_button_callback(self):
        self.timerpa6.stop()
        self.ensureCancelAndStop()
    def pa6(self):
        print 'mov_test a6 +5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = 5 * self.joyModeIncStep
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def na6_pressed_button_callback(self):
        self.joyModeIncStep = 0
        self.ensureLowSpeedScale()
        self.timerna6.start(350)
        self.na6()
    def na6_released_button_callback(self):
        self.timerna6.stop()
        self.ensureCancelAndStop()
    def na6(self):
        print 'mov_test a6 -5...'
        self.joyModeIncStep += 0.1
        if self.joyModeIncStep >= 1.0:
            self.joyModeIncStep = 1.0
        try:
            req = kr_joint_Type()
            req.A1 = 0
            req.A2 = 0
            req.A3 = 0
            req.A4 = 0
            req.A5 = 0
            req.A6 = -5 * self.joyModeIncStep
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movjrel_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movjrel_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def memStorePushButton_callback(self, n):
        print "Get current pose and angles to memory " + str(n)
        """if self.moveArmSelDial.value() == 1:
            self.memStore_msg[n] = copy.deepcopy(self.clone_kr1_msg)
        elif self.moveArmSelDial.value() == 2:
            self.memStore_msg[n] = copy.deepcopy(self.clone_kr2_msg)"""
        self.memStore_msg[n].pos_setpt.X = float(self.poseLineEdit_1.text())
        self.memStore_msg[n].pos_setpt.Y = float(self.poseLineEdit_2.text())
        self.memStore_msg[n].pos_setpt.Z = float(self.poseLineEdit_3.text())
        self.memStore_msg[n].pos_setpt.A = float(self.poseLineEdit_4.text())
        self.memStore_msg[n].pos_setpt.B = float(self.poseLineEdit_5.text())
        self.memStore_msg[n].pos_setpt.C = float(self.poseLineEdit_6.text())
        self.memStore_msg[n].pos_setpt.S = float(self.poseLineEdit_7.text())
        self.memStore_msg[n].pos_setpt.T = float(self.poseLineEdit_8.text())
        self.memStore_msg[n].axis_setpt.A1 = float(self.angleLineEdit_1.text())
        self.memStore_msg[n].axis_setpt.A2 = float(self.angleLineEdit_2.text())
        self.memStore_msg[n].axis_setpt.A3 = float(self.angleLineEdit_3.text())
        self.memStore_msg[n].axis_setpt.A4 = float(self.angleLineEdit_4.text())
        self.memStore_msg[n].axis_setpt.A5 = float(self.angleLineEdit_5.text())
        self.memStore_msg[n].axis_setpt.A6 = float(self.angleLineEdit_6.text())

    def memRecallPushButton_callback(self, n):
        print "Restore pose and angles from memory."
        poseTxtX = "{: 6.0f}"
        self.poseLineEdit_1.setText(poseTxtX.format(self.memStore_msg[n].pos_setpt.X))
        poseTxtY = "{: 6.0f}"
        self.poseLineEdit_2.setText(poseTxtY.format(self.memStore_msg[n].pos_setpt.Y))
        poseTxtZ = "{: 6.0f}"
        self.poseLineEdit_3.setText(poseTxtZ.format(self.memStore_msg[n].pos_setpt.Z))
        poseTxtA = "{: 6.3f}"
        self.poseLineEdit_4.setText(poseTxtA.format(self.memStore_msg[n].pos_setpt.A))
        poseTxtB = "{: 6.3f}"
        self.poseLineEdit_5.setText(poseTxtB.format(self.memStore_msg[n].pos_setpt.B))
        poseTxtC = "{: 6.3f}"
        self.poseLineEdit_6.setText(poseTxtC.format(self.memStore_msg[n].pos_setpt.C))
        poseTxtS = "{: 3.0f}"
        self.poseLineEdit_7.setText(poseTxtS.format(self.memStore_msg[n].pos_setpt.S))
        poseTxtT = "{: 3.0f}"
        self.poseLineEdit_8.setText(poseTxtT.format(self.memStore_msg[n].pos_setpt.T))
        jointsTxtA1 = "{: 6.3f}"
        self.angleLineEdit_1.setText(jointsTxtA1.format(self.memStore_msg[n].axis_setpt.A1))
        jointsTxtA2 = "{: 6.3f}"
        self.angleLineEdit_2.setText(jointsTxtA2.format(self.memStore_msg[n].axis_setpt.A2))
        jointsTxtA3 = "{: 6.3f}"
        self.angleLineEdit_3.setText(jointsTxtA3.format(self.memStore_msg[n].axis_setpt.A3))
        jointsTxtA4 = "{: 6.3f}"
        self.angleLineEdit_4.setText(jointsTxtA4.format(self.memStore_msg[n].axis_setpt.A4))
        jointsTxtA5 = "{: 6.3f}"
        self.angleLineEdit_5.setText(jointsTxtA5.format(self.memStore_msg[n].axis_setpt.A5))
        jointsTxtA6 = "{: 6.3f}"
        self.angleLineEdit_6.setText(jointsTxtA6.format(self.memStore_msg[n].axis_setpt.A6))

    def memStoreToFilePushButton_callback(self):
        print "Get current pose and angles to file."
        data0 = dict(
            name="mem0",
            byjoints=dict(type='movj', A1=self.memStore_msg[0].axis_setpt.A1, A2=self.memStore_msg[0].axis_setpt.A2,
                          A3=self.memStore_msg[0].axis_setpt.A3, A4=self.memStore_msg[0].axis_setpt.A4,
                          A5=self.memStore_msg[0].axis_setpt.A5, A6=self.memStore_msg[0].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[0].pos_setpt.X, Y=self.memStore_msg[0].pos_setpt.Y,
                        Z=self.memStore_msg[0].pos_setpt.Z, A=self.memStore_msg[0].pos_setpt.A,
                        B=self.memStore_msg[0].pos_setpt.B, C=self.memStore_msg[0].pos_setpt.C,
                        S=self.memStore_msg[0].pos_setpt.S, T=self.memStore_msg[0].pos_setpt.T, R=0.0))
        data1 = dict(
            name="mem1",
            byjoints=dict(type='movj', A1=self.memStore_msg[1].axis_setpt.A1, A2=self.memStore_msg[1].axis_setpt.A2,
                          A3=self.memStore_msg[1].axis_setpt.A3, A4=self.memStore_msg[1].axis_setpt.A4,
                          A5=self.memStore_msg[1].axis_setpt.A5, A6=self.memStore_msg[1].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[1].pos_setpt.X, Y=self.memStore_msg[1].pos_setpt.Y,
                        Z=self.memStore_msg[1].pos_setpt.Z, A=self.memStore_msg[1].pos_setpt.A,
                        B=self.memStore_msg[1].pos_setpt.B, C=self.memStore_msg[1].pos_setpt.C,
                        S=self.memStore_msg[1].pos_setpt.S, T=self.memStore_msg[1].pos_setpt.T, R=0.0))
        data2 = dict(
            name="mem2",
            byjoints=dict(type='movj', A1=self.memStore_msg[2].axis_setpt.A1, A2=self.memStore_msg[2].axis_setpt.A2,
                          A3=self.memStore_msg[2].axis_setpt.A3, A4=self.memStore_msg[2].axis_setpt.A4,
                          A5=self.memStore_msg[2].axis_setpt.A5, A6=self.memStore_msg[2].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[2].pos_setpt.X, Y=self.memStore_msg[2].pos_setpt.Y,
                        Z=self.memStore_msg[2].pos_setpt.Z, A=self.memStore_msg[2].pos_setpt.A,
                        B=self.memStore_msg[2].pos_setpt.B, C=self.memStore_msg[2].pos_setpt.C,
                        S=self.memStore_msg[2].pos_setpt.S, T=self.memStore_msg[2].pos_setpt.T, R=0.0))
        data3 = dict(
            name="mem3",
            byjoints=dict(type='movj', A1=self.memStore_msg[3].axis_setpt.A1, A2=self.memStore_msg[3].axis_setpt.A2,
                          A3=self.memStore_msg[3].axis_setpt.A3, A4=self.memStore_msg[3].axis_setpt.A4,
                          A5=self.memStore_msg[3].axis_setpt.A5, A6=self.memStore_msg[3].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[3].pos_setpt.X, Y=self.memStore_msg[3].pos_setpt.Y,
                        Z=self.memStore_msg[3].pos_setpt.Z, A=self.memStore_msg[3].pos_setpt.A,
                        B=self.memStore_msg[3].pos_setpt.B, C=self.memStore_msg[3].pos_setpt.C,
                        S=self.memStore_msg[3].pos_setpt.S, T=self.memStore_msg[3].pos_setpt.T, R=0.0))
        data4 = dict(
            name="mem4",
            byjoints=dict(type='movj', A1=self.memStore_msg[4].axis_setpt.A1, A2=self.memStore_msg[4].axis_setpt.A2,
                          A3=self.memStore_msg[4].axis_setpt.A3, A4=self.memStore_msg[4].axis_setpt.A4,
                          A5=self.memStore_msg[4].axis_setpt.A5, A6=self.memStore_msg[4].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[4].pos_setpt.X, Y=self.memStore_msg[4].pos_setpt.Y,
                        Z=self.memStore_msg[4].pos_setpt.Z, A=self.memStore_msg[4].pos_setpt.A,
                        B=self.memStore_msg[4].pos_setpt.B, C=self.memStore_msg[4].pos_setpt.C,
                        S=self.memStore_msg[4].pos_setpt.S, T=self.memStore_msg[4].pos_setpt.T, R=0.0))
        data5 = dict(
            name="mem5",
            byjoints=dict(type='movj', A1=self.memStore_msg[5].axis_setpt.A1, A2=self.memStore_msg[5].axis_setpt.A2,
                          A3=self.memStore_msg[5].axis_setpt.A3, A4=self.memStore_msg[5].axis_setpt.A4,
                          A5=self.memStore_msg[5].axis_setpt.A5, A6=self.memStore_msg[5].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[5].pos_setpt.X, Y=self.memStore_msg[5].pos_setpt.Y,
                        Z=self.memStore_msg[5].pos_setpt.Z, A=self.memStore_msg[5].pos_setpt.A,
                        B=self.memStore_msg[5].pos_setpt.B, C=self.memStore_msg[5].pos_setpt.C,
                        S=self.memStore_msg[5].pos_setpt.S, T=self.memStore_msg[5].pos_setpt.T, R=0.0))
        data6 = dict(
            name="mem6",
            byjoints=dict(type='movj', A1=self.memStore_msg[6].axis_setpt.A1, A2=self.memStore_msg[6].axis_setpt.A2,
                          A3=self.memStore_msg[6].axis_setpt.A3, A4=self.memStore_msg[6].axis_setpt.A4,
                          A5=self.memStore_msg[6].axis_setpt.A5, A6=self.memStore_msg[6].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[6].pos_setpt.X, Y=self.memStore_msg[6].pos_setpt.Y,
                        Z=self.memStore_msg[6].pos_setpt.Z, A=self.memStore_msg[6].pos_setpt.A,
                        B=self.memStore_msg[6].pos_setpt.B, C=self.memStore_msg[6].pos_setpt.C,
                        S=self.memStore_msg[6].pos_setpt.S, T=self.memStore_msg[6].pos_setpt.T, R=0.0))
        data7 = dict(
            name="mem7",
            byjoints=dict(type='movj', A1=self.memStore_msg[7].axis_setpt.A1, A2=self.memStore_msg[7].axis_setpt.A2,
                          A3=self.memStore_msg[7].axis_setpt.A3, A4=self.memStore_msg[7].axis_setpt.A4,
                          A5=self.memStore_msg[7].axis_setpt.A5, A6=self.memStore_msg[7].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[7].pos_setpt.X, Y=self.memStore_msg[7].pos_setpt.Y,
                        Z=self.memStore_msg[7].pos_setpt.Z, A=self.memStore_msg[7].pos_setpt.A,
                        B=self.memStore_msg[7].pos_setpt.B, C=self.memStore_msg[7].pos_setpt.C,
                        S=self.memStore_msg[7].pos_setpt.S, T=self.memStore_msg[7].pos_setpt.T, R=0.0))
        data8 = dict(
            name="mem8",
            byjoints=dict(type='movj', A1=self.memStore_msg[8].axis_setpt.A1, A2=self.memStore_msg[8].axis_setpt.A2,
                          A3=self.memStore_msg[8].axis_setpt.A3, A4=self.memStore_msg[8].axis_setpt.A4,
                          A5=self.memStore_msg[8].axis_setpt.A5, A6=self.memStore_msg[8].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[8].pos_setpt.X, Y=self.memStore_msg[8].pos_setpt.Y,
                        Z=self.memStore_msg[8].pos_setpt.Z, A=self.memStore_msg[8].pos_setpt.A,
                        B=self.memStore_msg[8].pos_setpt.B, C=self.memStore_msg[8].pos_setpt.C,
                        S=self.memStore_msg[8].pos_setpt.S, T=self.memStore_msg[8].pos_setpt.T, R=0.0))
        data9 = dict(
            name="mem9",
            byjoints=dict(type='movj', A1=self.memStore_msg[9].axis_setpt.A1, A2=self.memStore_msg[9].axis_setpt.A2,
                          A3=self.memStore_msg[9].axis_setpt.A3, A4=self.memStore_msg[9].axis_setpt.A4,
                          A5=self.memStore_msg[9].axis_setpt.A5, A6=self.memStore_msg[9].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[9].pos_setpt.X, Y=self.memStore_msg[9].pos_setpt.Y,
                        Z=self.memStore_msg[9].pos_setpt.Z, A=self.memStore_msg[9].pos_setpt.A,
                        B=self.memStore_msg[9].pos_setpt.B, C=self.memStore_msg[9].pos_setpt.C,
                        S=self.memStore_msg[9].pos_setpt.S, T=self.memStore_msg[9].pos_setpt.T, R=0.0))
        data10 = dict(
            name="mem10",
            byjoints=dict(type='movj', A1=self.memStore_msg[10].axis_setpt.A1, A2=self.memStore_msg[10].axis_setpt.A2,
                          A3=self.memStore_msg[10].axis_setpt.A3, A4=self.memStore_msg[10].axis_setpt.A4,
                          A5=self.memStore_msg[10].axis_setpt.A5, A6=self.memStore_msg[10].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[10].pos_setpt.X, Y=self.memStore_msg[10].pos_setpt.Y,
                        Z=self.memStore_msg[10].pos_setpt.Z, A=self.memStore_msg[10].pos_setpt.A,
                        B=self.memStore_msg[10].pos_setpt.B, C=self.memStore_msg[10].pos_setpt.C,
                        S=self.memStore_msg[10].pos_setpt.S, T=self.memStore_msg[10].pos_setpt.T, R=0.0))
        data11 = dict(
            name="mem11",
            byjoints=dict(type='movj', A1=self.memStore_msg[11].axis_setpt.A1, A2=self.memStore_msg[11].axis_setpt.A2,
                          A3=self.memStore_msg[11].axis_setpt.A3, A4=self.memStore_msg[11].axis_setpt.A4,
                          A5=self.memStore_msg[11].axis_setpt.A5, A6=self.memStore_msg[11].axis_setpt.A6, R=0.0),
            bypose=dict(type='movj', X=self.memStore_msg[11].pos_setpt.X, Y=self.memStore_msg[11].pos_setpt.Y,
                        Z=self.memStore_msg[11].pos_setpt.Z, A=self.memStore_msg[11].pos_setpt.A,
                        B=self.memStore_msg[11].pos_setpt.B, C=self.memStore_msg[11].pos_setpt.C,
                        S=self.memStore_msg[11].pos_setpt.S, T=self.memStore_msg[11].pos_setpt.T, R=0.0))
        with open('manual_waypoints.yaml', 'w') as outfile:
            yaml.dump_all([data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11], outfile, default_flow_style=True, width=1000)

    def memRecallFromFilePushButton_callback(self, n):
        print "Restore pose and angles from file."
        f = open(r'manual_waypoints.yaml')
        y = yaml.load_all(f)
        i = 0
        for data in y:
            #print(data)
            print "Restore " + data['name']
            byjoint = data['byjoints']
            bypose = data['bypose']
            self.memStore_msg[i].axis_setpt.A1 = float(byjoint['A1'])
            self.memStore_msg[i].axis_setpt.A2 = float(byjoint['A2'])
            self.memStore_msg[i].axis_setpt.A3 = float(byjoint['A3'])
            self.memStore_msg[i].axis_setpt.A4 = float(byjoint['A4'])
            self.memStore_msg[i].axis_setpt.A5 = float(byjoint['A5'])
            self.memStore_msg[i].axis_setpt.A6 = float(byjoint['A6'])
            self.memStore_msg[i].pos_setpt.X = float(bypose['X'])
            self.memStore_msg[i].pos_setpt.Y = float(bypose['Y'])
            self.memStore_msg[i].pos_setpt.Z = float(bypose['Z'])
            self.memStore_msg[i].pos_setpt.A = float(bypose['A'])
            self.memStore_msg[i].pos_setpt.B = float(bypose['B'])
            self.memStore_msg[i].pos_setpt.C = float(bypose['C'])
            self.memStore_msg[i].pos_setpt.S = float(bypose['S'])
            self.memStore_msg[i].pos_setpt.T = float(bypose['T'])
            i = i+1


    def getCurrentToByPosePushButton_callback(self):
        print "Get current pose to command input boxes."
        if self.moveArmSelDial.value() == 1:
            clone_pos_setpt = self.clone_kr1_msg.pos_setpt
        elif self.moveArmSelDial.value() == 2:
            clone_pos_setpt = self.clone_kr2_msg.pos_setpt
        poseTxtX = "{: 6.0f}"
        self.poseLineEdit_1.setText(poseTxtX.format(clone_pos_setpt.X))
        poseTxtY = "{: 6.0f}"
        self.poseLineEdit_2.setText(poseTxtY.format(clone_pos_setpt.Y))
        poseTxtZ = "{: 6.0f}"
        self.poseLineEdit_3.setText(poseTxtZ.format(clone_pos_setpt.Z))
        poseTxtA = "{: 6.3f}"
        self.poseLineEdit_4.setText(poseTxtA.format(clone_pos_setpt.A))
        poseTxtB = "{: 6.3f}"
        self.poseLineEdit_5.setText(poseTxtB.format(clone_pos_setpt.B))
        poseTxtC = "{: 6.3f}"
        self.poseLineEdit_6.setText(poseTxtC.format(clone_pos_setpt.C))
        poseTxtS = "{: 3.0f}"
        self.poseLineEdit_7.setText(poseTxtS.format(clone_pos_setpt.S))
        poseTxtT = "{: 3.0f}"
        self.poseLineEdit_8.setText(poseTxtT.format(clone_pos_setpt.T))

    def getCurrentToByAnglePushButton_callback(self):
        print "Get current joint angles to command input boxes."
        if self.moveArmSelDial.value() == 1:
            clone_axis_setpt = self.clone_kr1_msg.axis_setpt
        elif self.moveArmSelDial.value() == 2:
            clone_axis_setpt = self.clone_kr2_msg.axis_setpt
        jointsTxtA1 = "{: 6.3f}"
        self.angleLineEdit_1.setText(jointsTxtA1.format(clone_axis_setpt.A1))
        jointsTxtA2 = "{: 6.3f}"
        self.angleLineEdit_2.setText(jointsTxtA2.format(clone_axis_setpt.A2))
        jointsTxtA3 = "{: 6.3f}"
        self.angleLineEdit_3.setText(jointsTxtA3.format(clone_axis_setpt.A3))
        jointsTxtA4 = "{: 6.3f}"
        self.angleLineEdit_4.setText(jointsTxtA4.format(clone_axis_setpt.A4))
        jointsTxtA5 = "{: 6.3f}"
        self.angleLineEdit_5.setText(jointsTxtA5.format(clone_axis_setpt.A5))
        jointsTxtA6 = "{: 6.3f}"
        self.angleLineEdit_6.setText(jointsTxtA6.format(clone_axis_setpt.A6))

    def movJByPosePushButton_callback(self):
        print "MovJ by pose."
        try:
            req = kr_pose_Type()
            req.X = float(self.poseLineEdit_1.text())
            req.Y = float(self.poseLineEdit_2.text())
            req.Z = float(self.poseLineEdit_3.text())
            req.A = float(self.poseLineEdit_4.text())
            req.B = float(self.poseLineEdit_5.text())
            req.C = float(self.poseLineEdit_6.text())
            req.S = float(self.poseLineEdit_7.text())
            req.T = float(self.poseLineEdit_8.text())
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movj_bypose(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movj_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def movLByPosePushButton_callback(self):
        print "MovL by pose."
        try:
            req = kr_pose_Type()
            req.X = float(self.poseLineEdit_1.text())
            req.Y = float(self.poseLineEdit_2.text())
            req.Z = float(self.poseLineEdit_3.text())
            req.A = float(self.poseLineEdit_4.text())
            req.B = float(self.poseLineEdit_5.text())
            req.C = float(self.poseLineEdit_6.text())
            req.S = float(self.poseLineEdit_7.text())
            req.T = float(self.poseLineEdit_8.text())
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movl_bypose(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movl_bypose(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def movJByAnglePushButton_callback(self):
        print "MovJ by angles."
        try:
            req = kr_joint_Type()
            req.A1 = float(self.angleLineEdit_1.text())
            req.A2 = float(self.angleLineEdit_2.text())
            req.A3 = float(self.angleLineEdit_3.text())
            req.A4 = float(self.angleLineEdit_4.text())
            req.A5 = float(self.angleLineEdit_5.text())
            req.A6 = float(self.angleLineEdit_6.text())
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movj_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movj_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def movLByAnglePushButton_callback(self):
        print "MovL by angles."
        try:
            req = kr_joint_Type()
            req.A1 = float(self.angleLineEdit_1.text())
            req.A2 = float(self.angleLineEdit_2.text())
            req.A3 = float(self.angleLineEdit_3.text())
            req.A4 = float(self.angleLineEdit_4.text())
            req.A5 = float(self.angleLineEdit_5.text())
            req.A6 = float(self.angleLineEdit_6.text())
            if self.moveArmSelDial.value() == 1:
                resp = kr1_movl_byjoint(req)
            elif self.moveArmSelDial.value() == 2:
                resp = kr2_movl_byjoint(req)
            del req
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
    # ------------------ Manual Move Joy End ------------------

def shutdown(signal_number, unused_frame):
    rospy.loginfo("Signalled shutdown.")
    app.exit()


if __name__ == "__main__":
    app = QApplication(sys.argv)

    self_dir = os.path.dirname(os.path.realpath(__file__))
    ui_dir = os.path.join(self_dir, './')
    icon16_file = os.path.join(ui_dir, 'icons/16x16.png')
    icon24_file = os.path.join(ui_dir, 'icons/24x24.png')
    icon32_file = os.path.join(ui_dir, 'icons/32x32.png')
    icon48_file = os.path.join(ui_dir, 'icons/48x48.png')
    icon256_file = os.path.join(ui_dir, 'icons/256x256.png')
    app_icon = QtGui.QIcon()
    app_icon.addFile(icon16_file, QSize(16, 16))
    app_icon.addFile(icon24_file, QSize(24, 24))
    app_icon.addFile(icon32_file, QSize(32, 32))
    app_icon.addFile(icon48_file, QSize(48, 48))
    app_icon.addFile(icon256_file, QSize(256, 256))
    app.setWindowIcon(app_icon)

    myWin = MyMainWindow()
    myWin.show()
    #myWin.showMaximized()
    #myWin.showFullScreen()

    signal.signal(signal.SIGINT, shutdown)
    tm = QTimer()
    tm.start(500)
    tm.timeout.connect(lambda: None)
    result = app.exec_()
    rospy.signal_shutdown("Manual shutdown.")
    sys.exit(result)
