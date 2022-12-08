;; Auto-generated. Do not edit!


(when (boundp 'system_io::sio_state_Type)
  (if (not (find-package "SYSTEM_IO"))
    (make-package "SYSTEM_IO"))
  (shadow 'sio_state_Type (find-package "SYSTEM_IO")))
(unless (find-package "SYSTEM_IO::SIO_STATE_TYPE")
  (make-package "SYSTEM_IO::SIO_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude sio_state_Type.msg.html


(defclass system_io::sio_state_Type
  :super ros::object
  :slots (_timestamp _state _input_pin _output_pin _llb_has_cone _rlb_has_cone _rear_slider_down _cone_slider_extend _airpump_on _arrowlight_on ))

(defmethod system_io::sio_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:state __state) 0)
    ((:input_pin __input_pin) (make-array 18 :initial-element 0 :element-type :integer))
    ((:output_pin __output_pin) (make-array 18 :initial-element 0 :element-type :integer))
    ((:llb_has_cone __llb_has_cone) nil)
    ((:rlb_has_cone __rlb_has_cone) nil)
    ((:rear_slider_down __rear_slider_down) nil)
    ((:cone_slider_extend __cone_slider_extend) nil)
    ((:airpump_on __airpump_on) nil)
    ((:arrowlight_on __arrowlight_on) nil)
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _state (round __state))
   (setq _input_pin __input_pin)
   (setq _output_pin __output_pin)
   (setq _llb_has_cone __llb_has_cone)
   (setq _rlb_has_cone __rlb_has_cone)
   (setq _rear_slider_down __rear_slider_down)
   (setq _cone_slider_extend __cone_slider_extend)
   (setq _airpump_on __airpump_on)
   (setq _arrowlight_on __arrowlight_on)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:input_pin
   (&optional __input_pin)
   (if __input_pin (setq _input_pin __input_pin)) _input_pin)
  (:output_pin
   (&optional __output_pin)
   (if __output_pin (setq _output_pin __output_pin)) _output_pin)
  (:llb_has_cone
   (&optional __llb_has_cone)
   (if __llb_has_cone (setq _llb_has_cone __llb_has_cone)) _llb_has_cone)
  (:rlb_has_cone
   (&optional __rlb_has_cone)
   (if __rlb_has_cone (setq _rlb_has_cone __rlb_has_cone)) _rlb_has_cone)
  (:rear_slider_down
   (&optional __rear_slider_down)
   (if __rear_slider_down (setq _rear_slider_down __rear_slider_down)) _rear_slider_down)
  (:cone_slider_extend
   (&optional __cone_slider_extend)
   (if __cone_slider_extend (setq _cone_slider_extend __cone_slider_extend)) _cone_slider_extend)
  (:airpump_on
   (&optional __airpump_on)
   (if __airpump_on (setq _airpump_on __airpump_on)) _airpump_on)
  (:arrowlight_on
   (&optional __arrowlight_on)
   (if __arrowlight_on (setq _arrowlight_on __arrowlight_on)) _arrowlight_on)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; int64 _state
    8
    ;; int64[18] _input_pin
    (* 8    18)
    ;; int64[18] _output_pin
    (* 8    18)
    ;; bool _llb_has_cone
    1
    ;; bool _rlb_has_cone
    1
    ;; bool _rear_slider_down
    1
    ;; bool _cone_slider_extend
    1
    ;; bool _airpump_on
    1
    ;; bool _arrowlight_on
    1
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
     ;; int64[18] _input_pin
     (dotimes (i 18)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _input_pin i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _input_pin i)) (= (length ((elt _input_pin i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _input_pin i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _input_pin i) . bv) 1) -1) s))
             ((and (class (elt _input_pin i)) (= (length ((elt _input_pin i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _input_pin i) . bv) 0) s)
              (write-long (if (>= (elt _input_pin i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _input_pin i) s)(write-long (if (>= (elt _input_pin i) 0) 0 #xffffffff) s)))
       )
     ;; int64[18] _output_pin
     (dotimes (i 18)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _output_pin i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _output_pin i)) (= (length ((elt _output_pin i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _output_pin i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _output_pin i) . bv) 1) -1) s))
             ((and (class (elt _output_pin i)) (= (length ((elt _output_pin i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _output_pin i) . bv) 0) s)
              (write-long (if (>= (elt _output_pin i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _output_pin i) s)(write-long (if (>= (elt _output_pin i) 0) 0 #xffffffff) s)))
       )
     ;; bool _llb_has_cone
       (if _llb_has_cone (write-byte -1 s) (write-byte 0 s))
     ;; bool _rlb_has_cone
       (if _rlb_has_cone (write-byte -1 s) (write-byte 0 s))
     ;; bool _rear_slider_down
       (if _rear_slider_down (write-byte -1 s) (write-byte 0 s))
     ;; bool _cone_slider_extend
       (if _cone_slider_extend (write-byte -1 s) (write-byte 0 s))
     ;; bool _airpump_on
       (if _airpump_on (write-byte -1 s) (write-byte 0 s))
     ;; bool _arrowlight_on
       (if _arrowlight_on (write-byte -1 s) (write-byte 0 s))
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
   ;; int64[18] _input_pin
   (dotimes (i (length _input_pin))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _input_pin i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _input_pin i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; int64[18] _output_pin
   (dotimes (i (length _output_pin))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _output_pin i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _output_pin i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; bool _llb_has_cone
     (setq _llb_has_cone (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rlb_has_cone
     (setq _rlb_has_cone (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _rear_slider_down
     (setq _rear_slider_down (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _cone_slider_extend
     (setq _cone_slider_extend (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _airpump_on
     (setq _airpump_on (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _arrowlight_on
     (setq _arrowlight_on (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get system_io::sio_state_Type :md5sum-) "bb6f89f27eead6c5199e33a55449f841")
(setf (get system_io::sio_state_Type :datatype-) "system_io/sio_state_Type")
(setf (get system_io::sio_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# Ethernet IO raw states
int64 state
int64[18] input_pin
int64[18] output_pin

# LB states
bool llb_has_cone
bool rlb_has_cone

# slider switch states
bool rear_slider_down
bool cone_slider_extend

# air pump switch states
bool airpump_on

# arrow light switch states
bool arrowlight_on

")



(provide :system_io/sio_state_Type "bb6f89f27eead6c5199e33a55449f841")


