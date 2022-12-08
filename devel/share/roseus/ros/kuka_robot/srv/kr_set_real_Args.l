;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_set_real_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_set_real_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_SET_REAL_ARGS")
  (make-package "KUKA_ROBOT::KR_SET_REAL_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_SET_REAL_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_SET_REAL_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_SET_REAL_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_SET_REAL_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_set_real_ArgsRequest
  :super ros::object
  :slots (_number ))

(defmethod kuka_robot::kr_set_real_ArgsRequest
  (:init
   (&key
    ((:number __number) 0.0)
    )
   (send-super :init)
   (setq _number (float __number))
   self)
  (:number
   (&optional __number)
   (if __number (setq _number __number)) _number)
  (:serialization-length
   ()
   (+
    ;; float64 _number
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _number
       (sys::poke _number (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _number
     (setq _number (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass kuka_robot::kr_set_real_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_set_real_ArgsResponse
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

(defclass kuka_robot::kr_set_real_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_set_real_Args :md5sum-) "b3319af90c195facb7812dea88b9b248")
(setf (get kuka_robot::kr_set_real_Args :datatype-) "kuka_robot/kr_set_real_Args")
(setf (get kuka_robot::kr_set_real_Args :request) kuka_robot::kr_set_real_ArgsRequest)
(setf (get kuka_robot::kr_set_real_Args :response) kuka_robot::kr_set_real_ArgsResponse)

(defmethod kuka_robot::kr_set_real_ArgsRequest
  (:response () (instance kuka_robot::kr_set_real_ArgsResponse :init)))

(setf (get kuka_robot::kr_set_real_ArgsRequest :md5sum-) "b3319af90c195facb7812dea88b9b248")
(setf (get kuka_robot::kr_set_real_ArgsRequest :datatype-) "kuka_robot/kr_set_real_ArgsRequest")
(setf (get kuka_robot::kr_set_real_ArgsRequest :definition-)
      "
float64 number
---

int64 response


")

(setf (get kuka_robot::kr_set_real_ArgsResponse :md5sum-) "b3319af90c195facb7812dea88b9b248")
(setf (get kuka_robot::kr_set_real_ArgsResponse :datatype-) "kuka_robot/kr_set_real_ArgsResponse")
(setf (get kuka_robot::kr_set_real_ArgsResponse :definition-)
      "
float64 number
---

int64 response


")



(provide :kuka_robot/kr_set_real_Args "b3319af90c195facb7812dea88b9b248")


