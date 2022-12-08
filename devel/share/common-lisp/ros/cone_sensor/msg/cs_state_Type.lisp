; Auto-generated. Do not edit!


(cl:in-package cone_sensor-msg)


;//! \htmlinclude cs_state_Type.msg.html

(cl:defclass <cs_state_Type> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:float
    :initform 0.0)
   (weight_slots
    :reader weight_slots
    :initarg :weight_slots
    :type (cl:vector cl:float)
   :initform (cl:make-array 14 :element-type 'cl:float :initial-element 0.0))
   (state
    :reader state
    :initarg :state
    :type (cl:vector cl:integer)
   :initform (cl:make-array 14 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass cs_state_Type (<cs_state_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <cs_state_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'cs_state_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cone_sensor-msg:<cs_state_Type> is deprecated: use cone_sensor-msg:cs_state_Type instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <cs_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cone_sensor-msg:timestamp-val is deprecated.  Use cone_sensor-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'weight_slots-val :lambda-list '(m))
(cl:defmethod weight_slots-val ((m <cs_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cone_sensor-msg:weight_slots-val is deprecated.  Use cone_sensor-msg:weight_slots instead.")
  (weight_slots m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <cs_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cone_sensor-msg:state-val is deprecated.  Use cone_sensor-msg:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <cs_state_Type>) ostream)
  "Serializes a message object of type '<cs_state_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'weight_slots))
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
   (cl:slot-value msg 'state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <cs_state_Type>) istream)
  "Deserializes a message object of type '<cs_state_Type>"
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
  (cl:setf (cl:slot-value msg 'weight_slots) (cl:make-array 14))
  (cl:let ((vals (cl:slot-value msg 'weight_slots)))
    (cl:dotimes (i 14)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'state) (cl:make-array 14))
  (cl:let ((vals (cl:slot-value msg 'state)))
    (cl:dotimes (i 14)
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<cs_state_Type>)))
  "Returns string type for a message object of type '<cs_state_Type>"
  "cone_sensor/cs_state_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'cs_state_Type)))
  "Returns string type for a message object of type 'cs_state_Type"
  "cone_sensor/cs_state_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<cs_state_Type>)))
  "Returns md5sum for a message object of type '<cs_state_Type>"
  "ed4de7dc8dadb6133b9f1ded06e00707")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'cs_state_Type)))
  "Returns md5sum for a message object of type 'cs_state_Type"
  "ed4de7dc8dadb6133b9f1ded06e00707")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<cs_state_Type>)))
  "Returns full string definition for message of type '<cs_state_Type>"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# 14 weight sensor readings in [kg]~%float64[14] weight_slots~%~%# 14 sensor error state~%int64[14] state~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'cs_state_Type)))
  "Returns full string definition for message of type 'cs_state_Type"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# 14 weight sensor readings in [kg]~%float64[14] weight_slots~%~%# 14 sensor error state~%int64[14] state~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <cs_state_Type>))
  (cl:+ 0
     8
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'weight_slots) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <cs_state_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'cs_state_Type
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':weight_slots (weight_slots msg))
    (cl:cons ':state (state msg))
))
