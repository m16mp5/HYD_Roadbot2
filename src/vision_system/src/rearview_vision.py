#!/usr/bin/env python

import os, sys
import rospy
import numpy as np

import cv2
from cv_bridge import CvBridge, CvBridgeError

from std_msgs.msg import Header
from sensor_msgs.msg import Image
#from vision_system.msg import *
from vision_system.srv import *


def handle_check_position_has_cone(req):
    #rospy.loginfo("Returning [%s + %s = %s]"%(req.x, req.y, (req.x + req.y)))
    return vs_check_position_has_cone_ArgsResponse(10, (req.x + req.y))

def topic_rearview_camera():
    bridge = CvBridge()
    # Load img files.
    """self_dir = os.path.dirname(os.path.realpath(__file__))
    ui_dir = os.path.join(self_dir, './')
    img_file = os.path.join(ui_dir, 'rearviewbg.png')
    imgRearview = cv2.imread(img_file)"""

    # Open camera
    #capVideoL = cv2.VideoCapture('http://root:root@192.168.10.31/mjpg/video.mjpg?camera=1')
    capVideoL = cv2.VideoCapture('http://root:root@192.168.10.31/mjpg/video.mjpg?camera=5')
    capVideoR = cv2.VideoCapture('http://root:hkpc3801@192.168.10.32/mjpg/video.mjpg?camera=5')

    pubL = rospy.Publisher('~rearviewl_camera', Image, queue_size=10)
    pubR = rospy.Publisher('~rearviewr_camera', Image, queue_size=10)

    """K = np.array([[689.21, 0., 1295.56],        # test transf matrix
                  [0., 690.48, 942.17],
                  [0., 0., 1.]])
    D = np.array([0., 0., 0., 0.])              # test transf matrix
    Knew = K.copy()
    Knew[(0, 1), (0, 1)] = 0.4 * Knew[(0, 1), (0, 1)]"""

    rate = rospy.Rate(15) # 15hz
    while not rospy.is_shutdown():
        temp, frameL = capVideoL.read()
        temp, frameR = capVideoR.read()

        """frameLl = cv2.resize(frameL, (2592, 1944))  # suit for test transf matrix
        frameRl = cv2.resize(frameR, (2592, 1944))  # suit for test transf matrix
        frameL_undistorted = cv2.fisheye.undistortImage(frameLl, K, D=D, Knew=Knew)
        frameR_undistorted = cv2.fisheye.undistortImage(frameRl, K, D=D, Knew=Knew)"""

        """frameLr = cv2.resize(frameL, (500, 500))
        frameRr = cv2.resize(frameR, (500, 500))
        frameLr_flip = cv2.flip(frameLr, 1)
        frameRr_flip = cv2.flip(frameRr, 1)
        frame = cv2.hconcat([frameLr_flip, frameRr_flip])"""

        imgRearviewl = cv2.resize(frameL, (800, 400))
        image_messagel = bridge.cv2_to_imgmsg(imgRearviewl, "bgr8")
        image_messagel.header = Header(stamp=rospy.Time.now())
        image_messagel.header.frame_id = 'rearviewl'
        pubL.publish(image_messagel)

        imgRearviewr = cv2.resize(frameR, (800, 400))
        image_messager = bridge.cv2_to_imgmsg(imgRearviewr, "bgr8")
        image_messager.header = Header(stamp=rospy.Time.now())
        image_messager.header.frame_id = 'rearviewr'
        pubR.publish(image_messager)
        '''
        cv2.imshow('frameR', frame2)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        rate.sleep()
        '''
def visual_detector_server():
    rospy.init_node('rearview_vision')
    s1 = rospy.Service('~vs_check_position_has_cone', vs_check_position_has_cone_Args, handle_check_position_has_cone)
    rospy.loginfo("Rearview vision service ready to use.")
    topic_rearview_camera()
    #rospy.spin()

if __name__ == "__main__":
    visual_detector_server()


