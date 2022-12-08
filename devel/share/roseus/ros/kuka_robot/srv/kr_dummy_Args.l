;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_dummy_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_dummy_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_DUMMY_ARGS")
  (make-package "KUKA_ROBOT::KR_DUMMY_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_DUMMY_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_DUMMY_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_DUMMY_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_DUMMY_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_dummy_ArgsRequest
  :super ros::object
  :slots (_dummy ))

(defmethod kuka_robot::kr_dummy_ArgsRequest
  (:init
   (&key
    ((:dummy __dummy) 0)
    )
   (send-super :init)
   (setq _dummy (round __dummy))
   self)
  (:dummy
   (&optional __dummy)
   (if __dummy (setq _dummy __dummy)) _dummy)
  (:serialization-length
   ()
   (+
    ;; int64 _dummy
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _dummy
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _dummy (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _dummy) (= (length (_dummy . bv)) 2)) ;; bignum
              (write-long (ash (elt (_dummy . bv) 0) 0) s)
              (write-long (ash (elt (_dummy . bv) 1) -1) s))
             ((and (class _dummy) (= (length (_dummy . bv)) 1)) ;; big1
              (write-long (elt (_dummy . bv) 0) s)
              (write-long (if (>= _dummy 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _dummy s)(write-long (if (>= _dummy 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _dummy
#+(or :alpha :irix6 :x86_64)
      (setf _dummy (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _dummy (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass kuka_robot::kr_dummy_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_dummy_ArgsResponse
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

(defclass kuka_robot::kr_dummy_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_dummy_Args :md5sum-) "33736ff8569e3bd56de924f3e76e8121")
(setf (get kuka_robot::kr_dummy_Args :datatype-) "kuka_robot/kr_dummy_Args")
(setf (get kuka_robot::kr_dummy_Args :request) kuka_robot::kr_dummy_ArgsRequest)
(setf (get kuka_robot::kr_dummy_Args :response) kuka_robot::kr_dummy_ArgsResponse)

(defmethod kuka_robot::kr_dummy_ArgsRequest
  (:response () (instance kuka_robot::kr_dummy_ArgsResponse :init)))

(setf (get kuka_robot::kr_dummy_ArgsRequest :md5sum-) "33736ff8569e3bd56de924f3e76e8121")
(setf (get kuka_robot::kr_dummy_ArgsRequest :datatype-) "kuka_robot/kr_dummy_ArgsRequest")
(setf (get kuka_robot::kr_dummy_ArgsRequest :definition-)
      "
int64 dummy
---

int64 response


")

(setf (get kuka_robot::kr_dummy_ArgsResponse :md5sum-) "33736ff8569e3bd56de924f3e76e8121")
(setf (get kuka_robot::kr_dummy_ArgsResponse :datatype-) "kuka_robot/kr_dummy_ArgsResponse")
(setf (get kuka_robot::kr_dummy_ArgsResponse :definition-)
      "
int64 dummy
---

int64 response


")



(provide :kuka_robot/kr_dummy_Args "33736ff8569e3bd56de924f3e76e8121")


