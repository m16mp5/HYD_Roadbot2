;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_robot_state_Type)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_robot_state_Type (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_ROBOT_STATE_TYPE")
  (make-package "KUKA_ROBOT::KR_ROBOT_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude kr_robot_state_Type.msg.html


(defclass kuka_robot::kr_robot_state_Type
  :super ros::object
  :slots (_timestamp _pos_setpt _axis_setpt _pos_fb _axis_fb _dist_next _vel_act _vel_axis_act _curr_act _mot_temp _brake_sig _com_action _com_motstop _com_last_mot_time _com_di_port_value _com_do_port_value _com_error_no _com_alarm_normal _com_move_enable _com_autext_start _mode_op _ov_pro _power_fail _safety_sw _err ))

(defmethod kuka_robot::kr_robot_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:pos_setpt __pos_setpt) (instance kuka_robot::kr_pose_Type :init))
    ((:axis_setpt __axis_setpt) (instance kuka_robot::kr_joint_Type :init))
    ((:pos_fb __pos_fb) (instance kuka_robot::kr_pose_Type :init))
    ((:axis_fb __axis_fb) (instance kuka_robot::kr_joint_Type :init))
    ((:dist_next __dist_next) 0.0)
    ((:vel_act __vel_act) 0.0)
    ((:vel_axis_act __vel_axis_act) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:curr_act __curr_act) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:mot_temp __mot_temp) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:brake_sig __brake_sig) 0)
    ((:com_action __com_action) 0)
    ((:com_motstop __com_motstop) 0)
    ((:com_last_mot_time __com_last_mot_time) 0)
    ((:com_di_port_value __com_di_port_value) 0)
    ((:com_do_port_value __com_do_port_value) 0)
    ((:com_error_no __com_error_no) 0)
    ((:com_alarm_normal __com_alarm_normal) nil)
    ((:com_move_enable __com_move_enable) nil)
    ((:com_autext_start __com_autext_start) nil)
    ((:mode_op __mode_op) "")
    ((:ov_pro __ov_pro) 0)
    ((:power_fail __power_fail) nil)
    ((:safety_sw __safety_sw) "")
    ((:err __err) (instance kuka_robot::kr_robot_error_Type :init))
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _pos_setpt __pos_setpt)
   (setq _axis_setpt __axis_setpt)
   (setq _pos_fb __pos_fb)
   (setq _axis_fb __axis_fb)
   (setq _dist_next (float __dist_next))
   (setq _vel_act (float __vel_act))
   (setq _vel_axis_act __vel_axis_act)
   (setq _curr_act __curr_act)
   (setq _mot_temp __mot_temp)
   (setq _brake_sig (round __brake_sig))
   (setq _com_action (round __com_action))
   (setq _com_motstop (round __com_motstop))
   (setq _com_last_mot_time (round __com_last_mot_time))
   (setq _com_di_port_value (round __com_di_port_value))
   (setq _com_do_port_value (round __com_do_port_value))
   (setq _com_error_no (round __com_error_no))
   (setq _com_alarm_normal __com_alarm_normal)
   (setq _com_move_enable __com_move_enable)
   (setq _com_autext_start __com_autext_start)
   (setq _mode_op (string __mode_op))
   (setq _ov_pro (round __ov_pro))
   (setq _power_fail __power_fail)
   (setq _safety_sw (string __safety_sw))
   (setq _err __err)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:pos_setpt
   (&rest __pos_setpt)
   (if (keywordp (car __pos_setpt))
       (send* _pos_setpt __pos_setpt)
     (progn
       (if __pos_setpt (setq _pos_setpt (car __pos_setpt)))
       _pos_setpt)))
  (:axis_setpt
   (&rest __axis_setpt)
   (if (keywordp (car __axis_setpt))
       (send* _axis_setpt __axis_setpt)
     (progn
       (if __axis_setpt (setq _axis_setpt (car __axis_setpt)))
       _axis_setpt)))
  (:pos_fb
   (&rest __pos_fb)
   (if (keywordp (car __pos_fb))
       (send* _pos_fb __pos_fb)
     (progn
       (if __pos_fb (setq _pos_fb (car __pos_fb)))
       _pos_fb)))
  (:axis_fb
   (&rest __axis_fb)
   (if (keywordp (car __axis_fb))
       (send* _axis_fb __axis_fb)
     (progn
       (if __axis_fb (setq _axis_fb (car __axis_fb)))
       _axis_fb)))
  (:dist_next
   (&optional __dist_next)
   (if __dist_next (setq _dist_next __dist_next)) _dist_next)
  (:vel_act
   (&optional __vel_act)
   (if __vel_act (setq _vel_act __vel_act)) _vel_act)
  (:vel_axis_act
   (&optional __vel_axis_act)
   (if __vel_axis_act (setq _vel_axis_act __vel_axis_act)) _vel_axis_act)
  (:curr_act
   (&optional __curr_act)
   (if __curr_act (setq _curr_act __curr_act)) _curr_act)
  (:mot_temp
   (&optional __mot_temp)
   (if __mot_temp (setq _mot_temp __mot_temp)) _mot_temp)
  (:brake_sig
   (&optional __brake_sig)
   (if __brake_sig (setq _brake_sig __brake_sig)) _brake_sig)
  (:com_action
   (&optional __com_action)
   (if __com_action (setq _com_action __com_action)) _com_action)
  (:com_motstop
   (&optional __com_motstop)
   (if __com_motstop (setq _com_motstop __com_motstop)) _com_motstop)
  (:com_last_mot_time
   (&optional __com_last_mot_time)
   (if __com_last_mot_time (setq _com_last_mot_time __com_last_mot_time)) _com_last_mot_time)
  (:com_di_port_value
   (&optional __com_di_port_value)
   (if __com_di_port_value (setq _com_di_port_value __com_di_port_value)) _com_di_port_value)
  (:com_do_port_value
   (&optional __com_do_port_value)
   (if __com_do_port_value (setq _com_do_port_value __com_do_port_value)) _com_do_port_value)
  (:com_error_no
   (&optional __com_error_no)
   (if __com_error_no (setq _com_error_no __com_error_no)) _com_error_no)
  (:com_alarm_normal
   (&optional __com_alarm_normal)
   (if __com_alarm_normal (setq _com_alarm_normal __com_alarm_normal)) _com_alarm_normal)
  (:com_move_enable
   (&optional __com_move_enable)
   (if __com_move_enable (setq _com_move_enable __com_move_enable)) _com_move_enable)
  (:com_autext_start
   (&optional __com_autext_start)
   (if __com_autext_start (setq _com_autext_start __com_autext_start)) _com_autext_start)
  (:mode_op
   (&optional __mode_op)
   (if __mode_op (setq _mode_op __mode_op)) _mode_op)
  (:ov_pro
   (&optional __ov_pro)
   (if __ov_pro (setq _ov_pro __ov_pro)) _ov_pro)
  (:power_fail
   (&optional __power_fail)
   (if __power_fail (setq _power_fail __power_fail)) _power_fail)
  (:safety_sw
   (&optional __safety_sw)
   (if __safety_sw (setq _safety_sw __safety_sw)) _safety_sw)
  (:err
   (&rest __err)
   (if (keywordp (car __err))
       (send* _err __err)
     (progn
       (if __err (setq _err (car __err)))
       _err)))
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; kuka_robot/kr_pose_Type _pos_setpt
    (send _pos_setpt :serialization-length)
    ;; kuka_robot/kr_joint_Type _axis_setpt
    (send _axis_setpt :serialization-length)
    ;; kuka_robot/kr_pose_Type _pos_fb
    (send _pos_fb :serialization-length)
    ;; kuka_robot/kr_joint_Type _axis_fb
    (send _axis_fb :serialization-length)
    ;; float64 _dist_next
    8
    ;; float64 _vel_act
    8
    ;; float64[6] _vel_axis_act
    (* 8    6)
    ;; float64[6] _curr_act
    (* 8    6)
    ;; float64[6] _mot_temp
    (* 8    6)
    ;; int64 _brake_sig
    8
    ;; int64 _com_action
    8
    ;; int64 _com_motstop
    8
    ;; int64 _com_last_mot_time
    8
    ;; int64 _com_di_port_value
    8
    ;; int64 _com_do_port_value
    8
    ;; int64 _com_error_no
    8
    ;; bool _com_alarm_normal
    1
    ;; bool _com_move_enable
    1
    ;; bool _com_autext_start
    1
    ;; string _mode_op
    4 (length _mode_op)
    ;; int64 _ov_pro
    8
    ;; bool _power_fail
    1
    ;; string _safety_sw
    4 (length _safety_sw)
    ;; kuka_robot/kr_robot_error_Type _err
    (send _err :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; kuka_robot/kr_pose_Type _pos_setpt
       (send _pos_setpt :serialize s)
     ;; kuka_robot/kr_joint_Type _axis_setpt
       (send _axis_setpt :serialize s)
     ;; kuka_robot/kr_pose_Type _pos_fb
       (send _pos_fb :serialize s)
     ;; kuka_robot/kr_joint_Type _axis_fb
       (send _axis_fb :serialize s)
     ;; float64 _dist_next
       (sys::poke _dist_next (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_act
       (sys::poke _vel_act (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[6] _vel_axis_act
     (dotimes (i 6)
       (sys::poke (elt _vel_axis_act i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[6] _curr_act
     (dotimes (i 6)
       (sys::poke (elt _curr_act i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[6] _mot_temp
     (dotimes (i 6)
       (sys::poke (elt _mot_temp i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; int64 _brake_sig
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _brake_sig (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _brake_sig) (= (length (_brake_sig . bv)) 2)) ;; bignum
              (write-long (ash (elt (_brake_sig . bv) 0) 0) s)
              (write-long (ash (elt (_brake_sig . bv) 1) -1) s))
             ((and (class _brake_sig) (= (length (_brake_sig . bv)) 1)) ;; big1
              (write-long (elt (_brake_sig . bv) 0) s)
              (write-long (if (>= _brake_sig 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _brake_sig s)(write-long (if (>= _brake_sig 0) 0 #xffffffff) s)))
     ;; int64 _com_action
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _com_action (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _com_action) (= (length (_com_action . bv)) 2)) ;; bignum
              (write-long (ash (elt (_com_action . bv) 0) 0) s)
              (write-long (ash (elt (_com_action . bv) 1) -1) s))
             ((and (class _com_action) (= (length (_com_action . bv)) 1)) ;; big1
              (write-long (elt (_com_action . bv) 0) s)
              (write-long (if (>= _com_action 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _com_action s)(write-long (if (>= _com_action 0) 0 #xffffffff) s)))
     ;; int64 _com_motstop
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _com_motstop (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _com_motstop) (= (length (_com_motstop . bv)) 2)) ;; bignum
              (write-long (ash (elt (_com_motstop . bv) 0) 0) s)
              (write-long (ash (elt (_com_motstop . bv) 1) -1) s))
             ((and (class _com_motstop) (= (length (_com_motstop . bv)) 1)) ;; big1
              (write-long (elt (_com_motstop . bv) 0) s)
              (write-long (if (>= _com_motstop 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _com_motstop s)(write-long (if (>= _com_motstop 0) 0 #xffffffff) s)))
     ;; int64 _com_last_mot_time
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _com_last_mot_time (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _com_last_mot_time) (= (length (_com_last_mot_time . bv)) 2)) ;; bignum
              (write-long (ash (elt (_com_last_mot_time . bv) 0) 0) s)
              (write-long (ash (elt (_com_last_mot_time . bv) 1) -1) s))
             ((and (class _com_last_mot_time) (= (length (_com_last_mot_time . bv)) 1)) ;; big1
              (write-long (elt (_com_last_mot_time . bv) 0) s)
              (write-long (if (>= _com_last_mot_time 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _com_last_mot_time s)(write-long (if (>= _com_last_mot_time 0) 0 #xffffffff) s)))
     ;; int64 _com_di_port_value
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _com_di_port_value (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _com_di_port_value) (= (length (_com_di_port_value . bv)) 2)) ;; bignum
              (write-long (ash (elt (_com_di_port_value . bv) 0) 0) s)
              (write-long (ash (elt (_com_di_port_value . bv) 1) -1) s))
             ((and (class _com_di_port_value) (= (length (_com_di_port_value . bv)) 1)) ;; big1
              (write-long (elt (_com_di_port_value . bv) 0) s)
              (write-long (if (>= _com_di_port_value 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _com_di_port_value s)(write-long (if (>= _com_di_port_value 0) 0 #xffffffff) s)))
     ;; int64 _com_do_port_value
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _com_do_port_value (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _com_do_port_value) (= (length (_com_do_port_value . bv)) 2)) ;; bignum
              (write-long (ash (elt (_com_do_port_value . bv) 0) 0) s)
              (write-long (ash (elt (_com_do_port_value . bv) 1) -1) s))
             ((and (class _com_do_port_value) (= (length (_com_do_port_value . bv)) 1)) ;; big1
              (write-long (elt (_com_do_port_value . bv) 0) s)
              (write-long (if (>= _com_do_port_value 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _com_do_port_value s)(write-long (if (>= _com_do_port_value 0) 0 #xffffffff) s)))
     ;; int64 _com_error_no
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _com_error_no (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _com_error_no) (= (length (_com_error_no . bv)) 2)) ;; bignum
              (write-long (ash (elt (_com_error_no . bv) 0) 0) s)
              (write-long (ash (elt (_com_error_no . bv) 1) -1) s))
             ((and (class _com_error_no) (= (length (_com_error_no . bv)) 1)) ;; big1
              (write-long (elt (_com_error_no . bv) 0) s)
              (write-long (if (>= _com_error_no 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _com_error_no s)(write-long (if (>= _com_error_no 0) 0 #xffffffff) s)))
     ;; bool _com_alarm_normal
       (if _com_alarm_normal (write-byte -1 s) (write-byte 0 s))
     ;; bool _com_move_enable
       (if _com_move_enable (write-byte -1 s) (write-byte 0 s))
     ;; bool _com_autext_start
       (if _com_autext_start (write-byte -1 s) (write-byte 0 s))
     ;; string _mode_op
       (write-long (length _mode_op) s) (princ _mode_op s)
     ;; int64 _ov_pro
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ov_pro (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ov_pro) (= (length (_ov_pro . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ov_pro . bv) 0) 0) s)
              (write-long (ash (elt (_ov_pro . bv) 1) -1) s))
             ((and (class _ov_pro) (= (length (_ov_pro . bv)) 1)) ;; big1
              (write-long (elt (_ov_pro . bv) 0) s)
              (write-long (if (>= _ov_pro 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ov_pro s)(write-long (if (>= _ov_pro 0) 0 #xffffffff) s)))
     ;; bool _power_fail
       (if _power_fail (write-byte -1 s) (write-byte 0 s))
     ;; string _safety_sw
       (write-long (length _safety_sw) s) (princ _safety_sw s)
     ;; kuka_robot/kr_robot_error_Type _err
       (send _err :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; kuka_robot/kr_pose_Type _pos_setpt
     (send _pos_setpt :deserialize buf ptr-) (incf ptr- (send _pos_setpt :serialization-length))
   ;; kuka_robot/kr_joint_Type _axis_setpt
     (send _axis_setpt :deserialize buf ptr-) (incf ptr- (send _axis_setpt :serialization-length))
   ;; kuka_robot/kr_pose_Type _pos_fb
     (send _pos_fb :deserialize buf ptr-) (incf ptr- (send _pos_fb :serialization-length))
   ;; kuka_robot/kr_joint_Type _axis_fb
     (send _axis_fb :deserialize buf ptr-) (incf ptr- (send _axis_fb :serialization-length))
   ;; float64 _dist_next
     (setq _dist_next (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_act
     (setq _vel_act (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[6] _vel_axis_act
   (dotimes (i (length _vel_axis_act))
     (setf (elt _vel_axis_act i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[6] _curr_act
   (dotimes (i (length _curr_act))
     (setf (elt _curr_act i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[6] _mot_temp
   (dotimes (i (length _mot_temp))
     (setf (elt _mot_temp i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; int64 _brake_sig
#+(or :alpha :irix6 :x86_64)
      (setf _brake_sig (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _brake_sig (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _com_action
#+(or :alpha :irix6 :x86_64)
      (setf _com_action (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _com_action (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _com_motstop
#+(or :alpha :irix6 :x86_64)
      (setf _com_motstop (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _com_motstop (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _com_last_mot_time
#+(or :alpha :irix6 :x86_64)
      (setf _com_last_mot_time (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _com_last_mot_time (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _com_di_port_value
#+(or :alpha :irix6 :x86_64)
      (setf _com_di_port_value (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _com_di_port_value (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _com_do_port_value
#+(or :alpha :irix6 :x86_64)
      (setf _com_do_port_value (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _com_do_port_value (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _com_error_no
#+(or :alpha :irix6 :x86_64)
      (setf _com_error_no (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _com_error_no (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _com_alarm_normal
     (setq _com_alarm_normal (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _com_move_enable
     (setq _com_move_enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _com_autext_start
     (setq _com_autext_start (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mode_op
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode_op (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int64 _ov_pro
#+(or :alpha :irix6 :x86_64)
      (setf _ov_pro (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ov_pro (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _power_fail
     (setq _power_fail (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _safety_sw
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _safety_sw (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; kuka_robot/kr_robot_error_Type _err
     (send _err :deserialize buf ptr-) (incf ptr- (send _err :serialization-length))
   ;;
   self)
  )

(setf (get kuka_robot::kr_robot_state_Type :md5sum-) "52f44fa93866f06da1a2394c1fd725bd")
(setf (get kuka_robot::kr_robot_state_Type :datatype-) "kuka_robot/kr_robot_state_Type")
(setf (get kuka_robot::kr_robot_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# Pose setpoint [mm, c]
kuka_robot/kr_pose_Type pos_setpt

# Joints setpoint [c]
kuka_robot/kr_joint_Type axis_setpt

# Pose feedback [mm, c]
kuka_robot/kr_pose_Type pos_fb

# Joints feedback [c]
kuka_robot/kr_joint_Type axis_fb

# Distance next [mm]
float64 dist_next

# Velocity act [mm]
float64 vel_act

# Axis velocity act [c/s, 0-A1...5-A6]
float64[6] vel_axis_act

# Axis current act [%, 0-A1...5-A6]
float64[6] curr_act

# Axis motor temperature [c, 0-A1...5-A6]
float64[6] mot_temp

# Motor brake [bitwise, 0-braked 1-released]
int64 brake_sig

# Command action number [0-idle, xx-moving]
int64 com_action

# Command motion stop state [0-resume, 1-paused, 2-canceling]
int64 com_motstop

# Command motion (last one) elapsed time [mm]
int64 com_last_mot_time

# Command signal input port state [bitwise]
int64 com_di_port_value

# Command signal output port state [bitwise]
int64 com_do_port_value


# Slow update. Command error number [0~xxxx]
int64 com_error_no

# Slow update. Command alarm state normal [true/false]
bool com_alarm_normal

# Slow update. Command signal move enable (to stop auto external mode) [true/false]
bool com_move_enable

# Slow update. Command signal auto external mode start [true/false]
bool com_autext_start

# Slow update. Operation mode status [#T1/#T2/#AUT/#EX]
string mode_op

# Slow update. Overrided speed scale [%, 0~100]
int64 ov_pro

# Slow update. Power failure status [true/false]
bool power_fail

# Slow update. Safety switch status [#PRESSED/#RELEASED]
string safety_sw

# Slow update. Error status
kuka_robot/kr_robot_error_Type err



================================================================================
MSG: kuka_robot/kr_pose_Type
# XYZ coordinate [mm]
float64 X
float64 Y
float64 Z
# ABC orientation [mm]
float64 A
float64 B
float64 C
# Status and Turn [unit]
float64 S
float64 T

================================================================================
MSG: kuka_robot/kr_joint_Type
# Joint Angles [degree]
float64 A1
float64 A2
float64 A3
float64 A4
float64 A5
float64 A6


================================================================================
MSG: kuka_robot/kr_robot_error_Type
# Error number
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



(provide :kuka_robot/kr_robot_state_Type "52f44fa93866f06da1a2394c1fd725bd")


