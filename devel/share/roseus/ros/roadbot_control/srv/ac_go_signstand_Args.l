;; Auto-generated. Do not edit!


(when (boundp 'roadbot_control::ac_go_signstand_Args)
  (if (not (find-package "ROADBOT_CONTROL"))
    (make-package "ROADBOT_CONTROL"))
  (shadow 'ac_go_signstand_Args (find-package "ROADBOT_CONTROL")))
(unless (find-package "ROADBOT_CONTROL::AC_GO_SIGNSTAND_ARGS")
  (make-package "ROADBOT_CONTROL::AC_GO_SIGNSTAND_ARGS"))
(unless (find-package "ROADBOT_CONTROL::AC_GO_SIGNSTAND_ARGSREQUEST")
  (make-package "ROADBOT_CONTROL::AC_GO_SIGNSTAND_ARGSREQUEST"))
(unless (find-package "ROADBOT_CONTROL::AC_GO_SIGNSTAND_ARGSRESPONSE")
  (make-package "ROADBOT_CONTROL::AC_GO_SIGNSTAND_ARGSRESPONSE"))

(in-package "ROS")





(defclass roadbot_control::ac_go_signstand_ArgsRequest
  :super ros::object
  :slots (_position_y _position_x _lb_location ))

(defmethod roadbot_control::ac_go_signstand_ArgsRequest
  (:init
   (&key
    ((:position_y __position_y) 0.0)
    ((:position_x __position_x) 0.0)
    ((:lb_location __lb_location) 0)
    )
   (send-super :init)
   (setq _position_y (float __position_y))
   (setq _position_x (float __position_x))
   (setq _lb_location (round __lb_location))
   self)
  (:position_y
   (&optional __position_y)
   (if __position_y (setq _position_y __position_y)) _position_y)
  (:position_x
   (&optional __position_x)
   (if __position_x (setq _position_x __position_x)) _position_x)
  (:lb_location
   (&optional __lb_location)
   (if __lb_location (setq _lb_location __lb_location)) _lb_location)
  (:serialization-length
   ()
   (+
    ;; float64 _position_y
    8
    ;; float64 _position_x
    8
    ;; int64 _lb_location
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _position_y
       (sys::poke _position_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _position_x
       (sys::poke _position_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _lb_location
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lb_location (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lb_location) (= (length (_lb_location . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lb_location . bv) 0) 0) s)
              (write-long (ash (elt (_lb_location . bv) 1) -1) s))
             ((and (class _lb_location) (= (length (_lb_location . bv)) 1)) ;; big1
              (write-long (elt (_lb_location . bv) 0) s)
              (write-long (if (>= _lb_location 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lb_location s)(write-long (if (>= _lb_location 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _position_y
     (setq _position_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _position_x
     (setq _position_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _lb_location
#+(or :alpha :irix6 :x86_64)
      (setf _lb_location (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lb_location (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass roadbot_control::ac_go_signstand_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod roadbot_control::ac_go_signstand_ArgsResponse
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

(defclass roadbot_control::ac_go_signstand_Args
  :super ros::object
  :slots ())

(setf (get roadbot_control::ac_go_signstand_Args :md5sum-) "caec67dc8933c4357cb62028f1056dfe")
(setf (get roadbot_control::ac_go_signstand_Args :datatype-) "roadbot_control/ac_go_signstand_Args")
(setf (get roadbot_control::ac_go_signstand_Args :request) roadbot_control::ac_go_signstand_ArgsRequest)
(setf (get roadbot_control::ac_go_signstand_Args :response) roadbot_control::ac_go_signstand_ArgsResponse)

(defmethod roadbot_control::ac_go_signstand_ArgsRequest
  (:response () (instance roadbot_control::ac_go_signstand_ArgsResponse :init)))

(setf (get roadbot_control::ac_go_signstand_ArgsRequest :md5sum-) "caec67dc8933c4357cb62028f1056dfe")
(setf (get roadbot_control::ac_go_signstand_ArgsRequest :datatype-) "roadbot_control/ac_go_signstand_ArgsRequest")
(setf (get roadbot_control::ac_go_signstand_ArgsRequest :definition-)
      "
float64 position_y
float64 position_x


int64 lb_location
---

int64 response


")

(setf (get roadbot_control::ac_go_signstand_ArgsResponse :md5sum-) "caec67dc8933c4357cb62028f1056dfe")
(setf (get roadbot_control::ac_go_signstand_ArgsResponse :datatype-) "roadbot_control/ac_go_signstand_ArgsResponse")
(setf (get roadbot_control::ac_go_signstand_ArgsResponse :definition-)
      "
float64 position_y
float64 position_x


int64 lb_location
---

int64 response


")



(provide :roadbot_control/ac_go_signstand_Args "caec67dc8933c4357cb62028f1056dfe")


