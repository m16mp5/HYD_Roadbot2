; Auto-generated. Do not edit!


(cl:in-package lidar_tracker-msg)


;//! \htmlinclude lt_datapoint_Type.msg.html

(cl:defclass <lt_datapoint_Type> (roslisp-msg-protocol:ros-message)
  ((Dist
    :reader Dist
    :initarg :Dist
    :type cl:float
    :initform 0.0)
   (Angle
    :reader Angle
    :initarg :Angle
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
    :initform 0.0)
   (intensity
    :reader intensity
    :initarg :intensity
    :type cl:float
    :initform 0.0))
)

(cl:defclass lt_datapoint_Type (<lt_datapoint_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lt_datapoint_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lt_datapoint_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lidar_tracker-msg:<lt_datapoint_Type> is deprecated: use lidar_tracker-msg:lt_datapoint_Type instead.")))

(cl:ensure-generic-function 'Dist-val :lambda-list '(m))
(cl:defmethod Dist-val ((m <lt_datapoint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Dist-val is deprecated.  Use lidar_tracker-msg:Dist instead.")
  (Dist m))

(cl:ensure-generic-function 'Angle-val :lambda-list '(m))
(cl:defmethod Angle-val ((m <lt_datapoint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Angle-val is deprecated.  Use lidar_tracker-msg:Angle instead.")
  (Angle m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <lt_datapoint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:x-val is deprecated.  Use lidar_tracker-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <lt_datapoint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:y-val is deprecated.  Use lidar_tracker-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'intensity-val :lambda-list '(m))
(cl:defmethod intensity-val ((m <lt_datapoint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:intensity-val is deprecated.  Use lidar_tracker-msg:intensity instead.")
  (intensity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lt_datapoint_Type>) ostream)
  "Serializes a message object of type '<lt_datapoint_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Dist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Angle))))
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
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'intensity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lt_datapoint_Type>) istream)
  "Deserializes a message object of type '<lt_datapoint_Type>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Dist) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Angle) (roslisp-utils:decode-double-float-bits bits)))
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'intensity) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lt_datapoint_Type>)))
  "Returns string type for a message object of type '<lt_datapoint_Type>"
  "lidar_tracker/lt_datapoint_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lt_datapoint_Type)))
  "Returns string type for a message object of type 'lt_datapoint_Type"
  "lidar_tracker/lt_datapoint_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lt_datapoint_Type>)))
  "Returns md5sum for a message object of type '<lt_datapoint_Type>"
  "856cbb998fe9c851ccd38f03abcbca6e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lt_datapoint_Type)))
  "Returns md5sum for a message object of type 'lt_datapoint_Type"
  "856cbb998fe9c851ccd38f03abcbca6e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lt_datapoint_Type>)))
  "Returns full string definition for message of type '<lt_datapoint_Type>"
  (cl:format cl:nil "# XY coordinate [m]~%float64  Dist~%float64  Angle~%float64  x~%float64  y~%# RSSI [0~~255]~%float64  intensity~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lt_datapoint_Type)))
  "Returns full string definition for message of type 'lt_datapoint_Type"
  (cl:format cl:nil "# XY coordinate [m]~%float64  Dist~%float64  Angle~%float64  x~%float64  y~%# RSSI [0~~255]~%float64  intensity~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lt_datapoint_Type>))
  (cl:+ 0
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lt_datapoint_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'lt_datapoint_Type
    (cl:cons ':Dist (Dist msg))
    (cl:cons ':Angle (Angle msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':intensity (intensity msg))
))
