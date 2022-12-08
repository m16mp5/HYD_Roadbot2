; Auto-generated. Do not edit!


(cl:in-package cone_sensor-srv)


;//! \htmlinclude cs_set_bool_Args-request.msg.html

(cl:defclass <cs_set_bool_Args-request> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass cs_set_bool_Args-request (<cs_set_bool_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <cs_set_bool_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'cs_set_bool_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cone_sensor-srv:<cs_set_bool_Args-request> is deprecated: use cone_sensor-srv:cs_set_bool_Args-request instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <cs_set_bool_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cone_sensor-srv:state-val is deprecated.  Use cone_sensor-srv:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <cs_set_bool_Args-request>) ostream)
  "Serializes a message object of type '<cs_set_bool_Args-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <cs_set_bool_Args-request>) istream)
  "Deserializes a message object of type '<cs_set_bool_Args-request>"
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<cs_set_bool_Args-request>)))
  "Returns string type for a service object of type '<cs_set_bool_Args-request>"
  "cone_sensor/cs_set_bool_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cs_set_bool_Args-request)))
  "Returns string type for a service object of type 'cs_set_bool_Args-request"
  "cone_sensor/cs_set_bool_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<cs_set_bool_Args-request>)))
  "Returns md5sum for a message object of type '<cs_set_bool_Args-request>"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'cs_set_bool_Args-request)))
  "Returns md5sum for a message object of type 'cs_set_bool_Args-request"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<cs_set_bool_Args-request>)))
  "Returns full string definition for message of type '<cs_set_bool_Args-request>"
  (cl:format cl:nil "~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'cs_set_bool_Args-request)))
  "Returns full string definition for message of type 'cs_set_bool_Args-request"
  (cl:format cl:nil "~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <cs_set_bool_Args-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <cs_set_bool_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'cs_set_bool_Args-request
    (cl:cons ':state (state msg))
))
;//! \htmlinclude cs_set_bool_Args-response.msg.html

(cl:defclass <cs_set_bool_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass cs_set_bool_Args-response (<cs_set_bool_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <cs_set_bool_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'cs_set_bool_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cone_sensor-srv:<cs_set_bool_Args-response> is deprecated: use cone_sensor-srv:cs_set_bool_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <cs_set_bool_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cone_sensor-srv:response-val is deprecated.  Use cone_sensor-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <cs_set_bool_Args-response>) ostream)
  "Serializes a message object of type '<cs_set_bool_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <cs_set_bool_Args-response>) istream)
  "Deserializes a message object of type '<cs_set_bool_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<cs_set_bool_Args-response>)))
  "Returns string type for a service object of type '<cs_set_bool_Args-response>"
  "cone_sensor/cs_set_bool_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cs_set_bool_Args-response)))
  "Returns string type for a service object of type 'cs_set_bool_Args-response"
  "cone_sensor/cs_set_bool_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<cs_set_bool_Args-response>)))
  "Returns md5sum for a message object of type '<cs_set_bool_Args-response>"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'cs_set_bool_Args-response)))
  "Returns md5sum for a message object of type 'cs_set_bool_Args-response"
  "01ed7128038a1bd09607b70544351d27")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<cs_set_bool_Args-response>)))
  "Returns full string definition for message of type '<cs_set_bool_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'cs_set_bool_Args-response)))
  "Returns full string definition for message of type 'cs_set_bool_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <cs_set_bool_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <cs_set_bool_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'cs_set_bool_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'cs_set_bool_Args)))
  'cs_set_bool_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'cs_set_bool_Args)))
  'cs_set_bool_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cs_set_bool_Args)))
  "Returns string type for a service object of type '<cs_set_bool_Args>"
  "cone_sensor/cs_set_bool_Args")