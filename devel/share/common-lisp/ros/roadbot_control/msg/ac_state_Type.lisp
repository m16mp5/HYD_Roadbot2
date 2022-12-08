; Auto-generated. Do not edit!


(cl:in-package roadbot_control-msg)


;//! \htmlinclude ac_state_Type.msg.html

(cl:defclass <ac_state_Type> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:float
    :initform 0.0)
   (reararm_sm
    :reader reararm_sm
    :initarg :reararm_sm
    :type cl:integer
    :initform 0)
   (frontarm_sm
    :reader frontarm_sm
    :initarg :frontarm_sm
    :type cl:integer
    :initform 0)
   (target_id
    :reader target_id
    :initarg :target_id
    :type cl:integer
    :initform 0)
   (target_pos_X
    :reader target_pos_X
    :initarg :target_pos_X
    :type cl:float
    :initform 0.0)
   (target_pos_Y
    :reader target_pos_Y
    :initarg :target_pos_Y
    :type cl:float
    :initform 0.0)
   (target_pos_Z
    :reader target_pos_Z
    :initarg :target_pos_Z
    :type cl:float
    :initform 0.0)
   (target_vel_X
    :reader target_vel_X
    :initarg :target_vel_X
    :type cl:float
    :initform 0.0)
   (target_vel_Y
    :reader target_vel_Y
    :initarg :target_vel_Y
    :type cl:float
    :initform 0.0)
   (target_vel_Z
    :reader target_vel_Z
    :initarg :target_vel_Z
    :type cl:float
    :initform 0.0)
   (target_acc_X
    :reader target_acc_X
    :initarg :target_acc_X
    :type cl:float
    :initform 0.0)
   (target_acc_Y
    :reader target_acc_Y
    :initarg :target_acc_Y
    :type cl:float
    :initform 0.0)
   (target_acc_Z
    :reader target_acc_Z
    :initarg :target_acc_Z
    :type cl:float
    :initform 0.0)
   (roadmarkline_pos_X
    :reader roadmarkline_pos_X
    :initarg :roadmarkline_pos_X
    :type cl:float
    :initform 0.0)
   (roadmarkline_pos_Y
    :reader roadmarkline_pos_Y
    :initarg :roadmarkline_pos_Y
    :type cl:float
    :initform 0.0)
   (progress_place_count
    :reader progress_place_count
    :initarg :progress_place_count
    :type cl:integer
    :initform 0)
   (progress_place_in_total
    :reader progress_place_in_total
    :initarg :progress_place_in_total
    :type cl:integer
    :initform 0)
   (progress_collect_count
    :reader progress_collect_count
    :initarg :progress_collect_count
    :type cl:integer
    :initform 0)
   (progress_collect_in_total
    :reader progress_collect_in_total
    :initarg :progress_collect_in_total
    :type cl:integer
    :initform 0)
   (sb_slider_position
    :reader sb_slider_position
    :initarg :sb_slider_position
    :type cl:integer
    :initform 0)
   (sb_cones_in_total
    :reader sb_cones_in_total
    :initarg :sb_cones_in_total
    :type cl:integer
    :initform 0)
   (sb_cones_in_stack
    :reader sb_cones_in_stack
    :initarg :sb_cones_in_stack
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (sb_current_stack
    :reader sb_current_stack
    :initarg :sb_current_stack
    :type cl:integer
    :initform 0)
   (sb_current_stacklevel
    :reader sb_current_stacklevel
    :initarg :sb_current_stacklevel
    :type cl:integer
    :initform 0)
   (lb_left_slot
    :reader lb_left_slot
    :initarg :lb_left_slot
    :type cl:integer
    :initform 0)
   (lb_right_slot
    :reader lb_right_slot
    :initarg :lb_right_slot
    :type cl:integer
    :initform 0)
   (lr_lanterns_in_total
    :reader lr_lanterns_in_total
    :initarg :lr_lanterns_in_total
    :type cl:integer
    :initform 0)
   (lr_lanterns_in_stack
    :reader lr_lanterns_in_stack
    :initarg :lr_lanterns_in_stack
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (lr_current_stack
    :reader lr_current_stack
    :initarg :lr_current_stack
    :type cl:integer
    :initform 0)
   (lr_current_stacklevel
    :reader lr_current_stacklevel
    :initarg :lr_current_stacklevel
    :type cl:integer
    :initform 0)
   (rearDetectObjectInDeadZone
    :reader rearDetectObjectInDeadZone
    :initarg :rearDetectObjectInDeadZone
    :type cl:boolean
    :initform cl:nil)
   (rearDetectObjectInPlaceZoneRight
    :reader rearDetectObjectInPlaceZoneRight
    :initarg :rearDetectObjectInPlaceZoneRight
    :type cl:boolean
    :initform cl:nil)
   (rearDetectObjectInPlaceZoneCenter
    :reader rearDetectObjectInPlaceZoneCenter
    :initarg :rearDetectObjectInPlaceZoneCenter
    :type cl:boolean
    :initform cl:nil)
   (rearDetectObjectInPlaceZoneLeft
    :reader rearDetectObjectInPlaceZoneLeft
    :initarg :rearDetectObjectInPlaceZoneLeft
    :type cl:boolean
    :initform cl:nil)
   (rearDetectNonLockObjectInOperationZone
    :reader rearDetectNonLockObjectInOperationZone
    :initarg :rearDetectNonLockObjectInOperationZone
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ac_state_Type (<ac_state_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ac_state_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ac_state_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roadbot_control-msg:<ac_state_Type> is deprecated: use roadbot_control-msg:ac_state_Type instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:timestamp-val is deprecated.  Use roadbot_control-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'reararm_sm-val :lambda-list '(m))
(cl:defmethod reararm_sm-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:reararm_sm-val is deprecated.  Use roadbot_control-msg:reararm_sm instead.")
  (reararm_sm m))

(cl:ensure-generic-function 'frontarm_sm-val :lambda-list '(m))
(cl:defmethod frontarm_sm-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:frontarm_sm-val is deprecated.  Use roadbot_control-msg:frontarm_sm instead.")
  (frontarm_sm m))

(cl:ensure-generic-function 'target_id-val :lambda-list '(m))
(cl:defmethod target_id-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_id-val is deprecated.  Use roadbot_control-msg:target_id instead.")
  (target_id m))

(cl:ensure-generic-function 'target_pos_X-val :lambda-list '(m))
(cl:defmethod target_pos_X-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_pos_X-val is deprecated.  Use roadbot_control-msg:target_pos_X instead.")
  (target_pos_X m))

(cl:ensure-generic-function 'target_pos_Y-val :lambda-list '(m))
(cl:defmethod target_pos_Y-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_pos_Y-val is deprecated.  Use roadbot_control-msg:target_pos_Y instead.")
  (target_pos_Y m))

(cl:ensure-generic-function 'target_pos_Z-val :lambda-list '(m))
(cl:defmethod target_pos_Z-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_pos_Z-val is deprecated.  Use roadbot_control-msg:target_pos_Z instead.")
  (target_pos_Z m))

(cl:ensure-generic-function 'target_vel_X-val :lambda-list '(m))
(cl:defmethod target_vel_X-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_vel_X-val is deprecated.  Use roadbot_control-msg:target_vel_X instead.")
  (target_vel_X m))

(cl:ensure-generic-function 'target_vel_Y-val :lambda-list '(m))
(cl:defmethod target_vel_Y-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_vel_Y-val is deprecated.  Use roadbot_control-msg:target_vel_Y instead.")
  (target_vel_Y m))

(cl:ensure-generic-function 'target_vel_Z-val :lambda-list '(m))
(cl:defmethod target_vel_Z-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_vel_Z-val is deprecated.  Use roadbot_control-msg:target_vel_Z instead.")
  (target_vel_Z m))

(cl:ensure-generic-function 'target_acc_X-val :lambda-list '(m))
(cl:defmethod target_acc_X-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_acc_X-val is deprecated.  Use roadbot_control-msg:target_acc_X instead.")
  (target_acc_X m))

(cl:ensure-generic-function 'target_acc_Y-val :lambda-list '(m))
(cl:defmethod target_acc_Y-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_acc_Y-val is deprecated.  Use roadbot_control-msg:target_acc_Y instead.")
  (target_acc_Y m))

(cl:ensure-generic-function 'target_acc_Z-val :lambda-list '(m))
(cl:defmethod target_acc_Z-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:target_acc_Z-val is deprecated.  Use roadbot_control-msg:target_acc_Z instead.")
  (target_acc_Z m))

(cl:ensure-generic-function 'roadmarkline_pos_X-val :lambda-list '(m))
(cl:defmethod roadmarkline_pos_X-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:roadmarkline_pos_X-val is deprecated.  Use roadbot_control-msg:roadmarkline_pos_X instead.")
  (roadmarkline_pos_X m))

(cl:ensure-generic-function 'roadmarkline_pos_Y-val :lambda-list '(m))
(cl:defmethod roadmarkline_pos_Y-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:roadmarkline_pos_Y-val is deprecated.  Use roadbot_control-msg:roadmarkline_pos_Y instead.")
  (roadmarkline_pos_Y m))

(cl:ensure-generic-function 'progress_place_count-val :lambda-list '(m))
(cl:defmethod progress_place_count-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:progress_place_count-val is deprecated.  Use roadbot_control-msg:progress_place_count instead.")
  (progress_place_count m))

(cl:ensure-generic-function 'progress_place_in_total-val :lambda-list '(m))
(cl:defmethod progress_place_in_total-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:progress_place_in_total-val is deprecated.  Use roadbot_control-msg:progress_place_in_total instead.")
  (progress_place_in_total m))

(cl:ensure-generic-function 'progress_collect_count-val :lambda-list '(m))
(cl:defmethod progress_collect_count-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:progress_collect_count-val is deprecated.  Use roadbot_control-msg:progress_collect_count instead.")
  (progress_collect_count m))

(cl:ensure-generic-function 'progress_collect_in_total-val :lambda-list '(m))
(cl:defmethod progress_collect_in_total-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:progress_collect_in_total-val is deprecated.  Use roadbot_control-msg:progress_collect_in_total instead.")
  (progress_collect_in_total m))

(cl:ensure-generic-function 'sb_slider_position-val :lambda-list '(m))
(cl:defmethod sb_slider_position-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:sb_slider_position-val is deprecated.  Use roadbot_control-msg:sb_slider_position instead.")
  (sb_slider_position m))

(cl:ensure-generic-function 'sb_cones_in_total-val :lambda-list '(m))
(cl:defmethod sb_cones_in_total-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:sb_cones_in_total-val is deprecated.  Use roadbot_control-msg:sb_cones_in_total instead.")
  (sb_cones_in_total m))

(cl:ensure-generic-function 'sb_cones_in_stack-val :lambda-list '(m))
(cl:defmethod sb_cones_in_stack-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:sb_cones_in_stack-val is deprecated.  Use roadbot_control-msg:sb_cones_in_stack instead.")
  (sb_cones_in_stack m))

(cl:ensure-generic-function 'sb_current_stack-val :lambda-list '(m))
(cl:defmethod sb_current_stack-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:sb_current_stack-val is deprecated.  Use roadbot_control-msg:sb_current_stack instead.")
  (sb_current_stack m))

(cl:ensure-generic-function 'sb_current_stacklevel-val :lambda-list '(m))
(cl:defmethod sb_current_stacklevel-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:sb_current_stacklevel-val is deprecated.  Use roadbot_control-msg:sb_current_stacklevel instead.")
  (sb_current_stacklevel m))

(cl:ensure-generic-function 'lb_left_slot-val :lambda-list '(m))
(cl:defmethod lb_left_slot-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:lb_left_slot-val is deprecated.  Use roadbot_control-msg:lb_left_slot instead.")
  (lb_left_slot m))

(cl:ensure-generic-function 'lb_right_slot-val :lambda-list '(m))
(cl:defmethod lb_right_slot-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:lb_right_slot-val is deprecated.  Use roadbot_control-msg:lb_right_slot instead.")
  (lb_right_slot m))

(cl:ensure-generic-function 'lr_lanterns_in_total-val :lambda-list '(m))
(cl:defmethod lr_lanterns_in_total-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:lr_lanterns_in_total-val is deprecated.  Use roadbot_control-msg:lr_lanterns_in_total instead.")
  (lr_lanterns_in_total m))

(cl:ensure-generic-function 'lr_lanterns_in_stack-val :lambda-list '(m))
(cl:defmethod lr_lanterns_in_stack-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:lr_lanterns_in_stack-val is deprecated.  Use roadbot_control-msg:lr_lanterns_in_stack instead.")
  (lr_lanterns_in_stack m))

(cl:ensure-generic-function 'lr_current_stack-val :lambda-list '(m))
(cl:defmethod lr_current_stack-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:lr_current_stack-val is deprecated.  Use roadbot_control-msg:lr_current_stack instead.")
  (lr_current_stack m))

(cl:ensure-generic-function 'lr_current_stacklevel-val :lambda-list '(m))
(cl:defmethod lr_current_stacklevel-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:lr_current_stacklevel-val is deprecated.  Use roadbot_control-msg:lr_current_stacklevel instead.")
  (lr_current_stacklevel m))

(cl:ensure-generic-function 'rearDetectObjectInDeadZone-val :lambda-list '(m))
(cl:defmethod rearDetectObjectInDeadZone-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:rearDetectObjectInDeadZone-val is deprecated.  Use roadbot_control-msg:rearDetectObjectInDeadZone instead.")
  (rearDetectObjectInDeadZone m))

(cl:ensure-generic-function 'rearDetectObjectInPlaceZoneRight-val :lambda-list '(m))
(cl:defmethod rearDetectObjectInPlaceZoneRight-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:rearDetectObjectInPlaceZoneRight-val is deprecated.  Use roadbot_control-msg:rearDetectObjectInPlaceZoneRight instead.")
  (rearDetectObjectInPlaceZoneRight m))

(cl:ensure-generic-function 'rearDetectObjectInPlaceZoneCenter-val :lambda-list '(m))
(cl:defmethod rearDetectObjectInPlaceZoneCenter-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:rearDetectObjectInPlaceZoneCenter-val is deprecated.  Use roadbot_control-msg:rearDetectObjectInPlaceZoneCenter instead.")
  (rearDetectObjectInPlaceZoneCenter m))

(cl:ensure-generic-function 'rearDetectObjectInPlaceZoneLeft-val :lambda-list '(m))
(cl:defmethod rearDetectObjectInPlaceZoneLeft-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:rearDetectObjectInPlaceZoneLeft-val is deprecated.  Use roadbot_control-msg:rearDetectObjectInPlaceZoneLeft instead.")
  (rearDetectObjectInPlaceZoneLeft m))

(cl:ensure-generic-function 'rearDetectNonLockObjectInOperationZone-val :lambda-list '(m))
(cl:defmethod rearDetectNonLockObjectInOperationZone-val ((m <ac_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roadbot_control-msg:rearDetectNonLockObjectInOperationZone-val is deprecated.  Use roadbot_control-msg:rearDetectNonLockObjectInOperationZone instead.")
  (rearDetectNonLockObjectInOperationZone m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ac_state_Type>) ostream)
  "Serializes a message object of type '<ac_state_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'reararm_sm)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'frontarm_sm)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'target_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_pos_X))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_pos_Y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_pos_Z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_vel_X))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_vel_Y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_vel_Z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_acc_X))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_acc_Y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_acc_Z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'roadmarkline_pos_X))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'roadmarkline_pos_Y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'progress_place_count)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'progress_place_in_total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'progress_collect_count)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'progress_collect_in_total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sb_slider_position)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sb_cones_in_total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sb_cones_in_stack))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
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
   (cl:slot-value msg 'sb_cones_in_stack))
  (cl:let* ((signed (cl:slot-value msg 'sb_current_stack)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sb_current_stacklevel)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lb_left_slot)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lb_right_slot)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lr_lanterns_in_total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lr_lanterns_in_stack))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
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
   (cl:slot-value msg 'lr_lanterns_in_stack))
  (cl:let* ((signed (cl:slot-value msg 'lr_current_stack)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lr_current_stacklevel)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rearDetectObjectInDeadZone) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rearDetectObjectInPlaceZoneRight) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rearDetectObjectInPlaceZoneCenter) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rearDetectObjectInPlaceZoneLeft) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rearDetectNonLockObjectInOperationZone) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ac_state_Type>) istream)
  "Deserializes a message object of type '<ac_state_Type>"
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
      (cl:setf (cl:slot-value msg 'reararm_sm) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frontarm_sm) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target_id) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_pos_X) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_pos_Y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_pos_Z) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_vel_X) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_vel_Y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_vel_Z) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_acc_X) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_acc_Y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_acc_Z) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'roadmarkline_pos_X) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'roadmarkline_pos_Y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'progress_place_count) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'progress_place_in_total) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'progress_collect_count) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'progress_collect_in_total) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sb_slider_position) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sb_cones_in_total) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sb_cones_in_stack) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sb_cones_in_stack)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616)))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sb_current_stack) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sb_current_stacklevel) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lb_left_slot) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lb_right_slot) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lr_lanterns_in_total) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lr_lanterns_in_stack) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lr_lanterns_in_stack)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616)))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lr_current_stack) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lr_current_stacklevel) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'rearDetectObjectInDeadZone) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rearDetectObjectInPlaceZoneRight) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rearDetectObjectInPlaceZoneCenter) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rearDetectObjectInPlaceZoneLeft) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rearDetectNonLockObjectInOperationZone) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ac_state_Type>)))
  "Returns string type for a message object of type '<ac_state_Type>"
  "roadbot_control/ac_state_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ac_state_Type)))
  "Returns string type for a message object of type 'ac_state_Type"
  "roadbot_control/ac_state_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ac_state_Type>)))
  "Returns md5sum for a message object of type '<ac_state_Type>"
  "ab807b4f227aecbfa526561d1e53b40a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ac_state_Type)))
  "Returns md5sum for a message object of type 'ac_state_Type"
  "ab807b4f227aecbfa526561d1e53b40a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ac_state_Type>)))
  "Returns full string definition for message of type '<ac_state_Type>"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Robot Arm State Machine states~%int64 reararm_sm~%int64 frontarm_sm~%~%# Robot Arm Target Lock states~%int64 target_id~%float64 target_pos_X~%float64 target_pos_Y~%float64 target_pos_Z~%float64 target_vel_X~%float64 target_vel_Y~%float64 target_vel_Z~%float64 target_acc_X~%float64 target_acc_Y~%float64 target_acc_Z~%~%# Robot Arm Line Track states~%float64 roadmarkline_pos_X~%float64 roadmarkline_pos_Y~%~%# Place and Collect progress~%int64 progress_place_count~%int64 progress_place_in_total~%int64 progress_collect_count~%int64 progress_collect_in_total~%~%# Cone Storage states~%int64 sb_slider_position~%int64 sb_cones_in_total~%int64[] sb_cones_in_stack~%int64 sb_current_stack~%int64 sb_current_stacklevel~%~%# Loading Bay States~%int64 lb_left_slot~%int64 lb_right_slot~%~%# Lanterns Rack States~%int64 lr_lanterns_in_total~%int64[] lr_lanterns_in_stack~%int64 lr_current_stack~%int64 lr_current_stacklevel~%~%# Rear blockage detection~%bool rearDetectObjectInDeadZone~%bool rearDetectObjectInPlaceZoneRight~%bool rearDetectObjectInPlaceZoneCenter~%bool rearDetectObjectInPlaceZoneLeft~%bool rearDetectNonLockObjectInOperationZone~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ac_state_Type)))
  "Returns full string definition for message of type 'ac_state_Type"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Robot Arm State Machine states~%int64 reararm_sm~%int64 frontarm_sm~%~%# Robot Arm Target Lock states~%int64 target_id~%float64 target_pos_X~%float64 target_pos_Y~%float64 target_pos_Z~%float64 target_vel_X~%float64 target_vel_Y~%float64 target_vel_Z~%float64 target_acc_X~%float64 target_acc_Y~%float64 target_acc_Z~%~%# Robot Arm Line Track states~%float64 roadmarkline_pos_X~%float64 roadmarkline_pos_Y~%~%# Place and Collect progress~%int64 progress_place_count~%int64 progress_place_in_total~%int64 progress_collect_count~%int64 progress_collect_in_total~%~%# Cone Storage states~%int64 sb_slider_position~%int64 sb_cones_in_total~%int64[] sb_cones_in_stack~%int64 sb_current_stack~%int64 sb_current_stacklevel~%~%# Loading Bay States~%int64 lb_left_slot~%int64 lb_right_slot~%~%# Lanterns Rack States~%int64 lr_lanterns_in_total~%int64[] lr_lanterns_in_stack~%int64 lr_current_stack~%int64 lr_current_stacklevel~%~%# Rear blockage detection~%bool rearDetectObjectInDeadZone~%bool rearDetectObjectInPlaceZoneRight~%bool rearDetectObjectInPlaceZoneCenter~%bool rearDetectObjectInPlaceZoneLeft~%bool rearDetectNonLockObjectInOperationZone~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ac_state_Type>))
  (cl:+ 0
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sb_cones_in_stack) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
     8
     8
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lr_lanterns_in_stack) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
     8
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ac_state_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'ac_state_Type
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':reararm_sm (reararm_sm msg))
    (cl:cons ':frontarm_sm (frontarm_sm msg))
    (cl:cons ':target_id (target_id msg))
    (cl:cons ':target_pos_X (target_pos_X msg))
    (cl:cons ':target_pos_Y (target_pos_Y msg))
    (cl:cons ':target_pos_Z (target_pos_Z msg))
    (cl:cons ':target_vel_X (target_vel_X msg))
    (cl:cons ':target_vel_Y (target_vel_Y msg))
    (cl:cons ':target_vel_Z (target_vel_Z msg))
    (cl:cons ':target_acc_X (target_acc_X msg))
    (cl:cons ':target_acc_Y (target_acc_Y msg))
    (cl:cons ':target_acc_Z (target_acc_Z msg))
    (cl:cons ':roadmarkline_pos_X (roadmarkline_pos_X msg))
    (cl:cons ':roadmarkline_pos_Y (roadmarkline_pos_Y msg))
    (cl:cons ':progress_place_count (progress_place_count msg))
    (cl:cons ':progress_place_in_total (progress_place_in_total msg))
    (cl:cons ':progress_collect_count (progress_collect_count msg))
    (cl:cons ':progress_collect_in_total (progress_collect_in_total msg))
    (cl:cons ':sb_slider_position (sb_slider_position msg))
    (cl:cons ':sb_cones_in_total (sb_cones_in_total msg))
    (cl:cons ':sb_cones_in_stack (sb_cones_in_stack msg))
    (cl:cons ':sb_current_stack (sb_current_stack msg))
    (cl:cons ':sb_current_stacklevel (sb_current_stacklevel msg))
    (cl:cons ':lb_left_slot (lb_left_slot msg))
    (cl:cons ':lb_right_slot (lb_right_slot msg))
    (cl:cons ':lr_lanterns_in_total (lr_lanterns_in_total msg))
    (cl:cons ':lr_lanterns_in_stack (lr_lanterns_in_stack msg))
    (cl:cons ':lr_current_stack (lr_current_stack msg))
    (cl:cons ':lr_current_stacklevel (lr_current_stacklevel msg))
    (cl:cons ':rearDetectObjectInDeadZone (rearDetectObjectInDeadZone msg))
    (cl:cons ':rearDetectObjectInPlaceZoneRight (rearDetectObjectInPlaceZoneRight msg))
    (cl:cons ':rearDetectObjectInPlaceZoneCenter (rearDetectObjectInPlaceZoneCenter msg))
    (cl:cons ':rearDetectObjectInPlaceZoneLeft (rearDetectObjectInPlaceZoneLeft msg))
    (cl:cons ':rearDetectNonLockObjectInOperationZone (rearDetectNonLockObjectInOperationZone msg))
))
