;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_set_speed_scale_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_set_speed_scale_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_SET_SPEED_SCALE_ARGS")
  (make-package "KUKA_ROBOT::KR_SET_SPEED_SCALE_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_SET_SPEED_SCALE_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_SET_SPEED_SCALE_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_SET_SPEED_SCALE_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_SET_SPEED_SCALE_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_set_speed_scale_ArgsRequest
  :super ros::object
  :slots (_scale ))

(defmethod kuka_robot::kr_set_speed_scale_ArgsRequest
  (:init
   (&key
    ((:scale __scale) 0)
    )
   (send-super :init)
   (setq _scale (round __scale))
   self)
  (:scale
   (&optional __scale)
   (if __scale (setq _scale __scale)) _scale)
  (:serialization-length
   ()
   (+
    ;; int64 _scale
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _scale
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _scale (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _scale) (= (length (_scale . bv)) 2)) ;; bignum
              (write-long (ash (elt (_scale . bv) 0) 0) s)
              (write-long (ash (elt (_scale . bv) 1) -1) s))
             ((and (class _scale) (= (length (_scale . bv)) 1)) ;; big1
              (write-long (elt (_scale . bv) 0) s)
              (write-long (if (>= _scale 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _scale s)(write-long (if (>= _scale 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _scale
#+(or :alpha :irix6 :x86_64)
      (setf _scale (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _scale (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass kuka_robot::kr_set_speed_scale_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_set_speed_scale_ArgsResponse
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

(defclass kuka_robot::kr_set_speed_scale_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_set_speed_scale_Args :md5sum-) "e350400d43e80f2e5bbe749334ff56ac")
(setf (get kuka_robot::kr_set_speed_scale_Args :datatype-) "kuka_robot/kr_set_speed_scale_Args")
(setf (get kuka_robot::kr_set_speed_scale_Args :request) kuka_robot::kr_set_speed_scale_ArgsRequest)
(setf (get kuka_robot::kr_set_speed_scale_Args :response) kuka_robot::kr_set_speed_scale_ArgsResponse)

(defmethod kuka_robot::kr_set_speed_scale_ArgsRequest
  (:response () (instance kuka_robot::kr_set_speed_scale_ArgsResponse :init)))

(setf (get kuka_robot::kr_set_speed_scale_ArgsRequest :md5sum-) "e350400d43e80f2e5bbe749334ff56ac")
(setf (get kuka_robot::kr_set_speed_scale_ArgsRequest :datatype-) "kuka_robot/kr_set_speed_scale_ArgsRequest")
(setf (get kuka_robot::kr_set_speed_scale_ArgsRequest :definition-)
      "
int64 scale
---

int64 response


")

(setf (get kuka_robot::kr_set_speed_scale_ArgsResponse :md5sum-) "e350400d43e80f2e5bbe749334ff56ac")
(setf (get kuka_robot::kr_set_speed_scale_ArgsResponse :datatype-) "kuka_robot/kr_set_speed_scale_ArgsResponse")
(setf (get kuka_robot::kr_set_speed_scale_ArgsResponse :definition-)
      "
int64 scale
---

int64 response


")



(provide :kuka_robot/kr_set_speed_scale_Args "e350400d43e80f2e5bbe749334ff56ac")


