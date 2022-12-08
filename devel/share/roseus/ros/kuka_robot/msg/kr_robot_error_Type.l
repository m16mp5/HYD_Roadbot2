;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_robot_error_Type)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_robot_error_Type (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_ROBOT_ERROR_TYPE")
  (make-package "KUKA_ROBOT::KR_ROBOT_ERROR_TYPE"))

(in-package "ROS")
;;//! \htmlinclude kr_robot_error_Type.msg.html


(defclass kuka_robot::kr_robot_error_Type
  :super ros::object
  :slots (_number _interpreter _int_type _int_prio _line_nr _module _up_name _trigger_type ))

(defmethod kuka_robot::kr_robot_error_Type
  (:init
   (&key
    ((:number __number) 0)
    ((:interpreter __interpreter) "")
    ((:int_type __int_type) "")
    ((:int_prio __int_prio) 0)
    ((:line_nr __line_nr) 0)
    ((:module __module) "")
    ((:up_name __up_name) "")
    ((:trigger_type __trigger_type) "")
    )
   (send-super :init)
   (setq _number (round __number))
   (setq _interpreter (string __interpreter))
   (setq _int_type (string __int_type))
   (setq _int_prio (round __int_prio))
   (setq _line_nr (round __line_nr))
   (setq _module (string __module))
   (setq _up_name (string __up_name))
   (setq _trigger_type (string __trigger_type))
   self)
  (:number
   (&optional __number)
   (if __number (setq _number __number)) _number)
  (:interpreter
   (&optional __interpreter)
   (if __interpreter (setq _interpreter __interpreter)) _interpreter)
  (:int_type
   (&optional __int_type)
   (if __int_type (setq _int_type __int_type)) _int_type)
  (:int_prio
   (&optional __int_prio)
   (if __int_prio (setq _int_prio __int_prio)) _int_prio)
  (:line_nr
   (&optional __line_nr)
   (if __line_nr (setq _line_nr __line_nr)) _line_nr)
  (:module
   (&optional __module)
   (if __module (setq _module __module)) _module)
  (:up_name
   (&optional __up_name)
   (if __up_name (setq _up_name __up_name)) _up_name)
  (:trigger_type
   (&optional __trigger_type)
   (if __trigger_type (setq _trigger_type __trigger_type)) _trigger_type)
  (:serialization-length
   ()
   (+
    ;; int64 _number
    8
    ;; string _interpreter
    4 (length _interpreter)
    ;; string _int_type
    4 (length _int_type)
    ;; int64 _int_prio
    8
    ;; int64 _line_nr
    8
    ;; string _module
    4 (length _module)
    ;; string _up_name
    4 (length _up_name)
    ;; string _trigger_type
    4 (length _trigger_type)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _number
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _number (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _number) (= (length (_number . bv)) 2)) ;; bignum
              (write-long (ash (elt (_number . bv) 0) 0) s)
              (write-long (ash (elt (_number . bv) 1) -1) s))
             ((and (class _number) (= (length (_number . bv)) 1)) ;; big1
              (write-long (elt (_number . bv) 0) s)
              (write-long (if (>= _number 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _number s)(write-long (if (>= _number 0) 0 #xffffffff) s)))
     ;; string _interpreter
       (write-long (length _interpreter) s) (princ _interpreter s)
     ;; string _int_type
       (write-long (length _int_type) s) (princ _int_type s)
     ;; int64 _int_prio
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _int_prio (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _int_prio) (= (length (_int_prio . bv)) 2)) ;; bignum
              (write-long (ash (elt (_int_prio . bv) 0) 0) s)
              (write-long (ash (elt (_int_prio . bv) 1) -1) s))
             ((and (class _int_prio) (= (length (_int_prio . bv)) 1)) ;; big1
              (write-long (elt (_int_prio . bv) 0) s)
              (write-long (if (>= _int_prio 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _int_prio s)(write-long (if (>= _int_prio 0) 0 #xffffffff) s)))
     ;; int64 _line_nr
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _line_nr (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _line_nr) (= (length (_line_nr . bv)) 2)) ;; bignum
              (write-long (ash (elt (_line_nr . bv) 0) 0) s)
              (write-long (ash (elt (_line_nr . bv) 1) -1) s))
             ((and (class _line_nr) (= (length (_line_nr . bv)) 1)) ;; big1
              (write-long (elt (_line_nr . bv) 0) s)
              (write-long (if (>= _line_nr 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _line_nr s)(write-long (if (>= _line_nr 0) 0 #xffffffff) s)))
     ;; string _module
       (write-long (length _module) s) (princ _module s)
     ;; string _up_name
       (write-long (length _up_name) s) (princ _up_name s)
     ;; string _trigger_type
       (write-long (length _trigger_type) s) (princ _trigger_type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _number
#+(or :alpha :irix6 :x86_64)
      (setf _number (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _number (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string _interpreter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _interpreter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _int_type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _int_type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int64 _int_prio
#+(or :alpha :irix6 :x86_64)
      (setf _int_prio (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _int_prio (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _line_nr
#+(or :alpha :irix6 :x86_64)
      (setf _line_nr (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _line_nr (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string _module
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _module (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _up_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _up_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _trigger_type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _trigger_type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get kuka_robot::kr_robot_error_Type :md5sum-) "14c7fac1baea6ae7d763b4c80cd47929")
(setf (get kuka_robot::kr_robot_error_Type :datatype-) "kuka_robot/kr_robot_error_Type")
(setf (get kuka_robot::kr_robot_error_Type :definition-)
      "# Error number
int64 number

# R_INT
string interpreter

# I_NORMAL
string int_type

# Prio
int64 int_prio

# Line number
int64 line_nr

# Module name
string module

# Up name
string up_name

# TRG_NONE
string trigger_type


")



(provide :kuka_robot/kr_robot_error_Type "14c7fac1baea6ae7d763b4c80cd47929")


