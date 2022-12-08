; Auto-generated. Do not edit!


(cl:in-package kuka_robot-msg)


;//! \htmlinclude kr_payload_Type.msg.html

(cl:defclass <kr_payload_Type> (roslisp-msg-protocol:ros-message)
  ((mass
    :reader mass
    :initarg :mass
    :type cl:float
    :initform 0.0)
   (CenterOfGravity
    :reader CenterOfGravity
    :initarg :CenterOfGravity
    :type kuka_robot-msg:kr_pose_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_pose_Type))
   (Inertia
    :reader Inertia
    :initarg :Inertia
    :type kuka_robot-msg:kr_pose_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_pose_Type)))
)

(cl:defclass kr_payload_Type (<kr_payload_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_payload_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_payload_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-msg:<kr_payload_Type> is deprecated: use kuka_robot-msg:kr_payload_Type instead.")))

(cl:ensure-generic-function 'mass-val :lambda-list '(m))
(cl:defmethod mass-val ((m <kr_payload_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:mass-val is deprecated.  Use kuka_robot-msg:mass instead.")
  (mass m))

(cl:ensure-generic-function 'CenterOfGravity-val :lambda-list '(m))
(cl:defmethod CenterOfGravity-val ((m <kr_payload_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:CenterOfGravity-val is deprecated.  Use kuka_robot-msg:CenterOfGravity instead.")
  (CenterOfGravity m))

(cl:ensure-generic-function 'Inertia-val :lambda-list '(m))
(cl:defmethod Inertia-val ((m <kr_payload_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:Inertia-val is deprecated.  Use kuka_robot-msg:Inertia instead.")
  (Inertia m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_payload_Type>) ostream)
  "Serializes a message object of type '<kr_payload_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'mass))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'CenterOfGravity) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Inertia) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_payload_Type>) istream)
  "Deserializes a message object of type '<kr_payload_Type>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'mass) (roslisp-utils:decode-double-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'CenterOfGravity) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Inertia) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_payload_Type>)))
  "Returns string type for a message object of type '<kr_payload_Type>"
  "kuka_robot/kr_payload_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_payload_Type)))
  "Returns string type for a message object of type 'kr_payload_Type"
  "kuka_robot/kr_payload_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_payload_Type>)))
  "Returns md5sum for a message object of type '<kr_payload_Type>"
  "acc9595ae3c243c8e07bdd4ea0d971e4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_payload_Type)))
  "Returns md5sum for a message object of type 'kr_payload_Type"
  "acc9595ae3c243c8e07bdd4ea0d971e4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_payload_Type>)))
  "Returns full string definition for message of type '<kr_payload_Type>"
  (cl:format cl:nil "# Mass [kg]~%float64 mass~%~%# Center of mass [mm]~%kuka_robot/kr_pose_Type CenterOfGravity~%~%# Inertia [kg-m^2]~%kuka_robot/kr_pose_Type Inertia~%~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_payload_Type)))
  "Returns full string definition for message of type 'kr_payload_Type"
  (cl:format cl:nil "# Mass [kg]~%float64 mass~%~%# Center of mass [mm]~%kuka_robot/kr_pose_Type CenterOfGravity~%~%# Inertia [kg-m^2]~%kuka_robot/kr_pose_Type Inertia~%~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_payload_Type>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'CenterOfGravity))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Inertia))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_payload_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_payload_Type
    (cl:cons ':mass (mass msg))
    (cl:cons ':CenterOfGravity (CenterOfGravity msg))
    (cl:cons ':Inertia (Inertia msg))
))
