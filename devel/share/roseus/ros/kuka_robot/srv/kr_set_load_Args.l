;; Auto-generated. Do not edit!


(when (boundp 'kuka_robot::kr_set_load_Args)
  (if (not (find-package "KUKA_ROBOT"))
    (make-package "KUKA_ROBOT"))
  (shadow 'kr_set_load_Args (find-package "KUKA_ROBOT")))
(unless (find-package "KUKA_ROBOT::KR_SET_LOAD_ARGS")
  (make-package "KUKA_ROBOT::KR_SET_LOAD_ARGS"))
(unless (find-package "KUKA_ROBOT::KR_SET_LOAD_ARGSREQUEST")
  (make-package "KUKA_ROBOT::KR_SET_LOAD_ARGSREQUEST"))
(unless (find-package "KUKA_ROBOT::KR_SET_LOAD_ARGSRESPONSE")
  (make-package "KUKA_ROBOT::KR_SET_LOAD_ARGSRESPONSE"))

(in-package "ROS")





(defclass kuka_robot::kr_set_load_ArgsRequest
  :super ros::object
  :slots (_load _load_a1 _load_a2 _load_a3 ))

(defmethod kuka_robot::kr_set_load_ArgsRequest
  (:init
   (&key
    ((:load __load) (instance kuka_robot::kr_payload_Type :init))
    ((:load_a1 __load_a1) (instance kuka_robot::kr_payload_Type :init))
    ((:load_a2 __load_a2) (instance kuka_robot::kr_payload_Type :init))
    ((:load_a3 __load_a3) (instance kuka_robot::kr_payload_Type :init))
    )
   (send-super :init)
   (setq _load __load)
   (setq _load_a1 __load_a1)
   (setq _load_a2 __load_a2)
   (setq _load_a3 __load_a3)
   self)
  (:load
   (&rest __load)
   (if (keywordp (car __load))
       (send* _load __load)
     (progn
       (if __load (setq _load (car __load)))
       _load)))
  (:load_a1
   (&rest __load_a1)
   (if (keywordp (car __load_a1))
       (send* _load_a1 __load_a1)
     (progn
       (if __load_a1 (setq _load_a1 (car __load_a1)))
       _load_a1)))
  (:load_a2
   (&rest __load_a2)
   (if (keywordp (car __load_a2))
       (send* _load_a2 __load_a2)
     (progn
       (if __load_a2 (setq _load_a2 (car __load_a2)))
       _load_a2)))
  (:load_a3
   (&rest __load_a3)
   (if (keywordp (car __load_a3))
       (send* _load_a3 __load_a3)
     (progn
       (if __load_a3 (setq _load_a3 (car __load_a3)))
       _load_a3)))
  (:serialization-length
   ()
   (+
    ;; kuka_robot/kr_payload_Type _load
    (send _load :serialization-length)
    ;; kuka_robot/kr_payload_Type _load_a1
    (send _load_a1 :serialization-length)
    ;; kuka_robot/kr_payload_Type _load_a2
    (send _load_a2 :serialization-length)
    ;; kuka_robot/kr_payload_Type _load_a3
    (send _load_a3 :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; kuka_robot/kr_payload_Type _load
       (send _load :serialize s)
     ;; kuka_robot/kr_payload_Type _load_a1
       (send _load_a1 :serialize s)
     ;; kuka_robot/kr_payload_Type _load_a2
       (send _load_a2 :serialize s)
     ;; kuka_robot/kr_payload_Type _load_a3
       (send _load_a3 :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; kuka_robot/kr_payload_Type _load
     (send _load :deserialize buf ptr-) (incf ptr- (send _load :serialization-length))
   ;; kuka_robot/kr_payload_Type _load_a1
     (send _load_a1 :deserialize buf ptr-) (incf ptr- (send _load_a1 :serialization-length))
   ;; kuka_robot/kr_payload_Type _load_a2
     (send _load_a2 :deserialize buf ptr-) (incf ptr- (send _load_a2 :serialization-length))
   ;; kuka_robot/kr_payload_Type _load_a3
     (send _load_a3 :deserialize buf ptr-) (incf ptr- (send _load_a3 :serialization-length))
   ;;
   self)
  )

(defclass kuka_robot::kr_set_load_ArgsResponse
  :super ros::object
  :slots (_response ))

(defmethod kuka_robot::kr_set_load_ArgsResponse
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

(defclass kuka_robot::kr_set_load_Args
  :super ros::object
  :slots ())

(setf (get kuka_robot::kr_set_load_Args :md5sum-) "621c48a444ec50a2e8cd24b61ee09b4c")
(setf (get kuka_robot::kr_set_load_Args :datatype-) "kuka_robot/kr_set_load_Args")
(setf (get kuka_robot::kr_set_load_Args :request) kuka_robot::kr_set_load_ArgsRequest)
(setf (get kuka_robot::kr_set_load_Args :response) kuka_robot::kr_set_load_ArgsResponse)

(defmethod kuka_robot::kr_set_load_ArgsRequest
  (:response () (instance kuka_robot::kr_set_load_ArgsResponse :init)))

(setf (get kuka_robot::kr_set_load_ArgsRequest :md5sum-) "621c48a444ec50a2e8cd24b61ee09b4c")
(setf (get kuka_robot::kr_set_load_ArgsRequest :datatype-) "kuka_robot/kr_set_load_ArgsRequest")
(setf (get kuka_robot::kr_set_load_ArgsRequest :definition-)
      "
kr_payload_Type load

kr_payload_Type load_a1

kr_payload_Type load_a2

kr_payload_Type load_a3

================================================================================
MSG: kuka_robot/kr_payload_Type
# Mass [kg]
float64 mass

# Center of mass [mm]
kuka_robot/kr_pose_Type CenterOfGravity

# Inertia [kg-m^2]
kuka_robot/kr_pose_Type Inertia


================================================================================
MSG: kuka_robot/kr_pose_Type
# XYZ coordinate [mm]
float64 X
float64 Y
float64 Z
# ABC orientation [mm]
float64 A
float64 B
float64 C
# Status and Turn [unit]
float64 S
float64 T
---

int64 response


")

(setf (get kuka_robot::kr_set_load_ArgsResponse :md5sum-) "621c48a444ec50a2e8cd24b61ee09b4c")
(setf (get kuka_robot::kr_set_load_ArgsResponse :datatype-) "kuka_robot/kr_set_load_ArgsResponse")
(setf (get kuka_robot::kr_set_load_ArgsResponse :definition-)
      "
kr_payload_Type load

kr_payload_Type load_a1

kr_payload_Type load_a2

kr_payload_Type load_a3

================================================================================
MSG: kuka_robot/kr_payload_Type
# Mass [kg]
float64 mass

# Center of mass [mm]
kuka_robot/kr_pose_Type CenterOfGravity

# Inertia [kg-m^2]
kuka_robot/kr_pose_Type Inertia


================================================================================
MSG: kuka_robot/kr_pose_Type
# XYZ coordinate [mm]
float64 X
float64 Y
float64 Z
# ABC orientation [mm]
float64 A
float64 B
float64 C
# Status and Turn [unit]
float64 S
float64 T
---

int64 response


")



(provide :kuka_robot/kr_set_load_Args "621c48a444ec50a2e8cd24b61ee09b4c")


