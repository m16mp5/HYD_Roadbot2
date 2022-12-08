; Auto-generated. Do not edit!


(cl:in-package lantern_rack-msg)


;//! \htmlinclude lr_state_Type.msg.html

(cl:defclass <lr_state_Type> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:float
    :initform 0.0)
   (state
    :reader state
    :initarg :state
    :type cl:integer
    :initform 0)
   (mode
    :reader mode
    :initarg :mode
    :type (cl:vector cl:integer)
   :initform (cl:make-array 10 :element-type 'cl:integer :initial-element 0))
   (level
    :reader level
    :initarg :level
    :type (cl:vector cl:integer)
   :initform (cl:make-array 10 :element-type 'cl:integer :initial-element 0))
   (sensor_state
    :reader sensor_state
    :initarg :sensor_state
    :type (cl:vector cl:integer)
   :initform (cl:make-array 10 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass lr_state_Type (<lr_state_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lr_state_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lr_state_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lantern_rack-msg:<lr_state_Type> is deprecated: use lantern_rack-msg:lr_state_Type instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <lr_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-msg:timestamp-val is deprecated.  Use lantern_rack-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <lr_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-msg:state-val is deprecated.  Use lantern_rack-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <lr_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-msg:mode-val is deprecated.  Use lantern_rack-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'level-val :lambda-list '(m))
(cl:defmethod level-val ((m <lr_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-msg:level-val is deprecated.  Use lantern_rack-msg:level instead.")
  (level m))

(cl:ensure-generic-function 'sensor_state-val :lambda-list '(m))
(cl:defmethod sensor_state-val ((m <lr_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lantern_rack-msg:sensor_state-val is deprecated.  Use lantern_rack-msg:sensor_state instead.")
  (sensor_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lr_state_Type>) ostream)
  "Serializes a message object of type '<lr_state_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'state)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'mode))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'level))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'sensor_state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lr_state_Type>) istream)
  "Deserializes a message object of type '<lr_state_Type>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'state) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:setf (cl:slot-value msg 'mode) (cl:make-array 10))
  (cl:let ((vals (cl:slot-value msg 'mode)))
    (cl:dotimes (i 10)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))))
  (cl:setf (cl:slot-value msg 'level) (cl:make-array 10))
  (cl:let ((vals (cl:slot-value msg 'level)))
    (cl:dotimes (i 10)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))))
  (cl:setf (cl:slot-value msg 'sensor_state) (cl:make-array 10))
  (cl:let ((vals (cl:slot-value msg 'sensor_state)))
    (cl:dotimes (i 10)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lr_state_Type>)))
  "Returns string type for a message object of type '<lr_state_Type>"
  "lantern_rack/lr_state_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lr_state_Type)))
  "Returns string type for a message object of type 'lr_state_Type"
  "lantern_rack/lr_state_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lr_state_Type>)))
  "Returns md5sum for a message object of type '<lr_state_Type>"
  "446242a7e9ff89a4043e4a4889335818")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lr_state_Type)))
  "Returns md5sum for a message object of type 'lr_state_Type"
  "446242a7e9ff89a4043e4a4889335818")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lr_state_Type>)))
  "Returns full string definition for message of type '<lr_state_Type>"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Lantern rack controller state~%int64 state~%~%# Lantern rack stack current working mode state [0-down 1-picking 2-filling 3-in trans]~%int64[10] mode~%~%# 10 Lantern rack stack level position~%int64[10] level~%~%# Lantern Racks sensor status~%int64[10] sensor_state~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lr_state_Type)))
  "Returns full string definition for message of type 'lr_state_Type"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Lantern rack controller state~%int64 state~%~%# Lantern rack stack current working mode state [0-down 1-picking 2-filling 3-in trans]~%int64[10] mode~%~%# 10 Lantern rack stack level position~%int64[10] level~%~%# Lantern Racks sensor status~%int64[10] sensor_state~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lr_state_Type>))
  (cl:+ 0
     8
     8
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'mode) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'level) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'sensor_state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lr_state_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'lr_state_Type
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':state (state msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':level (level msg))
    (cl:cons ':sensor_state (sensor_state msg))
))
