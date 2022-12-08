#!/usr/bin/env python

import os, sys
import rospy
import numpy as np

import cv2
import glob
import time
import birdcam
from cv_bridge import CvBridge, CvBridgeError

from std_msgs.msg import Header
from sensor_msgs.msg import Image
#from vision_system.msg import *
from vision_system.srv import *

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

ToDay = "20210317"

photo_number = 36

global is_HD_Image
is_HD_Image = 1


bird_1_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=1"
bird_2_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=2"
bird_3_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=3"
bird_4_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=4"


SavedPath = ToDay + "SavedImage"
SaveImgFile = "Combined"
TakeImgPath = ToDay + "IMG"
TakeImgFile = "Bird0"
debug_imshow = False
take_Image = True
take_Video = False

oriImg_h = 360
oriImg_w = 640


###1920*1080
DIM_HD=(1920, 1080)
K_HD=np.array([[566.2645468995994, 0.0, 946.4566732403135], [0.0, 566.7040751436358, 564.7627139803151], [0.0, 0.0, 1.0]])
D_HD=np.array([[-0.0036311331464153377], [-0.03789240325895113], [0.03738650961608838], [-0.011800642423107936]])

###640*360
DIM=(oriImg_w, oriImg_h)
K=np.array([[193.35693757489466, 0.0, 312.6655184627045], [0.0, 193.42162171571857, 190.1320267545595], [0.0, 0.0, 1.0]])
D=np.array([[-0.011801503455617745], [-0.012117498886394455], [0.008620037974650175], [-0.0024227222838261965]])


cam2trim_w_s = 0
cam2trim_w_e = 1
cam2trim_h_s = 0
cam2trim_h_e = float(8)/float(9)

cam3trim_w_s = 0
cam3trim_w_e = 1
cam3trim_h_s = float(1)/float(9)
cam3trim_h_e = 1

resize_combine_h = 500
resize_combine_w = 1000

#5m
#cali_Data = [225,122,381,110,271,204,346,199]
#cali_Data = [element *3 for element in cali_Data]
#10m
#cali_Data = [148,120,468,107,263,230,357,230]
#cali_Data = [element *3 for element in cali_Data]
#20m
cali_Data = [55,340,1715,345,740,770,1115,743]
#cali_Data = [element /3 for element in cali_Data]


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

def undistort(img,K,D,DIM,showImage,scale=0.6):
    dim1 = img.shape[:2][::-1]  #dim1 is the dimension of input image to un-distort
    assert dim1[0]/dim1[1] == DIM[0]/DIM[1], "Image to undistort needs to have same aspect ratio as the ones used in calibration"
    if dim1[0]!=DIM[0]:
        img = cv2.resize(img,DIM,interpolation=cv2.INTER_AREA)
    Knew = K.copy()
    if scale:#change fov
        Knew[(0,1), (0,1)] = scale * Knew[(0,1), (0,1)]
    map1, map2 = cv2.fisheye.initUndistortRectifyMap(K, D, np.eye(3), Knew, DIM, cv2.CV_16SC2)
    undistorted_img = cv2.remap(img, map1, map2, interpolation=cv2.INTER_LINEAR, borderMode=cv2.BORDER_CONSTANT)
    if showImage:
        cv2.imshow("undistorted", undistorted_img)
        cv2.waitKey(0)
    return undistorted_img

def handle_send_cali_data(req):
    cali_Data[0] = req.caliD_0
    cali_Data[1] = req.caliD_1
    cali_Data[2] = req.caliD_2
    cali_Data[3] = req.caliD_3
    cali_Data[4] = req.caliD_4
    cali_Data[5] = req.caliD_5
    cali_Data[6] = req.caliD_6
    cali_Data[7] = req.caliD_7
    is_HD_Image = req.Is_HD_check
    '''
    print("---------------------is_HD_Image-------------------------")
    print(is_HD_Image)
    print("-------------------------req.Is_HD_check-------------------------")
    print(req.Is_HD_check)
    print("-------------------------req-------------------------")
    '''

    return vs_send_cali_data_ArgsResponse(10,11)

def handle_get_white_marking_position(req):
    #rospy.loginfo("Returning [%s + %s = %s]"%(req.x, req.y, (req.x + req.y)))
    pts_o = np.float32([[397, 350], [1340, 340], [772, 698], [1081, 679]])
    pts_d = np.float32([[0, 0], [500, 0], [0, 500], [500, 500]])
    M10 = cv2.getPerspectiveTransform(pts_o, pts_d)
    cam_4_ip = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=4"
    bird_4_img = birdcam.BIRD_CAM(1, cam_4_ip, 4, debug_imshow, 0, 0)

    input_pix = birdcam.LiDar_to_pixel(int(req.y), int(req.x))
    white_pix = bird_4_img.find_lane(1, M10, input_pix[0], input_pix[1])
    white_lane_pos = birdcam.Pixelx_to_Lidar(white_pix)
    #print("white_lane_pos", white_lane_pos)
    del bird_4_img
    return vs_get_white_marking_position_ArgsResponse(10, white_lane_pos, (req.x + req.y+1))

def topic_birdview_camera():
    bridge = CvBridge()
    # Load img files.
    #self_dir = os.path.dirname(os.path.realpath(__file__))
    #ui_dir = os.path.join(self_dir, './')
    #img_file = os.path.join(ui_dir, 'birdviewbg.png')
    #imgBirdview = cv2.imread(img_file)
    # Open camera


    bird_1_cap = cv2.VideoCapture(bird_1_addr)
    bird_2_cap = cv2.VideoCapture(bird_2_addr)
    bird_3_cap = cv2.VideoCapture(bird_3_addr)
    bird_4_cap = cv2.VideoCapture(bird_4_addr)

    pub = rospy.Publisher('~birdview_camera', Image, queue_size=10)
    pub_r5 = rospy.Publisher('~birdviewr5_camera', Image, queue_size=10)
    pub_r10 = rospy.Publisher('~birdviewr10_camera', Image, queue_size=10)
    pub_r20 = rospy.Publisher('~birdviewr20_camera', Image, queue_size=10)

    rear_UI_h = 500
    rear_UI_w = 500

    #wrapping point [left top - right top - left bottom - right bottom]

    pts_o = np.float32([[670, 335], [1140, 340], [810, 612], [1040, 595]])
    if not is_HD_Image:
        pts_o = int(pts_o/3)
    pts_d = np.float32([[0, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
    M5 = cv2.getPerspectiveTransform(pts_o, pts_d)

    pts_o = np.float32([[397, 350], [1340, 340], [772, 698], [1081, 679]])
    if not is_HD_Image:
        pts_o = int(pts_o/3)
    pts_d = np.float32([[0, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
    M10 = cv2.getPerspectiveTransform(pts_o, pts_d)

    pts_o = np.float32([[55, 340], [1715, 345], [740, 770], [1115, 743]])
    if not is_HD_Image:
        pts_o = int(pts_o/3)
    pts_d = np.float32([[50, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
    M20 = cv2.getPerspectiveTransform(pts_o, pts_d)

    rate = rospy.Rate(15) # 15hz
    while not rospy.is_shutdown():

        #print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!is_HD_Image!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        #print(is_HD_Image)
        #print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!is_HD_Image!!!!!!!!!!!!!!!!!!!!!!!!!!!")

        pts_o = np.float32([[cali_Data[0], cali_Data[1]], [cali_Data[2], cali_Data[3]], [cali_Data[4], cali_Data[5]], [cali_Data[6], cali_Data[7]]])
        pts_d = np.float32([[50, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
        M20 = cv2.getPerspectiveTransform(pts_o, pts_d)

        temp, bird_1 = bird_1_cap.read() #1
        temp, bird_2 = bird_2_cap.read() #2
        temp, bird_3 = bird_3_cap.read() #3
        temp, bird_4 = bird_4_cap.read() #4

        bird_1 = cv2.resize(bird_1, (640, 360))
        bird_2 = cv2.resize(bird_2, (640, 360))
        bird_3 = cv2.resize(bird_3, (640, 360))
        if not is_HD_Image:
            bird_4 = cv2.resize(bird_4, (640, 360))

	'''
        bird_1 = undistort(bird_1,K,D,DIM,debug_imshow)
        bird_2 = undistort(bird_2,K,D,DIM,debug_imshow)
        bird_3 = undistort(bird_3,K,D,DIM,debug_imshow)
	'''
        if is_HD_Image:
            bird_4 = undistort(bird_4,K_HD,D_HD,DIM_HD,debug_imshow)
        else:
            bird_4 = undistort(bird_4, K, D, DIM, debug_imshow)
	
        bird_2 = bird_2[int(oriImg_h*cam2trim_h_s):int(oriImg_h*cam2trim_h_e),int(oriImg_w*cam2trim_w_s):int(oriImg_w*cam2trim_w_e)]
        bird_3 = bird_3[int(oriImg_h*cam3trim_h_s):int(oriImg_h*cam3trim_h_e),int(oriImg_w*cam3trim_w_s):int(oriImg_w*cam3trim_w_e)]

        bird_1_rot = bird_1
        bird_2_rot = cv2.rotate(bird_2, cv2.ROTATE_90_COUNTERCLOCKWISE)
        bird_3_rot = cv2.rotate(bird_3, cv2.ROTATE_90_COUNTERCLOCKWISE)
        if is_HD_Image:
            bird_4_rot = cv2.resize(bird_4, (640, 360))
        else:
            bird_4_rot = bird_4


        combineImg = cv2.hconcat([bird_2_rot,bird_3_rot])
        combineImg = cv2.vconcat([bird_1_rot, combineImg, bird_4_rot])
	
        imgBirdview = cv2.resize(combineImg, (500, 990))
        image_message = bridge.cv2_to_imgmsg(imgBirdview, "bgr8")
        image_message.header = Header(stamp=rospy.Time.now())
        image_message.header.frame_id = 'birdview'
        pub.publish(image_message)


        frameBTF = cv2.warpPerspective(bird_4, M5, (500, 500))
        #draw_line(frameBTF)
        image_message = bridge.cv2_to_imgmsg(frameBTF, "bgr8")
        image_message.header = Header(stamp=rospy.Time.now())
        image_message.header.frame_id = 'birdviewr5'
        pub_r5.publish(image_message)

        frameBTF = cv2.warpPerspective(bird_4, M10, (500, 500))
        #draw_line(frameBTF)
        image_message = bridge.cv2_to_imgmsg(frameBTF, "bgr8")
        image_message.header = Header(stamp=rospy.Time.now())
        image_message.header.frame_id = 'birdviewr10'
        pub_r10.publish(image_message)

        frameBTF = cv2.warpPerspective(bird_4, M20, (500, 500))
        #draw_line(frameBTF)
        image_message = bridge.cv2_to_imgmsg(frameBTF, "bgr8")
        image_message.header = Header(stamp=rospy.Time.now())
        image_message.header.frame_id = 'birdviewr20'
        pub_r20.publish(image_message)

        rate.sleep()
#    pub = rospy.Publisher('~birdview_camera', Image, queue_size=10)
#    rate = rospy.Rate(15) # 15hz
#    while not rospy.is_shutdown():
#        image_message = bridge.cv2_to_imgmsg(imgBirdview, "bgr8")
#        image_message.header = Header(stamp=rospy.Time.now())
#        image_message.header.frame_id = 'birdview'
#        pub.publish(image_message)
#        rate.sleep()

def draw_line(frameBTF):
    max_line = 20
    for i in range(1, max_line):
        cv2.line(frameBTF, (500 * i / max_line, 0), (500 * i / max_line, 500), (0, 255, 0))
        cv2.line(frameBTF, (0, 500 * i / max_line), (500, 500 * i / max_line), (0, 255, 0))

def visual_detector_server():
    rospy.init_node('birdview_vision')

    #'''
    # ---------------------------------------------
    debug_imshow = 1
    debug_msgprint = 1
    img_HD = 1

    undistort_imshow = 0

    if take_Video:
        cam_1_ip = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=1"
        cam_2_ip = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=2"
        cam_3_ip = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=3"
        cam_4_ip = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=4"
    else:
        cam_1_ip = "1"
        cam_2_ip = "2"
        cam_3_ip = "3"
        cam_4_ip = "4"

    rear_UI_h = 500
    rear_UI_w = 500

    photo_no = 0
    photo_max = 120

    pts_o = np.float32([[670, 335], [1140, 340], [810, 612], [1040, 595]])
    if not img_HD:
        pts_o = int(pts_o / 3)
    pts_d = np.float32([[0, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
    M5 = cv2.getPerspectiveTransform(pts_o, pts_d)

    pts_o = np.float32([[397, 350], [1340, 340], [772, 698], [1081, 679]])
    if not img_HD:
        pts_o = int(pts_o / 3)
    pts_d = np.float32([[0, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
    M10 = cv2.getPerspectiveTransform(pts_o, pts_d)

    pts_o = np.float32([[55, 340], [1715, 345], [740, 770], [1115, 743]])
    if not img_HD:
        pts_o = int(pts_o / 3)
    pts_d = np.float32([[50, 0], [rear_UI_w, 0], [0, rear_UI_h], [rear_UI_w, rear_UI_h]])
    M20 = cv2.getPerspectiveTransform(pts_o, pts_d)

    # wrapping point [left top - right top - left bottom - right bottom]

    bird_1_img = birdcam.BIRD_CAM(take_Video, cam_1_ip, 1, debug_imshow, debug_msgprint, undistort_imshow)
    bird_2_img = birdcam.BIRD_CAM(take_Video, cam_2_ip, 2, debug_imshow, debug_msgprint, undistort_imshow)
    bird_3_img = birdcam.BIRD_CAM(take_Video, cam_3_ip, 3, debug_imshow, debug_msgprint, undistort_imshow)
    global bird_4_img
    bird_4_img = birdcam.BIRD_CAM(take_Video, cam_4_ip, 4, debug_imshow, debug_msgprint, undistort_imshow)

    #if cv2.waitKey(0) & 0xFF == ord('q'):
    #    break
    #'''

    s1 = rospy.Service('~vs_get_white_marking_position', vs_get_white_marking_position_Args, handle_get_white_marking_position)
    s2 = rospy.Service('~vs_send_cali_data', vs_send_cali_data_Args, handle_send_cali_data)
    print("Birdview vision ready to use.")

    topic_birdview_camera()

    #rospy.spin()

if __name__ == "__main__":
    visual_detector_server()

    # load a image
"""    img = cv2.imread('toprear.png')
    rows, cols = img.shape[:2]
    # original pts
    pts_o = np.float32([[38, 486], [1768, 384], [836, 1012], [1012,1000]])
    pts_d = np.float32([[0, 0], [500, 0], [0, 500], [500, 500]])
    # get transform matrix
    M = cv2.getPerspectiveTransform(pts_o, pts_d)
    # apply transformation
    dst = cv2.warpPerspective(img, M, (500, 500))
    cv2.imshow('img', img)
    cv2.imshow('dst', dst)
    cv2.waitKey(0)"""

