;; Auto-generated. Do not edit!


(when (boundp 'lantern_rack::lr_set_mode_Args)
  (if (not (find-package "LANTERN_RACK"))
    (make-package "LANTERN_RACK"))
  (shadow 'lr_set_mode_Args (find-package "LANTERN_RACK")))
(unless (find-package "LANTERN_RACK::LR_SET_MODE_ARGS")
  (make-package "LANTERN_RACK::LR_SET_MODE_ARGS"))
(unless (find-package "LANTERN_RACK::LR_SET_MODE_ARGSREQUEST")
  (make-package "LANTERN_RACK::LR_SET_MODE_ARGSREQUEST"))
(unless (find-package "LANTERN_RACK::LR_SET_MODE_ARGSRESPONSE")
  (make-package "LANTERN_RACK::LR_SET_MODE_ARGSRESPONSE"))

(in-package "ROS")





(defclass lantern_rack::lr_set_mode_ArgsRequest
  :super ros::object
  :slots (_mode ))

(defmethod lantern_rack::lr_set_mode_ArgsRequest
  (:init
   (&key
    ((:mode __mode) 0)
    )
   (send-super :init)
   (setq _mode (round __mode))
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; int64 _mode
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _mode
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mode (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mode) (= (length (_mode . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mode . bv) 0) 0) s)
              (write-long (ash (elt (_mode . bv) 1) -1) s))
             ((and (class _mode) (= (length (_mode . bv)) 1)) ;; big1
              (write-long (elt (_mode . bv) 0) s)
              (write-long (if (>= _mode 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mode s)(write-long (if (>= _mode 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _mode
#+(or :alpha :irix6 :x86_64)
      (setf _mode (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mode (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass lantern_rack::lr_set_mode_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod lantern_rack::lr_set_mode_ArgsResponse
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

(defclass lantern_rack::lr_set_mode_Args
  :super ros::object
  :slots ())

(setf (get lantern_rack::lr_set_mode_Args :md5sum-) "2e6307ffb6c6a15962ad11ee62cabe85")
(setf (get lantern_rack::lr_set_mode_Args :datatype-) "lantern_rack/lr_set_mode_Args")
(setf (get lantern_rack::lr_set_mode_Args :request) lantern_rack::lr_set_mode_ArgsRequest)
(setf (get lantern_rack::lr_set_mode_Args :response) lantern_rack::lr_set_mode_ArgsResponse)

(defmethod lantern_rack::lr_set_mode_ArgsRequest
  (:response () (instance lantern_rack::lr_set_mode_ArgsResponse :init)))

(setf (get lantern_rack::lr_set_mode_ArgsRequest :md5sum-) "2e6307ffb6c6a15962ad11ee62cabe85")
(setf (get lantern_rack::lr_set_mode_ArgsRequest :datatype-) "lantern_rack/lr_set_mode_ArgsRequest")
(setf (get lantern_rack::lr_set_mode_ArgsRequest :definition-)
      "
int64 mode
---

int64 response


")

(setf (get lantern_rack::lr_set_mode_ArgsResponse :md5sum-) "2e6307ffb6c6a15962ad11ee62cabe85")
(setf (get lantern_rack::lr_set_mode_ArgsResponse :datatype-) "lantern_rack/lr_set_mode_ArgsResponse")
(setf (get lantern_rack::lr_set_mode_ArgsResponse :definition-)
      "
int64 mode
---

int64 response


")



(provide :lantern_rack/lr_set_mode_Args "2e6307ffb6c6a15962ad11ee62cabe85")


