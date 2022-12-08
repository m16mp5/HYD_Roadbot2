; Auto-generated. Do not edit!


(cl:in-package kuka_robot-msg)


;//! \htmlinclude kr_robot_state_Type.msg.html

(cl:defclass <kr_robot_state_Type> (roslisp-msg-protocol:ros-message)
  ((timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:float
    :initform 0.0)
   (pos_setpt
    :reader pos_setpt
    :initarg :pos_setpt
    :type kuka_robot-msg:kr_pose_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_pose_Type))
   (axis_setpt
    :reader axis_setpt
    :initarg :axis_setpt
    :type kuka_robot-msg:kr_joint_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_joint_Type))
   (pos_fb
    :reader pos_fb
    :initarg :pos_fb
    :type kuka_robot-msg:kr_pose_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_pose_Type))
   (axis_fb
    :reader axis_fb
    :initarg :axis_fb
    :type kuka_robot-msg:kr_joint_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_joint_Type))
   (dist_next
    :reader dist_next
    :initarg :dist_next
    :type cl:float
    :initform 0.0)
   (vel_act
    :reader vel_act
    :initarg :vel_act
    :type cl:float
    :initform 0.0)
   (vel_axis_act
    :reader vel_axis_act
    :initarg :vel_axis_act
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0))
   (curr_act
    :reader curr_act
    :initarg :curr_act
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0))
   (mot_temp
    :reader mot_temp
    :initarg :mot_temp
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0))
   (brake_sig
    :reader brake_sig
    :initarg :brake_sig
    :type cl:integer
    :initform 0)
   (com_action
    :reader com_action
    :initarg :com_action
    :type cl:integer
    :initform 0)
   (com_motstop
    :reader com_motstop
    :initarg :com_motstop
    :type cl:integer
    :initform 0)
   (com_last_mot_time
    :reader com_last_mot_time
    :initarg :com_last_mot_time
    :type cl:integer
    :initform 0)
   (com_di_port_value
    :reader com_di_port_value
    :initarg :com_di_port_value
    :type cl:integer
    :initform 0)
   (com_do_port_value
    :reader com_do_port_value
    :initarg :com_do_port_value
    :type cl:integer
    :initform 0)
   (com_error_no
    :reader com_error_no
    :initarg :com_error_no
    :type cl:integer
    :initform 0)
   (com_alarm_normal
    :reader com_alarm_normal
    :initarg :com_alarm_normal
    :type cl:boolean
    :initform cl:nil)
   (com_move_enable
    :reader com_move_enable
    :initarg :com_move_enable
    :type cl:boolean
    :initform cl:nil)
   (com_autext_start
    :reader com_autext_start
    :initarg :com_autext_start
    :type cl:boolean
    :initform cl:nil)
   (mode_op
    :reader mode_op
    :initarg :mode_op
    :type cl:string
    :initform "")
   (ov_pro
    :reader ov_pro
    :initarg :ov_pro
    :type cl:integer
    :initform 0)
   (power_fail
    :reader power_fail
    :initarg :power_fail
    :type cl:boolean
    :initform cl:nil)
   (safety_sw
    :reader safety_sw
    :initarg :safety_sw
    :type cl:string
    :initform "")
   (err
    :reader err
    :initarg :err
    :type kuka_robot-msg:kr_robot_error_Type
    :initform (cl:make-instance 'kuka_robot-msg:kr_robot_error_Type)))
)

(cl:defclass kr_robot_state_Type (<kr_robot_state_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_robot_state_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_robot_state_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-msg:<kr_robot_state_Type> is deprecated: use kuka_robot-msg:kr_robot_state_Type instead.")))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:timestamp-val is deprecated.  Use kuka_robot-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'pos_setpt-val :lambda-list '(m))
(cl:defmethod pos_setpt-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:pos_setpt-val is deprecated.  Use kuka_robot-msg:pos_setpt instead.")
  (pos_setpt m))

(cl:ensure-generic-function 'axis_setpt-val :lambda-list '(m))
(cl:defmethod axis_setpt-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:axis_setpt-val is deprecated.  Use kuka_robot-msg:axis_setpt instead.")
  (axis_setpt m))

(cl:ensure-generic-function 'pos_fb-val :lambda-list '(m))
(cl:defmethod pos_fb-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:pos_fb-val is deprecated.  Use kuka_robot-msg:pos_fb instead.")
  (pos_fb m))

(cl:ensure-generic-function 'axis_fb-val :lambda-list '(m))
(cl:defmethod axis_fb-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:axis_fb-val is deprecated.  Use kuka_robot-msg:axis_fb instead.")
  (axis_fb m))

(cl:ensure-generic-function 'dist_next-val :lambda-list '(m))
(cl:defmethod dist_next-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:dist_next-val is deprecated.  Use kuka_robot-msg:dist_next instead.")
  (dist_next m))

(cl:ensure-generic-function 'vel_act-val :lambda-list '(m))
(cl:defmethod vel_act-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:vel_act-val is deprecated.  Use kuka_robot-msg:vel_act instead.")
  (vel_act m))

(cl:ensure-generic-function 'vel_axis_act-val :lambda-list '(m))
(cl:defmethod vel_axis_act-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:vel_axis_act-val is deprecated.  Use kuka_robot-msg:vel_axis_act instead.")
  (vel_axis_act m))

(cl:ensure-generic-function 'curr_act-val :lambda-list '(m))
(cl:defmethod curr_act-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:curr_act-val is deprecated.  Use kuka_robot-msg:curr_act instead.")
  (curr_act m))

(cl:ensure-generic-function 'mot_temp-val :lambda-list '(m))
(cl:defmethod mot_temp-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:mot_temp-val is deprecated.  Use kuka_robot-msg:mot_temp instead.")
  (mot_temp m))

(cl:ensure-generic-function 'brake_sig-val :lambda-list '(m))
(cl:defmethod brake_sig-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:brake_sig-val is deprecated.  Use kuka_robot-msg:brake_sig instead.")
  (brake_sig m))

(cl:ensure-generic-function 'com_action-val :lambda-list '(m))
(cl:defmethod com_action-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_action-val is deprecated.  Use kuka_robot-msg:com_action instead.")
  (com_action m))

(cl:ensure-generic-function 'com_motstop-val :lambda-list '(m))
(cl:defmethod com_motstop-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_motstop-val is deprecated.  Use kuka_robot-msg:com_motstop instead.")
  (com_motstop m))

(cl:ensure-generic-function 'com_last_mot_time-val :lambda-list '(m))
(cl:defmethod com_last_mot_time-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_last_mot_time-val is deprecated.  Use kuka_robot-msg:com_last_mot_time instead.")
  (com_last_mot_time m))

(cl:ensure-generic-function 'com_di_port_value-val :lambda-list '(m))
(cl:defmethod com_di_port_value-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_di_port_value-val is deprecated.  Use kuka_robot-msg:com_di_port_value instead.")
  (com_di_port_value m))

(cl:ensure-generic-function 'com_do_port_value-val :lambda-list '(m))
(cl:defmethod com_do_port_value-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_do_port_value-val is deprecated.  Use kuka_robot-msg:com_do_port_value instead.")
  (com_do_port_value m))

(cl:ensure-generic-function 'com_error_no-val :lambda-list '(m))
(cl:defmethod com_error_no-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_error_no-val is deprecated.  Use kuka_robot-msg:com_error_no instead.")
  (com_error_no m))

(cl:ensure-generic-function 'com_alarm_normal-val :lambda-list '(m))
(cl:defmethod com_alarm_normal-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_alarm_normal-val is deprecated.  Use kuka_robot-msg:com_alarm_normal instead.")
  (com_alarm_normal m))

(cl:ensure-generic-function 'com_move_enable-val :lambda-list '(m))
(cl:defmethod com_move_enable-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_move_enable-val is deprecated.  Use kuka_robot-msg:com_move_enable instead.")
  (com_move_enable m))

(cl:ensure-generic-function 'com_autext_start-val :lambda-list '(m))
(cl:defmethod com_autext_start-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:com_autext_start-val is deprecated.  Use kuka_robot-msg:com_autext_start instead.")
  (com_autext_start m))

(cl:ensure-generic-function 'mode_op-val :lambda-list '(m))
(cl:defmethod mode_op-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:mode_op-val is deprecated.  Use kuka_robot-msg:mode_op instead.")
  (mode_op m))

(cl:ensure-generic-function 'ov_pro-val :lambda-list '(m))
(cl:defmethod ov_pro-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:ov_pro-val is deprecated.  Use kuka_robot-msg:ov_pro instead.")
  (ov_pro m))

(cl:ensure-generic-function 'power_fail-val :lambda-list '(m))
(cl:defmethod power_fail-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:power_fail-val is deprecated.  Use kuka_robot-msg:power_fail instead.")
  (power_fail m))

(cl:ensure-generic-function 'safety_sw-val :lambda-list '(m))
(cl:defmethod safety_sw-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:safety_sw-val is deprecated.  Use kuka_robot-msg:safety_sw instead.")
  (safety_sw m))

(cl:ensure-generic-function 'err-val :lambda-list '(m))
(cl:defmethod err-val ((m <kr_robot_state_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:err-val is deprecated.  Use kuka_robot-msg:err instead.")
  (err m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_robot_state_Type>) ostream)
  "Serializes a message object of type '<kr_robot_state_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pos_setpt) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'axis_setpt) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pos_fb) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'axis_fb) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'dist_next))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'vel_act))))
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
   (cl:slot-value msg 'vel_axis_act))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'curr_act))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'mot_temp))
  (cl:let* ((signed (cl:slot-value msg 'brake_sig)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'com_action)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'com_motstop)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'com_last_mot_time)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'com_di_port_value)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'com_do_port_value)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'com_error_no)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'com_alarm_normal) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'com_move_enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'com_autext_start) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode_op))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode_op))
  (cl:let* ((signed (cl:slot-value msg 'ov_pro)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'power_fail) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'safety_sw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'safety_sw))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'err) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_robot_state_Type>) istream)
  "Deserializes a message object of type '<kr_robot_state_Type>"
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
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pos_setpt) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'axis_setpt) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pos_fb) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'axis_fb) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist_next) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vel_act) (roslisp-utils:decode-double-float-bits bits)))
  (cl:setf (cl:slot-value msg 'vel_axis_act) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'vel_axis_act)))
    (cl:dotimes (i 6)
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
  (cl:setf (cl:slot-value msg 'curr_act) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'curr_act)))
    (cl:dotimes (i 6)
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
  (cl:setf (cl:slot-value msg 'mot_temp) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'mot_temp)))
    (cl:dotimes (i 6)
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'brake_sig) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'com_action) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'com_motstop) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'com_last_mot_time) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'com_di_port_value) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'com_do_port_value) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'com_error_no) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'com_alarm_normal) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'com_move_enable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'com_autext_start) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode_op) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode_op) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ov_pro) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'power_fail) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'safety_sw) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'safety_sw) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'err) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_robot_state_Type>)))
  "Returns string type for a message object of type '<kr_robot_state_Type>"
  "kuka_robot/kr_robot_state_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_robot_state_Type)))
  "Returns string type for a message object of type 'kr_robot_state_Type"
  "kuka_robot/kr_robot_state_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_robot_state_Type>)))
  "Returns md5sum for a message object of type '<kr_robot_state_Type>"
  "52f44fa93866f06da1a2394c1fd725bd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_robot_state_Type)))
  "Returns md5sum for a message object of type 'kr_robot_state_Type"
  "52f44fa93866f06da1a2394c1fd725bd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_robot_state_Type>)))
  "Returns full string definition for message of type '<kr_robot_state_Type>"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Pose setpoint [mm, c]~%kuka_robot/kr_pose_Type pos_setpt~%~%# Joints setpoint [c]~%kuka_robot/kr_joint_Type axis_setpt~%~%# Pose feedback [mm, c]~%kuka_robot/kr_pose_Type pos_fb~%~%# Joints feedback [c]~%kuka_robot/kr_joint_Type axis_fb~%~%# Distance next [mm]~%float64 dist_next~%~%# Velocity act [mm]~%float64 vel_act~%~%# Axis velocity act [c/s, 0-A1...5-A6]~%float64[6] vel_axis_act~%~%# Axis current act [%, 0-A1...5-A6]~%float64[6] curr_act~%~%# Axis motor temperature [c, 0-A1...5-A6]~%float64[6] mot_temp~%~%# Motor brake [bitwise, 0-braked 1-released]~%int64 brake_sig~%~%# Command action number [0-idle, xx-moving]~%int64 com_action~%~%# Command motion stop state [0-resume, 1-paused, 2-canceling]~%int64 com_motstop~%~%# Command motion (last one) elapsed time [mm]~%int64 com_last_mot_time~%~%# Command signal input port state [bitwise]~%int64 com_di_port_value~%~%# Command signal output port state [bitwise]~%int64 com_do_port_value~%~%~%# Slow update. Command error number [0~~xxxx]~%int64 com_error_no~%~%# Slow update. Command alarm state normal [true/false]~%bool com_alarm_normal~%~%# Slow update. Command signal move enable (to stop auto external mode) [true/false]~%bool com_move_enable~%~%# Slow update. Command signal auto external mode start [true/false]~%bool com_autext_start~%~%# Slow update. Operation mode status [#T1/#T2/#AUT/#EX]~%string mode_op~%~%# Slow update. Overrided speed scale [%, 0~~100]~%int64 ov_pro~%~%# Slow update. Power failure status [true/false]~%bool power_fail~%~%# Slow update. Safety switch status [#PRESSED/#RELEASED]~%string safety_sw~%~%# Slow update. Error status~%kuka_robot/kr_robot_error_Type err~%~%~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%================================================================================~%MSG: kuka_robot/kr_joint_Type~%# Joint Angles [degree]~%float64 A1~%float64 A2~%float64 A3~%float64 A4~%float64 A5~%float64 A6~%~%~%================================================================================~%MSG: kuka_robot/kr_robot_error_Type~%# Error number~%int64 number~%~%# R_INT~%string interpreter~%~%# I_NORMAL~%string int_type~%~%# Prio~%int64 int_prio~%~%# Line number~%int64 line_nr~%~%# Module name~%string module~%~%# Up name~%string up_name~%~%# TRG_NONE~%string trigger_type~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_robot_state_Type)))
  "Returns full string definition for message of type 'kr_robot_state_Type"
  (cl:format cl:nil "# Timestamp [s]~%float64 timestamp~%~%# Pose setpoint [mm, c]~%kuka_robot/kr_pose_Type pos_setpt~%~%# Joints setpoint [c]~%kuka_robot/kr_joint_Type axis_setpt~%~%# Pose feedback [mm, c]~%kuka_robot/kr_pose_Type pos_fb~%~%# Joints feedback [c]~%kuka_robot/kr_joint_Type axis_fb~%~%# Distance next [mm]~%float64 dist_next~%~%# Velocity act [mm]~%float64 vel_act~%~%# Axis velocity act [c/s, 0-A1...5-A6]~%float64[6] vel_axis_act~%~%# Axis current act [%, 0-A1...5-A6]~%float64[6] curr_act~%~%# Axis motor temperature [c, 0-A1...5-A6]~%float64[6] mot_temp~%~%# Motor brake [bitwise, 0-braked 1-released]~%int64 brake_sig~%~%# Command action number [0-idle, xx-moving]~%int64 com_action~%~%# Command motion stop state [0-resume, 1-paused, 2-canceling]~%int64 com_motstop~%~%# Command motion (last one) elapsed time [mm]~%int64 com_last_mot_time~%~%# Command signal input port state [bitwise]~%int64 com_di_port_value~%~%# Command signal output port state [bitwise]~%int64 com_do_port_value~%~%~%# Slow update. Command error number [0~~xxxx]~%int64 com_error_no~%~%# Slow update. Command alarm state normal [true/false]~%bool com_alarm_normal~%~%# Slow update. Command signal move enable (to stop auto external mode) [true/false]~%bool com_move_enable~%~%# Slow update. Command signal auto external mode start [true/false]~%bool com_autext_start~%~%# Slow update. Operation mode status [#T1/#T2/#AUT/#EX]~%string mode_op~%~%# Slow update. Overrided speed scale [%, 0~~100]~%int64 ov_pro~%~%# Slow update. Power failure status [true/false]~%bool power_fail~%~%# Slow update. Safety switch status [#PRESSED/#RELEASED]~%string safety_sw~%~%# Slow update. Error status~%kuka_robot/kr_robot_error_Type err~%~%~%~%================================================================================~%MSG: kuka_robot/kr_pose_Type~%# XYZ coordinate [mm]~%float64 X~%float64 Y~%float64 Z~%# ABC orientation [mm]~%float64 A~%float64 B~%float64 C~%# Status and Turn [unit]~%float64 S~%float64 T~%~%================================================================================~%MSG: kuka_robot/kr_joint_Type~%# Joint Angles [degree]~%float64 A1~%float64 A2~%float64 A3~%float64 A4~%float64 A5~%float64 A6~%~%~%================================================================================~%MSG: kuka_robot/kr_robot_error_Type~%# Error number~%int64 number~%~%# R_INT~%string interpreter~%~%# I_NORMAL~%string int_type~%~%# Prio~%int64 int_prio~%~%# Line number~%int64 line_nr~%~%# Module name~%string module~%~%# Up name~%string up_name~%~%# TRG_NONE~%string trigger_type~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_robot_state_Type>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pos_setpt))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'axis_setpt))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pos_fb))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'axis_fb))
     8
     8
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'vel_axis_act) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'curr_act) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'mot_temp) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
     8
     8
     8
     8
     8
     8
     1
     1
     1
     4 (cl:length (cl:slot-value msg 'mode_op))
     8
     1
     4 (cl:length (cl:slot-value msg 'safety_sw))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'err))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_robot_state_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_robot_state_Type
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':pos_setpt (pos_setpt msg))
    (cl:cons ':axis_setpt (axis_setpt msg))
    (cl:cons ':pos_fb (pos_fb msg))
    (cl:cons ':axis_fb (axis_fb msg))
    (cl:cons ':dist_next (dist_next msg))
    (cl:cons ':vel_act (vel_act msg))
    (cl:cons ':vel_axis_act (vel_axis_act msg))
    (cl:cons ':curr_act (curr_act msg))
    (cl:cons ':mot_temp (mot_temp msg))
    (cl:cons ':brake_sig (brake_sig msg))
    (cl:cons ':com_action (com_action msg))
    (cl:cons ':com_motstop (com_motstop msg))
    (cl:cons ':com_last_mot_time (com_last_mot_time msg))
    (cl:cons ':com_di_port_value (com_di_port_value msg))
    (cl:cons ':com_do_port_value (com_do_port_value msg))
    (cl:cons ':com_error_no (com_error_no msg))
    (cl:cons ':com_alarm_normal (com_alarm_normal msg))
    (cl:cons ':com_move_enable (com_move_enable msg))
    (cl:cons ':com_autext_start (com_autext_start msg))
    (cl:cons ':mode_op (mode_op msg))
    (cl:cons ':ov_pro (ov_pro msg))
    (cl:cons ':power_fail (power_fail msg))
    (cl:cons ':safety_sw (safety_sw msg))
    (cl:cons ':err (err msg))
))
