;; Auto-generated. Do not edit!


(when (boundp 'lidar_tracker::lt_state_Type)
  (if (not (find-package "LIDAR_TRACKER"))
    (make-package "LIDAR_TRACKER"))
  (shadow 'lt_state_Type (find-package "LIDAR_TRACKER")))
(unless (find-package "LIDAR_TRACKER::LT_STATE_TYPE")
  (make-package "LIDAR_TRACKER::LT_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude lt_state_Type.msg.html


(defclass lidar_tracker::lt_state_Type
  :super ros::object
  :slots (_timestamp _lidars_difftime _objects _trackedcone_indexes _noncone_indexes _num_of_fusedobjects _columnscan_up_dist _columnscan_down_dist ))

(defmethod lidar_tracker::lt_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:lidars_difftime __lidars_difftime) 0.0)
    ((:objects __objects) (let (r) (dotimes (i 0) (push (instance lidar_tracker::lt_object_Type :init) r)) r))
    ((:trackedcone_indexes __trackedcone_indexes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:noncone_indexes __noncone_indexes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:num_of_fusedobjects __num_of_fusedobjects) 0)
    ((:columnscan_up_dist __columnscan_up_dist) (make-array 8 :initial-element 0.0 :element-type :float))
    ((:columnscan_down_dist __columnscan_down_dist) (make-array 8 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _lidars_difftime (float __lidars_difftime))
   (setq _objects __objects)
   (setq _trackedcone_indexes __trackedcone_indexes)
   (setq _noncone_indexes __noncone_indexes)
   (setq _num_of_fusedobjects (round __num_of_fusedobjects))
   (setq _columnscan_up_dist __columnscan_up_dist)
   (setq _columnscan_down_dist __columnscan_down_dist)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:lidars_difftime
   (&optional __lidars_difftime)
   (if __lidars_difftime (setq _lidars_difftime __lidars_difftime)) _lidars_difftime)
  (:objects
   (&rest __objects)
   (if (keywordp (car __objects))
       (send* _objects __objects)
     (progn
       (if __objects (setq _objects (car __objects)))
       _objects)))
  (:trackedcone_indexes
   (&optional __trackedcone_indexes)
   (if __trackedcone_indexes (setq _trackedcone_indexes __trackedcone_indexes)) _trackedcone_indexes)
  (:noncone_indexes
   (&optional __noncone_indexes)
   (if __noncone_indexes (setq _noncone_indexes __noncone_indexes)) _noncone_indexes)
  (:num_of_fusedobjects
   (&optional __num_of_fusedobjects)
   (if __num_of_fusedobjects (setq _num_of_fusedobjects __num_of_fusedobjects)) _num_of_fusedobjects)
  (:columnscan_up_dist
   (&optional __columnscan_up_dist)
   (if __columnscan_up_dist (setq _columnscan_up_dist __columnscan_up_dist)) _columnscan_up_dist)
  (:columnscan_down_dist
   (&optional __columnscan_down_dist)
   (if __columnscan_down_dist (setq _columnscan_down_dist __columnscan_down_dist)) _columnscan_down_dist)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; float64 _lidars_difftime
    8
    ;; lidar_tracker/lt_object_Type[] _objects
    (apply #'+ (send-all _objects :serialization-length)) 4
    ;; int64[] _trackedcone_indexes
    (* 8    (length _trackedcone_indexes)) 4
    ;; int64[] _noncone_indexes
    (* 8    (length _noncone_indexes)) 4
    ;; int64 _num_of_fusedobjects
    8
    ;; float64[8] _columnscan_up_dist
    (* 8    8)
    ;; float64[8] _columnscan_down_dist
    (* 8    8)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _lidars_difftime
       (sys::poke _lidars_difftime (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; lidar_tracker/lt_object_Type[] _objects
     (write-long (length _objects) s)
     (dolist (elem _objects)
       (send elem :serialize s)
       )
     ;; int64[] _trackedcone_indexes
     (write-long (length _trackedcone_indexes) s)
     (dotimes (i (length _trackedcone_indexes))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _trackedcone_indexes i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _trackedcone_indexes i)) (= (length ((elt _trackedcone_indexes i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _trackedcone_indexes i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _trackedcone_indexes i) . bv) 1) -1) s))
             ((and (class (elt _trackedcone_indexes i)) (= (length ((elt _trackedcone_indexes i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _trackedcone_indexes i) . bv) 0) s)
              (write-long (if (>= (elt _trackedcone_indexes i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _trackedcone_indexes i) s)(write-long (if (>= (elt _trackedcone_indexes i) 0) 0 #xffffffff) s)))
       )
     ;; int64[] _noncone_indexes
     (write-long (length _noncone_indexes) s)
     (dotimes (i (length _noncone_indexes))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _noncone_indexes i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _noncone_indexes i)) (= (length ((elt _noncone_indexes i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _noncone_indexes i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _noncone_indexes i) . bv) 1) -1) s))
             ((and (class (elt _noncone_indexes i)) (= (length ((elt _noncone_indexes i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _noncone_indexes i) . bv) 0) s)
              (write-long (if (>= (elt _noncone_indexes i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _noncone_indexes i) s)(write-long (if (>= (elt _noncone_indexes i) 0) 0 #xffffffff) s)))
       )
     ;; int64 _num_of_fusedobjects
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _num_of_fusedobjects (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _num_of_fusedobjects) (= (length (_num_of_fusedobjects . bv)) 2)) ;; bignum
              (write-long (ash (elt (_num_of_fusedobjects . bv) 0) 0) s)
              (write-long (ash (elt (_num_of_fusedobjects . bv) 1) -1) s))
             ((and (class _num_of_fusedobjects) (= (length (_num_of_fusedobjects . bv)) 1)) ;; big1
              (write-long (elt (_num_of_fusedobjects . bv) 0) s)
              (write-long (if (>= _num_of_fusedobjects 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _num_of_fusedobjects s)(write-long (if (>= _num_of_fusedobjects 0) 0 #xffffffff) s)))
     ;; float64[8] _columnscan_up_dist
     (dotimes (i 8)
       (sys::poke (elt _columnscan_up_dist i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[8] _columnscan_down_dist
     (dotimes (i 8)
       (sys::poke (elt _columnscan_down_dist i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _lidars_difftime
     (setq _lidars_difftime (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; lidar_tracker/lt_object_Type[] _objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objects (let (r) (dotimes (i n) (push (instance lidar_tracker::lt_object_Type :init) r)) r))
     (dolist (elem- _objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int64[] _trackedcone_indexes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _trackedcone_indexes (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _trackedcone_indexes i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _trackedcone_indexes i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64[] _noncone_indexes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _noncone_indexes (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _noncone_indexes i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _noncone_indexes i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64 _num_of_fusedobjects
#+(or :alpha :irix6 :x86_64)
      (setf _num_of_fusedobjects (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _num_of_fusedobjects (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float64[8] _columnscan_up_dist
   (dotimes (i (length _columnscan_up_dist))
     (setf (elt _columnscan_up_dist i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[8] _columnscan_down_dist
   (dotimes (i (length _columnscan_down_dist))
     (setf (elt _columnscan_down_dist i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get lidar_tracker::lt_state_Type :md5sum-) "e1e182e21c664b2dc04f11764f16b6e9")
(setf (get lidar_tracker::lt_state_Type :datatype-) "lidar_tracker/lt_state_Type")
(setf (get lidar_tracker::lt_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# DiffTime [s]
float64 lidars_difftime

# Detected Objects
lidar_tracker/lt_object_Type[] objects
int64[] trackedcone_indexes 
int64[] noncone_indexes 

# Detected Objects Stat
int64 num_of_fusedobjects

# Detected dist(X) for 8 column(Y) scanners
float64[8] columnscan_up_dist  
float64[8] columnscan_down_dist  

================================================================================
MSG: lidar_tracker/lt_object_Type
# Object ID
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



(provide :lidar_tracker/lt_state_Type "e1e182e21c664b2dc04f11764f16b6e9")


