;; Auto-generated. Do not edit!


(when (boundp 'system_io::sio_set_value_Args)
  (if (not (find-package "SYSTEM_IO"))
    (make-package "SYSTEM_IO"))
  (shadow 'sio_set_value_Args (find-package "SYSTEM_IO")))
(unless (find-package "SYSTEM_IO::SIO_SET_VALUE_ARGS")
  (make-package "SYSTEM_IO::SIO_SET_VALUE_ARGS"))
(unless (find-package "SYSTEM_IO::SIO_SET_VALUE_ARGSREQUEST")
  (make-package "SYSTEM_IO::SIO_SET_VALUE_ARGSREQUEST"))
(unless (find-package "SYSTEM_IO::SIO_SET_VALUE_ARGSRESPONSE")
  (make-package "SYSTEM_IO::SIO_SET_VALUE_ARGSRESPONSE"))

(in-package "ROS")





(defclass system_io::sio_set_value_ArgsRequest
  :super ros::object
  :slots (_mask _value ))

(defmethod system_io::sio_set_value_ArgsRequest
  (:init
   (&key
    ((:mask __mask) 0)
    ((:value __value) 0)
    )
   (send-super :init)
   (setq _mask (round __mask))
   (setq _value (round __value))
   self)
  (:mask
   (&optional __mask)
   (if __mask (setq _mask __mask)) _mask)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int64 _mask
    8
    ;; int64 _value
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _mask
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mask (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mask) (= (length (_mask . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mask . bv) 0) 0) s)
              (write-long (ash (elt (_mask . bv) 1) -1) s))
             ((and (class _mask) (= (length (_mask . bv)) 1)) ;; big1
              (write-long (elt (_mask . bv) 0) s)
              (write-long (if (>= _mask 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mask s)(write-long (if (>= _mask 0) 0 #xffffffff) s)))
     ;; int64 _value
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _value (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _value) (= (length (_value . bv)) 2)) ;; bignum
              (write-long (ash (elt (_value . bv) 0) 0) s)
              (write-long (ash (elt (_value . bv) 1) -1) s))
             ((and (class _value) (= (length (_value . bv)) 1)) ;; big1
              (write-long (elt (_value . bv) 0) s)
              (write-long (if (>= _value 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _value s)(write-long (if (>= _value 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _mask
#+(or :alpha :irix6 :x86_64)
      (setf _mask (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mask (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _value
#+(or :alpha :irix6 :x86_64)
      (setf _value (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _value (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass system_io::sio_set_value_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod system_io::sio_set_value_ArgsResponse
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

(defclass system_io::sio_set_value_Args
  :super ros::object
  :slots ())

(setf (get system_io::sio_set_value_Args :md5sum-) "ffd2562de9680d6709b20c1fd9d4dc2c")
(setf (get system_io::sio_set_value_Args :datatype-) "system_io/sio_set_value_Args")
(setf (get system_io::sio_set_value_Args :request) system_io::sio_set_value_ArgsRequest)
(setf (get system_io::sio_set_value_Args :response) system_io::sio_set_value_ArgsResponse)

(defmethod system_io::sio_set_value_ArgsRequest
  (:response () (instance system_io::sio_set_value_ArgsResponse :init)))

(setf (get system_io::sio_set_value_ArgsRequest :md5sum-) "ffd2562de9680d6709b20c1fd9d4dc2c")
(setf (get system_io::sio_set_value_ArgsRequest :datatype-) "system_io/sio_set_value_ArgsRequest")
(setf (get system_io::sio_set_value_ArgsRequest :definition-)
      "
int64 mask
int64 value

---

int64 response


")

(setf (get system_io::sio_set_value_ArgsResponse :md5sum-) "ffd2562de9680d6709b20c1fd9d4dc2c")
(setf (get system_io::sio_set_value_ArgsResponse :datatype-) "system_io/sio_set_value_ArgsResponse")
(setf (get system_io::sio_set_value_ArgsResponse :definition-)
      "
int64 mask
int64 value

---

int64 response


")



(provide :system_io/sio_set_value_Args "ffd2562de9680d6709b20c1fd9d4dc2c")


