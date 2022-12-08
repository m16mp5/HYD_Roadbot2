;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_batch_mv_run_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_batch_mv_run_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_RUN_ARGS")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_RUN_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_RUN_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_RUN_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_RUN_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_RUN_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_batch_mv_run_ArgsRequest
  :super ros::object
  :slots (_start_block _end_block ))

(defmethod kuka_robot::kr_batch_mv_run_ArgsRequest
  (:init
   (&key
    ((:start_block __start_block) 0)
    ((:end_block __end_block) 0)
    )
   (send-super :init)
   (setq _start_block (round __start_block))
   (setq _end_block (round __end_block))
   self)
  (:start_block
   (&optional __start_block)
   (if __start_block (setq _start_block __start_block)) _start_block)
  (:end_block
   (&optional __end_block)
   (if __end_block (setq _end_block __end_block)) _end_block)
  (:serialization-length
   ()
   (+
    ;; int64 _start_block
    8
    ;; int64 _end_block
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _start_block
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _start_block (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _start_block) (= (length (_start_block . bv)) 2)) ;; bignum
              (write-long (ash (elt (_start_block . bv) 0) 0) s)
              (write-long (ash (elt (_start_block . bv) 1) -1) s))
             ((and (class _start_block) (= (length (_start_block . bv)) 1)) ;; big1
              (write-long (elt (_start_block . bv) 0) s)
              (write-long (if (>= _start_block 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _start_block s)(write-long (if (>= _start_block 0) 0 #xffffffff) s)))
     ;; int64 _end_block
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _end_block (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _end_block) (= (length (_end_block . bv)) 2)) ;; bignum
              (write-long (ash (elt (_end_block . bv) 0) 0) s)
              (write-long (ash (elt (_end_block . bv) 1) -1) s))
             ((and (class _end_block) (= (length (_end_block . bv)) 1)) ;; big1
              (write-long (elt (_end_block . bv) 0) s)
              (write-long (if (>= _end_block 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _end_block s)(write-long (if (>= _end_block 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _start_block
#+(or :alpha :irix6 :x86_64)
      (setf _start_block (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _start_block (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _end_block
#+(or :alpha :irix6 :x86_64)
      (setf _end_block (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _end_block (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass kuka_robot::kr_batch_mv_run_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_batch_mv_run_ArgsResponse
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

(defclass kuka_robot::kr_batch_mv_run_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_batch_mv_run_Args :md5sum-) "abfd39835045227435d9bb38a4de4de2")
(setf (get kuka_robot::kr_batch_mv_run_Args :datatype-) "kuka_robot/kr_batch_mv_run_Args")
(setf (get kuka_robot::kr_batch_mv_run_Args :request) kuka_robot::kr_batch_mv_run_ArgsRequest)
(setf (get kuka_robot::kr_batch_mv_run_Args :response) kuka_robot::kr_batch_mv_run_ArgsResponse)

(defmethod kuka_robot::kr_batch_mv_run_ArgsRequest
  (:response () (instance kuka_robot::kr_batch_mv_run_ArgsResponse :init)))

(setf (get kuka_robot::kr_batch_mv_run_ArgsRequest :md5sum-) "abfd39835045227435d9bb38a4de4de2")
(setf (get kuka_robot::kr_batch_mv_run_ArgsRequest :datatype-) "kuka_robot/kr_batch_mv_run_ArgsRequest")
(setf (get kuka_robot::kr_batch_mv_run_ArgsRequest :definition-)
      "
int64 start_block

int64 end_block
---

int64 response


")

(setf (get kuka_robot::kr_batch_mv_run_ArgsResponse :md5sum-) "abfd39835045227435d9bb38a4de4de2")
(setf (get kuka_robot::kr_batch_mv_run_ArgsResponse :datatype-) "kuka_robot/kr_batch_mv_run_ArgsResponse")
(setf (get kuka_robot::kr_batch_mv_run_ArgsResponse :definition-)
      "
int64 start_block

int64 end_block
---

int64 response


")



(provide :kuka_robot/kr_batch_mv_run_Args "abfd39835045227435d9bb38a4de4de2")


