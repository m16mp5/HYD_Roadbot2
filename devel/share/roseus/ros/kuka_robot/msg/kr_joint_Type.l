;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_joint_Type)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_joint_Type (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_JOINT_TYPE")
  (make-package "KUKA_ROBOT::KR_JOINT_TYPE"))

(in-package "ROS")
;;//! \htmlinclude kr_joint_Type.msg.html


(defclass kuka_robot::kr_joint_Type
  :super ros::object
  :slots (_A1 _A2 _A3 _A4 _A5 _A6 ))

(defmethod kuka_robot::kr_joint_Type
  (:init
   (&key
    ((:A1 __A1) 0.0)
    ((:A2 __A2) 0.0)
    ((:A3 __A3) 0.0)
    ((:A4 __A4) 0.0)
    ((:A5 __A5) 0.0)
    ((:A6 __A6) 0.0)
    )
   (send-super :init)
   (setq _A1 (float __A1))
   (setq _A2 (float __A2))
   (setq _A3 (float __A3))
   (setq _A4 (float __A4))
   (setq _A5 (float __A5))
   (setq _A6 (float __A6))
   self)
  (:A1
   (&optional __A1)
   (if __A1 (setq _A1 __A1)) _A1)
  (:A2
   (&optional __A2)
   (if __A2 (setq _A2 __A2)) _A2)
  (:A3
   (&optional __A3)
   (if __A3 (setq _A3 __A3)) _A3)
  (:A4
   (&optional __A4)
   (if __A4 (setq _A4 __A4)) _A4)
  (:A5
   (&optional __A5)
   (if __A5 (setq _A5 __A5)) _A5)
  (:A6
   (&optional __A6)
   (if __A6 (setq _A6 __A6)) _A6)
  (:serialization-length
   ()
   (+
    ;; float64 _A1
    8
    ;; float64 _A2
    8
    ;; float64 _A3
    8
    ;; float64 _A4
    8
    ;; float64 _A5
    8
    ;; float64 _A6
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _A1
       (sys::poke _A1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _A2
       (sys::poke _A2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _A3
       (sys::poke _A3 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _A4
       (sys::poke _A4 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _A5
       (sys::poke _A5 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _A6
       (sys::poke _A6 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _A1
     (setq _A1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _A2
     (setq _A2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _A3
     (setq _A3 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _A4
     (setq _A4 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _A5
     (setq _A5 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _A6
     (setq _A6 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get kuka_robot::kr_joint_Type :md5sum-) "75a5288a21ef4ba3c22a3ba34b5bc48c")
(setf (get kuka_robot::kr_joint_Type :datatype-) "kuka_robot/kr_joint_Type")
(setf (get kuka_robot::kr_joint_Type :definition-)
      "# Joint Angles [degree]
float64 A1
float64 A2
float64 A3
float64 A4
float64 A5
float64 A6


")



(provide :kuka_robot/kr_joint_Type "75a5288a21ef4ba3c22a3ba34b5bc48c")


