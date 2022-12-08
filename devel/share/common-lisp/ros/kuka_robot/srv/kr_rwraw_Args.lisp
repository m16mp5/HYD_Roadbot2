; Auto-generated. Do not edit!


(cl:in-package kuka_robot-srv)


;//! \htmlinclude kr_rwraw_Args-request.msg.html

(cl:defclass <kr_rwraw_Args-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (value
    :reader value
    :initarg :value
    :type cl:string
    :initform ""))
)

(cl:defclass kr_rwraw_Args-request (<kr_rwraw_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_rwraw_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_rwraw_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_rwraw_Args-request> is deprecated: use kuka_robot-srv:kr_rwraw_Args-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <kr_rwraw_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:name-val is deprecated.  Use kuka_robot-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <kr_rwraw_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:value-val is deprecated.  Use kuka_robot-srv:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_rwraw_Args-request>) ostream)
  "Serializes a message object of type '<kr_rwraw_Args-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_rwraw_Args-request>) istream)
  "Deserializes a message object of type '<kr_rwraw_Args-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_rwraw_Args-request>)))
  "Returns string type for a service object of type '<kr_rwraw_Args-request>"
  "kuka_robot/kr_rwraw_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_rwraw_Args-request)))
  "Returns string type for a service object of type 'kr_rwraw_Args-request"
  "kuka_robot/kr_rwraw_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_rwraw_Args-request>)))
  "Returns md5sum for a message object of type '<kr_rwraw_Args-request>"
  "11c5a51efafea631b2d1acda167e91ef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_rwraw_Args-request)))
  "Returns md5sum for a message object of type 'kr_rwraw_Args-request"
  "11c5a51efafea631b2d1acda167e91ef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_rwraw_Args-request>)))
  "Returns full string definition for message of type '<kr_rwraw_Args-request>"
  (cl:format cl:nil "~%string name~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_rwraw_Args-request)))
  "Returns full string definition for message of type 'kr_rwraw_Args-request"
  (cl:format cl:nil "~%string name~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_rwraw_Args-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'value))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_rwraw_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_rwraw_Args-request
    (cl:cons ':name (name msg))
    (cl:cons ':value (value msg))
))
;//! \htmlinclude kr_rwraw_Args-response.msg.html

(cl:defclass <kr_rwraw_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0)
   (serialvalue
    :reader serialvalue
    :initarg :serialvalue
    :type cl:string
    :initform ""))
)

(cl:defclass kr_rwraw_Args-response (<kr_rwraw_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_rwraw_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_rwraw_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-srv:<kr_rwraw_Args-response> is deprecated: use kuka_robot-srv:kr_rwraw_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <kr_rwraw_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:response-val is deprecated.  Use kuka_robot-srv:response instead.")
  (response m))

(cl:ensure-generic-function 'serialvalue-val :lambda-list '(m))
(cl:defmethod serialvalue-val ((m <kr_rwraw_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-srv:serialvalue-val is deprecated.  Use kuka_robot-srv:serialvalue instead.")
  (serialvalue m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_rwraw_Args-response>) ostream)
  "Serializes a message object of type '<kr_rwraw_Args-response>"
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
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'serialvalue))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'serialvalue))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_rwraw_Args-response>) istream)
  "Deserializes a message object of type '<kr_rwraw_Args-response>"
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
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'serialvalue) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'serialvalue) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_rwraw_Args-response>)))
  "Returns string type for a service object of type '<kr_rwraw_Args-response>"
  "kuka_robot/kr_rwraw_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_rwraw_Args-response)))
  "Returns string type for a service object of type 'kr_rwraw_Args-response"
  "kuka_robot/kr_rwraw_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_rwraw_Args-response>)))
  "Returns md5sum for a message object of type '<kr_rwraw_Args-response>"
  "11c5a51efafea631b2d1acda167e91ef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_rwraw_Args-response)))
  "Returns md5sum for a message object of type 'kr_rwraw_Args-response"
  "11c5a51efafea631b2d1acda167e91ef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_rwraw_Args-response>)))
  "Returns full string definition for message of type '<kr_rwraw_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%string serialvalue~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_rwraw_Args-response)))
  "Returns full string definition for message of type 'kr_rwraw_Args-response"
  (cl:format cl:nil "~%int64 response~%~%string serialvalue~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_rwraw_Args-response>))
  (cl:+ 0
     8
     4 (cl:length (cl:slot-value msg 'serialvalue))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_rwraw_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_rwraw_Args-response
    (cl:cons ':response (response msg))
    (cl:cons ':serialvalue (serialvalue msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'kr_rwraw_Args)))
  'kr_rwraw_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'kr_rwraw_Args)))
  'kr_rwraw_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_rwraw_Args)))
  "Returns string type for a service object of type '<kr_rwraw_Args>"
  "kuka_robot/kr_rwraw_Args")