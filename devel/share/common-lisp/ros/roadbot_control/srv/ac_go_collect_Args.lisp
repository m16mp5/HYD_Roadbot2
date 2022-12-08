; Auto-generated. Do not edit!


(cl:in-package roadbot_control-srv)


;//! \htmlinclude ac_go_collect_Args-request.msg.html

(cl:defclass <ac_go_collect_Args-request> (roslisp-msg-protocol:ros-message)
  ((number_of_cones
    :reader number_of_cones
    :initarg :number_of_cones
    :type cl:integer
    :initform 0)
   (mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0))
)

(cl:defclass ac_go_collect_Args-request (<ac_go_collect_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ac_go_collect_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ac_go_collect_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roadbot_control-srv:<ac_go_collect_Args-request> is deprecated: use roadbot_control-srv:ac_go_collect_Args-request instead.")))

(cl:ensure-generic-function 'number_of_cones-val :lambda-list '(m))
(cl:defmethod number_of_cones-val ((m <ac_go_collect_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:number_of_cones-val is deprecated.  Use roadbot_control-srv:number_of_cones instead.")
  (number_of_cones m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <ac_go_collect_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:mode-val is deprecated.  Use roadbot_control-srv:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ac_go_collect_Args-request>) ostream)
  "Serializes a message object of type '<ac_go_collect_Args-request>"
  (cl:let* ((signed (cl:slot-value msg 'number_of_cones)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ac_go_collect_Args-request>) istream)
  "Deserializes a message object of type '<ac_go_collect_Args-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'number_of_cones) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ac_go_collect_Args-request>)))
  "Returns string type for a service object of type '<ac_go_collect_Args-request>"
  "roadbot_control/ac_go_collect_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_go_collect_Args-request)))
  "Returns string type for a service object of type 'ac_go_collect_Args-request"
  "roadbot_control/ac_go_collect_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ac_go_collect_Args-request>)))
  "Returns md5sum for a message object of type '<ac_go_collect_Args-request>"
  "21a374c41adc123047cf3f40397fcf04")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ac_go_collect_Args-request)))
  "Returns md5sum for a message object of type 'ac_go_collect_Args-request"
  "21a374c41adc123047cf3f40397fcf04")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ac_go_collect_Args-request>)))
  "Returns full string definition for message of type '<ac_go_collect_Args-request>"
  (cl:format cl:nil "~%int64 number_of_cones~%int64 mode~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ac_go_collect_Args-request)))
  "Returns full string definition for message of type 'ac_go_collect_Args-request"
  (cl:format cl:nil "~%int64 number_of_cones~%int64 mode~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ac_go_collect_Args-request>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ac_go_collect_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ac_go_collect_Args-request
    (cl:cons ':number_of_cones (number_of_cones msg))
    (cl:cons ':mode (mode msg))
))
;//! \htmlinclude ac_go_collect_Args-response.msg.html

(cl:defclass <ac_go_collect_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass ac_go_collect_Args-response (<ac_go_collect_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ac_go_collect_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ac_go_collect_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roadbot_control-srv:<ac_go_collect_Args-response> is deprecated: use roadbot_control-srv:ac_go_collect_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <ac_go_collect_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-srv:response-val is deprecated.  Use roadbot_control-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ac_go_collect_Args-response>) ostream)
  "Serializes a message object of type '<ac_go_collect_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ac_go_collect_Args-response>) istream)
  "Deserializes a message object of type '<ac_go_collect_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ac_go_collect_Args-response>)))
  "Returns string type for a service object of type '<ac_go_collect_Args-response>"
  "roadbot_control/ac_go_collect_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_go_collect_Args-response)))
  "Returns string type for a service object of type 'ac_go_collect_Args-response"
  "roadbot_control/ac_go_collect_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ac_go_collect_Args-response>)))
  "Returns md5sum for a message object of type '<ac_go_collect_Args-response>"
  "21a374c41adc123047cf3f40397fcf04")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ac_go_collect_Args-response)))
  "Returns md5sum for a message object of type 'ac_go_collect_Args-response"
  "21a374c41adc123047cf3f40397fcf04")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ac_go_collect_Args-response>)))
  "Returns full string definition for message of type '<ac_go_collect_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ac_go_collect_Args-response)))
  "Returns full string definition for message of type 'ac_go_collect_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ac_go_collect_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ac_go_collect_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ac_go_collect_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ac_go_collect_Args)))
  'ac_go_collect_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ac_go_collect_Args)))
  'ac_go_collect_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_go_collect_Args)))
  "Returns string type for a service object of type '<ac_go_collect_Args>"
  "roadbot_control/ac_go_collect_Args")