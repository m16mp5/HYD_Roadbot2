;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_batch_mv_byjoint_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_batch_mv_byjoint_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_BYJOINT_ARGS")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_BYJOINT_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_BYJOINT_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_BYJOINT_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_BATCH_MV_BYJOINT_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_BATCH_MV_BYJOINT_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_batch_mv_byjoint_ArgsRequest
  :super ros::object
  :slots (_joints _round _block ))

(defmethod kuka_robot::kr_batch_mv_byjoint_ArgsRequest
  (:init
   (&key
    ((:joints __joints) (instance kuka_robot::kr_joint_Type :init))
    ((:round __round) 0.0)
    ((:block __block) 0)
    )
   (send-super :init)
   (setq _joints __joints)
   (setq _round (float __round))
   (setq _block (round __block))
   self)
  (:joints
   (&rest __joints)
   (if (keywordp (car __joints))
       (send* _joints __joints)
     (progn
       (if __joints (setq _joints (car __joints)))
       _joints)))
  (:round
   (&optional __round)
   (if __round (setq _round __round)) _round)
  (:block
   (&optional __block)
   (if __block (setq _block __block)) _block)
  (:serialization-length
   ()
   (+
    ;; kuka_robot/kr_joint_Type _joints
    (send _joints :serialization-length)
    ;; float64 _round
    8
    ;; int64 _block
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; kuka_robot/kr_joint_Type _joints
       (send _joints :serialize s)
     ;; float64 _round
       (sys::poke _round (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
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
   ;; kuka_robot/kr_joint_Type _joints
     (send _joints :deserialize buf ptr-) (incf ptr- (send _joints :serialization-length))
   ;; float64 _round
     (setq _round (sys::peek buf ptr- :double)) (incf ptr- 8)
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

(defclass kuka_robot::kr_batch_mv_byjoint_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_batch_mv_byjoint_ArgsResponse
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

(defclass kuka_robot::kr_batch_mv_byjoint_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_batch_mv_byjoint_Args :md5sum-) "9cf269bbffea0d211457cbe74178bb95")
(setf (get kuka_robot::kr_batch_mv_byjoint_Args :datatype-) "kuka_robot/kr_batch_mv_byjoint_Args")
(setf (get kuka_robot::kr_batch_mv_byjoint_Args :request) kuka_robot::kr_batch_mv_byjoint_ArgsRequest)
(setf (get kuka_robot::kr_batch_mv_byjoint_Args :response) kuka_robot::kr_batch_mv_byjoint_ArgsResponse)

(defmethod kuka_robot::kr_batch_mv_byjoint_ArgsRequest
  (:response () (instance kuka_robot::kr_batch_mv_byjoint_ArgsResponse :init)))

(setf (get kuka_robot::kr_batch_mv_byjoint_ArgsRequest :md5sum-) "9cf269bbffea0d211457cbe74178bb95")
(setf (get kuka_robot::kr_batch_mv_byjoint_ArgsRequest :datatype-) "kuka_robot/kr_batch_mv_byjoint_ArgsRequest")
(setf (get kuka_robot::kr_batch_mv_byjoint_ArgsRequest :definition-)
      "
kr_joint_Type joints

float64 round

int64 block

================================================================================
MSG: kuka_robot/kr_joint_Type
# Joint Angles [degree]
float64 A1
float64 A2
float64 A3
float64 A4
float64 A5
float64 A6

---

int64 response


")

(setf (get kuka_robot::kr_batch_mv_byjoint_ArgsResponse :md5sum-) "9cf269bbffea0d211457cbe74178bb95")
(setf (get kuka_robot::kr_batch_mv_byjoint_ArgsResponse :datatype-) "kuka_robot/kr_batch_mv_byjoint_ArgsResponse")
(setf (get kuka_robot::kr_batch_mv_byjoint_ArgsResponse :definition-)
      "
kr_joint_Type joints

float64 round

int64 block

================================================================================
MSG: kuka_robot/kr_joint_Type
# Joint Angles [degree]
float64 A1
float64 A2
float64 A3
float64 A4
float64 A5
float64 A6

---

int64 response


")



(provide :kuka_robot/kr_batch_mv_byjoint_Args "9cf269bbffea0d211457cbe74178bb95")


