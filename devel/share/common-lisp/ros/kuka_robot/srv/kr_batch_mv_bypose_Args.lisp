; Auto-generated. Do not edit!


(cl:in-package kuka_robot-srv)


;//! \htmlinclude kr_batch_mv_bypose_Args-request.msg.html

(cl:defclass <kr_batch_mv_bypose_Args-request> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type kuka_robot-msg:kr_pose_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_pose_Type))
   (round
    :reader round
    :initarg :round
    :type cl:float
    :initform 0.0)
   (block
    :reader block
    :initarg :block
    :type cl:integer
    :initform 0))
)

(cl:defclass kr_batch_mv_bypose_Args-request (<kr_batch_mv_bypose_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_batch_mv_bypose_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_batch_mv_bypose_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_batch_mv_bypose_Args-request> is deprecated: use kuka_robot-srv:kr_batch_mv_bypose_Args-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <kr_batch_mv_bypose_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:pose-val is deprecated.  Use kuka_robot-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'round-val :lambda-list '(m))
(cl:defmethod round-val ((m <kr_batch_mv_bypose_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:round-val is deprecated.  Use kuka_robot-srv:round instead.")
  (round m))

(cl:ensure-generic-function 'block-val :lambda-list '(m))
(cl:defmethod block-val ((m <kr_batch_mv_bypose_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:block-val is deprecated.  Use kuka_robot-srv:block instead.")
  (block m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_batch_mv_bypose_Args-request>) ostream)
  "Serializes a message object of type '<kr_batch_mv_bypose_Args-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'round))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'block)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_batch_mv_bypose_Args-request>) istream)
  "Deserializes a message object of type '<kr_batch_mv_bypose_Args-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'round) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'block) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_batch_mv_bypose_Args-request>)))
  "Returns string type for a service object of type '<kr_batch_mv_bypose_Args-request>"
  "kuka_robot/kr_batch_mv_bypose_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_batch_mv_bypose_Args-request)))
  "Returns string type for a service object of type 'kr_batch_mv_bypose_Args-request"
  "kuka_robot/kr_batch_mv_bypose_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_batch_mv_bypose_Args-request>)))
  "Returns md5sum for a message object of type '<kr_batch_mv_bypose_Args-request>"
  "1d3f2106acf3dfd0bc50f0f47d909568")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_batch_mv_bypose_Args-request)))
  "Returns md5sum for a message object of type 'kr_batch_mv_bypose_Args-request"
  "1d3f2106acf3dfd0bc50f0f47d909568")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_batch_mv_bypose_Args-request>)))
  "Returns full string definition for message of type '<kr_batch_mv_bypose_Args-request>"
  (cl:format cl:nil "~%kr_pose_Type pose~%~%float64 round~%~%int64 block~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_batch_mv_bypose_Args-request)))
  "Returns full string definition for message of type 'kr_batch_mv_bypose_Args-request"
  (cl:format cl:nil "~%kr_pose_Type pose~%~%float64 round~%~%int64 block~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_batch_mv_bypose_Args-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_batch_mv_bypose_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_batch_mv_bypose_Args-request
    (cl:cons ':pose (pose msg))
    (cl:cons ':round (round msg))
    (cl:cons ':block (block msg))
))
;//! \htmlinclude kr_batch_mv_bypose_Args-response.msg.html

(cl:defclass <kr_batch_mv_bypose_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass kr_batch_mv_bypose_Args-response (<kr_batch_mv_bypose_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_batch_mv_bypose_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_batch_mv_bypose_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_batch_mv_bypose_Args-response> is deprecated: use kuka_robot-srv:kr_batch_mv_bypose_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <kr_batch_mv_bypose_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:response-val is deprecated.  Use kuka_robot-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_batch_mv_bypose_Args-response>) ostream)
  "Serializes a message object of type '<kr_batch_mv_bypose_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_batch_mv_bypose_Args-response>) istream)
  "Deserializes a message object of type '<kr_batch_mv_bypose_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_batch_mv_bypose_Args-response>)))
  "Returns string type for a service object of type '<kr_batch_mv_bypose_Args-response>"
  "kuka_robot/kr_batch_mv_bypose_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_batch_mv_bypose_Args-response)))
  "Returns string type for a service object of type 'kr_batch_mv_bypose_Args-response"
  "kuka_robot/kr_batch_mv_bypose_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_batch_mv_bypose_Args-response>)))
  "Returns md5sum for a message object of type '<kr_batch_mv_bypose_Args-response>"
  "1d3f2106acf3dfd0bc50f0f47d909568")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_batch_mv_bypose_Args-response)))
  "Returns md5sum for a message object of type 'kr_batch_mv_bypose_Args-response"
  "1d3f2106acf3dfd0bc50f0f47d909568")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_batch_mv_bypose_Args-response>)))
  "Returns full string definition for message of type '<kr_batch_mv_bypose_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_batch_mv_bypose_Args-response)))
  "Returns full string definition for message of type 'kr_batch_mv_bypose_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_batch_mv_bypose_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_batch_mv_bypose_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_batch_mv_bypose_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'kr_batch_mv_bypose_Args)))
  'kr_batch_mv_bypose_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'kr_batch_mv_bypose_Args)))
  'kr_batch_mv_bypose_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_batch_mv_bypose_Args)))
  "Returns string type for a service object of type '<kr_batch_mv_bypose_Args>"
  "kuka_robot/kr_batch_mv_bypose_Args")