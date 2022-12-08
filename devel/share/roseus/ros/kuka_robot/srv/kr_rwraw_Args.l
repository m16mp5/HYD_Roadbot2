;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_rwraw_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_rwraw_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_RWRAW_ARGS")
  (make-package "KUKA_ROBOT::KR_RWRAW_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_RWRAW_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_RWRAW_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_RWRAW_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_RWRAW_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_rwraw_ArgsRequest
  :super ros::object
  :slots (_name _value ))

(defmethod kuka_robot::kr_rwraw_ArgsRequest
  (:init
   (&key
    ((:name __name) "")
    ((:value __value) "")
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _value (string __value))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; string _value
    4 (length _value)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; string _value
       (write-long (length _value) s) (princ _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass kuka_robot::kr_rwraw_ArgsResponse
  :super ros::object
  :slots (_response _serialvalue ))

(defmethod kuka_robot::kr_rwraw_ArgsResponse
  (:init
   (&key
    ((:response __response) 0)
    ((:serialvalue __serialvalue) "")
    )
   (send-super :init)
   (setq _response (round __response))
   (setq _serialvalue (string __serialvalue))
   self)
  (:response
   (&optional __response)
   (if __response (setq _response __response)) _response)
  (:serialvalue
   (&optional __serialvalue)
   (if __serialvalue (setq _serialvalue __serialvalue)) _serialvalue)
  (:serialization-length
   ()
   (+
    ;; int64 _response
    8
    ;; string _serialvalue
    4 (length _serialvalue)
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
     ;; string _serialvalue
       (write-long (length _serialvalue) s) (princ _serialvalue s)
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
   ;; string _serialvalue
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _serialvalue (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass kuka_robot::kr_rwraw_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_rwraw_Args :md5sum-) "11c5a51efafea631b2d1acda167e91ef")
(setf (get kuka_robot::kr_rwraw_Args :datatype-) "kuka_robot/kr_rwraw_Args")
(setf (get kuka_robot::kr_rwraw_Args :request) kuka_robot::kr_rwraw_ArgsRequest)
(setf (get kuka_robot::kr_rwraw_Args :response) kuka_robot::kr_rwraw_ArgsResponse)

(defmethod kuka_robot::kr_rwraw_ArgsRequest
  (:response () (instance kuka_robot::kr_rwraw_ArgsResponse :init)))

(setf (get kuka_robot::kr_rwraw_ArgsRequest :md5sum-) "11c5a51efafea631b2d1acda167e91ef")
(setf (get kuka_robot::kr_rwraw_ArgsRequest :datatype-) "kuka_robot/kr_rwraw_ArgsRequest")
(setf (get kuka_robot::kr_rwraw_ArgsRequest :definition-)
      "
string name
string value
---

int64 response

string serialvalue

")

(setf (get kuka_robot::kr_rwraw_ArgsResponse :md5sum-) "11c5a51efafea631b2d1acda167e91ef")
(setf (get kuka_robot::kr_rwraw_ArgsResponse :datatype-) "kuka_robot/kr_rwraw_ArgsResponse")
(setf (get kuka_robot::kr_rwraw_ArgsResponse :definition-)
      "
string name
string value
---

int64 response

string serialvalue

")



(provide :kuka_robot/kr_rwraw_Args "11c5a51efafea631b2d1acda167e91ef")


