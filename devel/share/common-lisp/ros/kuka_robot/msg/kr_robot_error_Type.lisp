; Auto-generated. Do not edit!


(cl:in-package kuka_robot-msg)


;//! \htmlinclude kr_robot_error_Type.msg.html

(cl:defclass <kr_robot_error_Type> (roslisp-msg-protocol:ros-message)
  ((number
    :reader number
    :initarg :number
    :type cl:integer
    :initform 0)
   (interpreter
    :reader interpreter
    :initarg :interpreter
    :type cl:string
    :initform "")
   (int_type
    :reader int_type
    :initarg :int_type
    :type cl:string
    :initform "")
   (int_prio
    :reader int_prio
    :initarg :int_prio
    :type cl:integer
    :initform 0)
   (line_nr
    :reader line_nr
    :initarg :line_nr
    :type cl:integer
    :initform 0)
   (module
    :reader module
    :initarg :module
    :type cl:string
    :initform "")
   (up_name
    :reader up_name
    :initarg :up_name
    :type cl:string
    :initform "")
   (trigger_type
    :reader trigger_type
    :initarg :trigger_type
    :type cl:string
    :initform ""))
)

(cl:defclass kr_robot_error_Type (<kr_robot_error_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_robot_error_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_robot_error_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-msg:<kr_robot_error_Type> is deprecated: use kuka_robot-msg:kr_robot_error_Type instead.")))

(cl:ensure-generic-function 'number-val :lambda-list '(m))
(cl:defmethod number-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:number-val is deprecated.  Use kuka_robot-msg:number instead.")
  (number m))

(cl:ensure-generic-function 'interpreter-val :lambda-list '(m))
(cl:defmethod interpreter-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:interpreter-val is deprecated.  Use kuka_robot-msg:interpreter instead.")
  (interpreter m))

(cl:ensure-generic-function 'int_type-val :lambda-list '(m))
(cl:defmethod int_type-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:int_type-val is deprecated.  Use kuka_robot-msg:int_type instead.")
  (int_type m))

(cl:ensure-generic-function 'int_prio-val :lambda-list '(m))
(cl:defmethod int_prio-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:int_prio-val is deprecated.  Use kuka_robot-msg:int_prio instead.")
  (int_prio m))

(cl:ensure-generic-function 'line_nr-val :lambda-list '(m))
(cl:defmethod line_nr-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:line_nr-val is deprecated.  Use kuka_robot-msg:line_nr instead.")
  (line_nr m))

(cl:ensure-generic-function 'module-val :lambda-list '(m))
(cl:defmethod module-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:module-val is deprecated.  Use kuka_robot-msg:module instead.")
  (module m))

(cl:ensure-generic-function 'up_name-val :lambda-list '(m))
(cl:defmethod up_name-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:up_name-val is deprecated.  Use kuka_robot-msg:up_name instead.")
  (up_name m))

(cl:ensure-generic-function 'trigger_type-val :lambda-list '(m))
(cl:defmethod trigger_type-val ((m <kr_robot_error_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:trigger_type-val is deprecated.  Use kuka_robot-msg:trigger_type instead.")
  (trigger_type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_robot_error_Type>) ostream)
  "Serializes a message object of type '<kr_robot_error_Type>"
  (cl:let* ((signed (cl:slot-value msg 'number)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'interpreter))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'interpreter))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'int_type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'int_type))
  (cl:let* ((signed (cl:slot-value msg 'int_prio)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'line_nr)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'module))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'module))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'up_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'up_name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'trigger_type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'trigger_type))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_robot_error_Type>) istream)
  "Deserializes a message object of type '<kr_robot_error_Type>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'number) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'interpreter) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'interpreter) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'int_type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'int_type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'int_prio) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'line_nr) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'module) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'module) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'up_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'up_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'trigger_type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'trigger_type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_robot_error_Type>)))
  "Returns string type for a message object of type '<kr_robot_error_Type>"
  "kuka_robot/kr_robot_error_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_robot_error_Type)))
  "Returns string type for a message object of type 'kr_robot_error_Type"
  "kuka_robot/kr_robot_error_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_robot_error_Type>)))
  "Returns md5sum for a message object of type '<kr_robot_error_Type>"
  "14c7fac1baea6ae7d763b4c80cd47929")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_robot_error_Type)))
  "Returns md5sum for a message object of type 'kr_robot_error_Type"
  "14c7fac1baea6ae7d763b4c80cd47929")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_robot_error_Type>)))
  "Returns full string definition for message of type '<kr_robot_error_Type>"
  (cl:format cl:nil "# Error number~%int64 number~%~%# R_INT~%string interpreter~%~%# I_NORMAL~%string int_type~%~%# Prio~%int64 int_prio~%~%# Line number~%int64 line_nr~%~%# Module name~%string module~%~%# Up name~%string up_name~%~%# TRG_NONE~%string trigger_type~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_robot_error_Type)))
  "Returns full string definition for message of type 'kr_robot_error_Type"
  (cl:format cl:nil "# Error number~%int64 number~%~%# R_INT~%string interpreter~%~%# I_NORMAL~%string int_type~%~%# Prio~%int64 int_prio~%~%# Line number~%int64 line_nr~%~%# Module name~%string module~%~%# Up name~%string up_name~%~%# TRG_NONE~%string trigger_type~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_robot_error_Type>))
  (cl:+ 0
     8
     4 (cl:length (cl:slot-value msg 'interpreter))
     4 (cl:length (cl:slot-value msg 'int_type))
     8
     8
     4 (cl:length (cl:slot-value msg 'module))
     4 (cl:length (cl:slot-value msg 'up_name))
     4 (cl:length (cl:slot-value msg 'trigger_type))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_robot_error_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_robot_error_Type
    (cl:cons ':number (number msg))
    (cl:cons ':interpreter (interpreter msg))
    (cl:cons ':int_type (int_type msg))
    (cl:cons ':int_prio (int_prio msg))
    (cl:cons ':line_nr (line_nr msg))
    (cl:cons ':module (module msg))
    (cl:cons ':up_name (up_name msg))
    (cl:cons ':trigger_type (trigger_type msg))
))
