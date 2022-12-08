;; Auto-generated. Do not edit!


(when (boundp 'lidar_tracker::lt_object_Type)
  (if (not (find-package "LIDAR_TRACKER"))
    (make-package "LIDAR_TRACKER"))
  (shadow 'lt_object_Type (find-package "LIDAR_TRACKER")))
(unless (find-package "LIDAR_TRACKER::LT_OBJECT_TYPE")
  (make-package "LIDAR_TRACKER::LT_OBJECT_TYPE"))

(in-package "ROS")
;;//! \htmlinclude lt_object_Type.msg.html


(defclass lidar_tracker::lt_object_Type
  :super ros::object
  :slots (_ID _IDTimestamp _UpdateInterval _RatioM _MinPoint _IncEdge _DecEdge _CenterPoint _StableRefPoint _Size _Is_Cone _Is_Tracked _Est_Vel _Est_Acc _Is_Fused _Incline _Rotate ))

(defmethod lidar_tracker::lt_object_Type
  (:init
   (&key
    ((:ID __ID) 0)
    ((:IDTimestamp __IDTimestamp) 0.0)
    ((:UpdateInterval __UpdateInterval) 0.0)
    ((:RatioM __RatioM) 0.0)
    ((:MinPoint __MinPoint) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:IncEdge __IncEdge) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:DecEdge __DecEdge) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:CenterPoint __CenterPoint) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:StableRefPoint __StableRefPoint) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:Size __Size) 0.0)
    ((:Is_Cone __Is_Cone) nil)
    ((:Is_Tracked __Is_Tracked) nil)
    ((:Est_Vel __Est_Vel) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:Est_Acc __Est_Acc) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:Is_Fused __Is_Fused) nil)
    ((:Incline __Incline) (instance lidar_tracker::lt_datapoint_Type :init))
    ((:Rotate __Rotate) 0.0)
    )
   (send-super :init)
   (setq _ID (round __ID))
   (setq _IDTimestamp (float __IDTimestamp))
   (setq _UpdateInterval (float __UpdateInterval))
   (setq _RatioM (float __RatioM))
   (setq _MinPoint __MinPoint)
   (setq _IncEdge __IncEdge)
   (setq _DecEdge __DecEdge)
   (setq _CenterPoint __CenterPoint)
   (setq _StableRefPoint __StableRefPoint)
   (setq _Size (float __Size))
   (setq _Is_Cone __Is_Cone)
   (setq _Is_Tracked __Is_Tracked)
   (setq _Est_Vel __Est_Vel)
   (setq _Est_Acc __Est_Acc)
   (setq _Is_Fused __Is_Fused)
   (setq _Incline __Incline)
   (setq _Rotate (float __Rotate))
   self)
  (:ID
   (&optional __ID)
   (if __ID (setq _ID __ID)) _ID)
  (:IDTimestamp
   (&optional __IDTimestamp)
   (if __IDTimestamp (setq _IDTimestamp __IDTimestamp)) _IDTimestamp)
  (:UpdateInterval
   (&optional __UpdateInterval)
   (if __UpdateInterval (setq _UpdateInterval __UpdateInterval)) _UpdateInterval)
  (:RatioM
   (&optional __RatioM)
   (if __RatioM (setq _RatioM __RatioM)) _RatioM)
  (:MinPoint
   (&rest __MinPoint)
   (if (keywordp (car __MinPoint))
       (send* _MinPoint __MinPoint)
     (progn
       (if __MinPoint (setq _MinPoint (car __MinPoint)))
       _MinPoint)))
  (:IncEdge
   (&rest __IncEdge)
   (if (keywordp (car __IncEdge))
       (send* _IncEdge __IncEdge)
     (progn
       (if __IncEdge (setq _IncEdge (car __IncEdge)))
       _IncEdge)))
  (:DecEdge
   (&rest __DecEdge)
   (if (keywordp (car __DecEdge))
       (send* _DecEdge __DecEdge)
     (progn
       (if __DecEdge (setq _DecEdge (car __DecEdge)))
       _DecEdge)))
  (:CenterPoint
   (&rest __CenterPoint)
   (if (keywordp (car __CenterPoint))
       (send* _CenterPoint __CenterPoint)
     (progn
       (if __CenterPoint (setq _CenterPoint (car __CenterPoint)))
       _CenterPoint)))
  (:StableRefPoint
   (&rest __StableRefPoint)
   (if (keywordp (car __StableRefPoint))
       (send* _StableRefPoint __StableRefPoint)
     (progn
       (if __StableRefPoint (setq _StableRefPoint (car __StableRefPoint)))
       _StableRefPoint)))
  (:Size
   (&optional __Size)
   (if __Size (setq _Size __Size)) _Size)
  (:Is_Cone
   (&optional __Is_Cone)
   (if __Is_Cone (setq _Is_Cone __Is_Cone)) _Is_Cone)
  (:Is_Tracked
   (&optional __Is_Tracked)
   (if __Is_Tracked (setq _Is_Tracked __Is_Tracked)) _Is_Tracked)
  (:Est_Vel
   (&rest __Est_Vel)
   (if (keywordp (car __Est_Vel))
       (send* _Est_Vel __Est_Vel)
     (progn
       (if __Est_Vel (setq _Est_Vel (car __Est_Vel)))
       _Est_Vel)))
  (:Est_Acc
   (&rest __Est_Acc)
   (if (keywordp (car __Est_Acc))
       (send* _Est_Acc __Est_Acc)
     (progn
       (if __Est_Acc (setq _Est_Acc (car __Est_Acc)))
       _Est_Acc)))
  (:Is_Fused
   (&optional __Is_Fused)
   (if __Is_Fused (setq _Is_Fused __Is_Fused)) _Is_Fused)
  (:Incline
   (&rest __Incline)
   (if (keywordp (car __Incline))
       (send* _Incline __Incline)
     (progn
       (if __Incline (setq _Incline (car __Incline)))
       _Incline)))
  (:Rotate
   (&optional __Rotate)
   (if __Rotate (setq _Rotate __Rotate)) _Rotate)
  (:serialization-length
   ()
   (+
    ;; int64 _ID
    8
    ;; float64 _IDTimestamp
    8
    ;; float64 _UpdateInterval
    8
    ;; float64 _RatioM
    8
    ;; lidar_tracker/lt_datapoint_Type _MinPoint
    (send _MinPoint :serialization-length)
    ;; lidar_tracker/lt_datapoint_Type _IncEdge
    (send _IncEdge :serialization-length)
    ;; lidar_tracker/lt_datapoint_Type _DecEdge
    (send _DecEdge :serialization-length)
    ;; lidar_tracker/lt_datapoint_Type _CenterPoint
    (send _CenterPoint :serialization-length)
    ;; lidar_tracker/lt_datapoint_Type _StableRefPoint
    (send _StableRefPoint :serialization-length)
    ;; float64 _Size
    8
    ;; bool _Is_Cone
    1
    ;; bool _Is_Tracked
    1
    ;; lidar_tracker/lt_datapoint_Type _Est_Vel
    (send _Est_Vel :serialization-length)
    ;; lidar_tracker/lt_datapoint_Type _Est_Acc
    (send _Est_Acc :serialization-length)
    ;; bool _Is_Fused
    1
    ;; lidar_tracker/lt_datapoint_Type _Incline
    (send _Incline :serialization-length)
    ;; float64 _Rotate
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _ID
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ID (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ID) (= (length (_ID . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ID . bv) 0) 0) s)
              (write-long (ash (elt (_ID . bv) 1) -1) s))
             ((and (class _ID) (= (length (_ID . bv)) 1)) ;; big1
              (write-long (elt (_ID . bv) 0) s)
              (write-long (if (>= _ID 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ID s)(write-long (if (>= _ID 0) 0 #xffffffff) s)))
     ;; float64 _IDTimestamp
       (sys::poke _IDTimestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _UpdateInterval
       (sys::poke _UpdateInterval (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _RatioM
       (sys::poke _RatioM (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; lidar_tracker/lt_datapoint_Type _MinPoint
       (send _MinPoint :serialize s)
     ;; lidar_tracker/lt_datapoint_Type _IncEdge
       (send _IncEdge :serialize s)
     ;; lidar_tracker/lt_datapoint_Type _DecEdge
       (send _DecEdge :serialize s)
     ;; lidar_tracker/lt_datapoint_Type _CenterPoint
       (send _CenterPoint :serialize s)
     ;; lidar_tracker/lt_datapoint_Type _StableRefPoint
       (send _StableRefPoint :serialize s)
     ;; float64 _Size
       (sys::poke _Size (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _Is_Cone
       (if _Is_Cone (write-byte -1 s) (write-byte 0 s))
     ;; bool _Is_Tracked
       (if _Is_Tracked (write-byte -1 s) (write-byte 0 s))
     ;; lidar_tracker/lt_datapoint_Type _Est_Vel
       (send _Est_Vel :serialize s)
     ;; lidar_tracker/lt_datapoint_Type _Est_Acc
       (send _Est_Acc :serialize s)
     ;; bool _Is_Fused
       (if _Is_Fused (write-byte -1 s) (write-byte 0 s))
     ;; lidar_tracker/lt_datapoint_Type _Incline
       (send _Incline :serialize s)
     ;; float64 _Rotate
       (sys::poke _Rotate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _ID
#+(or :alpha :irix6 :x86_64)
      (setf _ID (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ID (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float64 _IDTimestamp
     (setq _IDTimestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _UpdateInterval
     (setq _UpdateInterval (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _RatioM
     (setq _RatioM (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; lidar_tracker/lt_datapoint_Type _MinPoint
     (send _MinPoint :deserialize buf ptr-) (incf ptr- (send _MinPoint :serialization-length))
   ;; lidar_tracker/lt_datapoint_Type _IncEdge
     (send _IncEdge :deserialize buf ptr-) (incf ptr- (send _IncEdge :serialization-length))
   ;; lidar_tracker/lt_datapoint_Type _DecEdge
     (send _DecEdge :deserialize buf ptr-) (incf ptr- (send _DecEdge :serialization-length))
   ;; lidar_tracker/lt_datapoint_Type _CenterPoint
     (send _CenterPoint :deserialize buf ptr-) (incf ptr- (send _CenterPoint :serialization-length))
   ;; lidar_tracker/lt_datapoint_Type _StableRefPoint
     (send _StableRefPoint :deserialize buf ptr-) (incf ptr- (send _StableRefPoint :serialization-length))
   ;; float64 _Size
     (setq _Size (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _Is_Cone
     (setq _Is_Cone (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _Is_Tracked
     (setq _Is_Tracked (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; lidar_tracker/lt_datapoint_Type _Est_Vel
     (send _Est_Vel :deserialize buf ptr-) (incf ptr- (send _Est_Vel :serialization-length))
   ;; lidar_tracker/lt_datapoint_Type _Est_Acc
     (send _Est_Acc :deserialize buf ptr-) (incf ptr- (send _Est_Acc :serialization-length))
   ;; bool _Is_Fused
     (setq _Is_Fused (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; lidar_tracker/lt_datapoint_Type _Incline
     (send _Incline :deserialize buf ptr-) (incf ptr- (send _Incline :serialization-length))
   ;; float64 _Rotate
     (setq _Rotate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get lidar_tracker::lt_object_Type :md5sum-) "653a1245a4632ad939226826e9619f93")
(setf (get lidar_tracker::lt_object_Type :datatype-) "lidar_tracker/lt_object_Type")
(setf (get lidar_tracker::lt_object_Type :definition-)
      "# Object ID
int64 ID
float64 IDTimestamp

# Interval [s]
float64 UpdateInterval

# Matching ratio
float64 RatioM

# Object feature points
lidar_tracker/lt_datapoint_Type MinPoint
lidar_tracker/lt_datapoint_Type IncEdge
lidar_tracker/lt_datapoint_Type DecEdge
lidar_tracker/lt_datapoint_Type CenterPoint
lidar_tracker/lt_datapoint_Type StableRefPoint

# Object size [m]
float64 Size

# Object is cone
bool Is_Cone
# Object is tracked
bool Is_Tracked

# Estimated Vel Acc
lidar_tracker/lt_datapoint_Type Est_Vel
lidar_tracker/lt_datapoint_Type Est_Acc

# Lidar data fused object
bool Is_Fused

# Estimated incline angle [rad]
lidar_tracker/lt_datapoint_Type Incline
# Estimated rotated angle [rad]
float64 Rotate


================================================================================
MSG: lidar_tracker/lt_datapoint_Type
# XY coordinate [m]
float64  Dist
float64  Angle
float64  x
float64  y
# RSSI [0~255]
float64  intensity


")



(provide :lidar_tracker/lt_object_Type "653a1245a4632ad939226826e9619f93")


