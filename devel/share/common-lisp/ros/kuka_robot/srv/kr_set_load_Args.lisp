; Auto-generated. Do not edit!


(cl:in-package kuka_robot-srv)


;//! \htmlinclude kr_set_load_Args-request.msg.html

(cl:defclass <kr_set_load_Args-request> (roslisp-msg-protocol:ros-message)
  ((load
    :reader load
    :initarg :load
    :type kuka_robot-msg:kr_payload_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_payload_Type))
   (load_a1
    :reader load_a1
    :initarg :load_a1
    :type kuka_robot-msg:kr_payload_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_payload_Type))
   (load_a2
    :reader load_a2
    :initarg :load_a2
    :type kuka_robot-msg:kr_payload_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_payload_Type))
   (load_a3
    :reader load_a3
    :initarg :load_a3
    :type kuka_robot-msg:kr_payload_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_payload_Type)))
)

(cl:defclass kr_set_load_Args-request (<kr_set_load_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_set_load_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_set_load_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_set_load_Args-request> is deprecated: use kuka_robot-srv:kr_set_load_Args-request instead.")))

(cl:ensure-generic-function 'load-val :lambda-list '(m))
(cl:defmethod load-val ((m <kr_set_load_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:load-val is deprecated.  Use kuka_robot-srv:load instead.")
  (load m))

(cl:ensure-generic-function 'load_a1-val :lambda-list '(m))
(cl:defmethod load_a1-val ((m <kr_set_load_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:load_a1-val is deprecated.  Use kuka_robot-srv:load_a1 instead.")
  (load_a1 m))

(cl:ensure-generic-function 'load_a2-val :lambda-list '(m))
(cl:defmethod load_a2-val ((m <kr_set_load_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:load_a2-val is deprecated.  Use kuka_robot-srv:load_a2 instead.")
  (load_a2 m))

(cl:ensure-generic-function 'load_a3-val :lambda-list '(m))
(cl:defmethod load_a3-val ((m <kr_set_load_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:load_a3-val is deprecated.  Use kuka_robot-srv:load_a3 instead.")
  (load_a3 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_set_load_Args-request>) ostream)
  "Serializes a message object of type '<kr_set_load_Args-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'load) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'load_a1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'load_a2) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'load_a3) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_set_load_Args-request>) istream)
  "Deserializes a message object of type '<kr_set_load_Args-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'load) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'load_a1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'load_a2) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'load_a3) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_set_load_Args-request>)))
  "Returns string type for a service object of type '<kr_set_load_Args-request>"
  "kuka_robot/kr_set_load_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_set_load_Args-request)))
  "Returns string type for a service object of type 'kr_set_load_Args-request"
  "kuka_robot/kr_set_load_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_set_load_Args-request>)))
  "Returns md5sum for a message object of type '<kr_set_load_Args-request>"
  "621c48a444ec50a2e8cd24b61ee09b4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_set_load_Args-request)))
  "Returns md5sum for a message object of type 'kr_set_load_Args-request"
  "621c48a444ec50a2e8cd24b61ee09b4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_set_load_Args-request>)))
  "Returns full string definition for message of type '<kr_set_load_Args-request>"
  (cl:format cl:nil "~%kr_payload_Type load~%~%kr_payload_Type load_a1~%~%kr_payload_Type load_a2~%~%kr_payload_Type load_a3~%~%================================================================================~%MSG: kuka_robot/kr_payload_Type~%# Mass [kg]~%float64 mass~%~%# Center of mass [mm]~%kuka_robot/kr_pose_Type CenterOfGravity~%~%# Inertia [kg-m^2]~%kuka_robot/kr_pose_Type Inertia~%~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_set_load_Args-request)))
  "Returns full string definition for message of type 'kr_set_load_Args-request"
  (cl:format cl:nil "~%kr_payload_Type load~%~%kr_payload_Type load_a1~%~%kr_payload_Type load_a2~%~%kr_payload_Type load_a3~%~%================================================================================~%MSG: kuka_robot/kr_payload_Type~%# Mass [kg]~%float64 mass~%~%# Center of mass [mm]~%kuka_robot/kr_pose_Type CenterOfGravity~%~%# Inertia [kg-m^2]~%kuka_robot/kr_pose_Type Inertia~%~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_set_load_Args-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'load))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'load_a1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'load_a2))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'load_a3))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_set_load_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_set_load_Args-request
    (cl:cons ':load (load msg))
    (cl:cons ':load_a1 (load_a1 msg))
    (cl:cons ':load_a2 (load_a2 msg))
    (cl:cons ':load_a3 (load_a3 msg))
))
;//! \htmlinclude kr_set_load_Args-response.msg.html

(cl:defclass <kr_set_load_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass kr_set_load_Args-response (<kr_set_load_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_set_load_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_set_load_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_set_load_Args-response> is deprecated: use kuka_robot-srv:kr_set_load_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <kr_set_load_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:response-val is deprecated.  Use kuka_robot-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_set_load_Args-response>) ostream)
  "Serializes a message object of type '<kr_set_load_Args-response>"
  (cl:let* ((signed (cl:slot-value msg 'response)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_set_load_Args-response>) istream)
  "Deserializes a message object of type '<kr_set_load_Args-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'response) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_set_load_Args-response>)))
  "Returns string type for a service object of type '<kr_set_load_Args-response>"
  "kuka_robot/kr_set_load_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_set_load_Args-response)))
  "Returns string type for a service object of type 'kr_set_load_Args-response"
  "kuka_robot/kr_set_load_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_set_load_Args-response>)))
  "Returns md5sum for a message object of type '<kr_set_load_Args-response>"
  "621c48a444ec50a2e8cd24b61ee09b4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_set_load_Args-response)))
  "Returns md5sum for a message object of type 'kr_set_load_Args-response"
  "621c48a444ec50a2e8cd24b61ee09b4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_set_load_Args-response>)))
  "Returns full string definition for message of type '<kr_set_load_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_set_load_Args-response)))
  "Returns full string definition for message of type 'kr_set_load_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_set_load_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_set_load_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_set_load_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'kr_set_load_Args)))
  'kr_set_load_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'kr_set_load_Args)))
  'kr_set_load_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_set_load_Args)))
  "Returns string type for a service object of type '<kr_set_load_Args>"
  "kuka_robot/kr_set_load_Args")