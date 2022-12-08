; Auto-generated. Do not edit!


(cl:in-package kuka_robot-msg)


;//! \htmlinclude kr_joint_Type.msg.html

(cl:defclass <kr_joint_Type> (roslisp-msg-protocol:ros-message)
  ((A1
    :reader A1
    :initarg :A1
    :type cl:float
    :initform 0.0)
   (A2
    :reader A2
    :initarg :A2
    :type cl:float
    :initform 0.0)
   (A3
    :reader A3
    :initarg :A3
    :type cl:float
    :initform 0.0)
   (A4
    :reader A4
    :initarg :A4
    :type cl:float
    :initform 0.0)
   (A5
    :reader A5
    :initarg :A5
    :type cl:float
    :initform 0.0)
   (A6
    :reader A6
    :initarg :A6
    :type cl:float
    :initform 0.0))
)

(cl:defclass kr_joint_Type (<kr_joint_Type>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <kr_joint_Type>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'kr_joint_Type)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name kuka_robot-msg:<kr_joint_Type> is deprecated: use kuka_robot-msg:kr_joint_Type instead.")))

(cl:ensure-generic-function 'A1-val :lambda-list '(m))
(cl:defmethod A1-val ((m <kr_joint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:A1-val is deprecated.  Use kuka_robot-msg:A1 instead.")
  (A1 m))

(cl:ensure-generic-function 'A2-val :lambda-list '(m))
(cl:defmethod A2-val ((m <kr_joint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:A2-val is deprecated.  Use kuka_robot-msg:A2 instead.")
  (A2 m))

(cl:ensure-generic-function 'A3-val :lambda-list '(m))
(cl:defmethod A3-val ((m <kr_joint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:A3-val is deprecated.  Use kuka_robot-msg:A3 instead.")
  (A3 m))

(cl:ensure-generic-function 'A4-val :lambda-list '(m))
(cl:defmethod A4-val ((m <kr_joint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:A4-val is deprecated.  Use kuka_robot-msg:A4 instead.")
  (A4 m))

(cl:ensure-generic-function 'A5-val :lambda-list '(m))
(cl:defmethod A5-val ((m <kr_joint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:A5-val is deprecated.  Use kuka_robot-msg:A5 instead.")
  (A5 m))

(cl:ensure-generic-function 'A6-val :lambda-list '(m))
(cl:defmethod A6-val ((m <kr_joint_Type>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader kuka_robot-msg:A6-val is deprecated.  Use kuka_robot-msg:A6 instead.")
  (A6 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <kr_joint_Type>) ostream)
  "Serializes a message object of type '<kr_joint_Type>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'A1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'A2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'A3))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'A4))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'A5))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'A6))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <kr_joint_Type>) istream)
  "Deserializes a message object of type '<kr_joint_Type>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'A1) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'A2) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'A3) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'A4) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'A5) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'A6) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<kr_joint_Type>)))
  "Returns string type for a message object of type '<kr_joint_Type>"
  "kuka_robot/kr_joint_Type")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'kr_joint_Type)))
  "Returns string type for a message object of type 'kr_joint_Type"
  "kuka_robot/kr_joint_Type")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<kr_joint_Type>)))
  "Returns md5sum for a message object of type '<kr_joint_Type>"
  "75a5288a21ef4ba3c22a3ba34b5bc48c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'kr_joint_Type)))
  "Returns md5sum for a message object of type 'kr_joint_Type"
  "75a5288a21ef4ba3c22a3ba34b5bc48c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<kr_joint_Type>)))
  "Returns full string definition for message of type '<kr_joint_Type>"
  (cl:format cl:nil "# Joint Angles [degree]~%float64 A1~%float64 A2~%float64 A3~%float64 A4~%float64 A5~%float64 A6~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'kr_joint_Type)))
  "Returns full string definition for message of type 'kr_joint_Type"
  (cl:format cl:nil "# Joint Angles [degree]~%float64 A1~%float64 A2~%float64 A3~%float64 A4~%float64 A5~%float64 A6~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <kr_joint_Type>))
  (cl:+ 0
     8
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <kr_joint_Type>))
  "Converts a ROS message object to a list"
  (cl:list 'kr_joint_Type
    (cl:cons ':A1 (A1 msg))
    (cl:cons ':A2 (A2 msg))
    (cl:cons ':A3 (A3 msg))
    (cl:cons ':A4 (A4 msg))
    (cl:cons ':A5 (A5 msg))
    (cl:cons ':A6 (A6 msg))
))
