;; Auto-generated. Do not edit!


(when (boundp 'vision_system::vs_get_white_marking_position_Args)
  (if (not (find-package "VISION_SYSTEM"))
    (make-package "VISION_SYSTEM"))
  (shadow 'vs_get_white_marking_position_Args (find-package "VISION_SYSTEM")))
(unless (find-package "VISION_SYSTEM::VS_GET_WHITE_MARKING_POSITION_ARGS")
  (make-package "VISION_SYSTEM::VS_GET_WHITE_MARKING_POSITION_ARGS"))
(unless (find-package "VISION_SYSTEM::VS_GET_WHITE_MARKING_POSITION_ARGSREQUEST")
  (make-package "VISION_SYSTEM::VS_GET_WHITE_MARKING_POSITION_ARGSREQUEST"))
(unless (find-package "VISION_SYSTEM::VS_GET_WHITE_MARKING_POSITION_ARGSRESPONSE")
  (make-package "VISION_SYSTEM::VS_GET_WHITE_MARKING_POSITION_ARGSRESPONSE"))

(in-package "ROS")





(defclass vision_system::vs_get_white_marking_position_ArgsRequest
  :super ros::object
  :slots (_timestamp _x _y ))

(defmethod vision_system::vs_get_white_marking_position_ArgsRequest
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _x (float __x))
   (setq _y (float __y))
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; float64 _x
    8
    ;; float64 _y
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass vision_system::vs_get_white_marking_position_ArgsResponse
  :super ros::object
  :slots (_response _y _result_code ))

(defmethod vision_system::vs_get_white_marking_position_ArgsResponse
  (:init
   (&key
    ((:response __response) 0)
    ((:y __y) 0.0)
    ((:result_code __result_code) 0)
    )
   (send-super :init)
   (setq _response (round __response))
   (setq _y (float __y))
   (setq _result_code (round __result_code))
   self)
  (:response
   (&optional __response)
   (if __response (setq _response __response)) _response)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:result_code
   (&optional __result_code)
   (if __result_code (setq _result_code __result_code)) _result_code)
  (:serialization-length
   ()
   (+
    ;; int64 _response
    8
    ;; float64 _y
    8
    ;; int64 _result_code
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
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _result_code
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _result_code (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _result_code) (= (length (_result_code . bv)) 2)) ;; bignum
              (write-long (ash (elt (_result_code . bv) 0) 0) s)
              (write-long (ash (elt (_result_code . bv) 1) -1) s))
             ((and (class _result_code) (= (length (_result_code . bv)) 1)) ;; big1
              (write-long (elt (_result_code . bv) 0) s)
              (write-long (if (>= _result_code 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _result_code s)(write-long (if (>= _result_code 0) 0 #xffffffff) s)))
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
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _result_code
#+(or :alpha :irix6 :x86_64)
      (setf _result_code (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _result_code (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass vision_system::vs_get_white_marking_position_Args
  :super ros::object
  :slots ())

(setf (get vision_system::vs_get_white_marking_position_Args :md5sum-) "f5317cca2c98e2b6437f8911f58cba1c")
(setf (get vision_system::vs_get_white_marking_position_Args :datatype-) "vision_system/vs_get_white_marking_position_Args")
(setf (get vision_system::vs_get_white_marking_position_Args :request) vision_system::vs_get_white_marking_position_ArgsRequest)
(setf (get vision_system::vs_get_white_marking_position_Args :response) vision_system::vs_get_white_marking_position_ArgsResponse)

(defmethod vision_system::vs_get_white_marking_position_ArgsRequest
  (:response () (instance vision_system::vs_get_white_marking_position_ArgsResponse :init)))

(setf (get vision_system::vs_get_white_marking_position_ArgsRequest :md5sum-) "f5317cca2c98e2b6437f8911f58cba1c")
(setf (get vision_system::vs_get_white_marking_position_ArgsRequest :datatype-) "vision_system/vs_get_white_marking_position_ArgsRequest")
(setf (get vision_system::vs_get_white_marking_position_ArgsRequest :definition-)
      "
float64 timestamp


float64 x
float64 y

---

int64 response


float64 y


int64 result_code


")

(setf (get vision_system::vs_get_white_marking_position_ArgsResponse :md5sum-) "f5317cca2c98e2b6437f8911f58cba1c")
(setf (get vision_system::vs_get_white_marking_position_ArgsResponse :datatype-) "vision_system/vs_get_white_marking_position_ArgsResponse")
(setf (get vision_system::vs_get_white_marking_position_ArgsResponse :definition-)
      "
float64 timestamp


float64 x
float64 y

---

int64 response


float64 y


int64 result_code


")



(provide :vision_system/vs_get_white_marking_position_Args "f5317cca2c98e2b6437f8911f58cba1c")


