; Auto-generated. Do not edit!


(cl:in-package system_io-srv)


;//! \htmlinclude sio_set_double_Args-request.msg.html

(cl:defclass <sio_set_double_Args-request> (roslisp-msg-protocol:ros-message)
  ((num
    :reader num
    :initarg :num
    :type cl:float
    :initform 0.0))
)

(cl:defclass sio_set_double_Args-request (<sio_set_double_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sio_set_double_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sio_set_double_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name system_io-srv:<sio_set_double_Args-request> is deprecated: use system_io-srv:sio_set_double_Args-request instead.")))

(cl:ensure-generic-function 'num-val :lambda-list '(m))
(cl:defmethod num-val ((m <sio_set_double_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-srv:num-val is deprecated.  Use system_io-srv:num instead.")
  (num m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sio_set_double_Args-request>) ostream)
  "Serializes a message object of type '<sio_set_double_Args-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'num))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sio_set_double_Args-request>) istream)
  "Deserializes a message object of type '<sio_set_double_Args-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'num) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sio_set_double_Args-request>)))
  "Returns string type for a service object of type '<sio_set_double_Args-request>"
  "system_io/sio_set_double_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sio_set_double_Args-request)))
  "Returns string type for a service object of type 'sio_set_double_Args-request"
  "system_io/sio_set_double_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sio_set_double_Args-request>)))
  "Returns md5sum for a message object of type '<sio_set_double_Args-request>"
  "1320d4a929ea6ef2a246c2b190a9f356")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sio_set_double_Args-request)))
  "Returns md5sum for a message object of type 'sio_set_double_Args-request"
  "1320d4a929ea6ef2a246c2b190a9f356")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sio_set_double_Args-request>)))
  "Returns full string definition for message of type '<sio_set_double_Args-request>"
  (cl:format cl:nil "~%float64 num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sio_set_double_Args-request)))
  "Returns full string definition for message of type 'sio_set_double_Args-request"
  (cl:format cl:nil "~%float64 num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sio_set_double_Args-request>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sio_set_double_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'sio_set_double_Args-request
    (cl:cons ':num (num msg))
))
;//! \htmlinclude sio_set_double_Args-response.msg.html

(cl:defclass <sio_set_double_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass sio_set_double_Args-response (<sio_set_double_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sio_set_double_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sio_set_double_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name system_io-srv:<sio_set_double_Args-response> is deprecated: use system_io-srv:sio_set_double_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <sio_set_double_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-srv:response-val is deprecated.  Use system_io-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sio_set_double_Args-response>) ostream)
  "Serializes a message object of type '<sio_set_double_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sio_set_double_Args-response>) istream)
  "Deserializes a message object of type '<sio_set_double_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sio_set_double_Args-response>)))
  "Returns string type for a service object of type '<sio_set_double_Args-response>"
  "system_io/sio_set_double_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sio_set_double_Args-response)))
  "Returns string type for a service object of type 'sio_set_double_Args-response"
  "system_io/sio_set_double_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sio_set_double_Args-response>)))
  "Returns md5sum for a message object of type '<sio_set_double_Args-response>"
  "1320d4a929ea6ef2a246c2b190a9f356")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sio_set_double_Args-response)))
  "Returns md5sum for a message object of type 'sio_set_double_Args-response"
  "1320d4a929ea6ef2a246c2b190a9f356")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sio_set_double_Args-response>)))
  "Returns full string definition for message of type '<sio_set_double_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sio_set_double_Args-response)))
  "Returns full string definition for message of type 'sio_set_double_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sio_set_double_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sio_set_double_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'sio_set_double_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'sio_set_double_Args)))
  'sio_set_double_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'sio_set_double_Args)))
  'sio_set_double_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sio_set_double_Args)))
  "Returns string type for a service object of type '<sio_set_double_Args>"
  "system_io/sio_set_double_Args")