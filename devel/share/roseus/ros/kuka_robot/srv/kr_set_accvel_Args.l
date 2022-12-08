;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_set_accvel_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_set_accvel_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_SET_ACCVEL_ARGS")
  (make-package "KUKA_ROBOT::KR_SET_ACCVEL_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_SET_ACCVEL_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_SET_ACCVEL_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_SET_ACCVEL_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_SET_ACCVEL_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_set_accvel_ArgsRequest
  :super ros::object
  :slots (_acc _acc_swivel _acc_rot _vel _vel_swivel _vel_rot ))

(defmethod kuka_robot::kr_set_accvel_ArgsRequest
  (:init
   (&key
    ((:acc __acc) 0.0)
    ((:acc_swivel __acc_swivel) 0.0)
    ((:acc_rot __acc_rot) 0.0)
    ((:vel __vel) 0.0)
    ((:vel_swivel __vel_swivel) 0.0)
    ((:vel_rot __vel_rot) 0.0)
    )
   (send-super :init)
   (setq _acc (float __acc))
   (setq _acc_swivel (float __acc_swivel))
   (setq _acc_rot (float __acc_rot))
   (setq _vel (float __vel))
   (setq _vel_swivel (float __vel_swivel))
   (setq _vel_rot (float __vel_rot))
   self)
  (:acc
   (&optional __acc)
   (if __acc (setq _acc __acc)) _acc)
  (:acc_swivel
   (&optional __acc_swivel)
   (if __acc_swivel (setq _acc_swivel __acc_swivel)) _acc_swivel)
  (:acc_rot
   (&optional __acc_rot)
   (if __acc_rot (setq _acc_rot __acc_rot)) _acc_rot)
  (:vel
   (&optional __vel)
   (if __vel (setq _vel __vel)) _vel)
  (:vel_swivel
   (&optional __vel_swivel)
   (if __vel_swivel (setq _vel_swivel __vel_swivel)) _vel_swivel)
  (:vel_rot
   (&optional __vel_rot)
   (if __vel_rot (setq _vel_rot __vel_rot)) _vel_rot)
  (:serialization-length
   ()
   (+
    ;; float64 _acc
    8
    ;; float64 _acc_swivel
    8
    ;; float64 _acc_rot
    8
    ;; float64 _vel
    8
    ;; float64 _vel_swivel
    8
    ;; float64 _vel_rot
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _acc
       (sys::poke _acc (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_swivel
       (sys::poke _acc_swivel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc_rot
       (sys::poke _acc_rot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel
       (sys::poke _vel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_swivel
       (sys::poke _vel_swivel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vel_rot
       (sys::poke _vel_rot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _acc
     (setq _acc (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_swivel
     (setq _acc_swivel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc_rot
     (setq _acc_rot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel
     (setq _vel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_swivel
     (setq _vel_swivel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vel_rot
     (setq _vel_rot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass kuka_robot::kr_set_accvel_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_set_accvel_ArgsResponse
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

(defclass kuka_robot::kr_set_accvel_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_set_accvel_Args :md5sum-) "8daacbb0ad8522dab063be7060ee20fc")
(setf (get kuka_robot::kr_set_accvel_Args :datatype-) "kuka_robot/kr_set_accvel_Args")
(setf (get kuka_robot::kr_set_accvel_Args :request) kuka_robot::kr_set_accvel_ArgsRequest)
(setf (get kuka_robot::kr_set_accvel_Args :response) kuka_robot::kr_set_accvel_ArgsResponse)

(defmethod kuka_robot::kr_set_accvel_ArgsRequest
  (:response () (instance kuka_robot::kr_set_accvel_ArgsResponse :init)))

(setf (get kuka_robot::kr_set_accvel_ArgsRequest :md5sum-) "8daacbb0ad8522dab063be7060ee20fc")
(setf (get kuka_robot::kr_set_accvel_ArgsRequest :datatype-) "kuka_robot/kr_set_accvel_ArgsRequest")
(setf (get kuka_robot::kr_set_accvel_ArgsRequest :definition-)
      "
float64 acc

float64 acc_swivel

float64 acc_rot

float64 vel

float64 vel_swivel

float64 vel_rot
---

int64 response


")

(setf (get kuka_robot::kr_set_accvel_ArgsResponse :md5sum-) "8daacbb0ad8522dab063be7060ee20fc")
(setf (get kuka_robot::kr_set_accvel_ArgsResponse :datatype-) "kuka_robot/kr_set_accvel_ArgsResponse")
(setf (get kuka_robot::kr_set_accvel_ArgsResponse :definition-)
      "
float64 acc

float64 acc_swivel

float64 acc_rot

float64 vel

float64 vel_swivel

float64 vel_rot
---

int64 response


")



(provide :kuka_robot/kr_set_accvel_Args "8daacbb0ad8522dab063be7060ee20fc")


