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
        self.clone_birdView_msg = Image()
        self.clone_birdViewCam1_msg = Image()
        self.clone_rearViewL_msg = Image()
        self.clone_rearViewR_msg = Image()
        self.clone_lidarLViz_msg = MarkerArray()
        self.clone_lidarRViz_msg = MarkerArray()
        self.clone_lt_msg = lt_state_Type()
        self.clone_kr1lt_timestamp = 0
        self.clone_kr2lt_timestamp = 0
        self.clone_kr1_msg = kr_robot_state_Type()
        self.clone_kr2_msg = kr_robot_state_Type()
        self.clone_ac_msg = ac_state_Type()
        self.clone_sio_msg = sio_state_Type()
        self.clone_ps_msg = ps_state_Type()
        self.clone_lr_msg = lr_state_Type()
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
        self.cameraRadarCursor_x = 0
        self.cameraRadarCursor_y = 0
        self.msgBVBuffMutex = Lock()
        self.msgRVBuffMutex = Lock()
        self.msgLidLBuffMutex = Lock()
        self.msgLidRBuffMutex = Lock()
        self.msgRadFBuffMutex = Lock()
        self.msgKr1BuffMutex = Lock()
        self.msgKr2BuffMutex = Lock()
        self.msgAcBuffMutex = Lock()
        self.audioMutex = Lock()
        self.bridge = CvBridge()
        self.run_SystemOnProcedureSkipTime = 0.0
#        self.speedPlotDivCounter = 0
#        self.cycleMarkTimestamp = 0
        self.batteryWarnCounter = 0
        self.rearArmPrevSM = 0
        self.rearArmEstTimeToReady = 0
        self.PlaceCollectMode = 0

        # Load files. Create HMI/gui - by loadui plugin direct create from .ui
        self_dir = os.path.dirname(os.path.realpath(__file__))
        self.ui_dir = os.path.join(self_dir, './')
        ui_file = os.path.join(self.ui_dir, 'MainWindow.ui')
        loadUi(ui_file, self)
 #       img_file = os.path.join(self.ui_dir, 'RedLightS.jpg')
 #       self.imgRedLightQPixmap = QPixmap(img_file)
 #       img_file = os.path.join(self.ui_dir, 'YellowLightS.jpg')
 #       self.imgYellowLightQPixmap = QPixmap(img_file)
 #       img_file = os.path.join(self.ui_dir, 'GreenLightS.jpg')
 #       self.imgGreenLightQPixmap = QPixmap(img_file)
        img_file = os.path.join(self.ui_dir, 'radarmap_bg.png')
        self.imgRadarMapBGOrg = cv2.imread(img_file)
        self.imgRadarMapBGPlain = cv2.imread(img_file)

        # Configure audio
        self.audioSampleRate = 44100.0
        self.volume = 32767
        self.audioBufTime = 0.2
        self.audioBufSize = int(self.audioSampleRate * self.audioBufTime * 2)     # x2 bytes
        format = QAudioFormat()
        format.setChannelCount(1)
        format.setSampleRate(int(self.audioSampleRate))
        format.setSampleSize(16)
        format.setCodec("audio/pcm")
        format.setByteOrder(QAudioFormat.LittleEndian)
        format.setSampleType(QAudioFormat.SignedInt)
        self.audioOutput = QAudioOutput(format, self)
        self.audioOutput.setBufferSize(self.audioBufSize)
        self.audioOutputIO = self.audioOutput.start()
        self.alertTonePrevTimestamp = 0

        # Enable mouse event
        self.setMouseTracking(True)

        # Connect UI events to callbacks
        # ------------------ All Tab ------------------
        self.allMoveStopPushButton_1.clicked.connect(self.allMoveStopPushButton_callback)
        self.allMoveStopPushButton_2.clicked.connect(self.allMoveStopPushButton_callback)
        self.allMoveStopPushButton_3.clicked.connect(self.allMoveStopPushButton_callback)
        self.allMoveStopPushButton_4.clicked.connect(self.allMoveStopPushButton_callback)

        # ------------------ Dashboard Tab ------------------
        self.rearSliderPushButton.clicked.connect(self.rearSliderPushButton_callback)
        self.coneSliderPushButton.clicked.connect(self.coneSliderPushButton_callback)
        self.airPumpPushButton.clicked.connect(self.airPumpPushButton_callback)
        self.arrowLightPushButton.clicked.connect(self.arrowLightPushButton_callback)

        self.lanternRackModeRadioButton_0.toggled.connect(lambda: self.lanternRackModeRadioButton_callback(0))
        self.lanternRackModeRadioButton_1.toggled.connect(lambda: self.lanternRackModeRadioButton_callback(1))
        self.lanternRackModeRadioButton_2.toggled.connect(lambda: self.lanternRackModeRadioButton_callback(2))
        self.lanternRackModeRadioButton_3.toggled.connect(lambda: self.lanternRackModeRadioButton_callback(99))

        self.inverterOnPushButton_0.clicked.connect(self.inverter0OnPushButton_callback)
        self.inverterOnPushButton_1.clicked.connect(self.inverter1OnPushButton_callback)

        self.autoExPushButton_0.clicked.connect(self.start_auto_ex_button1_callback)
        self.autoExPushButton_1.clicked.connect(self.start_auto_ex_button2_callback)
        self. moveEnablePushButton_0.clicked.connect(self.disable_move_button1_callback)
        self. moveEnablePushButton_1.clicked.connect(self.disable_move_button2_callback)
        self.errorCodePushButton_0.clicked.connect(self.stop_move_button1_callback)
        self.errorCodePushButton_1.clicked.connect(self.stop_move_button2_callback)

        self.goSafeHomeButton_0.clicked.connect(self.goSafeHome_button1_callback)
        self.goSafeHomeButton_1.clicked.connect(self.goSafeHome_button2_callback)

        self.shutdownSystemPushButton.clicked.connect(self.shutdownSystem_button_callback)

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

        # ------------------ AutoCone Tab ------------------
        self.ConeCollectButton.clicked.connect(self.goConeCollect_button_callback)
        self.ConePlaceButton.clicked.connect(self.goConePlace_button_callback)
        self.ChangeTargetButton.clicked.connect(self.changeTarget_button_callback)
        self.ChangeRoadmarkButton.clicked.connect(self.changeRoadmark_button_callback)
        self.ConePlaceStartYPosPushButton_0.clicked.connect(self.conePlaceStartYPos_button_0_callback)
        self.ConePlaceEndYPosPushButton_0.clicked.connect(self.conePlaceEndYPos_button_0_callback)
        self.ConePlaceStartYPosPushButton_1.clicked.connect(self.conePlaceStartYPos_button_1_callback)
        self.ConePlaceEndYPosPushButton_1.clicked.connect(self.conePlaceEndYPos_button_1_callback)
        self.ConePlaceStartYPosPushButton_2.clicked.connect(self.conePlaceStartYPos_button_2_callback)
        self.ConePlaceEndYPosPushButton_2.clicked.connect(self.conePlaceEndYPos_button_2_callback)

        # ------------------ Extended Function Tab ------------------
        self.conePlaceConvButton.clicked.connect(self.conePlaceConv_button_callback)
        self.StandPlaceButton_0.clicked.connect(lambda: self.StandPlace_button_callback(0))
        self.StandPlaceButton_1.clicked.connect(lambda: self.StandPlace_button_callback(1))
        self.StandPlaceButton_2.clicked.connect(lambda: self.StandPlace_button_callback(2))
        self.StandCollectButton_0.clicked.connect(lambda: self.StandCollect_button_callback(0))
        self.StandCollectButton_1.clicked.connect(lambda: self.StandCollect_button_callback(1))
        self.StandCollectButton_2.clicked.connect(lambda: self.StandCollect_button_callback(2))
        self.SignPlaceButton_0.clicked.connect(lambda: self.SignPlace_button_callback(0))
        self.SignPlaceButton_1.clicked.connect(lambda: self.SignPlace_button_callback(1))
        self.SignPlaceButton_2.clicked.connect(lambda: self.SignPlace_button_callback(2))
        self.SignCollectButton_0.clicked.connect(lambda: self.SignCollect_button_callback(0))
        self.SignCollectButton_1.clicked.connect(lambda: self.SignCollect_button_callback(1))
        self.SignCollectButton_2.clicked.connect(lambda: self.SignCollect_button_callback(2))
        #vvvvvSYvvvvv
        self.visionPushButton.clicked.connect(self.visionPushButton_callback)
        #^^^^^SY^^^^^

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
        global ac_change_line
        ac_change_line = rospy.ServiceProxy('/control/ac_change_line', ac_set_double_Args)
        global ac_go_coneinvcheck
        ac_go_coneinvcheck = rospy.ServiceProxy('/control/ac_go_coneinvcheck', ac_set_bool_Args)
        global ac_go_standplace
        ac_go_standplace = rospy.ServiceProxy('/control/ac_go_standplace', ac_go_signstand_Args)
        global ac_go_standcollect
        ac_go_standcollect = rospy.ServiceProxy('/control/ac_go_standcollect', ac_go_signstand_Args)
        global ac_go_signplace
        ac_go_signplace = rospy.ServiceProxy('/control/ac_go_signplace', ac_go_signstand_Args)
        global ac_go_signcollect
        ac_go_signcollect = rospy.ServiceProxy('/control/ac_go_signcollect', ac_go_signstand_Args)
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
        ##-----------------------SY---------------------------------------------------------
        global send_cali_data
        send_cali_data = rospy.ServiceProxy('/birdview_vision/vs_send_cali_data', vs_send_cali_data_Args)
        ##-----------------------SY---------------------------------------------------------

        rospy.Subscriber("birdview_vision/birdviewCam1_camera", Image, self.OnRxBirdViewCam1ImageMsg_callback, queue_size=10)
        rospy.Subscriber("birdview_vision/birdview_camera", Image, self.OnRxBirdViewImageMsg_callback, queue_size=10)
        rospy.Subscriber("birdview_vision/birdviewr5_camera", Image, self.OnRxBirdViewR5ImageMsg_callback, queue_size=10)
        rospy.Subscriber("birdview_vision/birdviewr10_camera", Image, self.OnRxBirdViewR10ImageMsg_callback, queue_size=10)
        rospy.Subscriber("birdview_vision/birdviewr20_camera", Image, self.OnRxBirdViewR20ImageMsg_callback, queue_size=10)
        rospy.Subscriber("rearview_vision/rearviewl_camera", Image, self.OnRxRearViewLImageMsg_callback, queue_size=10)
        rospy.Subscriber("rearview_vision/rearviewr_camera", Image, self.OnRxRearViewRImageMsg_callback, queue_size=10)
        rospy.Subscriber("rear_detector/lmsRL_markers_drop", MarkerArray, self.OnRxLidarLeftMsg_callback, queue_size=10)
        rospy.Subscriber("rear_detector/lmsRR_markers_drop", MarkerArray, self.OnRxLidarRightMsg_callback, queue_size=10)
        rospy.Subscriber("rear_detector/lt_state_drop", lt_state_Type, self.OnRxRadarFusedMsg_callback, queue_size=10)
        rospy.Subscriber("kr1_detector/lt_state", lt_state_Type, self.OnRxLidarKr1Msg_callback, queue_size=10)
        rospy.Subscriber("kr2_detector/lt_state", lt_state_Type, self.OnRxLidarKr2Msg_callback, queue_size=10)
        rospy.Subscriber("kr1/kr_state_drop", kr_robot_state_Type, self.OnRxKr1StateMsg_callback, queue_size=10)
        rospy.Subscriber("kr2/kr_state_drop", kr_robot_state_Type, self.OnRxKr2StateMsg_callback, queue_size=10)
        rospy.Subscriber("control/ac_state_drop", ac_state_Type, self.OnRxAcStateMsg_callback, queue_size=10)
        rospy.Subscriber("sys_io/sio_state", sio_state_Type, self.OnRxSioStateMsg_callback, queue_size=10)
        rospy.Subscriber("pwr_sys/ps_state", ps_state_Type, self.OnRxPsStateMsg_callback, queue_size=10)
        rospy.Subscriber("lantern_plc/lr_state", lr_state_Type, self.OnRxLrStateMsg_callback, queue_size=10)

        # Timer for sync GUI update, at 50 Hz
        self.timerBgPE = QTimer()
        self.timerBgPE.timeout.connect(self.bgGUISyncProcessEvent)
        self.timerBgPE.start(20)
        #for testing only
        #self.updateGUI_RadarUpdate()
        #self.updateGUI_AcState()

    # vvvvvSYvvvvv
    # Callback for calibration
    def visionPushButton_callback(self, msg):
        cali_data_0 = int(self.visionLineEdit_0.text())
        cali_data_1 = int(self.visionLineEdit_1.text())
        cali_data_2 = int(self.visionLineEdit_2.text())
        cali_data_3 = int(self.visionLineEdit_3.text())
        cali_data_4 = int(self.visionLineEdit_4.text())
        cali_data_5 = int(self.visionLineEdit_5.text())
        cali_data_6 = int(self.visionLineEdit_6.text())
        cali_data_7 = int(self.visionLineEdit_7.text())
        IS_HD_image = bool(self.HDimageCheckBox.isChecked())
        #print('---------------------------visionPushButton_callback----------------------------')
        #print(IS_HD_image)
        #print('---------------------------visionPushButton_callback----------------------------')
        try:
            resp = send_cali_data(cali_data_0, cali_data_1,cali_data_2,cali_data_3,cali_data_4,cali_data_5,cali_data_6,cali_data_7,IS_HD_image)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    #^^^^^SY^^^^^


    # Callback handling for rx topics msg (tasks created by ROS), to avoid QT GUI cross task accessing
    def OnRxBirdViewCam1ImageMsg_callback(self, msg):
        self.msgBVBuffMutex.acquire()
        self.clone_birdViewCam1_msg = copy.copy(msg)
        self.msgBVBuffMutex.release()

    def OnRxBirdViewImageMsg_callback(self, msg):
        self.msgBVBuffMutex.acquire()
        self.clone_birdView_msg = copy.copy(msg)
        self.msgBVBuffMutex.release()

    def OnRxBirdViewR5ImageMsg_callback(self, msg):
        if self.radarZoomComboBox.currentIndex() == 0:
            imgRadarMap = self.bridge.imgmsg_to_cv2(msg, "bgr8")  # to be used in RadarFused update
            if self.radarMapMaskCheckBox.isChecked() == True:
                self.imgRadarMapBGOrg = cv2.addWeighted(self.imgRadarMapBGPlain, 0.8, imgRadarMap, 0.2, 0)
            else:
                self.imgRadarMapBGOrg = imgRadarMap

    def OnRxBirdViewR10ImageMsg_callback(self, msg):
        if self.radarZoomComboBox.currentIndex() == 1:
            imgRadarMap = self.bridge.imgmsg_to_cv2(msg, "bgr8")  # to be used in RadarFused update
            if self.radarMapMaskCheckBox.isChecked() == True:
                self.imgRadarMapBGOrg = cv2.addWeighted(self.imgRadarMapBGPlain, 0.8, imgRadarMap, 0.2, 0)
            else:
                self.imgRadarMapBGOrg = imgRadarMap

    def OnRxBirdViewR20ImageMsg_callback(self, msg):
        if self.radarZoomComboBox.currentIndex() == 2:
            imgRadarMap = self.bridge.imgmsg_to_cv2(msg, "bgr8")  # to be used in RadarFused update
            if self.radarMapMaskCheckBox.isChecked() == True:
                self.imgRadarMapBGOrg = cv2.addWeighted(self.imgRadarMapBGPlain, 0.8, imgRadarMap, 0.2, 0)
            else:
                self.imgRadarMapBGOrg = imgRadarMap

    def OnRxRearViewLImageMsg_callback(self, msg):
        self.msgRVBuffMutex.acquire()
        self.clone_rearViewL_msg = copy.copy(msg)
        self.msgRVBuffMutex.release()

    def OnRxRearViewRImageMsg_callback(self, msg):
        self.msgRVBuffMutex.acquire()
        self.clone_rearViewR_msg = copy.copy(msg)
        self.msgRVBuffMutex.release()

    def OnRxLidarLeftMsg_callback(self, msg):
        self.msgLidLBuffMutex.acquire()
        self.clone_lidarLViz_msg = copy.copy(msg)
        self.msgLidLBuffMutex.release()

    def OnRxLidarRightMsg_callback(self, msg):
        self.msgLidRBuffMutex.acquire()
        self.clone_lidarRViz_msg = copy.copy(msg)
        self.msgLidRBuffMutex.release()

    def OnRxRadarFusedMsg_callback(self, msg):
        self.msgRadFBuffMutex.acquire()
        self.clone_lt_msg = copy.copy(msg)
        self.msgRadFBuffMutex.release()

    def OnRxLidarKr1Msg_callback(self, msg):
        self.clone_kr1lt_timestamp = msg.timestamp

    def OnRxLidarKr2Msg_callback(self, msg):
        self.clone_kr2lt_timestamp = msg.timestamp

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

    def OnRxPsStateMsg_callback(self, msg):
        self.clone_ps_msg = copy.deepcopy(msg)

    def OnRxLrStateMsg_callback(self, msg):
        self.clone_lr_msg = copy.deepcopy(msg)


    # Timer handling (in GUI task) for sync GUI update, at 50 Hz
    def bgGUISyncProcessEvent(self):
        now_ts = rospy.Time.now()
        now_sec = now_ts.secs + (now_ts.nsecs/1000000000.0)
        if (now_sec - self.clone_sio_msg.timestamp) < 1.0:
            self.ioCommLabel_0.setText("OK")
            self.updateGUI_SioState()
        elif (now_sec - self.clone_sio_msg.timestamp) < 4.0:
            self.ioCommLabel_0.setText("Waiting")
        else:
            self.ioCommLabel_0.setText("Offline")
        stamp_sec = self.clone_birdView_msg.header.stamp.secs + (self.clone_birdView_msg.header.stamp.nsecs/1000000000.0)
        if (now_sec - stamp_sec) < 1.0:
            self.birdViewCameraCommLabel_0.setText("OK")
            self.updateGUI_BirdViewImage()
        elif (now_sec - stamp_sec) < 4.0:
            self.birdViewCameraCommLabel_0.setText("Waiting")
        else:
            self.birdViewCameraCommLabel_0.setText("Offline")
        stamp_sec = self.clone_rearViewL_msg.header.stamp.secs + (self.clone_rearViewL_msg.header.stamp.nsecs/1000000000.0)
        if (now_sec - stamp_sec) < 1.0:
            self.rearViewCameraCommLabel_0.setText("OK")
            self.updateGUI_RearViewImage()
        elif (now_sec - stamp_sec) < 4.0:
            self.rearViewCameraCommLabel_0.setText("Waiting")
        else:
            self.rearViewCameraCommLabel_0.setText("Offline")
        if (now_sec - self.clone_lt_msg.timestamp) < 1.0:
            self.rearLidarCommLabel_0.setText("OK")
            self.updateGUI_RadarUpdate()
        elif (now_sec - self.clone_lt_msg.timestamp) < 4.0:
            self.rearLidarCommLabel_0.setText("Waiting")
        else:
            self.rearLidarCommLabel_0.setText("Offline")
        if (now_sec - self.clone_ps_msg.timestamp) < 3.0:
            self.powerSysCommLabel_0.setText("OK")
            self.powerSysCommLabel_1.setText("OK")
            self.systemStatusGroupBox.setEnabled(True)
            self.updateGUI_PsState()
        elif (now_sec - self.clone_ps_msg.timestamp) < 6.0:
            self.powerSysCommLabel_0.setText("Waiting")
            self.powerSysCommLabel_1.setText("Waiting")
            self.systemStatusGroupBox.setEnabled(True)
        else:
            self.powerSysCommLabel_0.setText("Offline")
            self.powerSysCommLabel_1.setText("Offline")
            self.systemStatusGroupBox.setEnabled(False)
        if (now_sec - self.clone_kr1_msg.timestamp) < 0.3:
            self.robotCommLabel_0.setText("OK")
            self.reararmgroupBox.setEnabled(True)
            self.updateGUI_Kr1State()
        elif (now_sec - self.clone_kr1_msg.timestamp) < 3.3:
            self.robotCommLabel_0.setText("Waiting")
            self.reararmgroupBox.setEnabled(False)
        else:
            self.robotCommLabel_0.setText("Offline")
            self.reararmgroupBox.setEnabled(False)
        if (now_sec - self.clone_kr2_msg.timestamp) < 0.3:
            self.robotCommLabel_1.setText("OK")
            self.frontarmgroupBox.setEnabled(True)
            self.updateGUI_Kr2State()
        elif (now_sec - self.clone_kr2_msg.timestamp) < 3.3:
            self.robotCommLabel_1.setText("Waiting")
            self.frontarmgroupBox.setEnabled(False)
        else:
            self.robotCommLabel_1.setText("Offline")
            self.frontarmgroupBox.setEnabled(False)
        if (now_sec - self.clone_kr1lt_timestamp) < 1.0:
            self.armLidarCommLabel_0.setText("OK")
        elif (now_sec - self.clone_kr1lt_timestamp) < 4.0:
            self.armLidarCommLabel_0.setText("Waiting")
        else:
            self.armLidarCommLabel_0.setText("Offline")
        if (now_sec - self.clone_kr2lt_timestamp) < 1.0:
            self.armLidarCommLabel_1.setText("OK")
        elif (now_sec - self.clone_kr2lt_timestamp) < 4.0:
            self.armLidarCommLabel_1.setText("Waiting")
        else:
            self.armLidarCommLabel_1.setText("Offline")
        if (now_sec - self.clone_lr_msg.timestamp) < 4.0:
            self.lanternRackCommLabel_0.setText("OK")
            self.updateGUI_LrState()
        elif (now_sec - self.clone_lr_msg.timestamp) < 7.0:
            self.lanternRackCommLabel_0.setText("Waiting")
        else:
            self.lanternRackCommLabel_0.setText("Offline")
        if (now_sec - self.clone_ac_msg.timestamp) < 1.0:
            self.autoControlCommLabel_0.setText("OK")
            self.updateGUI_AcState()
        elif (now_sec - self.clone_ac_msg.timestamp) < 4.0:
            self.autoControlCommLabel_0.setText("Waiting")
        else:
            self.autoControlCommLabel_0.setText("Offline")
        app.processEvents()
        if self.startSystemPushButton.isChecked() == True:
            self.run_SystemOnProcedure()

    def check_SystemGoodCondition(self):
        if self.rearLidarCommLabel_0.text() != "OK":
            QMessageBox.warning(self, "警告", "後激光雷達系統有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.armLidarCommLabel_0.text() != "OK":
            QMessageBox.warning(self, "警告", "後臂手部傳感器有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.armLidarCommLabel_1.text() != "OK":
            QMessageBox.warning(self, "警告", "前臂手部傳感器有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.robotCommLabel_0.text() != "OK":
            QMessageBox.warning(self, "警告", "後手臂有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.robotCommLabel_1.text() != "OK":
            QMessageBox.warning(self, "警告", "前手臂有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.ioCommLabel_0.text() != "OK":
            QMessageBox.warning(self, "警告", "輸入輸出系統有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.lanternRackCommLabel_0.text() != "OK":
            QMessageBox.warning(self, "警告", "燈架系統有問題，請檢查.", QMessageBox.Yes)
            return False
        if self.autoControlCommLabel_0.text() != "OK":
            QMessageBox.warning(self, "警告", "自動控制軟件系統有問題，請檢查.", QMessageBox.Yes)
            return False
        if int(self.coneStorageLabel_0.text()) > 23 or int(self.coneStorageLabel_1.text()) > 23 or int(self.coneStorageLabel_2.text()) > 23 or int(self.coneStorageLabel_0.text()) < 0 or int(self.coneStorageLabel_1.text()) < 0 or int(self.coneStorageLabel_2.text()) < 0:
            QMessageBox.warning(self, "警告", "雪糕筒存儲艙讀數無效，請將前手臂移動到HOME位置，並檢查存儲艙傳感器.", QMessageBox.Yes)
            return False
        return True

    # Handle auto system on procedure
    def run_SystemOnProcedure(self):
        now_ts = rospy.Time.now()
        now_sec = now_ts.secs + (now_ts.nsecs / 1000000000.0)
        if self.run_SystemOnProcedureSkipTime > now_sec:
            return
        if self.powerSysCommLabel_1.text() == "Offline":
            self.startSystemStatusLabel.setText("檢查與變壓器1的連接")
            return
        if self.clone_ps_msg.mcb_sw_pos[1] != 1:
            self.startSystemStatusLabel.setText("啟動變壓器(1)")
            self.run_SystemOnProcedureSkipTime = now_sec + 2.0
            self.inverter1OnPushButton_callback()
            return
        if self.inverterLabel_1.text() == "???":
            self.startSystemStatusLabel.setText("等待380v/220v上電")
            return
        if self.robotCommLabel_0.text() == "Offline":
            self.startSystemStatusLabel.setText("等待後機械臂(kr1)上電")
            return
        if self.robotCommLabel_1.text() == "Offline":
            self.startSystemStatusLabel.setText("等待前機械臂(kr2)上電")
            return
        if self.robotCommLabel_0.text() != "OK":
            self.startSystemStatusLabel.setText("等待後機械臂(kr1)載入程序")
            self.run_SystemOnProcedureSkipTime = now_sec + 5.0
            return
        if self.robotCommLabel_1.text() != "OK":
            self.startSystemStatusLabel.setText("等待前機械臂(kr2)載入程序")
            self.run_SystemOnProcedureSkipTime = now_sec + 5.0
            return
        if self.clone_kr1_msg.com_autext_start != True:
            self.startSystemStatusLabel.setText("啟動後機械臂(kr1)AutoEx")
            self.start_auto_ex_button1_callback()
            self.run_SystemOnProcedureSkipTime = now_sec + 3.0
            return
#        if self.clone_kr1_msg.com_motstop != 0:
#            self.startSystemStatusLabel.setText("重置後機械臂(kr1)錯誤狀態")
#            self.run_SystemOnProcedureSkipTime = now_sec + 1.0
#            return
        if self.clone_kr2_msg.com_autext_start != True:
            self.startSystemStatusLabel.setText("啟動前機械臂(kr2)AutoEx")
            self.start_auto_ex_button2_callback()
            self.run_SystemOnProcedureSkipTime = now_sec + 3.0
            return
#        if self.clone_kr2_msg.com_motstop != 0:
#            self.startSystemStatusLabel.setText("重置前機械臂(kr2)錯誤狀態")
#            self.run_SystemOnProcedureSkipTime = now_sec + 1.0
#            return
        self.startSystemStatusLabel.setText("準備就緒")
        self.startSystemPushButton.setChecked(False)
        self.startSystemPushButton.setEnabled(False)

    # Update GUI periodically by ROS msg
    # Bird View Image show
    def updateGUI_BirdViewImage(self):
        self.msgBVBuffMutex.acquire()
        #vv change
        if self.birdViewSelectionComboBox.currentIndex() == 0:
            msg = copy.copy(self.clone_birdViewCam1_msg)
        else:
            msg = copy.copy(self.clone_birdView_msg)
        #^^ change
        self.msgBVBuffMutex.release()
        timestamp = msg.header.stamp.nsecs
        if self.prevBirdViewImageTimestamp > timestamp:
            timestamp = timestamp + 1000000000.0
        timeElapsed = timestamp - self.prevBirdViewImageTimestamp
        self.prevBirdViewImageTimestamp = msg.header.stamp.nsecs
        if timeElapsed <= 0:
            return
        refreshHz = 1000000000.0 / timeElapsed
        refreshTxt = "{: 5.2f}fps"
        fps = refreshTxt.format(refreshHz)
        cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
        cv2.putText(cv_image, fps, (5, 20), cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.8, (0, 255, 255), 1, cv2.LINE_AA)
        rgb_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2RGB)
        cvt2qt = QImage(rgb_image.data, rgb_image.shape[1], rgb_image.shape[0], QImage.Format_RGB888)
        self.camera360Label.setPixmap(QPixmap.fromImage(cvt2qt))

    # Rear View Image show
    def updateGUI_RearViewImage(self):
        self.msgRVBuffMutex.acquire()
        if self.rearViewSelectionComboBox.currentIndex() == 0:
            msg = copy.copy(self.clone_rearViewL_msg)
        else:
            msg = copy.copy(self.clone_rearViewR_msg)
        self.msgRVBuffMutex.release()
        timestamp = msg.header.stamp.nsecs
        if self.prevRearViewImageTimestamp > timestamp:
            timestamp = timestamp + 1000000000.0
        timeElapsed = timestamp - self.prevRearViewImageTimestamp
        self.prevRearViewImageTimestamp = msg.header.stamp.nsecs
        if timeElapsed <= 0:
            return
        refreshHz = 1000000000.0 / timeElapsed
        refreshTxt = "{: 5.2f}fps"
        fps = refreshTxt.format(refreshHz)
        cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
        cv2.putText(cv_image, fps, (5, 20), cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.8, (0, 255, 255), 1, cv2.LINE_AA)
        rgb_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2RGB)
        cvt2qt = QImage(rgb_image.data, rgb_image.shape[1], rgb_image.shape[0], QImage.Format_RGB888)
        self.cameraRearLabel.setPixmap(QPixmap.fromImage(cvt2qt))

    # Radar Image show, by lidar tracker topic, augmented into imgRadarMapBGOrg
    def updateGUI_RadarUpdate(self):
        self.msgRadFBuffMutex.acquire()
        msg = copy.copy(self.clone_lt_msg)
        self.msgRadFBuffMutex.release()
        timeElapsed = msg.timestamp - self.prevRadarImageTimestamp
        self.prevRadarImageTimestamp = msg.timestamp
        if timeElapsed <= 0:
            return
        imgRadarMapBG = copy.copy(self.imgRadarMapBGOrg)
        (rows, cols, channels) = self.imgRadarMapBGOrg.shape
        cen_px_x = int(rows/2)
        # 1px = 1cm, 10mm
        mm2px = 1 / 10.0
        if self.radarZoomComboBox.currentIndex() == 1:
            # 1px = 2cm, 20mm
            mm2px = 1/20.0
        elif self.radarZoomComboBox.currentIndex() == 2:
            # 1px = 4cm, 40mm
            mm2px = 1/40.0
        # Draw grid lines
        cv2.rectangle(imgRadarMapBG, (cen_px_x-int(1200.0*mm2px), 0), (cen_px_x+int(1200.0*mm2px), int(250.0*mm2px)), (51, 51, 204), -1)
        cv2.circle(imgRadarMapBG,(cen_px_x, 0), int(1000.0*mm2px), (0, 0, 0), 3)
        cv2.circle(imgRadarMapBG,(cen_px_x, 0), int(2000.0*mm2px), (0, 0, 0), 2)
        for i in range(2, 20):
            cv2.circle(imgRadarMapBG,(cen_px_x, 0), int(i*1000.0*mm2px + 1000.0*mm2px), (0, 0, 0), 1)
        cv2.line(imgRadarMapBG, (cen_px_x-int(1500.0*mm2px), 0), (cen_px_x-int(1500.0*mm2px), cols), (0, 0, 0), 1)
        cv2.line(imgRadarMapBG, (cen_px_x, 0), (cen_px_x, cols), (0, 0, 0), 1)
        cv2.line(imgRadarMapBG, (cen_px_x+int(1500.0*mm2px), 0), (cen_px_x+int(1500.0*mm2px), cols), (0, 0, 0), 1)
        # Show X, Y axis label (in robot space)
        cv2.putText(imgRadarMapBG, "X", (cen_px_x+10, cols-10), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 0, 0), 1, cv2.LINE_AA)
        cv2.putText(imgRadarMapBG, "Y", (cen_px_x+int(1200.0*mm2px)+3, 10), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 0, 0), 1, cv2.LINE_AA)
        cv2.putText(imgRadarMapBG, "-Y", (cen_px_x-int(1200.0*mm2px)-15, 10), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 0, 0), 1, cv2.LINE_AA)
        # Draw operating zone line
        oz_axes = (int(1880.0*mm2px), int(1880.0*mm2px))
        oz_startAngle = 37;
        oz_endAngle = 180-oz_startAngle;
        cv2.ellipse(imgRadarMapBG,(cen_px_x, int(((170.0+270.0)-660.0)*mm2px)), oz_axes, 0, oz_startAngle, oz_endAngle, (51, 51, 204), 2)
        cv2.line(imgRadarMapBG, (cen_px_x-int(1500.0*mm2px), int((1350.0-660.0)*mm2px)), (cen_px_x+int(1500.0*mm2px), int((1350.0-660.0)*mm2px)), (51, 51, 204), 2)
        cv2.line(imgRadarMapBG, (cen_px_x-int(1500.0*mm2px), int((1580.0-660.0)*mm2px)), (cen_px_x-int(1500.0*mm2px), int((1350.0-660.0)*mm2px)), (51, 51, 204), 2)
        cv2.line(imgRadarMapBG, (cen_px_x+int(1500.0*mm2px), int((1580.0-660.0)*mm2px)), (cen_px_x+int(1500.0*mm2px), int((1350.0-660.0)*mm2px)), (51, 51, 204), 2)
        # Draw placement line and target placement gauge line
        drawPlaceStartLineX = int((float(self.ConePlaceStartYPosPushButton_0.text())*1000.0)*mm2px)
        drawPlaceEndLineX = int((float(self.ConePlaceEndYPosPushButton_0.text())*1000.0)*mm2px)
        cv2.line(imgRadarMapBG, (cen_px_x+drawPlaceStartLineX, int((1350.0-660.0)*mm2px)), (cen_px_x+drawPlaceStartLineX, int((1650.0-660.0)*mm2px)), (255, 0, 0), 2)
        cv2.line(imgRadarMapBG, (cen_px_x+drawPlaceEndLineX, int((1350.0-660.0)*mm2px)), (cen_px_x+drawPlaceEndLineX, int((1650.0-660.0)*mm2px)), (255, 0, 0), 2)
        cv2.line(imgRadarMapBG, (cen_px_x-int(1400.0*mm2px), int((1550.0-660.0)*mm2px)), (cen_px_x+int(1400.0*mm2px), int((1550.0-660.0)*mm2px)), (255, 0, 0), 2)
        cv2.circle(imgRadarMapBG, (cen_px_x+drawPlaceStartLineX, int((1550.0-660.0)*mm2px)), 3, (0, 0, 255), -1)
        cv2.circle(imgRadarMapBG, (cen_px_x+drawPlaceEndLineX, int((1550.0-660.0)*mm2px)), 3, (0, 0, 255), 1)
        #drawTargetLineY = int((float(self.ConeSpacingSpinBox_0.value())*1000.0 + (1550.0-660.0))*mm2px)
        #cv2.line(imgRadarMapBG, (cen_px_x-int(1400.0*mm2px), drawTargetLineY), (cen_px_x+int(1400.0*mm2px), drawTargetLineY), (204, 51, 51), 2)
        # Draw roadmark line position
#        self.clone_ac_msg.roadmarkline_pos_X = 1550.0
#        self.clone_ac_msg.roadmarkline_pos_Y = 1400.0
        drawpx = self.clone_ac_msg.roadmarkline_pos_Y
        drawpy = self.clone_ac_msg.roadmarkline_pos_X - 660.0
        cv2.line(imgRadarMapBG, (cen_px_x + int(drawpx*mm2px), int((drawpy-250.0)*mm2px)), (cen_px_x + int(drawpx*mm2px), int((drawpy+250.0)*mm2px)), (255, 255, 255), 2)
        cv2.line(imgRadarMapBG, (cen_px_x + int((drawpx-100.0)*mm2px), int(drawpy*mm2px)), (cen_px_x + int((drawpx+100.0)*mm2px), int(drawpy*mm2px)), (255, 255, 255), 2)
        # Draw lidar edges
        pointCloseToRearX = 9999.9
        pointCloseToRearY = 9999.9
        self.msgLidLBuffMutex.acquire()
        for marker in self.clone_lidarLViz_msg.markers:
            if marker.type == 8:
                prev_pt_x = int(-marker.points[0].y * 1000.0 * mm2px + cen_px_x)
                prev_pt_y = int(marker.points[0].x * 1000.0 * mm2px)
                for pt in marker.points:
                    if abs(pt.y) < 1.4 and pt.x > 0.2 and pt.x < pointCloseToRearX:
                        pointCloseToRearX = pt.x
                        pointCloseToRearY = pt.y
                    pt_x = int(-pt.y * 1000.0 * mm2px + cen_px_x)
                    pt_y = int(pt.x * 1000.0 * mm2px)
                    cv2.line(imgRadarMapBG, (prev_pt_x, prev_pt_y), (pt_x, pt_y), (255, 0, 255), 1)
                    cv2.circle(imgRadarMapBG, (pt_x, pt_y), 2, (0, 0, 255), -1)
                    prev_pt_x = pt_x
                    prev_pt_y = pt_y
        self.msgLidLBuffMutex.release()
        self.msgLidRBuffMutex.acquire()
        for marker in self.clone_lidarRViz_msg.markers:
            if marker.type == 8:
                prev_pt_x = int(-marker.points[0].y * 1000.0 * mm2px + cen_px_x)
                prev_pt_y = int(marker.points[0].x * 1000.0 * mm2px)
                for pt in marker.points:
                    if abs(pt.y) < 1.4 and pt.x > 0.2 and pt.x < pointCloseToRearX:
                        pointCloseToRearX = pt.x
                        pointCloseToRearY = pt.y
                    pt_x = int(-pt.y * 1000.0 * mm2px + cen_px_x)
                    pt_y = int(pt.x * 1000.0 * mm2px)
                    cv2.line(imgRadarMapBG, (prev_pt_x, prev_pt_y), (pt_x, pt_y), (255, 0, 128), 1)
                    cv2.circle(imgRadarMapBG, (pt_x, pt_y), 2, (255, 0, 0), -1)
                    prev_pt_x = pt_x
                    prev_pt_y = pt_y
        self.msgLidRBuffMutex.release()
        # Draw operating zone warning, lidar objects, fused, cone, targets
        objhalfsize = int(200*mm2px)
        zonemask_show = False
        in_opzone = False
        target_px_y = 0
        for obj in self.clone_lt_msg.objects:
            # Show zone mask if any object in operation zone
            in_opzone = self.checkInOperationZone(obj.CenterPoint.x, obj.CenterPoint.y)
            if zonemask_show != True and in_opzone == True:
                imgcrop = imgRadarMapBG[0:int((1350.0-660.0)*mm2px), 0:rows].copy()
                zonemask = imgRadarMapBG.copy()
                oz_startAngle = 29
                oz_endAngle = 180 - oz_startAngle
                cv2.ellipse(zonemask, (cen_px_x, int(((170.0 + 270.0) - 660.0) * mm2px)), oz_axes, 0,
                            oz_startAngle, oz_endAngle, (51, 51, 204), -1)
                imgRadarMapBG = cv2.addWeighted(imgRadarMapBG, 0.6, zonemask, 0.4, 0)
                imgRadarMapBG[0:int((1350.0-660.0)*mm2px), 0:rows] = imgcrop
                zonemask_show = True
            # Show all objects
            px_x = int(-obj.CenterPoint.y*1000.0*mm2px + cen_px_x)
            px_y = int(obj.CenterPoint.x*1000.0*mm2px)
            targetID = int(self.autoControlTargetIDLabel.text())
            if obj.ID == targetID:
                self.radarUpdateDrawTarget(imgRadarMapBG, px_x, px_y, objhalfsize, obj.ID)
                target_px_y = px_y
            elif obj.Is_Cone == True and obj.Is_Fused == True:
                self.radarUpdateDrawFusedConeObjects(imgRadarMapBG, px_x, px_y, objhalfsize, obj.ID)
            elif obj.Is_Cone == True:
                self.radarUpdateDrawConeObjects(imgRadarMapBG, px_x, px_y, objhalfsize, obj.ID)
            else:
                decpx_x = int(-obj.DecEdge.y * 1000.0 * mm2px + cen_px_x)
                decpx_y = int(obj.DecEdge.x * 1000.0 * mm2px)
                incpx_x = int(-obj.IncEdge.y * 1000.0 * mm2px + cen_px_x)
                incpx_y = int(obj.IncEdge.x * 1000.0 * mm2px)
                self.radarUpdateDrawObjects(imgRadarMapBG, decpx_x, decpx_y, px_x, px_y, incpx_x, incpx_y, int(objhalfsize*0.25), obj.ID)
        # Draw target line and its distance to go/reach
        if target_px_y != 0:
            cv2.line(imgRadarMapBG, (cen_px_x - int(1400.0 * mm2px), target_px_y), (cen_px_x + int(1400.0 * mm2px), target_px_y), (0, 0, 255), 2)
            DistTxt = self.targetDistanceLabel.text()
            cv2.putText(imgRadarMapBG, DistTxt, (cen_px_x + int(1400.0 * mm2px) + 10, target_px_y), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 2, cv2.LINE_AA)
        # Draw current robot TCP
        pt_x = int(self.clone_kr1_msg.pos_setpt.Y * mm2px + cen_px_x)
        pt_y = int((self.clone_kr1_msg.pos_setpt.X - 660.0) * mm2px)
        self.radarUpdateDrawRobotTCP(imgRadarMapBG, pt_x, pt_y, objhalfsize)
        # Draw circle of conflict point and alarm sound
        pt_x = int(-pointCloseToRearY * 1000.0 * mm2px + cen_px_x)
        pt_y = int(pointCloseToRearX * 1000.0 * mm2px)
        toneIntervalsec = abs(self.alertTonePrevTimestamp - self.clone_lt_msg.timestamp)
        if pointCloseToRearX < (1.4 - 0.66):                        # In arm dead zone, stop
            cv2.circle(imgRadarMapBG, (pt_x, pt_y), 8, (0, 0, 255), 4)
            if toneIntervalsec >= 0.18:                             # Long tone
                self.alertTonePrevTimestamp = self.clone_lt_msg.timestamp
                self.generateAudioTone(840, 0.2, False)
#        elif pointCloseToRearX < (2.0 - 0.66):                      # In arm op-zone, stop
#            cv2.circle(imgRadarMapBG, (pt_x, pt_y), 7, (0, 0, 255), 3)
#            if toneIntervalsec >= 0.11:                             # Almost Long tone
#                self.alertTonePrevTimestamp = self.clone_lt_msg.timestamp
#                self.generateAudioTone(840, 0.1, False)
#        elif pointCloseToRearX < (5.0 - 0.66):                      # Til arm op-zone edge, process with care
#            cv2.circle(imgRadarMapBG, (pt_x, pt_y), 5, (0, 255, 255), 2)
#            warningToneInterval = (pointCloseToRearX - (2.0 - 0.66)) / (5.0 - 2.0)
#            if toneIntervalsec >= warningToneInterval:              # Tone interval (0.1 ~ 1.0) according to dist
#                self.alertTonePrevTimestamp = self.clone_lt_msg.timestamp
#                self.generateAudioTone(840, 0.1, False)
        # Draw cursor finally (cameraRadarCursor is in LiDAR space)
        pt_x = int(-self.cameraRadarCursor_y * 1000.0 * mm2px + cen_px_x)
        pt_y = int(self.cameraRadarCursor_x * 1000.0 * mm2px)
        self.radarUpdateDrawCursor(imgRadarMapBG, pt_x, pt_y, objhalfsize)
        # Draw refresh rate and show image to HMI
        refreshHz = 1.0 / timeElapsed
        refreshTxt = "{: 5.2f}fps"
        fps = refreshTxt.format(refreshHz)
        cv2.putText(imgRadarMapBG, fps, (5, 20), cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.8, (0, 255, 255), 1, cv2.LINE_AA)
        rgb_image = cv2.cvtColor(imgRadarMapBG, cv2.COLOR_BGR2RGB)
        cvt2qt = QImage(rgb_image.data, rgb_image.shape[1], rgb_image.shape[0], QImage.Format_RGB888)
        if self.tabWidget.currentIndex() == 2:
            self.cameraRadarLabel.setPixmap(QPixmap.fromImage(cvt2qt))
        elif self.tabWidget.currentIndex() == 3:
            self.cameraRadarExtLabel.setPixmap(QPixmap.fromImage(cvt2qt))
    # CV draw functions
    def radarUpdateDrawCursor(self, img, x, y, half_size):
        x0 = x - 500
        x1 = x + 500
        y0 = y - 500
        y1 = y + 500
        halfline_size = half_size/2
        while x0 < x1:
            cv2.line(img, (x0, y), (x0+halfline_size, y), (0, 221, 0), 2)
            x0 = x0 + half_size
        while y0 < y1:
            cv2.line(img, (x, y0), (x, y0+halfline_size), (0, 221, 0), 2)
            y0 = y0 + half_size
        #cv2.line(img, (x-half_size, y), (x+half_size, y), (255, 0, 0), 1)
        #cv2.line(img, (x, y-half_size), (x, y+half_size), (255, 0, 0), 1)
        cv2.circle(img, (x, y), 3, (255, 0, 0), -1)
    def radarUpdateDrawRobotTCP(self, img, x, y, half_size):
        cv2.line(img, (x-half_size, y), (x, y-half_size), (255, 0, 255), 2)
        cv2.line(img, (x+half_size, y), (x, y-half_size), (255, 0, 255), 2)
#        cv2.line(img, (x+half_size, y), (x, y+half_size), (255, 0, 255), 2)
#        cv2.line(img, (x-half_size, y), (x, y+half_size), (255, 0, 255), 2)
        cv2.circle(img, (x, y), 3, (255, 0, 255), -1)
    def radarUpdateDrawTarget(self, img, x, y, half_size, ID):
        cv2.rectangle(img, (x-half_size, y-half_size), (x+half_size, y+half_size), (0, 0, 255), 1)
        inner_space = int(half_size*0.4)
        cv2.rectangle(img, (x-half_size+inner_space, y-half_size+inner_space), (x+half_size-inner_space, y+half_size-inner_space), (0, 0, 255), -1)
        IDTxt = "ID:" + str(ID)
        cv2.putText(img, IDTxt, (x-18, y-12), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 0, 255), 1, cv2.LINE_AA)
    def radarUpdateDrawFusedConeObjects(self, img, x, y, rad, ID):
        cv2.circle(img, (x, y), rad, (0, 128, 255), 1)
        inner_space = int(rad*0.4)
        cv2.circle(img, (x, y), rad-inner_space, (0, 128, 255), -1)
        IDTxt = "ID:" + str(ID)
        cv2.putText(img, IDTxt, (x-18, y-12), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 128, 255), 1, cv2.LINE_AA)
    def radarUpdateDrawConeObjects(self, img, x, y, rad, ID):
        inner_space = int(rad*0.4)
        cv2.circle(img, (x, y), rad-inner_space, (0, 128, 255), -1)
        IDTxt = "ID:" + str(ID)
        cv2.putText(img, IDTxt, (x-18, y-12), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 128, 255), 1, cv2.LINE_AA)
    def radarUpdateDrawObjects(self, img, dec_x, dec_y, x, y, inc_x, inc_y, width, ID):
        cv2.line(img, (dec_x, dec_y), (inc_x, inc_y), (0, 192, 0), 1)
        cv2.circle(img, (x, y), 3, (0, 255, 0), -1)
        cv2.circle(img, (dec_x, dec_y), 3, (0, 192, 0), -1)
        cv2.circle(img, (inc_x, inc_y), 3, (0, 192, 0), -1)
        IDTxt = "ID:" + str(ID)
        cv2.putText(img, IDTxt, (x-18, y-12), cv2.FONT_HERSHEY_SIMPLEX, 0.3, (0, 255, 0), 1, cv2.LINE_AA)
    def checkInOperationZone(self, x, y):
        x = x*1000.0 + 660.0           # lidar space to robot space for calculation
        y = -y*1000.0
        if 1350.0 > x:
            return False
        if 1500.0 < abs(y):
            return False
        basetoa5_x = x - (170.0 + 250.0)
        a5radius = math.sqrt(basetoa5_x * basetoa5_x + y * y)
        if 1880.0 < a5radius:
            return False
        return True

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
            self.krcModeStateLabel_0.setText("Mode:" + msg.mode_op + " On")
            self.autoExPushButton_0.setEnabled(False)
        else:
            self.autoExLabel_1.setText("AutoEx:N")
            self.startAutoExButton_1.setEnabled(True)
            self.krcModeStateLabel_0.setText("Mode:" + msg.mode_op + " Off")
            self.autoExPushButton_0.setEnabled(True)
        self.actionCodeLabel_1.setText("Act:" + str(msg.com_action))
        self.krActionCodeLabel_0.setText(str(msg.com_action))
        if msg.com_motstop == 0:
            self.resumeMoveButton_1.setEnabled(False)
            self.stopCodeLabel_1.setText("Norm:0")
            self.krStopCodeLabel_0.setText("Norm:0")
        elif msg.com_motstop == 1:
            self.resumeMoveButton_1.setEnabled(True)
            self.stopCodeLabel_1.setText("Pause:1")
            self.krStopCodeLabel_0.setText("Pause:1")
        else:
            self.resumeMoveButton_1.setEnabled(False)
            self.stopCodeLabel_1.setText("Stop:2")
            self.krStopCodeLabel_0.setText("Stop:2")
        self.errorCodeLabel_1.setText("Err:" + str(msg.com_error_no))
        self.errorCodePushButton_0.setText("Err:" + str(msg.com_error_no))
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
            self.krcModeStateLabel_1.setText("Mode:" + msg.mode_op + " On")
            self.autoExPushButton_1.setEnabled(False)
        else:
            self.autoExLabel_2.setText("AutoEx:N")
            self.startAutoExButton_2.setEnabled(True)
            self.krcModeStateLabel_1.setText("Mode:" + msg.mode_op + " Off")
            self.autoExPushButton_1.setEnabled(True)
        self.actionCodeLabel_2.setText("Act:" + str(msg.com_action))
        self.krActionCodeLabel_1.setText(str(msg.com_action))
        if msg.com_motstop == 0:
            self.resumeMoveButton_2.setEnabled(False)
            self.stopCodeLabel_2.setText("Norm:0")
            self.krStopCodeLabel_1.setText("Norm:0")
        elif msg.com_motstop == 1:
            self.resumeMoveButton_2.setEnabled(True)
            self.stopCodeLabel_2.setText("Pause:1")
            self.krStopCodeLabel_1.setText("Pause:1")
        else:
            self.resumeMoveButton_2.setEnabled(False)
            self.stopCodeLabel_2.setText("Stop:2")
            self.krStopCodeLabel_1.setText("Stop:2")
        self.errorCodeLabel_2.setText("Err:" + str(msg.com_error_no))
        self.errorCodePushButton_1.setText("Err:" + str(msg.com_error_no))
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
        self.autoControlStateLabel_1.setText(rearState + "," + frontState)
        self.autoControlStateLabel_2.setText(rearState + "," + frontState)
        self.autoControlStateLabel_3.setText(rearState + "," + frontState)
        self.autoControlStateLabel_4.setText(rearState + "," + frontState)
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
        if msg.reararm_sm != 1 or msg.frontarm_sm != 1:
            self.conePlaceGroupBox.setEnabled(False)
            self.coneCollectGroupBox.setEnabled(False)
        else:
            self.conePlaceGroupBox.setEnabled(True)
            self.coneCollectGroupBox.setEnabled(True)
        # Target Lock states
        targetID = int(self.autoControlTargetIDLabel.text())
        if targetID != msg.target_id:
            rospy.loginfo("Target changed from: " + str(targetID) + " to " + str(msg.target_id))
            # Alarm sound
            self.generateAudioDoubleTone(1240, 0.05, True)
        self.autoControlTargetIDLabel.setText(str(msg.target_id))
        positionTxt = "Y:{: 5.0f},X:{: 5.0f}"
        self.autoControlTargetPositionLabel.setText(positionTxt.format(msg.target_pos_Y, msg.target_pos_X))
        positionTxt = "{: 2.2f}m"
        workingLineX = 1550.0
        if self.clone_kr1_msg.pos_setpt.X > workingLineX:
            workingLineX = self.clone_kr1_msg.pos_setpt.X
        distInBetween = (msg.target_pos_X - workingLineX) / 1000.0
        if self.PlaceCollectMode == 0:                                      # in Placement mode, else in Collect
            placeTargetDist = float(self.ConeSpacingSpinBox_0.value())
            if msg.progress_place_count >= self.numOfConeToPlaceSpinBox_0.value():
                if msg.progress_place_count < (self.numOfConeToPlaceSpinBox_0.value() + self.numOfConeToPlaceSpinBox_1.value()):
                    placeTargetDist = float(self.ConeSpacingSpinBox_1.value())
                elif self.ConeSpacingSpinBox_2.value() > 0:
                    placeTargetDist = float(self.ConeSpacingSpinBox_2.value())
            distInBetween = placeTargetDist - distInBetween
        self.targetDistanceLabel.setText(positionTxt.format(distInBetween))
        speedTxt = "{: 2.2f}m/s"
        self.targetSpeedLabel.setText(speedTxt.format(msg.target_vel_X))
        targetSpeedPercent = int(abs(msg.target_vel_X / 1.00) * 100.0)       # 1.00m/s as progressbar max
        if targetSpeedPercent > 100:
            targetSpeedPercent = 100
        self.targetSpeedProgressBar.setValue(targetSpeedPercent)
        # msg.target_pos_Z
        # msg.target_vel_Y
        # msg.target_vel_Z
        # msg.target_acc_X
        # msg.target_acc_Y
        # msg.target_acc_Z
        #msg.roadmarkline_pos_X
        #msg.roadmarkline_pos_Y
        #msg.rearDetectObjectInDeadZone
        #msg.rearDetectObjectInPlaceZoneRight
        #msg.rearDetectObjectInPlaceZoneCenter
        #msg.rearDetectObjectInPlaceZoneLeft
        #msg.rearDetectNonLockObjectInOperationZone
        # Place and Collect progress
        self.numOfConePlaceProcessLabel_1.setText("/ " + str(msg.progress_place_in_total))
        self.numOfConeCollectProcessLabel_1.setText("/ " + str(msg.progress_collect_in_total))
        self.numOfConePlaceProcessLabel_0.setText(str(msg.progress_place_count))
        self.numOfConeCollectProcessLabel_0.setText(str(msg.progress_collect_count))
        # Cone Storage states
        self.coneStorageLabel_0.setText(str(msg.sb_cones_in_stack[0]))
        self.coneStorageLabel_1.setText(str(msg.sb_cones_in_stack[1]))
        self.coneStorageLabel_2.setText(str(msg.sb_cones_in_stack[2]))
        self.coneStorageLabel_3.setText(str(msg.sb_cones_in_stack[3]))
        self.coneStorageLabel_4.setText(str(msg.sb_cones_in_stack[4]))
        self.coneStorageLabel_5.setText(str(msg.sb_cones_in_stack[5]))
        self.coneStorageLabel_6.setText(str(msg.sb_cones_in_stack[6]))
        self.coneStorageLabel_7.setText(str(msg.sb_cones_in_stack[7]))
        self.coneStorageLabel_8.setText(str(msg.sb_cones_in_stack[8]))
        self.coneStorageLabel_9.setText(str(msg.sb_cones_in_stack[9]))
        self.coneStorageLabel_10.setText(str(msg.sb_cones_in_stack[10]))
        self.coneStorageLabel_11.setText(str(msg.sb_cones_in_stack[11]))
        self.coneStorageTotalLabel.setText(str(msg.sb_cones_in_total))
        """msg.sb_slider_position
        msg.sb_current_stack
        msg.sb_current_stacklevel"""
        # Loading Bay States
        self.loadingBayLabel_0.setText(str(msg.lb_left_slot))
        self.loadingBayLabel_1.setText(str(msg.lb_right_slot))
        # Lanterns Rack States
        self.lanternRackLabel_0.setText(str(msg.lr_lanterns_in_stack[0]))
        self.lanternRackLabel_1.setText(str(msg.lr_lanterns_in_stack[1]))
        self.lanternRackLabel_2.setText(str(msg.lr_lanterns_in_stack[2]))
        self.lanternRackLabel_3.setText(str(msg.lr_lanterns_in_stack[3]))
        self.lanternRackLabel_4.setText(str(msg.lr_lanterns_in_stack[4]))
        self.lanternRackLabel_5.setText(str(msg.lr_lanterns_in_stack[5]))
        self.lanternRackLabel_6.setText(str(msg.lr_lanterns_in_stack[6]))
        self.lanternRackLabel_7.setText(str(msg.lr_lanterns_in_stack[7]))
        self.lanternRackLabel_8.setText(str(msg.lr_lanterns_in_stack[8]))
        self.lanternRackLabel_9.setText(str(msg.lr_lanterns_in_stack[9]))
        self.lanternRackTotalLabel.setText(str(msg.lr_lanterns_in_total))
        """msg.lr_current_stack
        msg.lr_current_stacklevel"""
        # Identify rear robot arm cycle
        cycle_rate = 42.0 / (self.clone_kr1_msg.ov_pro + 0.01)
        approx_cycle_sec = 12.0 * cycle_rate  # approx cycle time at 42% is 12s
        smChanged = False
        now_ts = rospy.Time.now()
        now_timestamp = now_ts.secs + (now_ts.nsecs / 1000000000.0)
        if self.rearArmPrevSM != msg.reararm_sm:
            smChanged = True
        self.rearArmPrevSM = msg.reararm_sm
       # On SM Changes
        if smChanged:
            # Progress to 0%, 100% cycle time to next ready
            if msg.reararm_sm == 14 or msg.reararm_sm == 18:
                self.rearArmEstTimeToReady = approx_cycle_sec * 1.00 + now_timestamp
            # Progress to 7.4%, 92.6% cycle time to next ready
            elif msg.reararm_sm == 19:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.926 + now_timestamp
            # Progress to 12%, 88% cycle time to next ready
            elif msg.reararm_sm == 8:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.88 + now_timestamp
            # Progress to 18.7%, 81.3% cycle time to next ready
            elif msg.reararm_sm == 20 or msg.reararm_sm == 21 or msg.reararm_sm == 23:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.813 + now_timestamp
            # Progress to 23.2%, 76.8% cycle time to next ready
            elif msg.reararm_sm == 11:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.768 + now_timestamp
            # Progress to 32%, 68% cycle time to next ready
            elif msg.reararm_sm == 10:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.68 + now_timestamp
            # Progress to 59.7%, 40.3 cycle time to next ready
            elif msg.reararm_sm == 13:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.403 + now_timestamp
            # Progress to 59.9%, 40.1% cycle time to next ready
            elif msg.reararm_sm == 26:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.401 + now_timestamp
            # Progress to 83.2%, 16.8% cycle time to next ready
            elif msg.reararm_sm == 15:
                self.rearArmEstTimeToReady = approx_cycle_sec * 0.168 + now_timestamp
            # Progress to ~100%, 0% cycle time to next ready (ready / idle state)
            elif msg.reararm_sm == 16 or msg.reararm_sm == 17 or msg.reararm_sm == 1:
                self.rearArmEstTimeToReady = now_timestamp
        # On SM State
        # Progress to 32%, 68% cycle time to next ready
        if msg.reararm_sm == 9:
            self.rearArmEstTimeToReady = approx_cycle_sec * 0.68 + now_timestamp
        # Progress to 35.4%, 64.6% cycle time to next ready
        elif msg.reararm_sm == 22:
            self.rearArmEstTimeToReady = approx_cycle_sec * 0.646 + now_timestamp
        # Progress to 59.7%, 40.3 cycle time to next ready
        elif msg.reararm_sm == 12:
            self.rearArmEstTimeToReady = approx_cycle_sec * 0.403 + now_timestamp
        rearArmEstSecToReady = self.rearArmEstTimeToReady - now_timestamp
        if rearArmEstSecToReady <= 0:
            rearArmEstSecToReady = 0.001
        if distInBetween > 0:
            recmdTargetSpd = abs(distInBetween / rearArmEstSecToReady)
        else:
            recmdTargetSpd = 0
        if recmdTargetSpd < 1.00:
            self.recmdTargetSpeedLabel.setText(speedTxt.format(recmdTargetSpd))
        else:
            self.recmdTargetSpeedLabel.setText(">1.00m/s")
        recmdtargetSpeedPercent = int(abs(recmdTargetSpd / 1.00) * 100.0)       # 1.00m/s as progressbar max
        if recmdtargetSpeedPercent > 100:
            recmdtargetSpeedPercent = 100
        self.recmdTargetSpeedProgressBar.setValue(recmdtargetSpeedPercent)
        self.recmdTargetSpeedProgressBar.setStyleSheet('selection-background-color:blue')
        if abs(msg.target_vel_X) > recmdTargetSpd:
            self.targetSpeedLabel.setStyleSheet("color : red")
            self.targetSpeedProgressBar.setStyleSheet('selection-background-color:red')
        else:
            self.targetSpeedLabel.setStyleSheet("color : black")
            self.targetSpeedProgressBar.setStyleSheet('selection-background-color:blue')

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
        if msg.rear_slider_down == True:
            self.rearSliderPushButton.setText("Down")
        else:
            self.rearSliderPushButton.setText("Up")
        if msg.cone_slider_extend == True:
            self.coneSliderPushButton.setText("Extend")
        else:
            self.coneSliderPushButton.setText("Retract")
        if msg.airpump_on == True:
            self.airPumpPushButton.setText("On")
        else:
            self.airPumpPushButton.setText("Off")
        if msg.arrowlight_on == True:
            self.arrowLightPushButton.setText("On")
        else:
            self.arrowLightPushButton.setText("Off")

    # ROS topic subscriber callback for power system (ps_state)
    def updateGUI_PsState(self):
        msg = copy.copy(self.clone_ps_msg)
        ThreePhasevoltage0 = (msg.meter_phA_V[0] + msg.meter_phB_V[0] + msg.meter_phC_V[0])/3.0 * 1.732
        ThreePhasevoltage1 = (msg.meter_phA_V[1] + msg.meter_phB_V[1] + msg.meter_phC_V[1])/3.0 * 1.732
        displayTxt = "{: 3.2f}v"
        if msg.state_meter[0] == 0:
            self.inverterLabel_0.setText(displayTxt.format(ThreePhasevoltage0))
        else:
            self.inverterLabel_0.setText("???")
        if msg.state_meter[1] == 0:
            self.inverterLabel_1.setText(displayTxt.format(ThreePhasevoltage1))
        else:
            self.inverterLabel_1.setText("???")
        TotalWatt = msg.meter_tot_W[0] + msg.meter_tot_W[1]
        displayTxt = "{: 4.1f}W"
        self.totalWattLabel.setText(displayTxt.format(TotalWatt))

        displayTxt = "{: 2.1f}c"
        if msg.state_temphum[0] == 0:
            self.caseTempLabel_0.setText(displayTxt.format(msg.th_temperature[0]))
        else:
            self.caseTempLabel_0.setText("???")
        if msg.state_temphum[1] == 0:
            self.caseTempLabel_1.setText(displayTxt.format(msg.th_temperature[1]))
        else:
            self.caseTempLabel_1.setText("???")

        displayTxt = "{: 3.1f}v"
        #BattVolt = 0.462773 * msg.mcb_V[0]
        BattVolt = msg.mcb_V[1]
        #msg.mcb_I[0]
        #msg.mcb_I[1]
        if msg.state_mcb[0] == 0:
            if msg.mcb_sw_pos[0] == 1:
                self.ConvMCBLabel_0.setText("On")
                self.inverterOnPushButton_0.setText("SetOff")
            else:
                self.ConvMCBLabel_0.setText("Off")
                self.inverterOnPushButton_0.setText("SetOn")
        else:
            self.ConvMCBLabel_0.setText("???")
        if msg.state_mcb[1] == 0:
            if msg.mcb_sw_pos[1] == 1:
                self.ConvMCBLabel_1.setText("On")
                self.inverterOnPushButton_1.setText("SetOff")
            else:
                self.ConvMCBLabel_1.setText("Off")
                self.inverterOnPushButton_1.setText("SetOn")
            self.batteryVoltageLabel.setText(displayTxt.format(BattVolt))
        else:
            self.ConvMCBLabel_1.setText("???")
            self.batteryVoltageLabel.setText("???")
        BattSOC = (BattVolt - 210.0) / (236.0 - 210.0) * 100.0
        self.batterySOCProgressBar.setValue(int(BattSOC))
        if BattVolt <= 0:
            self.batterySOCProgressBar.setStyleSheet('selection-background-color:red')
        elif BattSOC < 10.0:
            self.batterySOCProgressBar.setStyleSheet('selection-background-color:red')
            self.generateAudioTone(840, 0.1, False)
            if self.batteryWarnCounter < 2:
                QMessageBox.warning(self, "警告", "電池電量極低! v=" + displayTxt.format(BattVolt), QMessageBox.Yes)
                self.batteryWarnCounter = 2
        elif BattSOC < 20.0:
            self.batterySOCProgressBar.setStyleSheet('selection-background-color:orange')
            if self.batteryWarnCounter == 0:
                QMessageBox.warning(self, "警告", "電池電量低! v=" + displayTxt.format(BattVolt), QMessageBox.Yes)
                self.batteryWarnCounter = 1
        else:
            self.batterySOCProgressBar.setStyleSheet('selection-background-color:blue')

    # ROS topic subscriber callback for lantern racks (lr_state)
    def updateGUI_LrState(self):
        msg = copy.copy(self.clone_lr_msg)


    # Close/Exit
    def closeEvent(self, event):
    #def gui_close(self):
        rospy.loginfo("GUI close. Will be restarted.")

    def generateAudioTone(self, freq, onTime, override):
        numOfData = int(self.audioBufSize / 2)   # 2 bytes, buffer fill 92% to start, at least fill 0.921
        duty = onTime / self.audioBufTime
        offT = int(duty * numOfData)
        audioData = QByteArray()
        audioData.clear()
        for i in xrange(numOfData):
            t = i / self.audioSampleRate
            if i < offT:
                value = int(self.volume * sin(2 * pi * freq * t))
            else:
                value = 0
            audioData.append(struct.pack("<h", value))
        self.audioMutex.acquire()
        try:
            if override == True:
                self.audioOutput.reset()
                self.audioOutputIO = self.audioOutput.start()
            actualWr = self.audioOutputIO.write(audioData)
            #print "data size: " + str(audioData.size()) + " actual: " + str(actualWr)
            self.audioMutex.release()
        except:
            print("Exception catch on Audio (Double) Tone Generator .")
            self.audioMutex.release()


    def generateAudioDoubleTone(self, freq, onTime, override):
        numOfData = int(self.audioBufSize / 2)   # 2 bytes, buffer fill 92% to start, at least fill 0.921
        duty = onTime / self.audioBufTime
        offT1 = int(duty * numOfData)
        onT2 = offT1 + int(duty * numOfData)
        offT3 = onT2 + int(duty * numOfData)
        audioData = QByteArray()
        audioData.clear()
        for i in xrange(numOfData):
            t = i / self.audioSampleRate
            if i < offT1 or (i > onT2 and i < offT3):
                value = int(self.volume * sin(2 * pi * freq * t))
            else:
                value = 0
            audioData.append(struct.pack("<h", value))
        self.audioMutex.acquire()
        try:
            if override == True:
                self.audioOutput.reset()
                self.audioOutputIO = self.audioOutput.start()
            actualWr = self.audioOutputIO.write(audioData)
            # print "data size: " + str(audioData.size()) + " actual: " + str(actualWr)
            self.audioMutex.release()
        except:
            print("Exception catch on Audio (Double) Tone Generator .")
            self.audioMutex.release()


    # HMI user trigger event callbacks
    # Mouse input event
    def mousePressEvent(self, event):
        # For cameraRadarLabel mouse press event (when tab at #2)
        if self.tabWidget.currentIndex() == 2:
            p = QPoint(584, 44)
        elif self.tabWidget.currentIndex() == 3:
            p = QPoint(64, 44)
        else:
            return
        if event.pos().x() >= p.x() and event.pos().x() <= p.x() + self.cameraRadarLabel.width():
            if event.pos().y() >= p.y() and event.pos().y() <= p.y() + self.cameraRadarLabel.height():
                (rows, cols, channels) = self.imgRadarMapBGOrg.shape
                cen_px_x = int(rows / 2)
                # 1px = 1cm, 10mm
                mm2px = 1 / 10.0
                if self.radarZoomComboBox.currentIndex() == 1:
                    # 1px = 2cm, 20mm
                    mm2px = 1 / 20.0
                elif self.radarZoomComboBox.currentIndex() == 2:
                    # 1px = 4cm, 40mm
                    mm2px = 1 / 40.0
                self.cameraRadarCursor_y = -(event.pos().x() - p.x() - cen_px_x)/mm2px /1000.0  # in meter, same as lidar
                self.cameraRadarCursor_x = (event.pos().y() - p.y())/mm2px /1000.0              # in meter, same as lidar
                # Show using mm, same orientation with robot
                self.mouseCursorPositionLabel.setText("Y:" + str(int(-self.cameraRadarCursor_y*1000.0)) + ",X:" + str(int(self.cameraRadarCursor_x*1000.0+660.0)))
                self.mouseCursorPositionYExtLabel.setText(str(int(-self.cameraRadarCursor_y*1000.0)))
                self.mouseCursorPositionXExtLabel.setText(str(int(self.cameraRadarCursor_x*1000.0+660.0)))
                # Search for closet object ID
                newID = 0
                objSize = 0
                objDist = 0
                minDist = 99999.0
                if self.cameraRadarCursor_x > 0.3:
                    for obj in self.clone_lt_msg.objects:
                        dx = obj.CenterPoint.x - self.cameraRadarCursor_x
                        dy = obj.CenterPoint.y - self.cameraRadarCursor_y
                        Dist = math.sqrt(dx * dx + dy * dy)
                        if minDist > Dist:
                            newID = obj.ID
                            objSize = obj.Size
                            objDist = obj.MinPoint.Dist
                            minDist = Dist
                if newID == 0:
                    self.changeTargetIDLineEdit.setText("Auto")
                else:
                    self.changeTargetIDLineEdit.setText(str(newID))
                rospy.loginfo("Mouse press selected object ID:" + str(newID) + " with size:" + str(objSize) + " dist:" + str(objDist))
                # Alarm sound
                self.generateAudioTone(440, 0.1, True)
                # for testing only
                #self.updateGUI_RadarUpdate()

    def shutdownSystem_button_callback(self):
        rospy.loginfo("User pressed system off.")
        reply = QMessageBox.warning(self, "警告", "請問機械臂，燈架，尾板，交通錐滑板可安全移動嗎?", QMessageBox.Yes | QMessageBox.No)
        if reply == QMessageBox.Yes:
            try:
               # ac_stop_autocontrol(True)
                #time.sleep(0.1)
                #kr1_setdigitaloutput(0x2000, 0, 0.1)
                #kr2_setdigitaloutput(0x2000, 0, 0.1)
                #time.sleep(0.1)
                sio_set_rear_slider(False)
                time.sleep(0.25)
                sio_set_cone_slider(False)
                time.sleep(0.25)
                sio_set_airpump(False)
                time.sleep(0.25)
                sio_set_arrowlight(False)
                time.sleep(0.25)
                ps_switchoff_invertermcb(1)
            except rospy.ServiceException, e:
                rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
            reply = QMessageBox.information(self, "關機", "您要關機嗎？", QMessageBox.Yes | QMessageBox.No)
            if reply == QMessageBox.Yes:
                rospy.loginfo("User confirmed system ready to off.")
                # roslaunch.parent.ROSLaunchParent.shutdown()
                os.system("systemctl poweroff")
                # os.system("systemctl halt")

    def rearSliderPushButton_callback(self):
        rospy.loginfo("Toggle rear slider")
        state = True
        if self.clone_sio_msg.rear_slider_down == True:
            state = False
        try:
            resp = sio_set_rear_slider(state)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def coneSliderPushButton_callback(self):
        rospy.loginfo("Toggle cone slider")
        reply = QMessageBox.warning(self, "警告", "請確保安全後移動交通錐滑板!", QMessageBox.Yes | QMessageBox.No)
        if reply != QMessageBox.Yes:
            return
        state = True
        if self.clone_sio_msg.cone_slider_extend == True:
            state = False
        try:
            resp = sio_set_cone_slider(state)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def airPumpPushButton_callback(self):
        rospy.loginfo("Toggle air pump")
        state = True
        if self.clone_sio_msg.airpump_on == True:
            state = False
        try:
            resp = sio_set_airpump(state)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def arrowLightPushButton_callback(self):
        rospy.loginfo("Toggle arrow light")
        state = True
        if self.clone_sio_msg.arrowlight_on == True:
            state = False
        try:
            resp = sio_set_arrowlight(state)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def lanternRackModeRadioButton_callback(self, n):
        rospy.loginfo("Toggle lantern rack mode " + str(n) + ".")
        radioButton = self.sender()
        mode = n
        if radioButton.isChecked():
            try:
                resp = lr_set_lantern_rack_mode(mode)
                return resp.response
            except rospy.ServiceException, e:
                rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def inverter0OnPushButton_callback(self):
        rospy.loginfo("Toggle invertor 0 On/Off")
        to_state = True
        if self.clone_ps_msg.mcb_sw_pos[0] == 1:
            to_state = False
        try:
            if to_state:
                resp = ps_switchon_invertermcb(0)
            else:
                resp = ps_switchoff_invertermcb(0)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def inverter1OnPushButton_callback(self):
        rospy.loginfo("Toggle invertor 1 On/Off")
        to_state = True
        if self.clone_ps_msg.mcb_sw_pos[1] == 1:
            to_state = False
        try:
            if to_state:
                resp = ps_switchon_invertermcb(1)
            else:
                resp = ps_switchoff_invertermcb(1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

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
            resp = lr_set_lantern_rack_mode(99)
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
            if self.clone_ac_msg.reararm_sm <= 2:
                resp = kr1_rampdown_stop(2)
            else:
                resp = ac_stop_autocontrol(True)
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
                resp = kr1_setdigitaloutput(0x8000, 0, 0.1)
            else:
                resp = kr1_setdigitaloutput(0x8000, 0x8000, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doLo_button1_callback(self):
        rospy.loginfo("Toggle kr1 DO Lo.")
        try:
            if self.doLoPushButton_1.text() == "Lower:1":
                resp = kr1_setdigitaloutput(0x4000, 0, 0.1)
            else:
                resp = kr1_setdigitaloutput(0x4000, 0x4000, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doValve_button1_callback(self):
        rospy.loginfo("Toggle kr1 DO Valve.")
        try:
            if self.doValvePushButton_1.text() == "Valve:1":
                resp = kr1_setdigitaloutput(0x2000, 0, 0.1)
            else:
                resp = kr1_setdigitaloutput(0x2000, 0x2000, 0.1)
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
            if self.clone_ac_msg.frontarm_sm <= 2:
                resp = kr2_rampdown_stop(2)
            else:
                resp = ac_stop_autocontrol(True)
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
                resp = kr2_setdigitaloutput(0x8000, 0, 0.1)
            else:
                resp = kr2_setdigitaloutput(0x8000, 0x8000, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doLo_button2_callback(self):
        rospy.loginfo("Toggle kr2 DO Lo.")
        try:
            if self.doLoPushButton_2.text() == "Lower:1":
                resp = kr2_setdigitaloutput(0x4000, 0, 0.1)
            else:
                resp = kr2_setdigitaloutput(0x4000, 0x4000, 0.1)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def doValve_button2_callback(self):
        rospy.loginfo("Toggle kr2 DO Valve.")
        try:
            if self.doValvePushButton_2.text() == "Valve:1":
                resp = kr2_setdigitaloutput(0x2000, 0, 0.1)
            else:
                resp = kr2_setdigitaloutput(0x2000, 0x2000, 0.1)
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

    def goSafeHome_button1_callback(self):
        rospy.loginfo("Auto move kr1 to home position.")
        try:
            resp = kr1_set_speedscale(10)
            resp = ac_go_home(-1)
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

    def goSafeHome_button2_callback(self):
        rospy.loginfo("Auto move kr2 to home position.")
        try:
            resp = kr2_set_speedscale(10)
            resp = ac_go_home(-2)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def goInvCheck_button_callback(self):
        rospy.loginfo("Move kr2 to inventory check.")
        if self.clone_kr2_msg.pos_setpt.X < 0:
            QMessageBox.warning(self, "警告", "請先把手臂返回Home位置.", QMessageBox.Yes)
            return
        try:
            resp = kr2_set_speedscale(10)
            resp = ac_go_coneinvcheck(True)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)


    def goConeCollect_button_callback(self):
        rospy.loginfo("Start Cone Collection.")
        self.PlaceCollectMode = 1
        self.placeCollectModeLabel.setText("收集")
        if self.check_SystemGoodCondition() != True:
            return
        if self.clone_sio_msg.airpump_on != True or self.clone_sio_msg.rear_slider_down != True:
            QMessageBox.warning(self, "警告", "請打開氣泵並向下滑動尾板.", QMessageBox.Yes)
            return
        try:
            resp = lr_set_lantern_rack_mode(2)
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
        numOfConeToCollect = int(self.numOfConeToCollectSpinBox_0.value())
        mode = 0
        if self.collectionModeCheckBox.isChecked() == True:
            mode = 1
        try:
            resp = ac_go_conecollect(numOfConeToCollect, mode)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def goConePlace_button_callback(self):
        rospy.loginfo("Start Cone Placement.")
        self.PlaceCollectMode = 0
        self.placeCollectModeLabel.setText("放置")
        totalNum = self.numOfConeToPlaceSpinBox_0.value() + self.numOfConeToPlaceSpinBox_1.value() + self.numOfConeToPlaceSpinBox_2.value()
        self.numOfConeToCollectSpinBox_0.setValue(totalNum)
        if self.check_SystemGoodCondition() != True:
            return
        if self.clone_sio_msg.airpump_on != True or self.clone_sio_msg.rear_slider_down != True:
            QMessageBox.warning(self, "警告", "請打開氣泵並向下滑動尾板.", QMessageBox.Yes)
            return
        try:
            resp = lr_set_lantern_rack_mode(1)
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)
        mode = 0
        if self.placeRoadmarkCheckBox_0.isChecked() == True:
            mode = 1
        numOfConeToPlace = []
        lanternPattern = []
        coneSpacing = []
        start_position_y = []
        end_position_y = []
        start_position_x = []
        end_position_x = []
        numOfConeToPlace.append(self.numOfConeToPlaceSpinBox_0.value())
        lanternPattern.append(int(self.withLanternComboBox_0.currentIndex()))
        coneSpacing.append(float(self.ConeSpacingSpinBox_0.value()))
        start_position_y.append(float(self.ConePlaceStartYPosPushButton_0.text()))
        end_position_y.append(float(self.ConePlaceEndYPosPushButton_0.text()))
        start_position_x.append(1.55)
        end_position_x.append(1.55)

        numOfConeToPlace.append(self.numOfConeToPlaceSpinBox_1.value())
        lanternPattern.append(int(self.withLanternComboBox_1.currentIndex()))
        coneSpacing.append(float(self.ConeSpacingSpinBox_1.value()))
        start_position_y.append(float(self.ConePlaceStartYPosPushButton_1.text()))
        end_position_y.append(float(self.ConePlaceEndYPosPushButton_1.text()))
        start_position_x.append(1.55)
        end_position_x.append(1.55)

        numOfConeToPlace.append(self.numOfConeToPlaceSpinBox_2.value())
        lanternPattern.append(int(self.withLanternComboBox_2.currentIndex()))
        coneSpacing.append(float(self.ConeSpacingSpinBox_2.value()))
        start_position_y.append(float(self.ConePlaceStartYPosPushButton_2.text()))
        end_position_y.append(float(self.ConePlaceEndYPosPushButton_2.text()))
        start_position_x.append(1.55)
        end_position_x.append(1.55)
        try:
            resp = ac_go_coneplace(numOfConeToPlace, lanternPattern, coneSpacing,
                                   start_position_y, start_position_x, end_position_y, end_position_x, mode)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def changeTarget_button_callback(self):
        rospy.loginfo("Change Target.")
        newID = 0
        if self.changeTargetIDLineEdit.text() != "Auto":
            newID = int(self.changeTargetIDLineEdit.text())
        try:
            resp = ac_change_target(newID)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def changeRoadmark_button_callback(self):
        rospy.loginfo("Change Roadmark.")
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        try:
            resp = ac_change_line(PosY)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def conePlaceStartYPos_button_0_callback(self):
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        if PosY > 1.5:
            PosY = 1.5
        elif PosY < -1.5:
            PosY = -1.5
        self.ConePlaceStartYPosPushButton_0.setText(str(PosY))
        start = float(self.ConePlaceStartYPosPushButton_0.text())
        end = float(self.ConePlaceEndYPosPushButton_0.text())
        if start > end:
            self.conePlaceOriLabel_0.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_0.setText("/")
        else:
            self.conePlaceOriLabel_0.setText("|")
        self.conePlaceConvSelectedLaneWidthLabel.setText(str(abs(end - start)))

    def conePlaceEndYPos_button_0_callback(self):
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        if PosY > 1.5:
            PosY = 1.5
        elif PosY < -1.5:
            PosY = -1.5
        self.ConePlaceEndYPosPushButton_0.setText(str(PosY))
        start = float(self.ConePlaceStartYPosPushButton_0.text())
        end = float(self.ConePlaceEndYPosPushButton_0.text())
        if start > end:
            self.conePlaceOriLabel_0.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_0.setText("/")
        else:
            self.conePlaceOriLabel_0.setText("|")
        self.conePlaceConvSelectedLaneWidthLabel.setText(str(abs(end - start)))

    def conePlaceStartYPos_button_1_callback(self):
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        if PosY > 1.5:
            PosY = 1.5
        elif PosY < -1.5:
            PosY = -1.5
        self.ConePlaceStartYPosPushButton_1.setText(str(PosY))
        start = float(self.ConePlaceStartYPosPushButton_1.text())
        end = float(self.ConePlaceEndYPosPushButton_1.text())
        if start > end:
            self.conePlaceOriLabel_1.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_1.setText("/")
        else:
            self.conePlaceOriLabel_1.setText("|")

    def conePlaceEndYPos_button_1_callback(self):
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        if PosY > 1.5:
            PosY = 1.5
        elif PosY < -1.5:
            PosY = -1.5
        self.ConePlaceEndYPosPushButton_1.setText(str(PosY))
        start = float(self.ConePlaceStartYPosPushButton_1.text())
        end = float(self.ConePlaceEndYPosPushButton_1.text())
        if start > end:
            self.conePlaceOriLabel_1.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_1.setText("/")
        else:
            self.conePlaceOriLabel_1.setText("|")

    def conePlaceStartYPos_button_2_callback(self):
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        if PosY > 1.5:
            PosY = 1.5
        elif PosY < -1.5:
            PosY = -1.5
        self.ConePlaceStartYPosPushButton_2.setText(str(PosY))
        start = float(self.ConePlaceStartYPosPushButton_2.text())
        end = float(self.ConePlaceEndYPosPushButton_2.text())
        if start > end:
            self.conePlaceOriLabel_2.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_2.setText("/")
        else:
            self.conePlaceOriLabel_2.setText("|")

    def conePlaceEndYPos_button_2_callback(self):
        PosY = -self.cameraRadarCursor_y                        # lidar Y opps to robot Y
        if PosY > 1.5:
            PosY = 1.5
        elif PosY < -1.5:
            PosY = -1.5
        self.ConePlaceEndYPosPushButton_2.setText(str(PosY))
        start = float(self.ConePlaceStartYPosPushButton_2.text())
        end = float(self.ConePlaceEndYPosPushButton_2.text())
        if start > end:
            self.conePlaceOriLabel_2.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_2.setText("/")
        else:
            self.conePlaceOriLabel_2.setText("|")


    # ------------------ Extended Function Tab ------------------
    def conePlaceConv_button_callback(self):
        rospy.loginfo("Converted input data to cone placement tab.")
        startTaperLength50km = [30, 34, 38, 42, 46, 52, 60, 68, 76, 84, 90]
        startTaperLength70km = [45, 51, 58, 63, 69, 78, 90, 102, 114, 126, 138]
        startTaperLength80km = [60, 69, 76, 84, 91, 108, 122, 138, 152, 168, 182]
        startWidth = float(self.conePlaceConvStartLaneWidthLineEdit.text())
        i = 0
        if startWidth <= 2.4:           # modified by Marco
            i = 0
        elif startWidth <= 2.7:         # modified by Marco
            i = 1
        elif startWidth <= 3.0:         # modified by Marco
            i = 2
        elif startWidth <= 3.4:         # modified by Marco
            i = 3
        elif startWidth <= 3.7:         # modified by Marco
            i = 4
        elif startWidth <= 4.3:         # modified by Marco
            i = 5
        elif startWidth <= 4.9:         # modified by Marco
            i = 6
        elif startWidth <= 5.5:         # modified by Marco
            i = 7
        elif startWidth <= 6.1:         # modified by Marco
            i = 8
        elif startWidth <= 6.7:         # modified by Marco
            i = 9
        elif startWidth <= 7.3:         # modified by Marco
            i = 10
        else:
            i = 10
        if self.conePlaceRoadSpeedSelConvComboBox.currentIndex() == 0:
            spacing0 = 1.9932           # modified by Marco, Approach Taper
            spacing1 = 4.5              # modified by Marco, Along Edge
            spacing2 = 0.7071           # modified by Marco, End Taper
            length0 = startTaperLength50km[i]
        elif self.conePlaceRoadSpeedSelConvComboBox.currentIndex() == 1:
            spacing0 = 1.9970           # modified by Marco
            spacing1 = 4.5              # modified by Marco
            spacing2 = 0.7071           # modified by Marco
            length0 = startTaperLength70km[i]
        else:
            spacing0 = 1.9983           # modified by Marco
            spacing1 = 9.0              # modified by Marco
            spacing2 = 0.7071           # modified by Marco
            length0 = startTaperLength80km[i]
        length2 = float(self.conePlaceConvEndLaneWidthLineEdit.text())
        length1 = float(self.conePlaceConvLengthLineEdit.text())
        self.conePlaceConvTotalLengthLabel.setText(str(length0 + length1 + length2))
        #numOfCone = round(length0 / spacing0)          # modified by Marco
        numOfCone = math.ceil(length0 / spacing0)       # modified by Marco
        self.numOfConeToPlaceSpinBox_0.setValue(int(numOfCone))
        self.ConeSpacingSpinBox_0.setValue(spacing0)
        #numOfCone = round(length1 / spacing1)          # modified by Marco
        numOfCone = math.ceil(length1 / spacing1)       # modified by Marco
        self.numOfConeToPlaceSpinBox_1.setValue(int(numOfCone))
        self.ConeSpacingSpinBox_1.setValue(spacing1)
        #numOfCone = round(length2 / spacing2)          # modified by Marco
        numOfCone = math.ceil(length2 / spacing2)       # modified by Marco
        self.numOfConeToPlaceSpinBox_2.setValue(int(numOfCone))
        self.ConeSpacingSpinBox_2.setValue(spacing2)

        x = float(self.mouseCursorPositionXExtLabel.text())
        y = float(self.mouseCursorPositionYExtLabel.text())
        self.ConePlaceStartYPosPushButton_0.setText(str(y / 1000.0))
        laneWidth = float(self.conePlaceConvStartLaneWidthLineEdit.text())
        if self.fastSlowLaneRadioButton_0.isChecked() == True:
            endPos = y/1000.0 + laneWidth
        else:
            endPos = y/1000.0 - laneWidth
        if endPos > 1.5:
            endPos = 1.5
        elif endPos < -1.5:
            endPos = -1.5
        self.ConePlaceEndYPosPushButton_0.setText(str(endPos))
        self.ConePlaceEndYPosPushButton_1.setText(self.ConePlaceEndYPosPushButton_0.text())
        self.ConePlaceStartYPosPushButton_1.setText(self.ConePlaceEndYPosPushButton_0.text())
        self.ConePlaceEndYPosPushButton_1.setText(self.ConePlaceEndYPosPushButton_0.text())
        self.ConePlaceStartYPosPushButton_2.setText(self.ConePlaceEndYPosPushButton_0.text())
        laneWidth = float(self.conePlaceConvEndLaneWidthLineEdit.text())
        if float(self.ConePlaceEndYPosPushButton_0.text()) > float(self.ConePlaceStartYPosPushButton_0.text()):
            endPos = float(self.ConePlaceStartYPosPushButton_2.text()) - laneWidth
        else:
            endPos = float(self.ConePlaceStartYPosPushButton_2.text()) + laneWidth
        if endPos > 1.5:
            endPos = 1.5
        elif endPos < -1.5:
            endPos = -1.5
        self.ConePlaceEndYPosPushButton_2.setText(str(endPos))

        start = float(self.ConePlaceStartYPosPushButton_0.text())
        end = float(self.ConePlaceEndYPosPushButton_0.text())
        if start > end:
            self.conePlaceOriLabel_0.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_0.setText("/")
        else:
            self.conePlaceOriLabel_0.setText("|")
        start = float(self.ConePlaceStartYPosPushButton_1.text())
        end = float(self.ConePlaceEndYPosPushButton_1.text())
        if start > end:
            self.conePlaceOriLabel_1.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_1.setText("/")
        else:
            self.conePlaceOriLabel_1.setText("|")
        start = float(self.ConePlaceStartYPosPushButton_2.text())
        end = float(self.ConePlaceEndYPosPushButton_2.text())
        if start > end:
            self.conePlaceOriLabel_2.setText("\\")
        elif start < end:
            self.conePlaceOriLabel_2.setText("/")
        else:
            self.conePlaceOriLabel_2.setText("|")

    def StandPlace_button_callback(self, value):
        rospy.loginfo("Start Stand Placement.")
        if self.check_SystemGoodCondition() != True:
            return
        if self.clone_sio_msg.airpump_on != True or self.clone_sio_msg.rear_slider_down != True:
            QMessageBox.warning(self, "警告", "請打開氣泵並向下滑動尾板.", QMessageBox.Yes)
            return
        x = float(self.mouseCursorPositionXExtLabel.text())
        y = float(self.mouseCursorPositionYExtLabel.text())
        try:
            resp = ac_go_standplace(x, y, value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def StandCollect_button_callback(self, value):
        rospy.loginfo("Start Stand Collection.")
        if self.check_SystemGoodCondition() != True:
            return
        if self.clone_sio_msg.airpump_on != True or self.clone_sio_msg.rear_slider_down != True:
            QMessageBox.warning(self, "警告", "請打開氣泵並向下滑動尾板.", QMessageBox.Yes)
            return
        x = float(self.mouseCursorPositionXExtLabel.text())
        y = float(self.mouseCursorPositionYExtLabel.text())
        try:
            resp = ac_go_standcollect(x, y, value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def SignPlace_button_callback(self, value):
        rospy.loginfo("Start Sign Placement.")
        if self.check_SystemGoodCondition() != True:
            return
        if self.clone_sio_msg.airpump_on != True or self.clone_sio_msg.rear_slider_down != True:
            QMessageBox.warning(self, "警告", "請打開氣泵並向下滑動尾板.", QMessageBox.Yes)
            return
        x = float(self.mouseCursorPositionXExtLabel.text())
        y = float(self.mouseCursorPositionYExtLabel.text())
        try:
            resp = ac_go_signplace(x, y, value)
            return resp.response
        except rospy.ServiceException, e:
            rospy.loginfo(rospy.get_caller_id() + "-Service call failed: %s", e)

    def SignCollect_button_callback(self, value):
        rospy.loginfo("Start Sign Collection.")
        if self.check_SystemGoodCondition() != True:
            return
        if self.clone_sio_msg.airpump_on != True or self.clone_sio_msg.rear_slider_down != True:
            QMessageBox.warning(self, "警告", "請打開氣泵並向下滑動尾板.", QMessageBox.Yes)
            return
        x = float(self.mouseCursorPositionXExtLabel.text())
        y = float(self.mouseCursorPositionYExtLabel.text())
        try:
            resp = ac_go_signcollect(x, y, value)
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
