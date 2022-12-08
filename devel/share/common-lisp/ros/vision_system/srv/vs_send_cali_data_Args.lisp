; Auto-generated. Do not edit!


(cl:in-package vision_system-srv)


;//! \htmlinclude vs_send_cali_data_Args-request.msg.html

(cl:defclass <vs_send_cali_data_Args-request> (roslisp-msg-protocol:ros-message)
  ((caliD_0
    :reader caliD_0
    :initarg :caliD_0
    :type cl:integer
    :initform 0)
   (caliD_1
    :reader caliD_1
    :initarg :caliD_1
    :type cl:integer
    :initform 0)
   (caliD_2
    :reader caliD_2
    :initarg :caliD_2
    :type cl:integer
    :initform 0)
   (caliD_3
    :reader caliD_3
    :initarg :caliD_3
    :type cl:integer
    :initform 0)
   (caliD_4
    :reader caliD_4
    :initarg :caliD_4
    :type cl:integer
    :initform 0)
   (caliD_5
    :reader caliD_5
    :initarg :caliD_5
    :type cl:integer
    :initform 0)
   (caliD_6
    :reader caliD_6
    :initarg :caliD_6
    :type cl:integer
    :initform 0)
   (caliD_7
    :reader caliD_7
    :initarg :caliD_7
    :type cl:integer
    :initform 0)
   (Is_HD_check
    :reader Is_HD_check
    :initarg :Is_HD_check
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass vs_send_cali_data_Args-request (<vs_send_cali_data_Args-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <vs_send_cali_data_Args-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'vs_send_cali_data_Args-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vision_system-srv:<vs_send_cali_data_Args-request> is deprecated: use vision_system-srv:vs_send_cali_data_Args-request instead.")))

(cl:ensure-generic-function 'caliD_0-val :lambda-list '(m))
(cl:defmethod caliD_0-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_0-val is deprecated.  Use vision_system-srv:caliD_0 instead.")
  (caliD_0 m))

(cl:ensure-generic-function 'caliD_1-val :lambda-list '(m))
(cl:defmethod caliD_1-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_1-val is deprecated.  Use vision_system-srv:caliD_1 instead.")
  (caliD_1 m))

(cl:ensure-generic-function 'caliD_2-val :lambda-list '(m))
(cl:defmethod caliD_2-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_2-val is deprecated.  Use vision_system-srv:caliD_2 instead.")
  (caliD_2 m))

(cl:ensure-generic-function 'caliD_3-val :lambda-list '(m))
(cl:defmethod caliD_3-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_3-val is deprecated.  Use vision_system-srv:caliD_3 instead.")
  (caliD_3 m))

(cl:ensure-generic-function 'caliD_4-val :lambda-list '(m))
(cl:defmethod caliD_4-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_4-val is deprecated.  Use vision_system-srv:caliD_4 instead.")
  (caliD_4 m))

(cl:ensure-generic-function 'caliD_5-val :lambda-list '(m))
(cl:defmethod caliD_5-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_5-val is deprecated.  Use vision_system-srv:caliD_5 instead.")
  (caliD_5 m))

(cl:ensure-generic-function 'caliD_6-val :lambda-list '(m))
(cl:defmethod caliD_6-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_6-val is deprecated.  Use vision_system-srv:caliD_6 instead.")
  (caliD_6 m))

(cl:ensure-generic-function 'caliD_7-val :lambda-list '(m))
(cl:defmethod caliD_7-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:caliD_7-val is deprecated.  Use vision_system-srv:caliD_7 instead.")
  (caliD_7 m))

(cl:ensure-generic-function 'Is_HD_check-val :lambda-list '(m))
(cl:defmethod Is_HD_check-val ((m <vs_send_cali_data_Args-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:Is_HD_check-val is deprecated.  Use vision_system-srv:Is_HD_check instead.")
  (Is_HD_check m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <vs_send_cali_data_Args-request>) ostream)
  "Serializes a message object of type '<vs_send_cali_data_Args-request>"
  (cl:let* ((signed (cl:slot-value msg 'caliD_0)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_3)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_4)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_5)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_6)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'caliD_7)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Is_HD_check) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <vs_send_cali_data_Args-request>) istream)
  "Deserializes a message object of type '<vs_send_cali_data_Args-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_0) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_1) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_2) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_3) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_4) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_5) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_6) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'caliD_7) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'Is_HD_check) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<vs_send_cali_data_Args-request>)))
  "Returns string type for a service object of type '<vs_send_cali_data_Args-request>"
  "vision_system/vs_send_cali_data_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vs_send_cali_data_Args-request)))
  "Returns string type for a service object of type 'vs_send_cali_data_Args-request"
  "vision_system/vs_send_cali_data_ArgsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<vs_send_cali_data_Args-request>)))
  "Returns md5sum for a message object of type '<vs_send_cali_data_Args-request>"
  "f30152e5d2a43a58c59d2b40816d1dd0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'vs_send_cali_data_Args-request)))
  "Returns md5sum for a message object of type 'vs_send_cali_data_Args-request"
  "f30152e5d2a43a58c59d2b40816d1dd0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<vs_send_cali_data_Args-request>)))
  "Returns full string definition for message of type '<vs_send_cali_data_Args-request>"
  (cl:format cl:nil "~%int64 caliD_0~%int64 caliD_1~%int64 caliD_2~%int64 caliD_3~%int64 caliD_4~%int64 caliD_5~%int64 caliD_6~%int64 caliD_7~%bool Is_HD_check~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'vs_send_cali_data_Args-request)))
  "Returns full string definition for message of type 'vs_send_cali_data_Args-request"
  (cl:format cl:nil "~%int64 caliD_0~%int64 caliD_1~%int64 caliD_2~%int64 caliD_3~%int64 caliD_4~%int64 caliD_5~%int64 caliD_6~%int64 caliD_7~%bool Is_HD_check~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <vs_send_cali_data_Args-request>))
  (cl:+ 0
     8
     8
     8
     8
     8
     8
     8
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <vs_send_cali_data_Args-request>))
  "Converts a ROS message object to a list"
  (cl:list 'vs_send_cali_data_Args-request
    (cl:cons ':caliD_0 (caliD_0 msg))
    (cl:cons ':caliD_1 (caliD_1 msg))
    (cl:cons ':caliD_2 (caliD_2 msg))
    (cl:cons ':caliD_3 (caliD_3 msg))
    (cl:cons ':caliD_4 (caliD_4 msg))
    (cl:cons ':caliD_5 (caliD_5 msg))
    (cl:cons ':caliD_6 (caliD_6 msg))
    (cl:cons ':caliD_7 (caliD_7 msg))
    (cl:cons ':Is_HD_check (Is_HD_check msg))
))
;//! \htmlinclude vs_send_cali_data_Args-response.msg.html

(cl:defclass <vs_send_cali_data_Args-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass vs_send_cali_data_Args-response (<vs_send_cali_data_Args-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <vs_send_cali_data_Args-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'vs_send_cali_data_Args-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vision_system-srv:<vs_send_cali_data_Args-response> is deprecated: use vision_system-srv:vs_send_cali_data_Args-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <vs_send_cali_data_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:response-val is deprecated.  Use vision_system-srv:response instead.")
  (response m))

(cl:ensure-generic-function 'result_code-val :lambda-list '(m))
(cl:defmethod result_code-val ((m <vs_send_cali_data_Args-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_system-srv:result_code-val is deprecated.  Use vision_system-srv:result_code instead.")
  (result_code m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <vs_send_cali_data_Args-response>) ostream)
  "Serializes a message object of type '<vs_send_cali_data_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <vs_send_cali_data_Args-response>) istream)
  "Deserializes a message object of type '<vs_send_cali_data_Args-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<vs_send_cali_data_Args-response>)))
  "Returns string type for a service object of type '<vs_send_cali_data_Args-response>"
  "vision_system/vs_send_cali_data_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vs_send_cali_data_Args-response)))
  "Returns string type for a service object of type 'vs_send_cali_data_Args-response"
  "vision_system/vs_send_cali_data_ArgsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<vs_send_cali_data_Args-response>)))
  "Returns md5sum for a message object of type '<vs_send_cali_data_Args-response>"
  "f30152e5d2a43a58c59d2b40816d1dd0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'vs_send_cali_data_Args-response)))
  "Returns md5sum for a message object of type 'vs_send_cali_data_Args-response"
  "f30152e5d2a43a58c59d2b40816d1dd0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<vs_send_cali_data_Args-response>)))
  "Returns full string definition for message of type '<vs_send_cali_data_Args-response>"
  (cl:format cl:nil "~%int64 response~%~%~%int64 result_code~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'vs_send_cali_data_Args-response)))
  "Returns full string definition for message of type 'vs_send_cali_data_Args-response"
  (cl:format cl:nil "~%int64 response~%~%~%int64 result_code~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <vs_send_cali_data_Args-response>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <vs_send_cali_data_Args-response>))
  "Converts a ROS message object to a list"
  (cl:list 'vs_send_cali_data_Args-response
    (cl:cons ':response (response msg))
    (cl:cons ':result_code (result_code msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'vs_send_cali_data_Args)))
  'vs_send_cali_data_Args-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'vs_send_cali_data_Args)))
  'vs_send_cali_data_Args-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vs_send_cali_data_Args)))
  "Returns string type for a service object of type '<vs_send_cali_data_Args>"
  "vision_system/vs_send_cali_data_Args")