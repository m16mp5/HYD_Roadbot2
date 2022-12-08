; Auto-generated. Do not edit!


(cl:in-package roadbot_control-srv)


;//! \htmlinclude ac_go_signstand_Args-request.msg.html

(cl:defclass <ac_go_signstand_Args-request> (roslisp-msg-protocol:ros-message)
  ((position_y
    :reader position_y
    :initarg :position_y
    :type cl:float
    :initform 0.0)
   (position_x
    :reader position_x
    :initarg :position_x
    :type cl:float
    :initform 0.0)
   (lb_location
    :reader lb_location
    :initarg :lb_location
    :type cl:integer
    :initform 0))
)

(cl:defclass ac_go_signstand_Args-request (<ac_go_signstand_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ac_go_signstand_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ac_go_signstand_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roadbot_control-srv:<ac_go_signstand_Args-request> is deprecated: use roadbot_control-srv:ac_go_signstand_Args-request instead.")))

(cl:ensure-generic-function 'position_y-val :lambda-list '(m))
(cl:defmethod position_y-val ((m <ac_go_signstand_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:position_y-val is deprecated.  Use roadbot_control-srv:position_y instead.")
  (position_y m))

(cl:ensure-generic-function 'position_x-val :lambda-list '(m))
(cl:defmethod position_x-val ((m <ac_go_signstand_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:position_x-val is deprecated.  Use roadbot_control-srv:position_x instead.")
  (position_x m))

(cl:ensure-generic-function 'lb_location-val :lambda-list '(m))
(cl:defmethod lb_location-val ((m <ac_go_signstand_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:lb_location-val is deprecated.  Use roadbot_control-srv:lb_location instead.")
  (lb_location m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ac_go_signstand_Args-request>) ostream)
  "Serializes a message object of type '<ac_go_signstand_Args-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'position_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'position_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'lb_location)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ac_go_signstand_Args-request>) istream)
  "Deserializes a message object of type '<ac_go_signstand_Args-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lb_location) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ac_go_signstand_Args-request>)))
  "Returns string type for a service object of type '<ac_go_signstand_Args-request>"
  "roadbot_control/ac_go_signstand_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_go_signstand_Args-request)))
  "Returns string type for a service object of type 'ac_go_signstand_Args-request"
  "roadbot_control/ac_go_signstand_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ac_go_signstand_Args-request>)))
  "Returns md5sum for a message object of type '<ac_go_signstand_Args-request>"
  "caec67dc8933c4357cb62028f1056dfe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ac_go_signstand_Args-request)))
  "Returns md5sum for a message object of type 'ac_go_signstand_Args-request"
  "caec67dc8933c4357cb62028f1056dfe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ac_go_signstand_Args-request>)))
  "Returns full string definition for message of type '<ac_go_signstand_Args-request>"
  (cl:format cl:nil "~%float64 position_y~%float64 position_x~%~%~%int64 lb_location~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ac_go_signstand_Args-request)))
  "Returns full string definition for message of type 'ac_go_signstand_Args-request"
  (cl:format cl:nil "~%float64 position_y~%float64 position_x~%~%~%int64 lb_location~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ac_go_signstand_Args-request>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ac_go_signstand_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ac_go_signstand_Args-request
    (cl:cons ':position_y (position_y msg))
    (cl:cons ':position_x (position_x msg))
    (cl:cons ':lb_location (lb_location msg))
))
;//! \htmlinclude ac_go_signstand_Args-response.msg.html

(cl:defclass <ac_go_signstand_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass ac_go_signstand_Args-response (<ac_go_signstand_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ac_go_signstand_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ac_go_signstand_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roadbot_control-srv:<ac_go_signstand_Args-response> is deprecated: use roadbot_control-srv:ac_go_signstand_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <ac_go_signstand_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:response-val is deprecated.  Use roadbot_control-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ac_go_signstand_Args-response>) ostream)
  "Serializes a message object of type '<ac_go_signstand_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ac_go_signstand_Args-response>) istream)
  "Deserializes a message object of type '<ac_go_signstand_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ac_go_signstand_Args-response>)))
  "Returns string type for a service object of type '<ac_go_signstand_Args-response>"
  "roadbot_control/ac_go_signstand_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_go_signstand_Args-response)))
  "Returns string type for a service object of type 'ac_go_signstand_Args-response"
  "roadbot_control/ac_go_signstand_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ac_go_signstand_Args-response>)))
  "Returns md5sum for a message object of type '<ac_go_signstand_Args-response>"
  "caec67dc8933c4357cb62028f1056dfe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ac_go_signstand_Args-response)))
  "Returns md5sum for a message object of type 'ac_go_signstand_Args-response"
  "caec67dc8933c4357cb62028f1056dfe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ac_go_signstand_Args-response>)))
  "Returns full string definition for message of type '<ac_go_signstand_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ac_go_signstand_Args-response)))
  "Returns full string definition for message of type 'ac_go_signstand_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ac_go_signstand_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ac_go_signstand_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ac_go_signstand_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ac_go_signstand_Args)))
  'ac_go_signstand_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ac_go_signstand_Args)))
  'ac_go_signstand_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_go_signstand_Args)))
  "Returns string type for a service object of type '<ac_go_signstand_Args>"
  "roadbot_control/ac_go_signstand_Args")