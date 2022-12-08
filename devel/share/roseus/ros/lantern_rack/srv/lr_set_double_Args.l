;; Auto-generated. Do not edit!


(when (boundp 'lantern_rack::lr_set_double_Args)
  (if (not (find-package "LANTERN_RACK"))
    (make-package "LANTERN_RACK"))
  (shadow 'lr_set_double_Args (find-package "LANTERN_RACK")))
(unless (find-package "LANTERN_RACK::LR_SET_DOUBLE_ARGS")
  (make-package "LANTERN_RACK::LR_SET_DOUBLE_ARGS"))
(unless (find-package "LANTERN_RACK::LR_SET_DOUBLE_ARGSREQUEST")
  (make-package "LANTERN_RACK::LR_SET_DOUBLE_ARGSREQUEST"))
(unless (find-package "LANTERN_RACK::LR_SET_DOUBLE_ARGSRESPONSE")
  (make-package "LANTERN_RACK::LR_SET_DOUBLE_ARGSRESPONSE"))

(in-package "ROS")





(defclass lantern_rack::lr_set_double_ArgsRequest
  :super ros::object
  :slots (_num ))

(defmethod lantern_rack::lr_set_double_ArgsRequest
  (:init
   (&key
    ((:num __num) 0.0)
    )
   (send-super :init)
   (setq _num (float __num))
   self)
  (:num
   (&optional __num)
   (if __num (setq _num __num)) _num)
  (:serialization-length
   ()
   (+
    ;; float64 _num
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _num
       (sys::poke _num (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _num
     (setq _num (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass lantern_rack::lr_set_double_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod lantern_rack::lr_set_double_ArgsResponse
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

(defclass lantern_rack::lr_set_double_Args
  :super ros::object
  :slots ())

(setf (get lantern_rack::lr_set_double_Args :md5sum-) "1320d4a929ea6ef2a246c2b190a9f356")
(setf (get lantern_rack::lr_set_double_Args :datatype-) "lantern_rack/lr_set_double_Args")
(setf (get lantern_rack::lr_set_double_Args :request) lantern_rack::lr_set_double_ArgsRequest)
(setf (get lantern_rack::lr_set_double_Args :response) lantern_rack::lr_set_double_ArgsResponse)

(defmethod lantern_rack::lr_set_double_ArgsRequest
  (:response () (instance lantern_rack::lr_set_double_ArgsResponse :init)))

(setf (get lantern_rack::lr_set_double_ArgsRequest :md5sum-) "1320d4a929ea6ef2a246c2b190a9f356")
(setf (get lantern_rack::lr_set_double_ArgsRequest :datatype-) "lantern_rack/lr_set_double_ArgsRequest")
(setf (get lantern_rack::lr_set_double_ArgsRequest :definition-)
      "
float64 num
---

int64 response


")

(setf (get lantern_rack::lr_set_double_ArgsResponse :md5sum-) "1320d4a929ea6ef2a246c2b190a9f356")
(setf (get lantern_rack::lr_set_double_ArgsResponse :datatype-) "lantern_rack/lr_set_double_ArgsResponse")
(setf (get lantern_rack::lr_set_double_ArgsResponse :definition-)
      "
float64 num
---

int64 response


")



(provide :lantern_rack/lr_set_double_Args "1320d4a929ea6ef2a246c2b190a9f356")


