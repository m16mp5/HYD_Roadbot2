; Auto-generated. Do not edit!


(cl:in-package kuka_robot-srv)


;//! \htmlinclude kr_batch_mv_run_Args-request.msg.html

(cl:defclass <kr_batch_mv_run_Args-request> (roslisp-msg-protocol:ros-message)
  ((start_block
    :reader start_block
    :initarg :start_block
    :type cl:integer
    :initform 0)
   (end_block
    :reader end_block
    :initarg :end_block
    :type cl:integer
    :initform 0))
)

(cl:defclass kr_batch_mv_run_Args-request (<kr_batch_mv_run_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_batch_mv_run_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_batch_mv_run_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_batch_mv_run_Args-request> is deprecated: use kuka_robot-srv:kr_batch_mv_run_Args-request instead.")))

(cl:ensure-generic-function 'start_block-val :lambda-list '(m))
(cl:defmethod start_block-val ((m <kr_batch_mv_run_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:start_block-val is deprecated.  Use kuka_robot-srv:start_block instead.")
  (start_block m))

(cl:ensure-generic-function 'end_block-val :lambda-list '(m))
(cl:defmethod end_block-val ((m <kr_batch_mv_run_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:end_block-val is deprecated.  Use kuka_robot-srv:end_block instead.")
  (end_block m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_batch_mv_run_Args-request>) ostream)
  "Serializes a message object of type '<kr_batch_mv_run_Args-request>"
  (cl:let* ((signed (cl:slot-value msg 'start_block)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'end_block)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_batch_mv_run_Args-request>) istream)
  "Deserializes a message object of type '<kr_batch_mv_run_Args-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'start_block) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'end_block) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_batch_mv_run_Args-request>)))
  "Returns string type for a service object of type '<kr_batch_mv_run_Args-request>"
  "kuka_robot/kr_batch_mv_run_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_batch_mv_run_Args-request)))
  "Returns string type for a service object of type 'kr_batch_mv_run_Args-request"
  "kuka_robot/kr_batch_mv_run_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_batch_mv_run_Args-request>)))
  "Returns md5sum for a message object of type '<kr_batch_mv_run_Args-request>"
  "abfd39835045227435d9bb38a4de4de2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_batch_mv_run_Args-request)))
  "Returns md5sum for a message object of type 'kr_batch_mv_run_Args-request"
  "abfd39835045227435d9bb38a4de4de2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_batch_mv_run_Args-request>)))
  "Returns full string definition for message of type '<kr_batch_mv_run_Args-request>"
  (cl:format cl:nil "~%int64 start_block~%~%int64 end_block~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_batch_mv_run_Args-request)))
  "Returns full string definition for message of type 'kr_batch_mv_run_Args-request"
  (cl:format cl:nil "~%int64 start_block~%~%int64 end_block~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_batch_mv_run_Args-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_batch_mv_run_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_batch_mv_run_Args-request
    (cl:cons ':start_block (start_block msg))
    (cl:cons ':end_block (end_block msg))
))
;//! \htmlinclude kr_batch_mv_run_Args-response.msg.html

(cl:defclass <kr_batch_mv_run_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass kr_batch_mv_run_Args-response (<kr_batch_mv_run_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_batch_mv_run_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_batch_mv_run_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_batch_mv_run_Args-response> is deprecated: use kuka_robot-srv:kr_batch_mv_run_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <kr_batch_mv_run_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:response-val is deprecated.  Use kuka_robot-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_batch_mv_run_Args-response>) ostream)
  "Serializes a message object of type '<kr_batch_mv_run_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_batch_mv_run_Args-response>) istream)
  "Deserializes a message object of type '<kr_batch_mv_run_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_batch_mv_run_Args-response>)))
  "Returns string type for a service object of type '<kr_batch_mv_run_Args-response>"
  "kuka_robot/kr_batch_mv_run_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_batch_mv_run_Args-response)))
  "Returns string type for a service object of type 'kr_batch_mv_run_Args-response"
  "kuka_robot/kr_batch_mv_run_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_batch_mv_run_Args-response>)))
  "Returns md5sum for a message object of type '<kr_batch_mv_run_Args-response>"
  "abfd39835045227435d9bb38a4de4de2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_batch_mv_run_Args-response)))
  "Returns md5sum for a message object of type 'kr_batch_mv_run_Args-response"
  "abfd39835045227435d9bb38a4de4de2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_batch_mv_run_Args-response>)))
  "Returns full string definition for message of type '<kr_batch_mv_run_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_batch_mv_run_Args-response)))
  "Returns full string definition for message of type 'kr_batch_mv_run_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_batch_mv_run_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_batch_mv_run_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_batch_mv_run_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'kr_batch_mv_run_Args)))
  'kr_batch_mv_run_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'kr_batch_mv_run_Args)))
  'kr_batch_mv_run_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_batch_mv_run_Args)))
  "Returns string type for a service object of type '<kr_batch_mv_run_Args>"
  "kuka_robot/kr_batch_mv_run_Args")