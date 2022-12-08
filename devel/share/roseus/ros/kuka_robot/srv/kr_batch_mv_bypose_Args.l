;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_batch_mv_bypose_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_batch_mv_bypose_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_BYPOSE_ARGS")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_BYPOSE_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_BYPOSE_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_BYPOSE_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_BYPOSE_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_BYPOSE_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_batch_mv_bypose_ArgsRequest
  :super ros::object
  :slots (_pose _round _block ))

(defmethod kuka_robot::kr_batch_mv_bypose_ArgsRequest
  (:init
   (&key
    ((:pose __pose) (instance kuka_robot::kr_pose_Type :init))
    ((:round __round) 0.0)
    ((:block __block) 0)
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _round (float __round))
   (setq _block (round __block))
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:round
   (&optional __round)
   (if __round (setq _round __round)) _round)
  (:block
   (&optional __block)
   (if __block (setq _block __block)) _block)
  (:serialization-length
   ()
   (+
    ;; kuka_robot/kr_pose_Type _pose
    (send _pose :serialization-length)
    ;; float64 _round
    8
    ;; int64 _block
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; kuka_robot/kr_pose_Type _pose
       (send _pose :serialize s)
     ;; float64 _round
       (sys::poke _round (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _block
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _block (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _block) (= (length (_block . bv)) 2)) ;; bignum
              (write-long (ash (elt (_block . bv) 0) 0) s)
              (write-long (ash (elt (_block . bv) 1) -1) s))
             ((and (class _block) (= (length (_block . bv)) 1)) ;; big1
              (write-long (elt (_block . bv) 0) s)
              (write-long (if (>= _block 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _block s)(write-long (if (>= _block 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; kuka_robot/kr_pose_Type _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; float64 _round
     (setq _round (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _block
#+(or :alpha :irix6 :x86_64)
      (setf _block (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _block (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass kuka_robot::kr_batch_mv_bypose_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_batch_mv_bypose_ArgsResponse
  (:init
   (&key
    ((:response __response) 0)
    )
   (send-super :init)
   (setq _response (round __response))
   self)
  (:response
   (&optional __response)
   (if __response (setq _response __response)) _response)
  (:serialization-length
   ()
   (+
    ;; int64 _response
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _response
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _response (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _response) (= (length (_response . bv)) 2)) ;; bignum
              (write-long (ash (elt (_response . bv) 0) 0) s)
              (write-long (ash (elt (_response . bv) 1) -1) s))
             ((and (class _response) (= (length (_response . bv)) 1)) ;; big1
              (write-long (elt (_response . bv) 0) s)
              (write-long (if (>= _response 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _response s)(write-long (if (>= _response 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _response
#+(or :alpha :irix6 :x86_64)
      (setf _response (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _response (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass kuka_robot::kr_batch_mv_bypose_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_batch_mv_bypose_Args :md5sum-) "1d3f2106acf3dfd0bc50f0f47d909568")
(setf (get kuka_robot::kr_batch_mv_bypose_Args :datatype-) "kuka_robot/kr_batch_mv_bypose_Args")
(setf (get kuka_robot::kr_batch_mv_bypose_Args :request) kuka_robot::kr_batch_mv_bypose_ArgsRequest)
(setf (get kuka_robot::kr_batch_mv_bypose_Args :response) kuka_robot::kr_batch_mv_bypose_ArgsResponse)

(defmethod kuka_robot::kr_batch_mv_bypose_ArgsRequest
  (:response () (instance kuka_robot::kr_batch_mv_bypose_ArgsResponse :init)))

(setf (get kuka_robot::kr_batch_mv_bypose_ArgsRequest :md5sum-) "1d3f2106acf3dfd0bc50f0f47d909568")
(setf (get kuka_robot::kr_batch_mv_bypose_ArgsRequest :datatype-) "kuka_robot/kr_batch_mv_bypose_ArgsRequest")
(setf (get kuka_robot::kr_batch_mv_bypose_ArgsRequest :definition-)
      "
kr_pose_Type pose

float64 round

int64 block

================================================================================
MSG: kuka_robot/kr_pose_Type
# XYZ coordinate [mm]
float64 X
float64 Y
float64 Z
# ABC orientation [mm]
float64 A
float64 B
float64 C
# Status and Turn [unit]
float64 S
float64 T
---

int64 response


")

(setf (get kuka_robot::kr_batch_mv_bypose_ArgsResponse :md5sum-) "1d3f2106acf3dfd0bc50f0f47d909568")
(setf (get kuka_robot::kr_batch_mv_bypose_ArgsResponse :datatype-) "kuka_robot/kr_batch_mv_bypose_ArgsResponse")
(setf (get kuka_robot::kr_batch_mv_bypose_ArgsResponse :definition-)
      "
kr_pose_Type pose

float64 round

int64 block

================================================================================
MSG: kuka_robot/kr_pose_Type
# XYZ coordinate [mm]
float64 X
float64 Y
float64 Z
# ABC orientation [mm]
float64 A
float64 B
float64 C
# Status and Turn [unit]
float64 S
float64 T
---

int64 response


")



(provide :kuka_robot/kr_batch_mv_bypose_Args "1d3f2106acf3dfd0bc50f0f47d909568")


