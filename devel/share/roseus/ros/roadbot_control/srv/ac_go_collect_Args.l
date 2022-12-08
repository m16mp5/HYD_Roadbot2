;; Auto-generated. Do not edit!


(when (boundp 'roadbot_control::ac_go_collect_Args)
  (if (not (find-package "ROADBOT_CONTROL"))
    (make-package "ROADBOT_CONTROL"))
  (shadow 'ac_go_collect_Args (find-package "ROADBOT_CONTROL")))
(unless (find-package "ROADBOT_CONTROL::AC_GO_COLLECT_ARGS")
  (make-package "ROADBOT_CONTROL::AC_GO_COLLECT_ARGS"))
(unless (find-package "ROADBOT_CONTROL::AC_GO_COLLECT_ARGSREQUEST")
  (make-package "ROADBOT_CONTROL::AC_GO_COLLECT_ARGSREQUEST"))
(unless (find-package "ROADBOT_CONTROL::AC_GO_COLLECT_ARGSRESPONSE")
  (make-package "ROADBOT_CONTROL::AC_GO_COLLECT_ARGSRESPONSE"))

(in-package "ROS")





(defclass roadbot_control::ac_go_collect_ArgsRequest
  :super ros::object
  :slots (_number_of_cones _mode ))

(defmethod roadbot_control::ac_go_collect_ArgsRequest
  (:init
   (&key
    ((:number_of_cones __number_of_cones) 0)
    ((:mode __mode) 0)
    )
   (send-super :init)
   (setq _number_of_cones (round __number_of_cones))
   (setq _mode (round __mode))
   self)
  (:number_of_cones
   (&optional __number_of_cones)
   (if __number_of_cones (setq _number_of_cones __number_of_cones)) _number_of_cones)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; int64 _number_of_cones
    8
    ;; int64 _mode
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _number_of_cones
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _number_of_cones (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _number_of_cones) (= (length (_number_of_cones . bv)) 2)) ;; bignum
              (write-long (ash (elt (_number_of_cones . bv) 0) 0) s)
              (write-long (ash (elt (_number_of_cones . bv) 1) -1) s))
             ((and (class _number_of_cones) (= (length (_number_of_cones . bv)) 1)) ;; big1
              (write-long (elt (_number_of_cones . bv) 0) s)
              (write-long (if (>= _number_of_cones 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _number_of_cones s)(write-long (if (>= _number_of_cones 0) 0 #xffffffff) s)))
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
   ;; int64 _number_of_cones
#+(or :alpha :irix6 :x86_64)
      (setf _number_of_cones (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _number_of_cones (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
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

(defclass roadbot_control::ac_go_collect_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod roadbot_control::ac_go_collect_ArgsResponse
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

(defclass roadbot_control::ac_go_collect_Args
  :super ros::object
  :slots ())

(setf (get roadbot_control::ac_go_collect_Args :md5sum-) "21a374c41adc123047cf3f40397fcf04")
(setf (get roadbot_control::ac_go_collect_Args :datatype-) "roadbot_control/ac_go_collect_Args")
(setf (get roadbot_control::ac_go_collect_Args :request) roadbot_control::ac_go_collect_ArgsRequest)
(setf (get roadbot_control::ac_go_collect_Args :response) roadbot_control::ac_go_collect_ArgsResponse)

(defmethod roadbot_control::ac_go_collect_ArgsRequest
  (:response () (instance roadbot_control::ac_go_collect_ArgsResponse :init)))

(setf (get roadbot_control::ac_go_collect_ArgsRequest :md5sum-) "21a374c41adc123047cf3f40397fcf04")
(setf (get roadbot_control::ac_go_collect_ArgsRequest :datatype-) "roadbot_control/ac_go_collect_ArgsRequest")
(setf (get roadbot_control::ac_go_collect_ArgsRequest :definition-)
      "
int64 number_of_cones
int64 mode

---

int64 response


")

(setf (get roadbot_control::ac_go_collect_ArgsResponse :md5sum-) "21a374c41adc123047cf3f40397fcf04")
(setf (get roadbot_control::ac_go_collect_ArgsResponse :datatype-) "roadbot_control/ac_go_collect_ArgsResponse")
(setf (get roadbot_control::ac_go_collect_ArgsResponse :definition-)
      "
int64 number_of_cones
int64 mode

---

int64 response


")



(provide :roadbot_control/ac_go_collect_Args "21a374c41adc123047cf3f40397fcf04")


