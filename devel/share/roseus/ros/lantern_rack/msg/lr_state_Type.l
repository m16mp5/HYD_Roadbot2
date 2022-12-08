;; Auto-generated. Do not edit!


(when (boundp 'lantern_rack::lr_state_Type)
  (if (not (find-package "LANTERN_RACK"))
    (make-package "LANTERN_RACK"))
  (shadow 'lr_state_Type (find-package "LANTERN_RACK")))
(unless (find-package "LANTERN_RACK::LR_STATE_TYPE")
  (make-package "LANTERN_RACK::LR_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude lr_state_Type.msg.html


(defclass lantern_rack::lr_state_Type
  :super ros::object
  :slots (_timestamp _state _mode _level _sensor_state ))

(defmethod lantern_rack::lr_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:state __state) 0)
    ((:mode __mode) (make-array 10 :initial-element 0 :element-type :integer))
    ((:level __level) (make-array 10 :initial-element 0 :element-type :integer))
    ((:sensor_state __sensor_state) (make-array 10 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _state (round __state))
   (setq _mode __mode)
   (setq _level __level)
   (setq _sensor_state __sensor_state)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:level
   (&optional __level)
   (if __level (setq _level __level)) _level)
  (:sensor_state
   (&optional __sensor_state)
   (if __sensor_state (setq _sensor_state __sensor_state)) _sensor_state)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; int64 _state
    8
    ;; int64[10] _mode
    (* 8    10)
    ;; int64[10] _level
    (* 8    10)
    ;; int64[10] _sensor_state
    (* 8    10)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _state
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _state (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _state) (= (length (_state . bv)) 2)) ;; bignum
              (write-long (ash (elt (_state . bv) 0) 0) s)
              (write-long (ash (elt (_state . bv) 1) -1) s))
             ((and (class _state) (= (length (_state . bv)) 1)) ;; big1
              (write-long (elt (_state . bv) 0) s)
              (write-long (if (>= _state 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _state s)(write-long (if (>= _state 0) 0 #xffffffff) s)))
     ;; int64[10] _mode
     (dotimes (i 10)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _mode i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _mode i)) (= (length ((elt _mode i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _mode i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _mode i) . bv) 1) -1) s))
             ((and (class (elt _mode i)) (= (length ((elt _mode i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _mode i) . bv) 0) s)
              (write-long (if (>= (elt _mode i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _mode i) s)(write-long (if (>= (elt _mode i) 0) 0 #xffffffff) s)))
       )
     ;; int64[10] _level
     (dotimes (i 10)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _level i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _level i)) (= (length ((elt _level i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _level i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _level i) . bv) 1) -1) s))
             ((and (class (elt _level i)) (= (length ((elt _level i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _level i) . bv) 0) s)
              (write-long (if (>= (elt _level i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _level i) s)(write-long (if (>= (elt _level i) 0) 0 #xffffffff) s)))
       )
     ;; int64[10] _sensor_state
     (dotimes (i 10)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _sensor_state i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _sensor_state i)) (= (length ((elt _sensor_state i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _sensor_state i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _sensor_state i) . bv) 1) -1) s))
             ((and (class (elt _sensor_state i)) (= (length ((elt _sensor_state i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _sensor_state i) . bv) 0) s)
              (write-long (if (>= (elt _sensor_state i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _sensor_state i) s)(write-long (if (>= (elt _sensor_state i) 0) 0 #xffffffff) s)))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _state
#+(or :alpha :irix6 :x86_64)
      (setf _state (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _state (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64[10] _mode
   (dotimes (i (length _mode))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _mode i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _mode i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; int64[10] _level
   (dotimes (i (length _level))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _level i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _level i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; int64[10] _sensor_state
   (dotimes (i (length _sensor_state))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _sensor_state i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _sensor_state i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;;
   self)
  )

(setf (get lantern_rack::lr_state_Type :md5sum-) "446242a7e9ff89a4043e4a4889335818")
(setf (get lantern_rack::lr_state_Type :datatype-) "lantern_rack/lr_state_Type")
(setf (get lantern_rack::lr_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# Lantern rack controller state
int64 state

# Lantern rack stack current working mode state [0-down 1-picking 2-filling 3-in trans]
int64[10] mode

# 10 Lantern rack stack level position
int64[10] level

# Lantern Racks sensor status
int64[10] sensor_state


")



(provide :lantern_rack/lr_state_Type "446242a7e9ff89a4043e4a4889335818")


