; Auto-generated. Do not edit!


(cl:in-package lantern_rack-srv)


;//! \htmlinclude lr_set_mode_Args-request.msg.html

(cl:defclass <lr_set_mode_Args-request> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0))
)

(cl:defclass lr_set_mode_Args-request (<lr_set_mode_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lr_set_mode_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lr_set_mode_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lantern_rack-srv:<lr_set_mode_Args-request> is deprecated: use lantern_rack-srv:lr_set_mode_Args-request instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <lr_set_mode_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-srv:mode-val is deprecated.  Use lantern_rack-srv:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lr_set_mode_Args-request>) ostream)
  "Serializes a message object of type '<lr_set_mode_Args-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lr_set_mode_Args-request>) istream)
  "Deserializes a message object of type '<lr_set_mode_Args-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lr_set_mode_Args-request>)))
  "Returns string type for a service object of type '<lr_set_mode_Args-request>"
  "lantern_rack/lr_set_mode_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lr_set_mode_Args-request)))
  "Returns string type for a service object of type 'lr_set_mode_Args-request"
  "lantern_rack/lr_set_mode_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lr_set_mode_Args-request>)))
  "Returns md5sum for a message object of type '<lr_set_mode_Args-request>"
  "2e6307ffb6c6a15962ad11ee62cabe85")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lr_set_mode_Args-request)))
  "Returns md5sum for a message object of type 'lr_set_mode_Args-request"
  "2e6307ffb6c6a15962ad11ee62cabe85")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lr_set_mode_Args-request>)))
  "Returns full string definition for message of type '<lr_set_mode_Args-request>"
  (cl:format cl:nil "~%int64 mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lr_set_mode_Args-request)))
  "Returns full string definition for message of type 'lr_set_mode_Args-request"
  (cl:format cl:nil "~%int64 mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lr_set_mode_Args-request>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lr_set_mode_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'lr_set_mode_Args-request
    (cl:cons ':mode (mode msg))
))
;//! \htmlinclude lr_set_mode_Args-response.msg.html

(cl:defclass <lr_set_mode_Args-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:integer
    :initform 0))
)

(cl:defclass lr_set_mode_Args-response (<lr_set_mode_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lr_set_mode_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lr_set_mode_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lantern_rack-srv:<lr_set_mode_Args-response> is deprecated: use lantern_rack-srv:lr_set_mode_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <lr_set_mode_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-srv:response-val is deprecated.  Use lantern_rack-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lr_set_mode_Args-response>) ostream)
  "Serializes a message object of type '<lr_set_mode_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lr_set_mode_Args-response>) istream)
  "Deserializes a message object of type '<lr_set_mode_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lr_set_mode_Args-response>)))
  "Returns string type for a service object of type '<lr_set_mode_Args-response>"
  "lantern_rack/lr_set_mode_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lr_set_mode_Args-response)))
  "Returns string type for a service object of type 'lr_set_mode_Args-response"
  "lantern_rack/lr_set_mode_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lr_set_mode_Args-response>)))
  "Returns md5sum for a message object of type '<lr_set_mode_Args-response>"
  "2e6307ffb6c6a15962ad11ee62cabe85")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lr_set_mode_Args-response)))
  "Returns md5sum for a message object of type 'lr_set_mode_Args-response"
  "2e6307ffb6c6a15962ad11ee62cabe85")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lr_set_mode_Args-response>)))
  "Returns full string definition for message of type '<lr_set_mode_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lr_set_mode_Args-response)))
  "Returns full string definition for message of type 'lr_set_mode_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lr_set_mode_Args-response>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lr_set_mode_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'lr_set_mode_Args-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'lr_set_mode_Args)))
  'lr_set_mode_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'lr_set_mode_Args)))
  'lr_set_mode_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lr_set_mode_Args)))
  "Returns string type for a service object of type '<lr_set_mode_Args>"
  "lantern_rack/lr_set_mode_Args")