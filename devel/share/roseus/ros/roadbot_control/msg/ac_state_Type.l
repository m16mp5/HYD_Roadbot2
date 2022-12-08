;; Auto-generated. Do not edit!


(when (boundp 'roadbot_control::ac_state_Type)
  (if (not (find-package "ROADBOT_CONTROL"))
    (make-package "ROADBOT_CONTROL"))
  (shadow 'ac_state_Type (find-package "ROADBOT_CONTROL")))
(unless (find-package "ROADBOT_CONTROL::AC_STATE_TYPE")
  (make-package "ROADBOT_CONTROL::AC_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude ac_state_Type.msg.html


(defclass roadbot_control::ac_state_Type
  :super ros::object
  :slots (_timestamp _reararm_sm _frontarm_sm _target_id _target_pos_X _target_pos_Y _target_pos_Z _target_vel_X _target_vel_Y _target_vel_Z _target_acc_X _target_acc_Y _target_acc_Z _roadmarkline_pos_X _roadmarkline_pos_Y _progress_place_count _progress_place_in_total _progress_collect_count _progress_collect_in_total _sb_slider_position _sb_cones_in_total _sb_cones_in_stack _sb_current_stack _sb_current_stacklevel _lb_left_slot _lb_right_slot _lr_lanterns_in_total _lr_lanterns_in_stack _lr_current_stack _lr_current_stacklevel _rearDetectObjectInDeadZone _rearDetectObjectInPlaceZoneRight _rearDetectObjectInPlaceZoneCenter _rearDetectObjectInPlaceZoneLeft _rearDetectNonLockObjectInOperationZone ))

(defmethod roadbot_control::ac_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:reararm_sm __reararm_sm) 0)
    ((:frontarm_sm __frontarm_sm) 0)
    ((:target_id __target_id) 0)
    ((:target_pos_X __target_pos_X) 0.0)
    ((:target_pos_Y __target_pos_Y) 0.0)
    ((:target_pos_Z __target_pos_Z) 0.0)
    ((:target_vel_X __target_vel_X) 0.0)
    ((:target_vel_Y __target_vel_Y) 0.0)
    ((:target_vel_Z __target_vel_Z) 0.0)
    ((:target_acc_X __target_acc_X) 0.0)
    ((:target_acc_Y __target_acc_Y) 0.0)
    ((:target_acc_Z __target_acc_Z) 0.0)
    ((:roadmarkline_pos_X __roadmarkline_pos_X) 0.0)
    ((:roadmarkline_pos_Y __roadmarkline_pos_Y) 0.0)
    ((:progress_place_count __progress_place_count) 0)
    ((:progress_place_in_total __progress_place_in_total) 0)
    ((:progress_collect_count __progress_collect_count) 0)
    ((:progress_collect_in_total __progress_collect_in_total) 0)
    ((:sb_slider_position __sb_slider_position) 0)
    ((:sb_cones_in_total __sb_cones_in_total) 0)
    ((:sb_cones_in_stack __sb_cones_in_stack) (make-array 0 :initial-element 0 :element-type :integer))
    ((:sb_current_stack __sb_current_stack) 0)
    ((:sb_current_stacklevel __sb_current_stacklevel) 0)
    ((:lb_left_slot __lb_left_slot) 0)
    ((:lb_right_slot __lb_right_slot) 0)
    ((:lr_lanterns_in_total __lr_lanterns_in_total) 0)
    ((:lr_lanterns_in_stack __lr_lanterns_in_stack) (make-array 0 :initial-element 0 :element-type :integer))
    ((:lr_current_stack __lr_current_stack) 0)
    ((:lr_current_stacklevel __lr_current_stacklevel) 0)
    ((:rearDetectObjectInDeadZone __rearDetectObjectInDeadZone) nil)
    ((:rearDetectObjectInPlaceZoneRight __rearDetectObjectInPlaceZoneRight) nil)
    ((:rearDetectObjectInPlaceZoneCenter __rearDetectObjectInPlaceZoneCenter) nil)
    ((:rearDetectObjectInPlaceZoneLeft __rearDetectObjectInPlaceZoneLeft) nil)
    ((:rearDetectNonLockObjectInOperationZone __rearDetectNonLockObjectInOperationZone) nil)
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _reararm_sm (round __reararm_sm))
   (setq _frontarm_sm (round __frontarm_sm))
   (setq _target_id (round __target_id))
   (setq _target_pos_X (float __target_pos_X))
   (setq _target_pos_Y (float __target_pos_Y))
   (setq _target_pos_Z (float __target_pos_Z))
   (setq _target_vel_X (float __target_vel_X))
   (setq _target_vel_Y (float __target_vel_Y))
   (setq _target_vel_Z (float __target_vel_Z))
   (setq _target_acc_X (float __target_acc_X))
   (setq _target_acc_Y (float __target_acc_Y))
   (setq _target_acc_Z (float __target_acc_Z))
   (setq _roadmarkline_pos_X (float __roadmarkline_pos_X))
   (setq _roadmarkline_pos_Y (float __roadmarkline_pos_Y))
   (setq _progress_place_count (round __progress_place_count))
   (setq _progress_place_in_total (round __progress_place_in_total))
   (setq _progress_collect_count (round __progress_collect_count))
   (setq _progress_collect_in_total (round __progress_collect_in_total))
   (setq _sb_slider_position (round __sb_slider_position))
   (setq _sb_cones_in_total (round __sb_cones_in_total))
   (setq _sb_cones_in_stack __sb_cones_in_stack)
   (setq _sb_current_stack (round __sb_current_stack))
   (setq _sb_current_stacklevel (round __sb_current_stacklevel))
   (setq _lb_left_slot (round __lb_left_slot))
   (setq _lb_right_slot (round __lb_right_slot))
   (setq _lr_lanterns_in_total (round __lr_lanterns_in_total))
   (setq _lr_lanterns_in_stack __lr_lanterns_in_stack)
   (setq _lr_current_stack (round __lr_current_stack))
   (setq _lr_current_stacklevel (round __lr_current_stacklevel))
   (setq _rearDetectObjectInDeadZone __rearDetectObjectInDeadZone)
   (setq _rearDetectObjectInPlaceZoneRight __rearDetectObjectInPlaceZoneRight)
   (setq _rearDetectObjectInPlaceZoneCenter __rearDetectObjectInPlaceZoneCenter)
   (setq _rearDetectObjectInPlaceZoneLeft __rearDetectObjectInPlaceZoneLeft)
   (setq _rearDetectNonLockObjectInOperationZone __rearDetectNonLockObjectInOperationZone)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:reararm_sm
   (&optional __reararm_sm)
   (if __reararm_sm (setq _reararm_sm __reararm_sm)) _reararm_sm)
  (:frontarm_sm
   (&optional __frontarm_sm)
   (if __frontarm_sm (setq _frontarm_sm __frontarm_sm)) _frontarm_sm)
  (:target_id
   (&optional __target_id)
   (if __target_id (setq _target_id __target_id)) _target_id)
  (:target_pos_X
   (&optional __target_pos_X)
   (if __target_pos_X (setq _target_pos_X __target_pos_X)) _target_pos_X)
  (:target_pos_Y
   (&optional __target_pos_Y)
   (if __target_pos_Y (setq _target_pos_Y __target_pos_Y)) _target_pos_Y)
  (:target_pos_Z
   (&optional __target_pos_Z)
   (if __target_pos_Z (setq _target_pos_Z __target_pos_Z)) _target_pos_Z)
  (:target_vel_X
   (&optional __target_vel_X)
   (if __target_vel_X (setq _target_vel_X __target_vel_X)) _target_vel_X)
  (:target_vel_Y
   (&optional __target_vel_Y)
   (if __target_vel_Y (setq _target_vel_Y __target_vel_Y)) _target_vel_Y)
  (:target_vel_Z
   (&optional __target_vel_Z)
   (if __target_vel_Z (setq _target_vel_Z __target_vel_Z)) _target_vel_Z)
  (:target_acc_X
   (&optional __target_acc_X)
   (if __target_acc_X (setq _target_acc_X __target_acc_X)) _target_acc_X)
  (:target_acc_Y
   (&optional __target_acc_Y)
   (if __target_acc_Y (setq _target_acc_Y __target_acc_Y)) _target_acc_Y)
  (:target_acc_Z
   (&optional __target_acc_Z)
   (if __target_acc_Z (setq _target_acc_Z __target_acc_Z)) _target_acc_Z)
  (:roadmarkline_pos_X
   (&optional __roadmarkline_pos_X)
   (if __roadmarkline_pos_X (setq _roadmarkline_pos_X __roadmarkline_pos_X)) _roadmarkline_pos_X)
  (:roadmarkline_pos_Y
   (&optional __roadmarkline_pos_Y)
   (if __roadmarkline_pos_Y (setq _roadmarkline_pos_Y __roadmarkline_pos_Y)) _roadmarkline_pos_Y)
  (:progress_place_count
   (&optional __progress_place_count)
   (if __progress_place_count (setq _progress_place_count __progress_place_count)) _progress_place_count)
  (:progress_place_in_total
   (&optional __progress_place_in_total)
   (if __progress_place_in_total (setq _progress_place_in_total __progress_place_in_total)) _progress_place_in_total)
  (:progress_collect_count
   (&optional __progress_collect_count)
   (if __progress_collect_count (setq _progress_collect_count __progress_collect_count)) _progress_collect_count)
  (:progress_collect_in_total
   (&optional __progress_collect_in_total)
   (if __progress_collect_in_total (setq _progress_collect_in_total __progress_collect_in_total)) _progress_collect_in_total)
  (:sb_slider_position
   (&optional __sb_slider_position)
   (if __sb_slider_position (setq _sb_slider_position __sb_slider_position)) _sb_slider_position)
  (:sb_cones_in_total
   (&optional __sb_cones_in_total)
   (if __sb_cones_in_total (setq _sb_cones_in_total __sb_cones_in_total)) _sb_cones_in_total)
  (:sb_cones_in_stack
   (&optional __sb_cones_in_stack)
   (if __sb_cones_in_stack (setq _sb_cones_in_stack __sb_cones_in_stack)) _sb_cones_in_stack)
  (:sb_current_stack
   (&optional __sb_current_stack)
   (if __sb_current_stack (setq _sb_current_stack __sb_current_stack)) _sb_current_stack)
  (:sb_current_stacklevel
   (&optional __sb_current_stacklevel)
   (if __sb_current_stacklevel (setq _sb_current_stacklevel __sb_current_stacklevel)) _sb_current_stacklevel)
  (:lb_left_slot
   (&optional __lb_left_slot)
   (if __lb_left_slot (setq _lb_left_slot __lb_left_slot)) _lb_left_slot)
  (:lb_right_slot
   (&optional __lb_right_slot)
   (if __lb_right_slot (setq _lb_right_slot __lb_right_slot)) _lb_right_slot)
  (:lr_lanterns_in_total
   (&optional __lr_lanterns_in_total)
   (if __lr_lanterns_in_total (setq _lr_lanterns_in_total __lr_lanterns_in_total)) _lr_lanterns_in_total)
  (:lr_lanterns_in_stack
   (&optional __lr_lanterns_in_stack)
   (if __lr_lanterns_in_stack (setq _lr_lanterns_in_stack __lr_lanterns_in_stack)) _lr_lanterns_in_stack)
  (:lr_current_stack
   (&optional __lr_current_stack)
   (if __lr_current_stack (setq _lr_current_stack __lr_current_stack)) _lr_current_stack)
  (:lr_current_stacklevel
   (&optional __lr_current_stacklevel)
   (if __lr_current_stacklevel (setq _lr_current_stacklevel __lr_current_stacklevel)) _lr_current_stacklevel)
  (:rearDetectObjectInDeadZone
   (&optional __rearDetectObjectInDeadZone)
   (if __rearDetectObjectInDeadZone (setq _rearDetectObjectInDeadZone __rearDetectObjectInDeadZone)) _rearDetectObjectInDeadZone)
  (:rearDetectObjectInPlaceZoneRight
   (&optional __rearDetectObjectInPlaceZoneRight)
   (if __rearDetectObjectInPlaceZoneRight (setq _rearDetectObjectInPlaceZoneRight __rearDetectObjectInPlaceZoneRight)) _rearDetectObjectInPlaceZoneRight)
  (:rearDetectObjectInPlaceZoneCenter
   (&optional __rearDetectObjectInPlaceZoneCenter)
   (if __rearDetectObjectInPlaceZoneCenter (setq _rearDetectObjectInPlaceZoneCenter __rearDetectObjectInPlaceZoneCenter)) _rearDetectObjectInPlaceZoneCenter)
  (:rearDetectObjectInPlaceZoneLeft
   (&optional __rearDetectObjectInPlaceZoneLeft)
   (if __rearDetectObjectInPlaceZoneLeft (setq _rearDetectObjectInPlaceZoneLeft __rearDetectObjectInPlaceZoneLeft)) _rearDetectObjectInPlaceZoneLeft)
  (:rearDetectNonLockObjectInOperationZone
   (&optional __rearDetectNonLockObjectInOperationZone)
   (if __rearDetectNonLockObjectInOperationZone (setq _rearDetectNonLockObjectInOperationZone __rearDetectNonLockObjectInOperationZone)) _rearDetectNonLockObjectInOperationZone)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; int64 _reararm_sm
    8
    ;; int64 _frontarm_sm
    8
    ;; int64 _target_id
    8
    ;; float64 _target_pos_X
    8
    ;; float64 _target_pos_Y
    8
    ;; float64 _target_pos_Z
    8
    ;; float64 _target_vel_X
    8
    ;; float64 _target_vel_Y
    8
    ;; float64 _target_vel_Z
    8
    ;; float64 _target_acc_X
    8
    ;; float64 _target_acc_Y
    8
    ;; float64 _target_acc_Z
    8
    ;; float64 _roadmarkline_pos_X
    8
    ;; float64 _roadmarkline_pos_Y
    8
    ;; int64 _progress_place_count
    8
    ;; int64 _progress_place_in_total
    8
    ;; int64 _progress_collect_count
    8
    ;; int64 _progress_collect_in_total
    8
    ;; int64 _sb_slider_position
    8
    ;; int64 _sb_cones_in_total
    8
    ;; int64[] _sb_cones_in_stack
    (* 8    (length _sb_cones_in_stack)) 4
    ;; int64 _sb_current_stack
    8
    ;; int64 _sb_current_stacklevel
    8
    ;; int64 _lb_left_slot
    8
    ;; int64 _lb_right_slot
    8
    ;; int64 _lr_lanterns_in_total
    8
    ;; int64[] _lr_lanterns_in_stack
    (* 8    (length _lr_lanterns_in_stack)) 4
    ;; int64 _lr_current_stack
    8
    ;; int64 _lr_current_stacklevel
    8
    ;; bool _rearDetectObjectInDeadZone
    1
    ;; bool _rearDetectObjectInPlaceZoneRight
    1
    ;; bool _rearDetectObjectInPlaceZoneCenter
    1
    ;; bool _rearDetectObjectInPlaceZoneLeft
    1
    ;; bool _rearDetectNonLockObjectInOperationZone
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _reararm_sm
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _reararm_sm (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _reararm_sm) (= (length (_reararm_sm . bv)) 2)) ;; bignum
              (write-long (ash (elt (_reararm_sm . bv) 0) 0) s)
              (write-long (ash (elt (_reararm_sm . bv) 1) -1) s))
             ((and (class _reararm_sm) (= (length (_reararm_sm . bv)) 1)) ;; big1
              (write-long (elt (_reararm_sm . bv) 0) s)
              (write-long (if (>= _reararm_sm 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _reararm_sm s)(write-long (if (>= _reararm_sm 0) 0 #xffffffff) s)))
     ;; int64 _frontarm_sm
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _frontarm_sm (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _frontarm_sm) (= (length (_frontarm_sm . bv)) 2)) ;; bignum
              (write-long (ash (elt (_frontarm_sm . bv) 0) 0) s)
              (write-long (ash (elt (_frontarm_sm . bv) 1) -1) s))
             ((and (class _frontarm_sm) (= (length (_frontarm_sm . bv)) 1)) ;; big1
              (write-long (elt (_frontarm_sm . bv) 0) s)
              (write-long (if (>= _frontarm_sm 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _frontarm_sm s)(write-long (if (>= _frontarm_sm 0) 0 #xffffffff) s)))
     ;; int64 _target_id
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _target_id (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _target_id) (= (length (_target_id . bv)) 2)) ;; bignum
              (write-long (ash (elt (_target_id . bv) 0) 0) s)
              (write-long (ash (elt (_target_id . bv) 1) -1) s))
             ((and (class _target_id) (= (length (_target_id . bv)) 1)) ;; big1
              (write-long (elt (_target_id . bv) 0) s)
              (write-long (if (>= _target_id 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _target_id s)(write-long (if (>= _target_id 0) 0 #xffffffff) s)))
     ;; float64 _target_pos_X
       (sys::poke _target_pos_X (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_pos_Y
       (sys::poke _target_pos_Y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_pos_Z
       (sys::poke _target_pos_Z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_vel_X
       (sys::poke _target_vel_X (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_vel_Y
       (sys::poke _target_vel_Y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_vel_Z
       (sys::poke _target_vel_Z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_acc_X
       (sys::poke _target_acc_X (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_acc_Y
       (sys::poke _target_acc_Y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_acc_Z
       (sys::poke _target_acc_Z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _roadmarkline_pos_X
       (sys::poke _roadmarkline_pos_X (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _roadmarkline_pos_Y
       (sys::poke _roadmarkline_pos_Y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _progress_place_count
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _progress_place_count (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _progress_place_count) (= (length (_progress_place_count . bv)) 2)) ;; bignum
              (write-long (ash (elt (_progress_place_count . bv) 0) 0) s)
              (write-long (ash (elt (_progress_place_count . bv) 1) -1) s))
             ((and (class _progress_place_count) (= (length (_progress_place_count . bv)) 1)) ;; big1
              (write-long (elt (_progress_place_count . bv) 0) s)
              (write-long (if (>= _progress_place_count 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _progress_place_count s)(write-long (if (>= _progress_place_count 0) 0 #xffffffff) s)))
     ;; int64 _progress_place_in_total
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _progress_place_in_total (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _progress_place_in_total) (= (length (_progress_place_in_total . bv)) 2)) ;; bignum
              (write-long (ash (elt (_progress_place_in_total . bv) 0) 0) s)
              (write-long (ash (elt (_progress_place_in_total . bv) 1) -1) s))
             ((and (class _progress_place_in_total) (= (length (_progress_place_in_total . bv)) 1)) ;; big1
              (write-long (elt (_progress_place_in_total . bv) 0) s)
              (write-long (if (>= _progress_place_in_total 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _progress_place_in_total s)(write-long (if (>= _progress_place_in_total 0) 0 #xffffffff) s)))
     ;; int64 _progress_collect_count
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _progress_collect_count (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _progress_collect_count) (= (length (_progress_collect_count . bv)) 2)) ;; bignum
              (write-long (ash (elt (_progress_collect_count . bv) 0) 0) s)
              (write-long (ash (elt (_progress_collect_count . bv) 1) -1) s))
             ((and (class _progress_collect_count) (= (length (_progress_collect_count . bv)) 1)) ;; big1
              (write-long (elt (_progress_collect_count . bv) 0) s)
              (write-long (if (>= _progress_collect_count 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _progress_collect_count s)(write-long (if (>= _progress_collect_count 0) 0 #xffffffff) s)))
     ;; int64 _progress_collect_in_total
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _progress_collect_in_total (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _progress_collect_in_total) (= (length (_progress_collect_in_total . bv)) 2)) ;; bignum
              (write-long (ash (elt (_progress_collect_in_total . bv) 0) 0) s)
              (write-long (ash (elt (_progress_collect_in_total . bv) 1) -1) s))
             ((and (class _progress_collect_in_total) (= (length (_progress_collect_in_total . bv)) 1)) ;; big1
              (write-long (elt (_progress_collect_in_total . bv) 0) s)
              (write-long (if (>= _progress_collect_in_total 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _progress_collect_in_total s)(write-long (if (>= _progress_collect_in_total 0) 0 #xffffffff) s)))
     ;; int64 _sb_slider_position
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sb_slider_position (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sb_slider_position) (= (length (_sb_slider_position . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sb_slider_position . bv) 0) 0) s)
              (write-long (ash (elt (_sb_slider_position . bv) 1) -1) s))
             ((and (class _sb_slider_position) (= (length (_sb_slider_position . bv)) 1)) ;; big1
              (write-long (elt (_sb_slider_position . bv) 0) s)
              (write-long (if (>= _sb_slider_position 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sb_slider_position s)(write-long (if (>= _sb_slider_position 0) 0 #xffffffff) s)))
     ;; int64 _sb_cones_in_total
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sb_cones_in_total (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sb_cones_in_total) (= (length (_sb_cones_in_total . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sb_cones_in_total . bv) 0) 0) s)
              (write-long (ash (elt (_sb_cones_in_total . bv) 1) -1) s))
             ((and (class _sb_cones_in_total) (= (length (_sb_cones_in_total . bv)) 1)) ;; big1
              (write-long (elt (_sb_cones_in_total . bv) 0) s)
              (write-long (if (>= _sb_cones_in_total 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sb_cones_in_total s)(write-long (if (>= _sb_cones_in_total 0) 0 #xffffffff) s)))
     ;; int64[] _sb_cones_in_stack
     (write-long (length _sb_cones_in_stack) s)
     (dotimes (i (length _sb_cones_in_stack))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _sb_cones_in_stack i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _sb_cones_in_stack i)) (= (length ((elt _sb_cones_in_stack i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _sb_cones_in_stack i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _sb_cones_in_stack i) . bv) 1) -1) s))
             ((and (class (elt _sb_cones_in_stack i)) (= (length ((elt _sb_cones_in_stack i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _sb_cones_in_stack i) . bv) 0) s)
              (write-long (if (>= (elt _sb_cones_in_stack i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _sb_cones_in_stack i) s)(write-long (if (>= (elt _sb_cones_in_stack i) 0) 0 #xffffffff) s)))
       )
     ;; int64 _sb_current_stack
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sb_current_stack (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sb_current_stack) (= (length (_sb_current_stack . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sb_current_stack . bv) 0) 0) s)
              (write-long (ash (elt (_sb_current_stack . bv) 1) -1) s))
             ((and (class _sb_current_stack) (= (length (_sb_current_stack . bv)) 1)) ;; big1
              (write-long (elt (_sb_current_stack . bv) 0) s)
              (write-long (if (>= _sb_current_stack 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sb_current_stack s)(write-long (if (>= _sb_current_stack 0) 0 #xffffffff) s)))
     ;; int64 _sb_current_stacklevel
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sb_current_stacklevel (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sb_current_stacklevel) (= (length (_sb_current_stacklevel . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sb_current_stacklevel . bv) 0) 0) s)
              (write-long (ash (elt (_sb_current_stacklevel . bv) 1) -1) s))
             ((and (class _sb_current_stacklevel) (= (length (_sb_current_stacklevel . bv)) 1)) ;; big1
              (write-long (elt (_sb_current_stacklevel . bv) 0) s)
              (write-long (if (>= _sb_current_stacklevel 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sb_current_stacklevel s)(write-long (if (>= _sb_current_stacklevel 0) 0 #xffffffff) s)))
     ;; int64 _lb_left_slot
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lb_left_slot (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lb_left_slot) (= (length (_lb_left_slot . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lb_left_slot . bv) 0) 0) s)
              (write-long (ash (elt (_lb_left_slot . bv) 1) -1) s))
             ((and (class _lb_left_slot) (= (length (_lb_left_slot . bv)) 1)) ;; big1
              (write-long (elt (_lb_left_slot . bv) 0) s)
              (write-long (if (>= _lb_left_slot 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lb_left_slot s)(write-long (if (>= _lb_left_slot 0) 0 #xffffffff) s)))
     ;; int64 _lb_right_slot
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lb_right_slot (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lb_right_slot) (= (length (_lb_right_slot . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lb_right_slot . bv) 0) 0) s)
              (write-long (ash (elt (_lb_right_slot . bv) 1) -1) s))
             ((and (class _lb_right_slot) (= (length (_lb_right_slot . bv)) 1)) ;; big1
              (write-long (elt (_lb_right_slot . bv) 0) s)
              (write-long (if (>= _lb_right_slot 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lb_right_slot s)(write-long (if (>= _lb_right_slot 0) 0 #xffffffff) s)))
     ;; int64 _lr_lanterns_in_total
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lr_lanterns_in_total (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lr_lanterns_in_total) (= (length (_lr_lanterns_in_total . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lr_lanterns_in_total . bv) 0) 0) s)
              (write-long (ash (elt (_lr_lanterns_in_total . bv) 1) -1) s))
             ((and (class _lr_lanterns_in_total) (= (length (_lr_lanterns_in_total . bv)) 1)) ;; big1
              (write-long (elt (_lr_lanterns_in_total . bv) 0) s)
              (write-long (if (>= _lr_lanterns_in_total 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lr_lanterns_in_total s)(write-long (if (>= _lr_lanterns_in_total 0) 0 #xffffffff) s)))
     ;; int64[] _lr_lanterns_in_stack
     (write-long (length _lr_lanterns_in_stack) s)
     (dotimes (i (length _lr_lanterns_in_stack))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _lr_lanterns_in_stack i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _lr_lanterns_in_stack i)) (= (length ((elt _lr_lanterns_in_stack i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _lr_lanterns_in_stack i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _lr_lanterns_in_stack i) . bv) 1) -1) s))
             ((and (class (elt _lr_lanterns_in_stack i)) (= (length ((elt _lr_lanterns_in_stack i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _lr_lanterns_in_stack i) . bv) 0) s)
              (write-long (if (>= (elt _lr_lanterns_in_stack i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _lr_lanterns_in_stack i) s)(write-long (if (>= (elt _lr_lanterns_in_stack i) 0) 0 #xffffffff) s)))
       )
     ;; int64 _lr_current_stack
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lr_current_stack (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lr_current_stack) (= (length (_lr_current_stack . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lr_current_stack . bv) 0) 0) s)
              (write-long (ash (elt (_lr_current_stack . bv) 1) -1) s))
             ((and (class _lr_current_stack) (= (length (_lr_current_stack . bv)) 1)) ;; big1
              (write-long (elt (_lr_current_stack . bv) 0) s)
              (write-long (if (>= _lr_current_stack 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lr_current_stack s)(write-long (if (>= _lr_current_stack 0) 0 #xffffffff) s)))
     ;; int64 _lr_current_stacklevel
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lr_current_stacklevel (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lr_current_stacklevel) (= (length (_lr_current_stacklevel . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lr_current_stacklevel . bv) 0) 0) s)
              (write-long (ash (elt (_lr_current_stacklevel . bv) 1) -1) s))
             ((and (class _lr_current_stacklevel) (= (length (_lr_current_stacklevel . bv)) 1)) ;; big1
              (write-long (elt (_lr_current_stacklevel . bv) 0) s)
              (write-long (if (>= _lr_current_stacklevel 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lr_current_stacklevel s)(write-long (if (>= _lr_current_stacklevel 0) 0 #xffffffff) s)))
     ;; bool _rearDetectObjectInDeadZone
       (if _rearDetectObjectInDeadZone (write-byte -1 s) (write-byte 0 s))
     ;; bool _rearDetectObjectInPlaceZoneRight
       (if _rearDetectObjectInPlaceZoneRight (write-byte -1 s) (write-byte 0 s))
     ;; bool _rearDetectObjectInPlaceZoneCenter
       (if _rearDetectObjectInPlaceZoneCenter (write-byte -1 s) (write-byte 0 s))
     ;; bool _rearDetectObjectInPlaceZoneLeft
       (if _rearDetectObjectInPlaceZoneLeft (write-byte -1 s) (write-byte 0 s))
     ;; bool _rearDetectNonLockObjectInOperationZone
       (if _rearDetectNonLockObjectInOperationZone (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _reararm_sm
#+(or :alpha :irix6 :x86_64)
      (setf _reararm_sm (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _reararm_sm (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _frontarm_sm
#+(or :alpha :irix6 :x86_64)
      (setf _frontarm_sm (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _frontarm_sm (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _target_id
#+(or :alpha :irix6 :x86_64)
      (setf _target_id (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _target_id (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float64 _target_pos_X
     (setq _target_pos_X (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_pos_Y
     (setq _target_pos_Y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_pos_Z
     (setq _target_pos_Z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_vel_X
     (setq _target_vel_X (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_vel_Y
     (setq _target_vel_Y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_vel_Z
     (setq _target_vel_Z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_acc_X
     (setq _target_acc_X (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_acc_Y
     (setq _target_acc_Y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_acc_Z
     (setq _target_acc_Z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _roadmarkline_pos_X
     (setq _roadmarkline_pos_X (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _roadmarkline_pos_Y
     (setq _roadmarkline_pos_Y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _progress_place_count
#+(or :alpha :irix6 :x86_64)
      (setf _progress_place_count (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _progress_place_count (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _progress_place_in_total
#+(or :alpha :irix6 :x86_64)
      (setf _progress_place_in_total (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _progress_place_in_total (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _progress_collect_count
#+(or :alpha :irix6 :x86_64)
      (setf _progress_collect_count (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _progress_collect_count (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _progress_collect_in_total
#+(or :alpha :irix6 :x86_64)
      (setf _progress_collect_in_total (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _progress_collect_in_total (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _sb_slider_position
#+(or :alpha :irix6 :x86_64)
      (setf _sb_slider_position (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sb_slider_position (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _sb_cones_in_total
#+(or :alpha :irix6 :x86_64)
      (setf _sb_cones_in_total (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sb_cones_in_total (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64[] _sb_cones_in_stack
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sb_cones_in_stack (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _sb_cones_in_stack i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _sb_cones_in_stack i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64 _sb_current_stack
#+(or :alpha :irix6 :x86_64)
      (setf _sb_current_stack (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sb_current_stack (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _sb_current_stacklevel
#+(or :alpha :irix6 :x86_64)
      (setf _sb_current_stacklevel (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sb_current_stacklevel (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _lb_left_slot
#+(or :alpha :irix6 :x86_64)
      (setf _lb_left_slot (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lb_left_slot (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _lb_right_slot
#+(or :alpha :irix6 :x86_64)
      (setf _lb_right_slot (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lb_right_slot (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _lr_lanterns_in_total
#+(or :alpha :irix6 :x86_64)
      (setf _lr_lanterns_in_total (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lr_lanterns_in_total (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64[] _lr_lanterns_in_stack
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lr_lanterns_in_stack (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _lr_lanterns_in_stack i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _lr_lanterns_in_stack i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64 _lr_current_stack
#+(or :alpha :irix6 :x86_64)
      (setf _lr_current_stack (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lr_current_stack (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _lr_current_stacklevel
#+(or :alpha :irix6 :x86_64)
      (setf _lr_current_stacklevel (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lr_current_stacklevel (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _rearDetectObjectInDeadZone
     (setq _rearDetectObjectInDeadZone (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rearDetectObjectInPlaceZoneRight
     (setq _rearDetectObjectInPlaceZoneRight (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rearDetectObjectInPlaceZoneCenter
     (setq _rearDetectObjectInPlaceZoneCenter (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rearDetectObjectInPlaceZoneLeft
     (setq _rearDetectObjectInPlaceZoneLeft (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rearDetectNonLockObjectInOperationZone
     (setq _rearDetectNonLockObjectInOperationZone (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get roadbot_control::ac_state_Type :md5sum-) "ab807b4f227aecbfa526561d1e53b40a")
(setf (get roadbot_control::ac_state_Type :datatype-) "roadbot_control/ac_state_Type")
(setf (get roadbot_control::ac_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# Robot Arm State Machine states
int64 reararm_sm
int64 frontarm_sm

# Robot Arm Target Lock states
int64 target_id
float64 target_pos_X
float64 target_pos_Y
float64 target_pos_Z
float64 target_vel_X
float64 target_vel_Y
float64 target_vel_Z
float64 target_acc_X
float64 target_acc_Y
float64 target_acc_Z

# Robot Arm Line Track states
float64 roadmarkline_pos_X
float64 roadmarkline_pos_Y

# Place and Collect progress
int64 progress_place_count
int64 progress_place_in_total
int64 progress_collect_count
int64 progress_collect_in_total

# Cone Storage states
int64 sb_slider_position
int64 sb_cones_in_total
int64[] sb_cones_in_stack
int64 sb_current_stack
int64 sb_current_stacklevel

# Loading Bay States
int64 lb_left_slot
int64 lb_right_slot

# Lanterns Rack States
int64 lr_lanterns_in_total
int64[] lr_lanterns_in_stack
int64 lr_current_stack
int64 lr_current_stacklevel

# Rear blockage detection
bool rearDetectObjectInDeadZone
bool rearDetectObjectInPlaceZoneRight
bool rearDetectObjectInPlaceZoneCenter
bool rearDetectObjectInPlaceZoneLeft
bool rearDetectNonLockObjectInOperationZone


")



(provide :roadbot_control/ac_state_Type "ab807b4f227aecbfa526561d1e53b40a")


