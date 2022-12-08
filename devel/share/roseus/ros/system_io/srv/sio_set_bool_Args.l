;; Auto-generated. Do not edit!


(when (boundp 'system_io::sio_set_bool_Args)
  (if (not (find-package "SYSTEM_IO"))
    (make-package "SYSTEM_IO"))
  (shadow 'sio_set_bool_Args (find-package "SYSTEM_IO")))
(unless (find-package "SYSTEM_IO::SIO_SET_BOOL_ARGS")
  (make-package "SYSTEM_IO::SIO_SET_BOOL_ARGS"))
(unless (find-package "SYSTEM_IO::SIO_SET_BOOL_ARGSREQUEST")
  (make-package "SYSTEM_IO::SIO_SET_BOOL_ARGSREQUEST"))
(unless (find-package "SYSTEM_IO::SIO_SET_BOOL_ARGSRESPONSE")
  (make-package "SYSTEM_IO::SIO_SET_BOOL_ARGSRESPONSE"))

(in-package "ROS")





(defclass system_io::sio_set_bool_ArgsRequest
  :super ros::object
  :slots (_state ))

(defmethod system_io::sio_set_bool_ArgsRequest
  (:init
   (&key
    ((:state __state) nil)
    )
   (send-super :init)
   (setq _state __state)
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; bool _state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _state
       (if _state (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _state
     (setq _state (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass system_io::sio_set_bool_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod system_io::sio_set_bool_ArgsResponse
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

(defclass system_io::sio_set_bool_Args
  :super ros::object
  :slots ())

(setf (get system_io::sio_set_bool_Args :md5sum-) "01ed7128038a1bd09607b70544351d27")
(setf (get system_io::sio_set_bool_Args :datatype-) "system_io/sio_set_bool_Args")
(setf (get system_io::sio_set_bool_Args :request) system_io::sio_set_bool_ArgsRequest)
(setf (get system_io::sio_set_bool_Args :response) system_io::sio_set_bool_ArgsResponse)

(defmethod system_io::sio_set_bool_ArgsRequest
  (:response () (instance system_io::sio_set_bool_ArgsResponse :init)))

(setf (get system_io::sio_set_bool_ArgsRequest :md5sum-) "01ed7128038a1bd09607b70544351d27")
(setf (get system_io::sio_set_bool_ArgsRequest :datatype-) "system_io/sio_set_bool_ArgsRequest")
(setf (get system_io::sio_set_bool_ArgsRequest :definition-)
      "
bool state
---

int64 response


")

(setf (get system_io::sio_set_bool_ArgsResponse :md5sum-) "01ed7128038a1bd09607b70544351d27")
(setf (get system_io::sio_set_bool_ArgsResponse :datatype-) "system_io/sio_set_bool_ArgsResponse")
(setf (get system_io::sio_set_bool_ArgsResponse :definition-)
      "
bool state
---

int64 response


")



(provide :system_io/sio_set_bool_Args "01ed7128038a1bd09607b70544351d27")


