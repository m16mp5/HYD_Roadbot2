;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_payload_Type)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_payload_Type (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_PAYLOAD_TYPE")
  (make-package "KUKA_ROBOT::KR_PAYLOAD_TYPE"))

(in-package "ROS")
;;//! \htmlinclude kr_payload_Type.msg.html


(defclass kuka_robot::kr_payload_Type
  :super ros::object
  :slots (_mass _CenterOfGravity _Inertia ))

(defmethod kuka_robot::kr_payload_Type
  (:init
   (&key
    ((:mass __mass) 0.0)
    ((:CenterOfGravity __CenterOfGravity) (instance kuka_robot::kr_pose_Type :init))
    ((:Inertia __Inertia) (instance kuka_robot::kr_pose_Type :init))
    )
   (send-super :init)
   (setq _mass (float __mass))
   (setq _CenterOfGravity __CenterOfGravity)
   (setq _Inertia __Inertia)
   self)
  (:mass
   (&optional __mass)
   (if __mass (setq _mass __mass)) _mass)
  (:CenterOfGravity
   (&rest __CenterOfGravity)
   (if (keywordp (car __CenterOfGravity))
       (send* _CenterOfGravity __CenterOfGravity)
     (progn
       (if __CenterOfGravity (setq _CenterOfGravity (car __CenterOfGravity)))
       _CenterOfGravity)))
  (:Inertia
   (&rest __Inertia)
   (if (keywordp (car __Inertia))
       (send* _Inertia __Inertia)
     (progn
       (if __Inertia (setq _Inertia (car __Inertia)))
       _Inertia)))
  (:serialization-length
   ()
   (+
    ;; float64 _mass
    8
    ;; kuka_robot/kr_pose_Type _CenterOfGravity
    (send _CenterOfGravity :serialization-length)
    ;; kuka_robot/kr_pose_Type _Inertia
    (send _Inertia :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _mass
       (sys::poke _mass (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; kuka_robot/kr_pose_Type _CenterOfGravity
       (send _CenterOfGravity :serialize s)
     ;; kuka_robot/kr_pose_Type _Inertia
       (send _Inertia :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _mass
     (setq _mass (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; kuka_robot/kr_pose_Type _CenterOfGravity
     (send _CenterOfGravity :deserialize buf ptr-) (incf ptr- (send _CenterOfGravity :serialization-length))
   ;; kuka_robot/kr_pose_Type _Inertia
     (send _Inertia :deserialize buf ptr-) (incf ptr- (send _Inertia :serialization-length))
   ;;
   self)
  )

(setf (get kuka_robot::kr_payload_Type :md5sum-) "acc9595ae3c243c8e07bdd4ea0d971e4")
(setf (get kuka_robot::kr_payload_Type :datatype-) "kuka_robot/kr_payload_Type")
(setf (get kuka_robot::kr_payload_Type :definition-)
      "# Mass [kg]
float64 mass

# Center of mass [mm]
kuka_robot/kr_pose_Type CenterOfGravity

# Inertia [kg-m^2]
kuka_robot/kr_pose_Type Inertia


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

")



(provide :kuka_robot/kr_payload_Type "acc9595ae3c243c8e07bdd4ea0d971e4")


