; Auto-generated. Do not edit!


(cl:in-package power_system-srv)


;//! \htmlinclude ps_set_bool_Args-request.msg.html

(cl:defclass <ps_set_bool_Args-request> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ps_set_bool_Args-request (<ps_set_bool_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ps_set_bool_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ps_set_bool_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name power_system-srv:<ps_set_bool_Args-request> is deprecated: use power_system-srv:ps_set_bool_Args-request instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <ps_set_bool_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader power_system-srv:state-val is deprecated.  Use power_system-srv:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ps_set_bool_Args-request>) ostream)
  "Serializes a message object of type '<ps_set_bool_Args-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ps_set_bool_Args-request>) istream)
  "Deserializes a message object of type '<ps_set_bool_Args-request>"
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ps_set_bool_Args-request>)))
  "Returns string type for a service object of type '<ps_set_bool_Args-request>"
  "power_system/ps_set_bool_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ps_set_bool_Args-request)))
  "Returns string type for a service object of type 'ps_set_bool_Args-request"
  "power_system/ps_set_bool_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ps_set_bool_Args-request>)))
  "Returns md5sum for a message object of type '<ps_set_bool_Args-request>"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ps_set_bool_Args-request)))
  "Returns md5sum for a message object of type 'ps_set_bool_Args-request"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ps_set_bool_Args-request>)))
  "Returns full string definition for message of type '<ps_set_bool_Args-request>"
  (cl:format cl:nil "~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ps_set_bool_Args-request)))
  "Returns full string definition for message of type 'ps_set_bool_Args-request"
  (cl:format cl:nil "~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ps_set_bool_Args-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ps_set_bool_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ps_set_bool_Args-request
    (cl:cons ':state (state msg))
))
;//! \htmlinclude ps_set_bool_Args-response.msg.html

(cl:defclass <ps_set_bool_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass ps_set_bool_Args-response (<ps_set_bool_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ps_set_bool_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ps_set_bool_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name power_system-srv:<ps_set_bool_Args-response> is deprecated: use power_system-srv:ps_set_bool_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <ps_set_bool_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader power_system-srv:response-val is deprecated.  Use power_system-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ps_set_bool_Args-response>) ostream)
  "Serializes a message object of type '<ps_set_bool_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ps_set_bool_Args-response>) istream)
  "Deserializes a message object of type '<ps_set_bool_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ps_set_bool_Args-response>)))
  "Returns string type for a service object of type '<ps_set_bool_Args-response>"
  "power_system/ps_set_bool_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ps_set_bool_Args-response)))
  "Returns string type for a service object of type 'ps_set_bool_Args-response"
  "power_system/ps_set_bool_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ps_set_bool_Args-response>)))
  "Returns md5sum for a message object of type '<ps_set_bool_Args-response>"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ps_set_bool_Args-response)))
  "Returns md5sum for a message object of type 'ps_set_bool_Args-response"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ps_set_bool_Args-response>)))
  "Returns full string definition for message of type '<ps_set_bool_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ps_set_bool_Args-response)))
  "Returns full string definition for message of type 'ps_set_bool_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ps_set_bool_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ps_set_bool_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ps_set_bool_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ps_set_bool_Args)))
  'ps_set_bool_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ps_set_bool_Args)))
  'ps_set_bool_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ps_set_bool_Args)))
  "Returns string type for a service object of type '<ps_set_bool_Args>"
  "power_system/ps_set_bool_Args")