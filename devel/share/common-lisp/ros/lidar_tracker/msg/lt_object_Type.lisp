; Auto-generated. Do not edit!


(cl:in-package lidar_tracker-msg)


;//! \htmlinclude lt_object_Type.msg.html

(cl:defclass <lt_object_Type> (roslisp-msg-protocol:ros-message)
  ((ID
    :reader ID
    :initarg :ID
    :type cl:integer
    :initform 0)
   (IDTimestamp
    :reader IDTimestamp
    :initarg :IDTimestamp
    :type cl:float
    :initform 0.0)
   (UpdateInterval
    :reader UpdateInterval
    :initarg :UpdateInterval
    :type cl:float
    :initform 0.0)
   (RatioM
    :reader RatioM
    :initarg :RatioM
    :type cl:float
    :initform 0.0)
   (MinPoint
    :reader MinPoint
    :initarg :MinPoint
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (IncEdge
    :reader IncEdge
    :initarg :IncEdge
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (DecEdge
    :reader DecEdge
    :initarg :DecEdge
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (CenterPoint
    :reader CenterPoint
    :initarg :CenterPoint
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (StableRefPoint
    :reader StableRefPoint
    :initarg :StableRefPoint
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (Size
    :reader Size
    :initarg :Size
    :type cl:float
    :initform 0.0)
   (Is_Cone
    :reader Is_Cone
    :initarg :Is_Cone
    :type cl:boolean
    :initform cl:nil)
   (Is_Tracked
    :reader Is_Tracked
    :initarg :Is_Tracked
    :type cl:boolean
    :initform cl:nil)
   (Est_Vel
    :reader Est_Vel
    :initarg :Est_Vel
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (Est_Acc
    :reader Est_Acc
    :initarg :Est_Acc
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (Is_Fused
    :reader Is_Fused
    :initarg :Is_Fused
    :type cl:boolean
    :initform cl:nil)
   (Incline
    :reader Incline
    :initarg :Incline
    :type lidar_tracker-msg:lt_datapoint_Type
    :initform (cl:make-instance 'lidar_tracker-msg:lt_datapoint_Type))
   (Rotate
    :reader Rotate
    :initarg :Rotate
    :type cl:float
    :initform 0.0))
)

(cl:defclass lt_object_Type (<lt_object_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lt_object_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lt_object_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lidar_tracker-msg:<lt_object_Type> is deprecated: use lidar_tracker-msg:lt_object_Type instead.")))

(cl:ensure-generic-function 'ID-val :lambda-list '(m))
(cl:defmethod ID-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:ID-val is deprecated.  Use lidar_tracker-msg:ID instead.")
  (ID m))

(cl:ensure-generic-function 'IDTimestamp-val :lambda-list '(m))
(cl:defmethod IDTimestamp-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:IDTimestamp-val is deprecated.  Use lidar_tracker-msg:IDTimestamp instead.")
  (IDTimestamp m))

(cl:ensure-generic-function 'UpdateInterval-val :lambda-list '(m))
(cl:defmethod UpdateInterval-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:UpdateInterval-val is deprecated.  Use lidar_tracker-msg:UpdateInterval instead.")
  (UpdateInterval m))

(cl:ensure-generic-function 'RatioM-val :lambda-list '(m))
(cl:defmethod RatioM-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:RatioM-val is deprecated.  Use lidar_tracker-msg:RatioM instead.")
  (RatioM m))

(cl:ensure-generic-function 'MinPoint-val :lambda-list '(m))
(cl:defmethod MinPoint-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:MinPoint-val is deprecated.  Use lidar_tracker-msg:MinPoint instead.")
  (MinPoint m))

(cl:ensure-generic-function 'IncEdge-val :lambda-list '(m))
(cl:defmethod IncEdge-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:IncEdge-val is deprecated.  Use lidar_tracker-msg:IncEdge instead.")
  (IncEdge m))

(cl:ensure-generic-function 'DecEdge-val :lambda-list '(m))
(cl:defmethod DecEdge-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:DecEdge-val is deprecated.  Use lidar_tracker-msg:DecEdge instead.")
  (DecEdge m))

(cl:ensure-generic-function 'CenterPoint-val :lambda-list '(m))
(cl:defmethod CenterPoint-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:CenterPoint-val is deprecated.  Use lidar_tracker-msg:CenterPoint instead.")
  (CenterPoint m))

(cl:ensure-generic-function 'StableRefPoint-val :lambda-list '(m))
(cl:defmethod StableRefPoint-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:StableRefPoint-val is deprecated.  Use lidar_tracker-msg:StableRefPoint instead.")
  (StableRefPoint m))

(cl:ensure-generic-function 'Size-val :lambda-list '(m))
(cl:defmethod Size-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Size-val is deprecated.  Use lidar_tracker-msg:Size instead.")
  (Size m))

(cl:ensure-generic-function 'Is_Cone-val :lambda-list '(m))
(cl:defmethod Is_Cone-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Is_Cone-val is deprecated.  Use lidar_tracker-msg:Is_Cone instead.")
  (Is_Cone m))

(cl:ensure-generic-function 'Is_Tracked-val :lambda-list '(m))
(cl:defmethod Is_Tracked-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Is_Tracked-val is deprecated.  Use lidar_tracker-msg:Is_Tracked instead.")
  (Is_Tracked m))

(cl:ensure-generic-function 'Est_Vel-val :lambda-list '(m))
(cl:defmethod Est_Vel-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Est_Vel-val is deprecated.  Use lidar_tracker-msg:Est_Vel instead.")
  (Est_Vel m))

(cl:ensure-generic-function 'Est_Acc-val :lambda-list '(m))
(cl:defmethod Est_Acc-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Est_Acc-val is deprecated.  Use lidar_tracker-msg:Est_Acc instead.")
  (Est_Acc m))

(cl:ensure-generic-function 'Is_Fused-val :lambda-list '(m))
(cl:defmethod Is_Fused-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Is_Fused-val is deprecated.  Use lidar_tracker-msg:Is_Fused instead.")
  (Is_Fused m))

(cl:ensure-generic-function 'Incline-val :lambda-list '(m))
(cl:defmethod Incline-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Incline-val is deprecated.  Use lidar_tracker-msg:Incline instead.")
  (Incline m))

(cl:ensure-generic-function 'Rotate-val :lambda-list '(m))
(cl:defmethod Rotate-val ((m <lt_object_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_tracker-msg:Rotate-val is deprecated.  Use lidar_tracker-msg:Rotate instead.")
  (Rotate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lt_object_Type>) ostream)
  "Serializes a message object of type '<lt_object_Type>"
  (cl:let* ((signed (cl:slot-value msg 'ID)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'IDTimestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'UpdateInterval))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'RatioM))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'MinPoint) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'IncEdge) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'DecEdge) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'CenterPoint) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'StableRefPoint) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Size))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Is_Cone) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Is_Tracked) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Est_Vel) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Est_Acc) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Is_Fused) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Incline) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Rotate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lt_object_Type>) istream)
  "Deserializes a message object of type '<lt_object_Type>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ID) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'IDTimestamp) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'UpdateInterval) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'RatioM) (roslisp-utils:decode-double-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'MinPoint) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'IncEdge) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'DecEdge) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'CenterPoint) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'StableRefPoint) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Size) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:slot-value msg 'Is_Cone) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'Is_Tracked) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Est_Vel) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Est_Acc) istream)
    (cl:setf (cl:slot-value msg 'Is_Fused) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Incline) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Rotate) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lt_object_Type>)))
  "Returns string type for a message object of type '<lt_object_Type>"
  "lidar_tracker/lt_object_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lt_object_Type)))
  "Returns string type for a message object of type 'lt_object_Type"
  "lidar_tracker/lt_object_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lt_object_Type>)))
  "Returns md5sum for a message object of type '<lt_object_Type>"
  "653a1245a4632ad939226826e9619f93")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lt_object_Type)))
  "Returns md5sum for a message object of type 'lt_object_Type"
  "653a1245a4632ad939226826e9619f93")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lt_object_Type>)))
  "Returns full string definition for message of type '<lt_object_Type>"
  (cl:format cl:nil "# Object ID~%int64 ID~%float64 IDTimestamp~%~%# Interval [s]~%float64 UpdateInterval~%~%# Matching ratio~%float64 RatioM~%~%# Object feature points~%lidar_tracker/lt_datapoint_Type MinPoint~%lidar_tracker/lt_datapoint_Type IncEdge~%lidar_tracker/lt_datapoint_Type DecEdge~%lidar_tracker/lt_datapoint_Type CenterPoint~%lidar_tracker/lt_datapoint_Type StableRefPoint~%~%# Object size [m]~%float64 Size~%~%# Object is cone~%bool Is_Cone~%# Object is tracked~%bool Is_Tracked~%~%# Estimated Vel Acc~%lidar_tracker/lt_datapoint_Type Est_Vel~%lidar_tracker/lt_datapoint_Type Est_Acc~%~%# Lidar data fused object~%bool Is_Fused~%~%# Estimated incline angle [rad]~%lidar_tracker/lt_datapoint_Type Incline~%# Estimated rotated angle [rad]~%float64 Rotate~%~%~%================================================================================~%MSG: lidar_tracker/lt_datapoint_Type~%# XY coordinate [m]~%float64  Dist~%float64  Angle~%float64  x~%float64  y~%# RSSI [0~~255]~%float64  intensity~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lt_object_Type)))
  "Returns full string definition for message of type 'lt_object_Type"
  (cl:format cl:nil "# Object ID~%int64 ID~%float64 IDTimestamp~%~%# Interval [s]~%float64 UpdateInterval~%~%# Matching ratio~%float64 RatioM~%~%# Object feature points~%lidar_tracker/lt_datapoint_Type MinPoint~%lidar_tracker/lt_datapoint_Type IncEdge~%lidar_tracker/lt_datapoint_Type DecEdge~%lidar_tracker/lt_datapoint_Type CenterPoint~%lidar_tracker/lt_datapoint_Type StableRefPoint~%~%# Object size [m]~%float64 Size~%~%# Object is cone~%bool Is_Cone~%# Object is tracked~%bool Is_Tracked~%~%# Estimated Vel Acc~%lidar_tracker/lt_datapoint_Type Est_Vel~%lidar_tracker/lt_datapoint_Type Est_Acc~%~%# Lidar data fused object~%bool Is_Fused~%~%# Estimated incline angle [rad]~%lidar_tracker/lt_datapoint_Type Incline~%# Estimated rotated angle [rad]~%float64 Rotate~%~%~%================================================================================~%MSG: lidar_tracker/lt_datapoint_Type~%# XY coordinate [m]~%float64  Dist~%float64  Angle~%float64  x~%float64  y~%# RSSI [0~~255]~%float64  intensity~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lt_object_Type>))
  (cl:+ 0
     8
     8
     8
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'MinPoint))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'IncEdge))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'DecEdge))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'CenterPoint))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'StableRefPoint))
     8
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Est_Vel))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Est_Acc))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Incline))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lt_object_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'lt_object_Type
    (cl:cons ':ID (ID msg))
    (cl:cons ':IDTimestamp (IDTimestamp msg))
    (cl:cons ':UpdateInterval (UpdateInterval msg))
    (cl:cons ':RatioM (RatioM msg))
    (cl:cons ':MinPoint (MinPoint msg))
    (cl:cons ':IncEdge (IncEdge msg))
    (cl:cons ':DecEdge (DecEdge msg))
    (cl:cons ':CenterPoint (CenterPoint msg))
    (cl:cons ':StableRefPoint (StableRefPoint msg))
    (cl:cons ':Size (Size msg))
    (cl:cons ':Is_Cone (Is_Cone msg))
    (cl:cons ':Is_Tracked (Is_Tracked msg))
    (cl:cons ':Est_Vel (Est_Vel msg))
    (cl:cons ':Est_Acc (Est_Acc msg))
    (cl:cons ':Is_Fused (Is_Fused msg))
    (cl:cons ':Incline (Incline msg))
    (cl:cons ':Rotate (Rotate msg))
))
