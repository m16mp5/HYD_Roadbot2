;; Auto-generated. Do not edit!


(when (boundp 'lidar_tracker::lt_datapoint_Type)
  (if (not (find-package "LIDAR_TRACKER"))
    (make-package "LIDAR_TRACKER"))
  (shadow 'lt_datapoint_Type (find-package "LIDAR_TRACKER")))
(unless (find-package "LIDAR_TRACKER::LT_DATAPOINT_TYPE")
  (make-package "LIDAR_TRACKER::LT_DATAPOINT_TYPE"))

(in-package "ROS")
;;//! \htmlinclude lt_datapoint_Type.msg.html


(defclass lidar_tracker::lt_datapoint_Type
  :super ros::object
  :slots (_Dist _Angle _x _y _intensity ))

(defmethod lidar_tracker::lt_datapoint_Type
  (:init
   (&key
    ((:Dist __Dist) 0.0)
    ((:Angle __Angle) 0.0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:intensity __intensity) 0.0)
    )
   (send-super :init)
   (setq _Dist (float __Dist))
   (setq _Angle (float __Angle))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _intensity (float __intensity))
   self)
  (:Dist
   (&optional __Dist)
   (if __Dist (setq _Dist __Dist)) _Dist)
  (:Angle
   (&optional __Angle)
   (if __Angle (setq _Angle __Angle)) _Angle)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:intensity
   (&optional __intensity)
   (if __intensity (setq _intensity __intensity)) _intensity)
  (:serialization-length
   ()
   (+
    ;; float64 _Dist
    8
    ;; float64 _Angle
    8
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _intensity
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _Dist
       (sys::poke _Dist (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Angle
       (sys::poke _Angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _intensity
       (sys::poke _intensity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _Dist
     (setq _Dist (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Angle
     (setq _Angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _intensity
     (setq _intensity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get lidar_tracker::lt_datapoint_Type :md5sum-) "856cbb998fe9c851ccd38f03abcbca6e")
(setf (get lidar_tracker::lt_datapoint_Type :datatype-) "lidar_tracker/lt_datapoint_Type")
(setf (get lidar_tracker::lt_datapoint_Type :definition-)
      "# XY coordinate [m]
float64  Dist
float64  Angle
float64  x
float64  y
# RSSI [0~255]
float64  intensity


")



(provide :lidar_tracker/lt_datapoint_Type "856cbb998fe9c851ccd38f03abcbca6e")


