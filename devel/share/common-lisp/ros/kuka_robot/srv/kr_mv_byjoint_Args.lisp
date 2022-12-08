; Auto-generated. Do not edit!


(cl:in-package kuka_robot-srv)


;//! \htmlinclude kr_mv_byjoint_Args-request.msg.html

(cl:defclass <kr_mv_byjoint_Args-request> (roslisp-msg-protocol:ros-message)
  ((joints
    :reader joints
    :initarg :joints
    :type kuka_robot-msg:kr_joint_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_joint_Type)))
)

(cl:defclass kr_mv_byjoint_Args-request (<kr_mv_byjoint_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_mv_byjoint_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_mv_byjoint_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_mv_byjoint_Args-request> is deprecated: use kuka_robot-srv:kr_mv_byjoint_Args-request instead.")))

(cl:ensure-generic-function 'joints-val :lambda-list '(m))
(cl:defmethod joints-val ((m <kr_mv_byjoint_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:joints-val is deprecated.  Use kuka_robot-srv:joints instead.")
  (joints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_mv_byjoint_Args-request>) ostream)
  "Serializes a message object of type '<kr_mv_byjoint_Args-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'joints) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_mv_byjoint_Args-request>) istream)
  "Deserializes a message object of type '<kr_mv_byjoint_Args-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'joints) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_mv_byjoint_Args-request>)))
  "Returns string type for a service object of type '<kr_mv_byjoint_Args-request>"
  "kuka_robot/kr_mv_byjoint_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_mv_byjoint_Args-request)))
  "Returns string type for a service object of type 'kr_mv_byjoint_Args-request"
  "kuka_robot/kr_mv_byjoint_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_mv_byjoint_Args-request>)))
  "Returns md5sum for a message object of type '<kr_mv_byjoint_Args-request>"
  "1ffacecfaa4c500ecb39aa7cf1b68d2f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_mv_byjoint_Args-request)))
  "Returns md5sum for a message object of type 'kr_mv_byjoint_Args-request"
  "1ffacecfaa4c500ecb39aa7cf1b68d2f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_mv_byjoint_Args-request>)))
  "Returns full string definition for message of type '<kr_mv_byjoint_Args-request>"
  (cl:format cl:nil "~%kr_joint_Type joints~%~%================================================================================~%MSG: kuka_robot/kr_joint_Type~%# Joint Angles [degree]~%float64 A1~%float64 A2~%float64 A3~%float64 A4~%float64 A5~%float64 A6~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_mv_byjoint_Args-request)))
  "Returns full string definition for message of type 'kr_mv_byjoint_Args-request"
  (cl:format cl:nil "~%kr_joint_Type joints~%~%================================================================================~%MSG: kuka_robot/kr_joint_Type~%# Joint Angles [degree]~%float64 A1~%float64 A2~%float64 A3~%float64 A4~%float64 A5~%float64 A6~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_mv_byjoint_Args-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'joints))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_mv_byjoint_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_mv_byjoint_Args-request
    (cl:cons ':joints (joints msg))
))
;//! \htmlinclude kr_mv_byjoint_Args-response.msg.html

(cl:defclass <kr_mv_byjoint_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass kr_mv_byjoint_Args-response (<kr_mv_byjoint_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_mv_byjoint_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_mv_byjoint_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_mv_byjoint_Args-response> is deprecated: use kuka_robot-srv:kr_mv_byjoint_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <kr_mv_byjoint_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:response-val is deprecated.  Use kuka_robot-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_mv_byjoint_Args-response>) ostream)
  "Serializes a message object of type '<kr_mv_byjoint_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_mv_byjoint_Args-response>) istream)
  "Deserializes a message object of type '<kr_mv_byjoint_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_mv_byjoint_Args-response>)))
  "Returns string type for a service object of type '<kr_mv_byjoint_Args-response>"
  "kuka_robot/kr_mv_byjoint_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_mv_byjoint_Args-response)))
  "Returns string type for a service object of type 'kr_mv_byjoint_Args-response"
  "kuka_robot/kr_mv_byjoint_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_mv_byjoint_Args-response>)))
  "Returns md5sum for a message object of type '<kr_mv_byjoint_Args-response>"
  "1ffacecfaa4c500ecb39aa7cf1b68d2f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_mv_byjoint_Args-response)))
  "Returns md5sum for a message object of type 'kr_mv_byjoint_Args-response"
  "1ffacecfaa4c500ecb39aa7cf1b68d2f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_mv_byjoint_Args-response>)))
  "Returns full string definition for message of type '<kr_mv_byjoint_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_mv_byjoint_Args-response)))
  "Returns full string definition for message of type 'kr_mv_byjoint_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_mv_byjoint_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_mv_byjoint_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_mv_byjoint_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'kr_mv_byjoint_Args)))
  'kr_mv_byjoint_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'kr_mv_byjoint_Args)))
  'kr_mv_byjoint_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_mv_byjoint_Args)))
  "Returns string type for a service object of type '<kr_mv_byjoint_Args>"
  "kuka_robot/kr_mv_byjoint_Args")