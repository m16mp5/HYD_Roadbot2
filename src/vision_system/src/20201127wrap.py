import cv2
import numpy as np
from PIL import Image
import os, sys # for save file


Target_folder = "./T"
Target_file_name_01 = "wraped01.jpg"
Target_file_name_02 = "wraped02.jpg"

bird_1_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=1"
bird_2_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=2"
bird_3_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=3"
bird_4_addr = "http://root:root@192.168.10.41/mjpg/video.mjpg?camera=4"


def WrapImg(target,src_coordinate,dst_coordinate):

    target_H, target_W,target_c = target.shape
    target_H = 500
    target_W = 500

    src = np.float32(src_coordinate)
    dst = np.float32(dst_coordinate)
    M = cv2.getPerspectiveTransform(src, dst) # The transformation matrix

    return cv2.warpPerspective(target, M, (target_W, target_H)) # Image warping

if __name__ == '__main__':

    bird_1_cap = cv2.VideoCapture(bird_1_addr)
    bird_2_cap = cv2.VideoCapture(bird_2_addr)
    bird_3_cap = cv2.VideoCapture(bird_3_addr)
    bird_4_cap = cv2.VideoCapture(bird_4_addr)
    
    while(True):

        temp, RB_head = bird_1_cap.read()
        temp, RB_rear = bird_4_cap.read()

	#RB_head = cv2.imread(Target_folder + "/01.jpg") # Read image
        #RB_rear = cv2.imread(Target_folder + "/02.jpg") # Read image

        RB_head_H, RB_head_W,RB_head_c = RB_head.shape
        RB_rear_H, RB_rear_W,RB_rear_c = RB_rear.shape

        src_head_X_left = 0
        src_head_Y_top = 550
        src_head_X_right = RB_head_W
        src_head_Y_bottom = RB_head_H

        dst_head_X_left = RB_head_W/3
        dst_head_X_right = RB_head_W - RB_head_W/3
        dst_head_Y_bottom = RB_head_H

        dst_head_X_offset = RB_head_W/3

        src_head = [[src_head_X_left,src_head_Y_top],
                    [src_head_X_right, src_head_Y_top],
                    [src_head_X_left, src_head_Y_bottom],
                    [src_head_X_right, src_head_Y_bottom]]
        dst_head = [[src_head_X_left,src_head_Y_top],
                    [src_head_X_right, src_head_Y_top],
                    [dst_head_X_left, dst_head_Y_bottom],
                    [dst_head_X_right, dst_head_Y_bottom]]

        '''10m
        src_rear_left_top = np.float32([0, 120])
        src_rear_right_top = np.float32([540, 120])
        src_rear_left_bottom = np.float32([190, 237])
        src_rear_right_bottom = np.float32([413, 222])
        '''

        rear_h_w = 500

#10m wrap point
        src_rear_left_top = np.float32([210,115])
        src_rear_right_top = np.float32([403,110])
        src_rear_left_bottom = np.float32([263,210])
        src_rear_right_bottom = np.float32([340,210])

        dst_rear_left_top = np.float32([0, 0])
        dst_rear_right_top = np.float32([rear_h_w, 0])
        dst_rear_left_bottom = np.float32([0, rear_h_w])
        dst_rear_right_bottom = np.float32([rear_h_w, rear_h_w])

        src_rear = [src_rear_left_top,
                    src_rear_right_top,
                    src_rear_left_bottom,
                    src_rear_right_bottom]
        dst_rear = [dst_rear_left_top,
                    dst_rear_right_top,
                    dst_rear_left_bottom,
                    dst_rear_right_bottom]


        warped_RB_head = WrapImg(RB_head,src_head,dst_head)
        warped_RB_rear = WrapImg(RB_rear,src_rear,dst_rear)


	RB_rear = cv2.circle(RB_rear, (210,115), radius = 2, color=(0,0,255), thickness = 10)
	RB_rear = cv2.circle(RB_rear, (403,110), radius = 2, color=(0,0,255), thickness = 10)
	RB_rear = cv2.circle(RB_rear, (263,210), radius = 2, color=(0,0,255), thickness = 10)
	RB_rear = cv2.circle(RB_rear, (340,210), radius = 2, color=(0,0,255), thickness = 10)

        #cv2.imshow('ORI_RB_head',RB_head)

        cv2.imshow('ORI_RB_rear',RB_rear)

        cv2.namedWindow('warped_RB_head',cv2.WINDOW_NORMAL)
        cv2.resizeWindow('warped_RB_head', 500, 500)
        #cv2.imshow('warped_RB_head',warped_RB_head)

        cv2.namedWindow('warped_RB_rear',cv2.WINDOW_NORMAL)
        cv2.resizeWindow('warped_RB_rear', 500, 500)
        cv2.imshow('warped_RB_rear',warped_RB_rear)

        cv2.imwrite(Target_file_name_01,warped_RB_head)
        cv2.imwrite(Target_file_name_02,warped_RB_rear)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
