; Auto-generated. Do not edit!


(cl:in-package vision_system-srv)


;//! \htmlinclude vs_check_position_has_cone_Args-request.msg.html

(cl:defclass <vs_check_position_has_cone_Args-request> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:float
    :initform 0.0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0))
)

(cl:defclass vs_check_position_has_cone_Args-request (<vs_check_position_has_cone_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <vs_check_position_has_cone_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'vs_check_position_has_cone_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vision_system-srv:<vs_check_position_has_cone_Args-request> is deprecated: use vision_system-srv:vs_check_position_has_cone_Args-request instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <vs_check_position_has_cone_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:timestamp-val is deprecated.  Use vision_system-srv:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <vs_check_position_has_cone_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:x-val is deprecated.  Use vision_system-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <vs_check_position_has_cone_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:y-val is deprecated.  Use vision_system-srv:y instead.")
  (y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <vs_check_position_has_cone_Args-request>) ostream)
  "Serializes a message object of type '<vs_check_position_has_cone_Args-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <vs_check_position_has_cone_Args-request>) istream)
  "Deserializes a message object of type '<vs_check_position_has_cone_Args-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'timestamp) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<vs_check_position_has_cone_Args-request>)))
  "Returns string type for a service object of type '<vs_check_position_has_cone_Args-request>"
  "vision_system/vs_check_position_has_cone_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vs_check_position_has_cone_Args-request)))
  "Returns string type for a service object of type 'vs_check_position_has_cone_Args-request"
  "vision_system/vs_check_position_has_cone_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<vs_check_position_has_cone_Args-request>)))
  "Returns md5sum for a message object of type '<vs_check_position_has_cone_Args-request>"
  "abbd5f4e52593080e85548c693299665")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'vs_check_position_has_cone_Args-request)))
  "Returns md5sum for a message object of type 'vs_check_position_has_cone_Args-request"
  "abbd5f4e52593080e85548c693299665")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<vs_check_position_has_cone_Args-request>)))
  "Returns full string definition for message of type '<vs_check_position_has_cone_Args-request>"
  (cl:format cl:nil "~%float64 timestamp~%~%~%float64 x~%float64 y~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'vs_check_position_has_cone_Args-request)))
  "Returns full string definition for message of type 'vs_check_position_has_cone_Args-request"
  (cl:format cl:nil "~%float64 timestamp~%~%~%float64 x~%float64 y~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <vs_check_position_has_cone_Args-request>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <vs_check_position_has_cone_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'vs_check_position_has_cone_Args-request
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
))
;//! \htmlinclude vs_check_position_has_cone_Args-response.msg.html

(cl:defclass <vs_check_position_has_cone_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0)
   (result_code
    :reader result_code
    :initarg :result_code
    :type cl:integer
    :initform 0))
)

(cl:defclass vs_check_position_has_cone_Args-response (<vs_check_position_has_cone_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <vs_check_position_has_cone_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'vs_check_position_has_cone_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vision_system-srv:<vs_check_position_has_cone_Args-response> is deprecated: use vision_system-srv:vs_check_position_has_cone_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <vs_check_position_has_cone_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:response-val is deprecated.  Use vision_system-srv:response instead.")
  (response m))

(cl:ensure-generic-function 'result_code-val :lambda-list '(m))
(cl:defmethod result_code-val ((m <vs_check_position_has_cone_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:result_code-val is deprecated.  Use vision_system-srv:result_code instead.")
  (result_code m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <vs_check_position_has_cone_Args-response>) ostream)
  "Serializes a message object of type '<vs_check_position_has_cone_Args-response>"
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
  (cl:let* ((signed (cl:slot-value msg 'result_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <vs_check_position_has_cone_Args-response>) istream)
  "Deserializes a message object of type '<vs_check_position_has_cone_Args-response>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result_code) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<vs_check_position_has_cone_Args-response>)))
  "Returns string type for a service object of type '<vs_check_position_has_cone_Args-response>"
  "vision_system/vs_check_position_has_cone_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vs_check_position_has_cone_Args-response)))
  "Returns string type for a service object of type 'vs_check_position_has_cone_Args-response"
  "vision_system/vs_check_position_has_cone_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<vs_check_position_has_cone_Args-response>)))
  "Returns md5sum for a message object of type '<vs_check_position_has_cone_Args-response>"
  "abbd5f4e52593080e85548c693299665")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'vs_check_position_has_cone_Args-response)))
  "Returns md5sum for a message object of type 'vs_check_position_has_cone_Args-response"
  "abbd5f4e52593080e85548c693299665")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<vs_check_position_has_cone_Args-response>)))
  "Returns full string definition for message of type '<vs_check_position_has_cone_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%int64 result_code~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'vs_check_position_has_cone_Args-response)))
  "Returns full string definition for message of type 'vs_check_position_has_cone_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%int64 result_code~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <vs_check_position_has_cone_Args-response>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <vs_check_position_has_cone_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'vs_check_position_has_cone_Args-response
    (cl:cons ':response (response msg))
    (cl:cons ':result_code (result_code msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'vs_check_position_has_cone_Args)))
  'vs_check_position_has_cone_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'vs_check_position_has_cone_Args)))
  'vs_check_position_has_cone_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vs_check_position_has_cone_Args)))
  "Returns string type for a service object of type '<vs_check_position_has_cone_Args>"
  "vision_system/vs_check_position_has_cone_Args")