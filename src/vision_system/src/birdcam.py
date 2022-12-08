import cv2
import numpy as np
import matplotlib.pyplot as plt
from collections import deque
import glob
import os

def LiDar_to_pixel(x, y):
    new_x = x / 20 + 250

    new_y = (y - 660) / 20

    return int(new_x), int(new_y)


def Pixelx_to_Lidar(x):
    new_x = (x - 250) * 20

    return int(new_x)

def running_mean(x, N):
    cumsum = np.cumsum(np.insert(x, 0, 0))
    return (cumsum[N:] - cumsum[:-N]) / N


def moving_average(data):
    # calculates the moving average of the data
    # data : data to be averaged
    # return : the filtered average of the data
    return sum(data) / len(data)


def plot_histogram(data):
    # plot a real time histogram of the supplied data
    # data : data to plot
    plt.clf()
    plt.plot(data)
    plt.pause(0.00001)


def histogram(data):
    # calculates the histogram of data
    # data : data to be transformed into a histogram
    # returns : a vector of the histogram data
    return np.sum(data, axis=0)


def histogram_peaks(data, plot_hist=0):
    # finds the peak location of a data line
    # data : input 2D data to locate peaks
    # plot_hist : plot the histogram of the data
    # return : the peak locations
    hist = histogram(data)

    #if plot_hist == True:
    #    plot_histogram(hist)

    midpoint = np.int(hist.shape[0] // 2)
    leftx_base = np.argmax(hist[:midpoint])
    rightx_base = np.argmax(hist[midpoint:]) + midpoint

    cv2.waitKey(1)
    return leftx_base, rightx_base


def plot_graph(x_data, y_data):
    # plot a real time histogram of the supplied data
    # x_data : X data to plot
    # y_data : Y data to plot
    plt.clf()
    for y in y_data:
        plt.plot(y, x_data)
    plt.gca().invert_yaxis()  # to visualize as we do the images
    plt.pause(0.00001)


class Filter():

    def __init__(self, max_length):
        self.queue = deque(maxlen=max_length)
        self.max_length = max_length

    def moving_average(self, data):
        # calculates the moving average of the filter as well as keeps track
        # of the time series  data
        # data : new data to be added to the queue to be filtered
        # return : the filtered average for the filter, -1 if error

        self.queue.appendleft(data)
        queue_length = len(self.queue)
        try:
            # find the moving average
            average = sum(self.queue) / queue_length
        except:
            average = -1

        if queue_length >= self.max_length:
            self.queue.pop()
        return average


class BIRD_CAM:
    def __init__(self, source, target, cam_no, showImage, showDebug, showUndistort):
        self.source = source
        self.target = target
        self.cam_no = cam_no
        self.showImage = showImage
        self.showDebug = showDebug
        self.showUndistort = showUndistort
        self.left_fit = None
        self.right_fit = None
        self.queue_size = 32
        self.left_fit_filter = Filter(self.queue_size)
        self.right_fit_filter = Filter(self.queue_size)
        self.h = 1080
        self.w = 1920
        self.bird_h = 500
        self.bird_w = 500
        self.plot_line = 1

        self.mask_hide = np.zeros((self.bird_h, self.bird_w, 3), np.uint8)
        self.mask_hide[:] = 255
        self.mask_hide_m5 = self.mask_hide.copy()
        self.mask_hide_m5[:, 150:350] = 0
        self.mask_hide_m5[:50] = 0

        self.mask_hide_m10 = self.mask_hide.copy()
        self.mask_hide_m10[:, 220:280] = 0  # left
        self.mask_hide_m10[:, 0:100] = 0  # right
        self.mask_hide_m10[:, 400:500] = 0
        self.mask_hide_m10[:25] = 0
        #if self.showImage:
        #    cv2.imshow('mask_hide_m10', self.mask_hide_m10)  # visulise the output of the function

        if self.source:
            self.video_cap = cv2.VideoCapture(target)

    def plot_best_fit(self, img, nonzerox, nonzeroy, left_lane_inds, right_lane_inds, margin=10):
        # plots the search boxes and lane lines of where the lane lines are thought to be

        # Generate x and y values for plotting
        ploty = np.linspace(0, img.shape[0] - 1, img.shape[0])
        left_fitx = self.left_fit[0] * ploty ** 2 + self.left_fit[1] * ploty + self.left_fit[2]
        right_fitx = self.right_fit[0] * ploty ** 2 + self.right_fit[1] * ploty + self.right_fit[2]

        # Create an image to draw on and an image to show the selection window
        out_img = np.dstack((img, img, img)) * 255
        window_img = np.zeros_like(out_img)
        # Color in left and right line pixels
        out_img[nonzeroy[left_lane_inds], nonzerox[left_lane_inds]] = [255, 0, 0]
        out_img[nonzeroy[right_lane_inds], nonzerox[right_lane_inds]] = [0, 0, 255]

        # Generate a polygon to illustrate the search window area
        # And recast the x and y points into usable format for cv2.fillPoly()
        left_line_window1 = np.array([np.transpose(np.vstack([left_fitx - margin, ploty]))])
        left_line_window2 = np.array([np.flipud(np.transpose(np.vstack([left_fitx + margin, ploty])))])
        left_line_pts = np.hstack((left_line_window1, left_line_window2))
        right_line_window1 = np.array([np.transpose(np.vstack([right_fitx - margin, ploty]))])
        right_line_window2 = np.array([np.flipud(np.transpose(np.vstack([right_fitx + margin, ploty])))])
        right_line_pts = np.hstack((right_line_window1, right_line_window2))

        # Draw the lane onto the warped blank image
        cv2.fillPoly(window_img, np.int_([left_line_pts]), (0, 255, 0))
        cv2.fillPoly(window_img, np.int_([right_line_pts]), (0, 255, 0))
        result = self.combine_images(out_img, window_img, img_one_weight=1, img_two_weight=0.3)
        if self.showImage:
            cv2.imshow('result', result)  # visulise the output of the function

    def combine_images(self, img_one, img_two, img_one_weight=0.8, img_two_weight=1.):
        # combines two images into one for display purposes
        # img_one : image one
        # img_two : image two
        # img_one_weight : transparency weight of image one
        # img_two_weight : transparency weight of image two
        # return : combined image
        return cv2.addWeighted(img_one, img_one_weight, img_two, img_two_weight, 0)

    def undistort(self, hd, img, scale=0.6):
        showImage = self.showUndistort

        # Fish eye
        if hd:
            # 1920*1080
            DIM = (1920, 1080)
            K = np.array([[566.2645468995994, 0.0, 946.4566732403135], [0.0, 566.7040751436358, 564.7627139803151],
                          [0.0, 0.0, 1.0]])
            D = np.array(
                [[-0.0036311331464153377], [-0.03789240325895113], [0.03738650961608838], [-0.011800642423107936]])
        else:
            # 640*360
            DIM = (640, 360)
            K = np.array([[193.35693757489466, 0.0, 312.6655184627045], [0.0, 193.42162171571857, 190.1320267545595],
                          [0.0, 0.0, 1.0]])
            D = np.array(
                [[-0.011801503455617745], [-0.012117498886394455], [0.008620037974650175], [-0.0024227222838261965]])
            img = cv2.resize(img, (640, 360))

        dim1 = img.shape[:2][::-1]  # dim1 is the dimension of input image to un-distort
        assert dim1[0] / dim1[1] == DIM[0] / DIM[
            1], "Image to un-distort needs to have same aspect ratio as the ones used in calibration"
        if dim1[0] != DIM[0]:
            img = cv2.resize(img, DIM, interpolation=cv2.INTER_AREA)
        Knew = K.copy()
        if scale:  # change fov
            Knew[(0, 1), (0, 1)] = scale * Knew[(0, 1), (0, 1)]
        map1, map2 = cv2.fisheye.initUndistortRectifyMap(K, D, np.eye(3), Knew, DIM, cv2.CV_16SC2)
        undistorted_img = cv2.remap(img, map1, map2, interpolation=cv2.INTER_LINEAR, borderMode=cv2.BORDER_CONSTANT)

        if showImage:
            cv2.imshow("undistorted", undistorted_img)
            cv2.waitKey(1)
        assert isinstance(undistorted_img, object)
        return undistorted_img

    def show_ori(self, photo_no):
        img = self.get_img(photo_no)
        cv2.imshow("img", img)
        cv2.waitKey(1)

    def get_img(self, photo_no):
        if self.source:
            temp, img = self.video_cap.read()
        else:
            target = self.target
            photo_path = "RAW/Bird0" + target + "/Bird0" + target + "_" + str(photo_no) + ".jpg"
            img = cv2.imread(photo_path)
        return img

    def wrap_img(self, img, photo_no, ratio):
        wrapped_img = cv2.warpPerspective(img, ratio, (self.bird_h, self.bird_w))
        return wrapped_img

    def threshold_img(self, image):

        font = cv2.FONT_HERSHEY_SIMPLEX

        # hls for edge detection
        hls = cv2.cvtColor(image, cv2.COLOR_BGR2HLS)

        normalize = cv2.normalize(image, dst=None, alpha=350, beta=10, norm_type=cv2.NORM_MINMAX)
        equalizeHist = cv2.equalizeHist(hls[:, :, 2])

        # hls = normalize

        hls_channel = hls[:, :, 1]  # use on the luminance channel data for edges
        # cv2.imshow("l_channel", hls_channel)
	#white colour
        _, binary = cv2.threshold(hls_channel, 140, 255, cv2.THRESH_BINARY)

        binary = cv2.GaussianBlur(binary, (3, 3), 0)

        low_threshold = 1
        high_threshold = 10
        edges = cv2.Canny(hls_channel, low_threshold, high_threshold)

        _, contours, hierarchy = cv2.findContours(binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        mask = np.ones(binary.shape[:2], dtype="uint8") * 0

        for i in range(0, len(contours)):
            (x, y, w, h) = cv2.boundingRect(contours[i])
            cv2.rectangle(image, (x, y), (x + w, y + h), (255, 0, 0), 2, cv2.LINE_AA)
            area = cv2.contourArea(contours[i])
            length = cv2.arcLength(contours[i], True)
            #cv2.putText(image, "No.%d" % i, (x, y - 5), font, 0.8, (255, 0, 0), 2)
            if area > 250 and h > 35 and w < 40:
                cv2.drawContours(mask, [contours[i]], -1, 255, -1)

            bit_img = cv2.bitwise_and(binary, binary, mask=mask)
            #print("no = " + str(i) + " area = " + str(area) + " arcLength = " + str(length))
            #print("no = " + str(i) + " w = " + str(w) + " h = " + str(h))

        if self.showImage:
            cv2.imshow("hls", hls[:, :, 1])
            cv2.imshow("equalizeHist", equalizeHist)
            cv2.imshow("normalize", normalize)
            cv2.imshow("image of thresh", image)
            cv2.imshow("mask", mask)
            cv2.imshow("binary", binary)
            cv2.imshow("bit_img", bit_img)

            # cv2.waitKey(0)

        return bit_img

    def lane_lines(self, image, plot_line):
        # finds the location of the lanes lines
        # image : image that needs o be search for line. Should be a warped image
        # plot_line : True => plots the found lines onto the image for visulisation
        # return : quadratics functions of the left and right lane lines

        # is the input image a binary image or a multi-channel image
        if len(image.shape) > 2:
            # image has multiple channels. convert the image to a binary image
            # raise 'Lane.lane_lines input image needs to be a binary image'
            img = image[:, :, 0]
            for channel in range(1, image.shape[2]):
                img = self.binary_image(img, image[:, :, channel])
        else:
            img = image.copy()

        # Does the program know where the lane lines are?
        """
        if self.left_fit is None or self.right_fit is None:
            # Don't know where the lane lines are, so go and find them
            self.find_lane_lines(img, plot_line=plot_line, draw_square=plot_line)
        else:
            self.refresh_lane_lines(img, plot_line=plot_line)
        """
        self.find_lane_lines(img, plot_line=plot_line, draw_square=plot_line)

        return self.left_fit, self.right_fit

    def find_lane_lines(self, img, line_windows=100, plot_line=0, draw_square=0):
        # finds the lane line locations within an image
        # img : image that needs o be search for line. Should be a warped image
        # line_windows : how many windods are used in the search for the lane lines
        # plot_line : True => plots the found lines onto the image for visulisation
        # draw_square : draws the search boxes locations wher the lane lines are located
        # return : quadratics functions of the left and right lane lines

        out_img = img.copy()

        # Set height of windows
        window_height = np.int(img.shape[0] / line_windows)
        # Identify the x and y positions of all nonzero pixels in the image
        nonzero = img.nonzero()
        nonzeroy = np.array(nonzero[0])
        nonzerox = np.array(nonzero[1])
        if self.showImage:
            cv2.imshow("imgimgimgimgimg", img)

        # Current positions to be updated for each window
        leftx, rightx = histogram_peaks(img, self.plot_line)
        leftx_current = leftx
        rightx_current = rightx
        # Set the width of the windows +/- margin
        margin = 10
        # Set minimum number of pixels found to recenter window
        minpix = 50
        # Create empty lists to receive left and right lane pixel indices
        left_lane_inds = []
        right_lane_inds = []

        # Step through the windows one by one
        for window in range(line_windows):
            # Identify window boundaries in x and y (and right and left)
            win_y_low = img.shape[0] - (window + 1) * window_height
            win_y_high = img.shape[0] - window * window_height

            win_xleft_low = leftx_current - margin
            win_xleft_high = leftx_current + margin
            win_xright_low = rightx_current - margin
            win_xright_high = rightx_current + margin

            if draw_square == True:
                # Draw the windows on the visualization image
                cv2.rectangle(out_img, (win_xleft_low, win_y_low), (win_xleft_high, win_y_high), (255, 255, 255), 2)
                cv2.rectangle(out_img, (win_xright_low, win_y_low), (win_xright_high, win_y_high), (255, 255, 255), 2)
            if self.showImage:
                cv2.imshow("out_imgout_img", out_img)

            # Identify the nonzero pixels in x and y within the window
            good_left_inds = ((nonzeroy >= win_y_low) & (nonzeroy < win_y_high) & (nonzerox >= win_xleft_low) & (
                    nonzerox < win_xleft_high)).nonzero()[0]
            good_right_inds = ((nonzeroy >= win_y_low) & (nonzeroy < win_y_high) & (nonzerox >= win_xright_low) & (
                    nonzerox < win_xright_high)).nonzero()[0]
            # Append these indices to the lists
            left_lane_inds.append(good_left_inds)
            right_lane_inds.append(good_right_inds)
            # If you found > minpix pixels, recenter next window on their mean position
            if len(good_left_inds) > minpix:
                leftx_current = np.int(np.mean(nonzerox[good_left_inds]))
            if len(good_right_inds) > minpix:
                rightx_current = np.int(np.mean(nonzerox[good_right_inds]))

        # Concatenate the arrays of indices
        left_lane_inds = np.concatenate(left_lane_inds)
        right_lane_inds = np.concatenate(right_lane_inds)

        # Extract left and right line pixel positions
        leftx = nonzerox[left_lane_inds]
        lefty = nonzeroy[left_lane_inds]
        rightx = nonzerox[right_lane_inds]
        righty = nonzeroy[right_lane_inds]

        # Fit a second order polynomial to each
        try:
            self.left_fit = np.polyfit(lefty, leftx, 2)
        except:
            self.left_fit = [0, 0, 0]
        try:
            self.right_fit = np.polyfit(righty, rightx, 2)
        except:
            self.right_fit = [0, 0, 0]

        if plot_line == True:
            # plot the line of best fit onto the image

            self.plot_best_fit(img, nonzerox, nonzeroy, left_lane_inds, right_lane_inds)

        cv2.waitKey(1)

        return self.left_fit, self.right_fit

    def refresh_lane_lines(self, img, plot_line):
        # uses the previous lane line locations to refresh the current lane line location
        # img : image that needs o be search for line. Should be a warped image
        # plot_line : True => plots the found lines onto the image for visulisation
        # return : quadratics functions of the left and right lane lines

        nonzero = img.nonzero()
        nonzeroy = np.array(nonzero[0])
        nonzerox = np.array(nonzero[1])
        margin = 100
        left_lane_inds = (
                (nonzerox > (
                        self.left_fit[0] * (nonzeroy ** 2) + self.left_fit[1] * nonzeroy + self.left_fit[
                    2] - margin)) & (
                        nonzerox < (
                        self.left_fit[0] * (nonzeroy ** 2) + self.left_fit[1] * nonzeroy + self.left_fit[2] + margin)))
        right_lane_inds = (
                (nonzerox > (
                        self.right_fit[0] * (nonzeroy ** 2) + self.right_fit[1] * nonzeroy + self.right_fit[
                    2] - margin)) & (
                        nonzerox < (
                        self.right_fit[0] * (nonzeroy ** 2) + self.right_fit[1] * nonzeroy + self.right_fit[
                    2] + margin)))

        # Again, extract left and right line pixel positions
        leftx = nonzerox[left_lane_inds]
        lefty = nonzeroy[left_lane_inds]
        rightx = nonzerox[right_lane_inds]
        righty = nonzeroy[right_lane_inds]
        # Fit a second order polynomial to each

        try:
            self.left_fit = np.polyfit(lefty, leftx, 2)
            self.right_fit = np.polyfit(righty, rightx, 2)
        except:
            return 0, 0

        if plot_line:
            # plot the line of best fit onto the image
            self.plot_best_fit(img, nonzerox, nonzeroy, left_lane_inds, right_lane_inds)

        return self.left_fit, self.right_fit

    def quadratic_line(self, calc, plot, start, stop, *argv):
        # gets each pixle value for a quadratic over the image
        # start : start value for the quadratic
        # stop : end value for the quadratic
        # calc : what quadratic variable do calculate
        # quad_values : list of quadratic variables
        # result : list of x and y coordinates

        data = []
        count = 0
        array = np.array([n for n in range(start, stop)])
        for arg_vect in argv:
            if len(arg_vect) != 3:
                raise Exception('there must be 3 quadratic values supplied')

            data.append(arg_vect[0] * array ** 2 + arg_vect[1] * array + arg_vect[2])
            count += 1

        # make the last list the average of all the lists
        data.append(np.sum(data, axis=0) / count)

        lines = np.array(data)

        #if 0:
        #    plot_graph(array, lines)

        return lines, array

    def find_lane(self, photo_no, ratio, pre_x, target_Y):
        img = self.get_img(photo_no)
        img_undistort = self.undistort(1, img)
        wrap = self.wrap_img(img_undistort, photo_no, ratio)
        wrap_mask = cv2.bitwise_and(wrap, self.mask_hide_m10)
        thresh = self.threshold_img(wrap_mask)

        left_white_point = 0
        right_white_point = 0

        if self.showImage:
            cv2.imshow("wrap_mask", wrap_mask)
            cv2.imshow("thresh", thresh)

        left_fit, right_fit = self.lane_lines(thresh, plot_line=self.plot_line)

        self.h, self.w = thresh.shape  # horizontal pixel count of the camera

        if all(left_fit) or all(right_fit):
            self.left_fit = self.left_fit_filter.moving_average(left_fit)
            self.right_fit = self.right_fit_filter.moving_average(right_fit)

            lanes_x, lanes_y = self.quadratic_line('x', self.showImage, 0, self.h, left_fit, right_fit, )

            self.left_pts = lanes_x[0]
            self.right_pts = lanes_x[1]
            self.center_pts = lanes_x[2]
            self.y_pts = lanes_y

            for i in lanes_y:
                show_point = cv2.circle(wrap, (int(lanes_x[0, i]), int(lanes_y[i])), 0, (0, 0, 255), 2)
                show_point = cv2.circle(wrap, (int(lanes_x[1, i]), int(lanes_y[i])), 0, (0, 0, 255), 2)
                show_point = cv2.circle(wrap, (i, target_Y), 0, (0, 0, 255), 2)

            if self.showImage:
                cv2.imshow('show_point', show_point)


            left_white_point = lanes_x[0, target_Y]
            right_white_point = lanes_x[1, target_Y]

            if self.showDebug:
                print("Target Y:", target_Y)
                print("y_pts line:", lanes_y[target_Y])
                print("left line:", lanes_x[0, target_Y])
                print("right line:", lanes_x[1, target_Y])
                print("center line:", lanes_x[2, target_Y])

        else:
            if self.showDebug:
                print("no white lane")
            return pre_x

        if left_white_point == 0 and right_white_point == 0:
            left_white_point = pre_x
            right_white_point = pre_x
        elif left_white_point == 0:
            left_white_point = right_white_point
        elif right_white_point == 0:
            right_white_point = left_white_point


        #if self.showDebug:
        #print('left_white_point:', left_white_point, '\n  right_white_point: ', right_white_point)

        diff_mm = 2000
        _, diff_pix_y = LiDar_to_pixel(0, diff_mm)
        left_diff = abs(left_white_point - pre_x)
        right_diff = abs(right_white_point - pre_x)
        if left_diff < right_diff:
            if left_diff > diff_pix_y:
                new_x = pre_x
            else:
                new_x = left_white_point
        elif right_diff > diff_pix_y:
            new_x = pre_x
        else:
            new_x = right_white_point

        return int(new_x)


def combine_bird(bird_1_img, bird_2_img, bird_3_img, bird_4_img, photo_no, img_HD):
    cam2trim_w_s = 0
    cam2trim_w_e = 1
    cam2trim_h_s = 0
    cam2trim_h_e = float(8) / float(9)

    cam3trim_w_s = 0
    cam3trim_w_e = 1
    cam3trim_h_s = float(1) / float(9)
    cam3trim_h_e = 1

    if img_HD:
        oriImg_h = 1080
        oriImg_w = 1920
    else:
        oriImg_h = 360
        oriImg_w = 640

    resize_combine_h = 500
    resize_combine_w = 990

    bird_4_hd = bird_4_img.undistort(1, photo_no)

    bird_1 = bird_1_img.undistort(img_HD, photo_no)
    bird_2 = bird_2_img.undistort(img_HD, photo_no)
    bird_3 = bird_3_img.undistort(img_HD, photo_no)
    bird_4 = bird_4_img.undistort(img_HD, photo_no)

    bird_2 = bird_2[int(oriImg_h * cam2trim_h_s):int(oriImg_h * cam2trim_h_e),
             int(oriImg_w * cam2trim_w_s):int(oriImg_w * cam2trim_w_e)]
    bird_3 = bird_3[int(oriImg_h * cam3trim_h_s):int(oriImg_h * cam3trim_h_e),
             int(oriImg_w * cam3trim_w_s):int(oriImg_w * cam3trim_w_e)]

    bird_1_rot = bird_1
    bird_2_rot = cv2.rotate(bird_2, cv2.ROTATE_90_COUNTERCLOCKWISE)
    bird_3_rot = cv2.rotate(bird_3, cv2.ROTATE_90_COUNTERCLOCKWISE)
    bird_4_rot = bird_4

    combineImg = cv2.hconcat([bird_2_rot, bird_3_rot])
    combineImg = cv2.vconcat([bird_1_rot, combineImg, bird_4_rot])

    imgBirdview = cv2.resize(combineImg, (resize_combine_w, resize_combine_h))
    return imgBirdview
