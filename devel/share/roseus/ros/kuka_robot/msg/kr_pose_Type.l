;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_pose_Type)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_pose_Type (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_POSE_TYPE")
  (make-package "KUKA_ROBOT::KR_POSE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude kr_pose_Type.msg.html


(defclass kuka_robot::kr_pose_Type
  :super ros::object
  :slots (_X _Y _Z _A _B _C _S _T ))

(defmethod kuka_robot::kr_pose_Type
  (:init
   (&key
    ((:X __X) 0.0)
    ((:Y __Y) 0.0)
    ((:Z __Z) 0.0)
    ((:A __A) 0.0)
    ((:B __B) 0.0)
    ((:C __C) 0.0)
    ((:S __S) 0.0)
    ((:T __T) 0.0)
    )
   (send-super :init)
   (setq _X (float __X))
   (setq _Y (float __Y))
   (setq _Z (float __Z))
   (setq _A (float __A))
   (setq _B (float __B))
   (setq _C (float __C))
   (setq _S (float __S))
   (setq _T (float __T))
   self)
  (:X
   (&optional __X)
   (if __X (setq _X __X)) _X)
  (:Y
   (&optional __Y)
   (if __Y (setq _Y __Y)) _Y)
  (:Z
   (&optional __Z)
   (if __Z (setq _Z __Z)) _Z)
  (:A
   (&optional __A)
   (if __A (setq _A __A)) _A)
  (:B
   (&optional __B)
   (if __B (setq _B __B)) _B)
  (:C
   (&optional __C)
   (if __C (setq _C __C)) _C)
  (:S
   (&optional __S)
   (if __S (setq _S __S)) _S)
  (:T
   (&optional __T)
   (if __T (setq _T __T)) _T)
  (:serialization-length
   ()
   (+
    ;; float64 _X
    8
    ;; float64 _Y
    8
    ;; float64 _Z
    8
    ;; float64 _A
    8
    ;; float64 _B
    8
    ;; float64 _C
    8
    ;; float64 _S
    8
    ;; float64 _T
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _X
       (sys::poke _X (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Y
       (sys::poke _Y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _Z
       (sys::poke _Z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _A
       (sys::poke _A (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _B
       (sys::poke _B (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _C
       (sys::poke _C (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _S
       (sys::poke _S (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _T
       (sys::poke _T (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _X
     (setq _X (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Y
     (setq _Y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _Z
     (setq _Z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _A
     (setq _A (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _B
     (setq _B (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _C
     (setq _C (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _S
     (setq _S (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _T
     (setq _T (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get kuka_robot::kr_pose_Type :md5sum-) "68763b86dc393f24490d032ede03c3ee")
(setf (get kuka_robot::kr_pose_Type :datatype-) "kuka_robot/kr_pose_Type")
(setf (get kuka_robot::kr_pose_Type :definition-)
      "# XYZ coordinate [mm]
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

")



(provide :kuka_robot/kr_pose_Type "68763b86dc393f24490d032ede03c3ee")


