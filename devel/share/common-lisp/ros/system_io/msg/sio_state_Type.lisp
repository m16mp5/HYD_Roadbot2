; Auto-generated. Do not edit!


(cl:in-package system_io-msg)


;//! \htmlinclude sio_state_Type.msg.html

(cl:defclass <sio_state_Type> (roslisp-msg-protocol:ros-message)
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
   (input_pin
    :reader input_pin
    :initarg :input_pin
    :type (cl:vector cl:integer)
   :initform (cl:make-array 18 :element-type 'cl:integer :initial-element 0))
   (output_pin
    :reader output_pin
    :initarg :output_pin
    :type (cl:vector cl:integer)
   :initform (cl:make-array 18 :element-type 'cl:integer :initial-element 0))
   (llb_has_cone
    :reader llb_has_cone
    :initarg :llb_has_cone
    :type cl:boolean
    :initform cl:nil)
   (rlb_has_cone
    :reader rlb_has_cone
    :initarg :rlb_has_cone
    :type cl:boolean
    :initform cl:nil)
   (rear_slider_down
    :reader rear_slider_down
    :initarg :rear_slider_down
    :type cl:boolean
    :initform cl:nil)
   (cone_slider_extend
    :reader cone_slider_extend
    :initarg :cone_slider_extend
    :type cl:boolean
    :initform cl:nil)
   (airpump_on
    :reader airpump_on
    :initarg :airpump_on
    :type cl:boolean
    :initform cl:nil)
   (arrowlight_on
    :reader arrowlight_on
    :initarg :arrowlight_on
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass sio_state_Type (<sio_state_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sio_state_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sio_state_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name system_io-msg:<sio_state_Type> is deprecated: use system_io-msg:sio_state_Type instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:timestamp-val is deprecated.  Use system_io-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:state-val is deprecated.  Use system_io-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'input_pin-val :lambda-list '(m))
(cl:defmethod input_pin-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:input_pin-val is deprecated.  Use system_io-msg:input_pin instead.")
  (input_pin m))

(cl:ensure-generic-function 'output_pin-val :lambda-list '(m))
(cl:defmethod output_pin-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:output_pin-val is deprecated.  Use system_io-msg:output_pin instead.")
  (output_pin m))

(cl:ensure-generic-function 'llb_has_cone-val :lambda-list '(m))
(cl:defmethod llb_has_cone-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:llb_has_cone-val is deprecated.  Use system_io-msg:llb_has_cone instead.")
  (llb_has_cone m))

(cl:ensure-generic-function 'rlb_has_cone-val :lambda-list '(m))
(cl:defmethod rlb_has_cone-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:rlb_has_cone-val is deprecated.  Use system_io-msg:rlb_has_cone instead.")
  (rlb_has_cone m))

(cl:ensure-generic-function 'rear_slider_down-val :lambda-list '(m))
(cl:defmethod rear_slider_down-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:rear_slider_down-val is deprecated.  Use system_io-msg:rear_slider_down instead.")
  (rear_slider_down m))

(cl:ensure-generic-function 'cone_slider_extend-val :lambda-list '(m))
(cl:defmethod cone_slider_extend-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:cone_slider_extend-val is deprecated.  Use system_io-msg:cone_slider_extend instead.")
  (cone_slider_extend m))

(cl:ensure-generic-function 'airpump_on-val :lambda-list '(m))
(cl:defmethod airpump_on-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:airpump_on-val is deprecated.  Use system_io-msg:airpump_on instead.")
  (airpump_on m))

(cl:ensure-generic-function 'arrowlight_on-val :lambda-list '(m))
(cl:defmethod arrowlight_on-val ((m <sio_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader system_io-msg:arrowlight_on-val is deprecated.  Use system_io-msg:arrowlight_on instead.")
  (arrowlight_on m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sio_state_Type>) ostream)
  "Serializes a message object of type '<sio_state_Type>"
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
   (cl:slot-value msg 'input_pin))
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
   (cl:slot-value msg 'output_pin))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'llb_has_cone) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rlb_has_cone) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rear_slider_down) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cone_slider_extend) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'airpump_on) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'arrowlight_on) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sio_state_Type>) istream)
  "Deserializes a message object of type '<sio_state_Type>"
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
  (cl:setf (cl:slot-value msg 'input_pin) (cl:make-array 18))
  (cl:let ((vals (cl:slot-value msg 'input_pin)))
    (cl:dotimes (i 18)
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
  (cl:setf (cl:slot-value msg 'output_pin) (cl:make-array 18))
  (cl:let ((vals (cl:slot-value msg 'output_pin)))
    (cl:dotimes (i 18)
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
    (cl:setf (cl:slot-value msg 'llb_has_cone) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rlb_has_cone) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rear_slider_down) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'cone_slider_extend) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'airpump_on) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'arrowlight_on) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sio_state_Type>)))
  "Returns string type for a message object of type '<sio_state_Type>"
  "system_io/sio_state_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sio_state_Type)))
  "Returns string type for a message object of type 'sio_state_Type"
  "system_io/sio_state_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sio_state_Type>)))
  "Returns md5sum for a message object of type '<sio_state_Type>"
  "bb6f89f27eead6c5199e33a55449f841")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sio_state_Type)))
  "Returns md5sum for a message object of type 'sio_state_Type"
  "bb6f89f27eead6c5199e33a55449f841")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sio_state_Type>)))
  "Returns full string definition for message of type '<sio_state_Type>"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Ethernet IO raw states~%int64 state~%int64[18] input_pin~%int64[18] output_pin~%~%# LB states~%bool llb_has_cone~%bool rlb_has_cone~%~%# slider switch states~%bool rear_slider_down~%bool cone_slider_extend~%~%# air pump switch states~%bool airpump_on~%~%# arrow light switch states~%bool arrowlight_on~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sio_state_Type)))
  "Returns full string definition for message of type 'sio_state_Type"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Ethernet IO raw states~%int64 state~%int64[18] input_pin~%int64[18] output_pin~%~%# LB states~%bool llb_has_cone~%bool rlb_has_cone~%~%# slider switch states~%bool rear_slider_down~%bool cone_slider_extend~%~%# air pump switch states~%bool airpump_on~%~%# arrow light switch states~%bool arrowlight_on~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sio_state_Type>))
  (cl:+ 0
     8
     8
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'input_pin) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'output_pin) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sio_state_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'sio_state_Type
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':state (state msg))
    (cl:cons ':input_pin (input_pin msg))
    (cl:cons ':output_pin (output_pin msg))
    (cl:cons ':llb_has_cone (llb_has_cone msg))
    (cl:cons ':rlb_has_cone (rlb_has_cone msg))
    (cl:cons ':rear_slider_down (rear_slider_down msg))
    (cl:cons ':cone_slider_extend (cone_slider_extend msg))
    (cl:cons ':airpump_on (airpump_on msg))
    (cl:cons ':arrowlight_on (arrowlight_on msg))
))
