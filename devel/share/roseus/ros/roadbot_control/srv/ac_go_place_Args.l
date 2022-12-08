;; Auto-generated. Do not edit!


(when (boundp 'roadbot_control::ac_go_place_Args)
  (if (not (find-package "ROADBOT_CONTROL"))
    (make-package "ROADBOT_CONTROL"))
  (shadow 'ac_go_place_Args (find-package "ROADBOT_CONTROL")))
(unless (find-package "ROADBOT_CONTROL::AC_GO_PLACE_ARGS")
  (make-package "ROADBOT_CONTROL::AC_GO_PLACE_ARGS"))
(unless (find-package "ROADBOT_CONTROL::AC_GO_PLACE_ARGSREQUEST")
  (make-package "ROADBOT_CONTROL::AC_GO_PLACE_ARGSREQUEST"))
(unless (find-package "ROADBOT_CONTROL::AC_GO_PLACE_ARGSRESPONSE")
  (make-package "ROADBOT_CONTROL::AC_GO_PLACE_ARGSRESPONSE"))

(in-package "ROS")





(defclass roadbot_control::ac_go_place_ArgsRequest
  :super ros::object
  :slots (_number_of_cones _lantern_pattern _cone_spacing _start_position_y _start_position_x _end_position_y _end_position_x _mode ))

(defmethod roadbot_control::ac_go_place_ArgsRequest
  (:init
   (&key
    ((:number_of_cones __number_of_cones) (make-array 0 :initial-element 0 :element-type :integer))
    ((:lantern_pattern __lantern_pattern) (make-array 0 :initial-element 0 :element-type :integer))
    ((:cone_spacing __cone_spacing) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:start_position_y __start_position_y) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:start_position_x __start_position_x) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:end_position_y __end_position_y) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:end_position_x __end_position_x) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:mode __mode) 0)
    )
   (send-super :init)
   (setq _number_of_cones __number_of_cones)
   (setq _lantern_pattern __lantern_pattern)
   (setq _cone_spacing __cone_spacing)
   (setq _start_position_y __start_position_y)
   (setq _start_position_x __start_position_x)
   (setq _end_position_y __end_position_y)
   (setq _end_position_x __end_position_x)
   (setq _mode (round __mode))
   self)
  (:number_of_cones
   (&optional __number_of_cones)
   (if __number_of_cones (setq _number_of_cones __number_of_cones)) _number_of_cones)
  (:lantern_pattern
   (&optional __lantern_pattern)
   (if __lantern_pattern (setq _lantern_pattern __lantern_pattern)) _lantern_pattern)
  (:cone_spacing
   (&optional __cone_spacing)
   (if __cone_spacing (setq _cone_spacing __cone_spacing)) _cone_spacing)
  (:start_position_y
   (&optional __start_position_y)
   (if __start_position_y (setq _start_position_y __start_position_y)) _start_position_y)
  (:start_position_x
   (&optional __start_position_x)
   (if __start_position_x (setq _start_position_x __start_position_x)) _start_position_x)
  (:end_position_y
   (&optional __end_position_y)
   (if __end_position_y (setq _end_position_y __end_position_y)) _end_position_y)
  (:end_position_x
   (&optional __end_position_x)
   (if __end_position_x (setq _end_position_x __end_position_x)) _end_position_x)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; int64[] _number_of_cones
    (* 8    (length _number_of_cones)) 4
    ;; int64[] _lantern_pattern
    (* 8    (length _lantern_pattern)) 4
    ;; float64[] _cone_spacing
    (* 8    (length _cone_spacing)) 4
    ;; float64[] _start_position_y
    (* 8    (length _start_position_y)) 4
    ;; float64[] _start_position_x
    (* 8    (length _start_position_x)) 4
    ;; float64[] _end_position_y
    (* 8    (length _end_position_y)) 4
    ;; float64[] _end_position_x
    (* 8    (length _end_position_x)) 4
    ;; int64 _mode
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64[] _number_of_cones
     (write-long (length _number_of_cones) s)
     (dotimes (i (length _number_of_cones))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _number_of_cones i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _number_of_cones i)) (= (length ((elt _number_of_cones i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _number_of_cones i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _number_of_cones i) . bv) 1) -1) s))
             ((and (class (elt _number_of_cones i)) (= (length ((elt _number_of_cones i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _number_of_cones i) . bv) 0) s)
              (write-long (if (>= (elt _number_of_cones i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _number_of_cones i) s)(write-long (if (>= (elt _number_of_cones i) 0) 0 #xffffffff) s)))
       )
     ;; int64[] _lantern_pattern
     (write-long (length _lantern_pattern) s)
     (dotimes (i (length _lantern_pattern))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _lantern_pattern i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _lantern_pattern i)) (= (length ((elt _lantern_pattern i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _lantern_pattern i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _lantern_pattern i) . bv) 1) -1) s))
             ((and (class (elt _lantern_pattern i)) (= (length ((elt _lantern_pattern i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _lantern_pattern i) . bv) 0) s)
              (write-long (if (>= (elt _lantern_pattern i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _lantern_pattern i) s)(write-long (if (>= (elt _lantern_pattern i) 0) 0 #xffffffff) s)))
       )
     ;; float64[] _cone_spacing
     (write-long (length _cone_spacing) s)
     (dotimes (i (length _cone_spacing))
       (sys::poke (elt _cone_spacing i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _start_position_y
     (write-long (length _start_position_y) s)
     (dotimes (i (length _start_position_y))
       (sys::poke (elt _start_position_y i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _start_position_x
     (write-long (length _start_position_x) s)
     (dotimes (i (length _start_position_x))
       (sys::poke (elt _start_position_x i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _end_position_y
     (write-long (length _end_position_y) s)
     (dotimes (i (length _end_position_y))
       (sys::poke (elt _end_position_y i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _end_position_x
     (write-long (length _end_position_x) s)
     (dotimes (i (length _end_position_x))
       (sys::poke (elt _end_position_x i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; int64 _mode
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mode (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mode) (= (length (_mode . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mode . bv) 0) 0) s)
              (write-long (ash (elt (_mode . bv) 1) -1) s))
             ((and (class _mode) (= (length (_mode . bv)) 1)) ;; big1
              (write-long (elt (_mode . bv) 0) s)
              (write-long (if (>= _mode 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mode s)(write-long (if (>= _mode 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64[] _number_of_cones
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _number_of_cones (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _number_of_cones i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _number_of_cones i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64[] _lantern_pattern
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lantern_pattern (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _lantern_pattern i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _lantern_pattern i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; float64[] _cone_spacing
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cone_spacing (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _cone_spacing i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _start_position_y
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _start_position_y (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _start_position_y i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _start_position_x
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _start_position_x (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _start_position_x i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _end_position_y
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _end_position_y (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _end_position_y i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _end_position_x
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _end_position_x (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _end_position_x i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; int64 _mode
#+(or :alpha :irix6 :x86_64)
      (setf _mode (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mode (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass roadbot_control::ac_go_place_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod roadbot_control::ac_go_place_ArgsResponse
  (:init
   (&key
    ((:response __response) 0)
    )
   (send-super :init)
   (setq _response (round __response))
   self)
  (:response
   (&optional __response)
   (if __response (setq _response __response)) _response)
  (:serialization-length
   ()
   (+
    ;; int64 _response
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _response
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _response (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _response) (= (length (_response . bv)) 2)) ;; bignum
              (write-long (ash (elt (_response . bv) 0) 0) s)
              (write-long (ash (elt (_response . bv) 1) -1) s))
             ((and (class _response) (= (length (_response . bv)) 1)) ;; big1
              (write-long (elt (_response . bv) 0) s)
              (write-long (if (>= _response 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _response s)(write-long (if (>= _response 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _response
#+(or :alpha :irix6 :x86_64)
      (setf _response (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _response (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass roadbot_control::ac_go_place_Args
  :super ros::object
  :slots ())

(setf (get roadbot_control::ac_go_place_Args :md5sum-) "39ebae836b3ef946be77dc87891f2639")
(setf (get roadbot_control::ac_go_place_Args :datatype-) "roadbot_control/ac_go_place_Args")
(setf (get roadbot_control::ac_go_place_Args :request) roadbot_control::ac_go_place_ArgsRequest)
(setf (get roadbot_control::ac_go_place_Args :response) roadbot_control::ac_go_place_ArgsResponse)

(defmethod roadbot_control::ac_go_place_ArgsRequest
  (:response () (instance roadbot_control::ac_go_place_ArgsResponse :init)))

(setf (get roadbot_control::ac_go_place_ArgsRequest :md5sum-) "39ebae836b3ef946be77dc87891f2639")
(setf (get roadbot_control::ac_go_place_ArgsRequest :datatype-) "roadbot_control/ac_go_place_ArgsRequest")
(setf (get roadbot_control::ac_go_place_ArgsRequest :definition-)
      "
int64[] number_of_cones

int64[] lantern_pattern

float64[] cone_spacing

float64[] start_position_y
float64[] start_position_x
float64[] end_position_y
float64[] end_position_x


int64 mode
---

int64 response


")

(setf (get roadbot_control::ac_go_place_ArgsResponse :md5sum-) "39ebae836b3ef946be77dc87891f2639")
(setf (get roadbot_control::ac_go_place_ArgsResponse :datatype-) "roadbot_control/ac_go_place_ArgsResponse")
(setf (get roadbot_control::ac_go_place_ArgsResponse :definition-)
      "
int64[] number_of_cones

int64[] lantern_pattern

float64[] cone_spacing

float64[] start_position_y
float64[] start_position_x
float64[] end_position_y
float64[] end_position_x


int64 mode
---

int64 response


")



(provide :roadbot_control/ac_go_place_Args "39ebae836b3ef946be77dc87891f2639")


