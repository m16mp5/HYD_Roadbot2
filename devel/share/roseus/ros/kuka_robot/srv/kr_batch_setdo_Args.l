;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_batch_setdo_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_batch_setdo_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_BATCH_SETDO_ARGS")
  (make-package "KUKA_ROBOT::KR_BATCH_SETDO_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_SETDO_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_BATCH_SETDO_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_SETDO_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_BATCH_SETDO_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_batch_setdo_ArgsRequest
  :super ros::object
  :slots (_mask _value _settle_sec _block ))

(defmethod kuka_robot::kr_batch_setdo_ArgsRequest
  (:init
   (&key
    ((:mask __mask) 0)
    ((:value __value) 0)
    ((:settle_sec __settle_sec) 0.0)
    ((:block __block) 0)
    )
   (send-super :init)
   (setq _mask (round __mask))
   (setq _value (round __value))
   (setq _settle_sec (float __settle_sec))
   (setq _block (round __block))
   self)
  (:mask
   (&optional __mask)
   (if __mask (setq _mask __mask)) _mask)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:settle_sec
   (&optional __settle_sec)
   (if __settle_sec (setq _settle_sec __settle_sec)) _settle_sec)
  (:block
   (&optional __block)
   (if __block (setq _block __block)) _block)
  (:serialization-length
   ()
   (+
    ;; int64 _mask
    8
    ;; int64 _value
    8
    ;; float64 _settle_sec
    8
    ;; int64 _block
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
     ;; float64 _settle_sec
       (sys::poke _settle_sec (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int64 _block
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _block (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _block) (= (length (_block . bv)) 2)) ;; bignum
              (write-long (ash (elt (_block . bv) 0) 0) s)
              (write-long (ash (elt (_block . bv) 1) -1) s))
             ((and (class _block) (= (length (_block . bv)) 1)) ;; big1
              (write-long (elt (_block . bv) 0) s)
              (write-long (if (>= _block 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _block s)(write-long (if (>= _block 0) 0 #xffffffff) s)))
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
   ;; float64 _settle_sec
     (setq _settle_sec (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int64 _block
#+(or :alpha :irix6 :x86_64)
      (setf _block (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _block (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass kuka_robot::kr_batch_setdo_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_batch_setdo_ArgsResponse
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

(defclass kuka_robot::kr_batch_setdo_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_batch_setdo_Args :md5sum-) "597fbd75fbca5e1c5c2cbcc9cc497506")
(setf (get kuka_robot::kr_batch_setdo_Args :datatype-) "kuka_robot/kr_batch_setdo_Args")
(setf (get kuka_robot::kr_batch_setdo_Args :request) kuka_robot::kr_batch_setdo_ArgsRequest)
(setf (get kuka_robot::kr_batch_setdo_Args :response) kuka_robot::kr_batch_setdo_ArgsResponse)

(defmethod kuka_robot::kr_batch_setdo_ArgsRequest
  (:response () (instance kuka_robot::kr_batch_setdo_ArgsResponse :init)))

(setf (get kuka_robot::kr_batch_setdo_ArgsRequest :md5sum-) "597fbd75fbca5e1c5c2cbcc9cc497506")
(setf (get kuka_robot::kr_batch_setdo_ArgsRequest :datatype-) "kuka_robot/kr_batch_setdo_ArgsRequest")
(setf (get kuka_robot::kr_batch_setdo_ArgsRequest :definition-)
      "
int64 mask

int64 value

float64 settle_sec

int64 block
---

int64 response


")

(setf (get kuka_robot::kr_batch_setdo_ArgsResponse :md5sum-) "597fbd75fbca5e1c5c2cbcc9cc497506")
(setf (get kuka_robot::kr_batch_setdo_ArgsResponse :datatype-) "kuka_robot/kr_batch_setdo_ArgsResponse")
(setf (get kuka_robot::kr_batch_setdo_ArgsResponse :definition-)
      "
int64 mask

int64 value

float64 settle_sec

int64 block
---

int64 response


")



(provide :kuka_robot/kr_batch_setdo_Args "597fbd75fbca5e1c5c2cbcc9cc497506")


