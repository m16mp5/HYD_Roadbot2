;; Auto-generated. Do not edit!


(when (boundp 'cone_sensor::cs_state_Type)
  (if (not (find-package "CONE_SENSOR"))
    (make-package "CONE_SENSOR"))
  (shadow 'cs_state_Type (find-package "CONE_SENSOR")))
(unless (find-package "CONE_SENSOR::CS_STATE_TYPE")
  (make-package "CONE_SENSOR::CS_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude cs_state_Type.msg.html


(defclass cone_sensor::cs_state_Type
  :super ros::object
  :slots (_timestamp _weight_slots _state ))

(defmethod cone_sensor::cs_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:weight_slots __weight_slots) (make-array 14 :initial-element 0.0 :element-type :float))
    ((:state __state) (make-array 14 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _weight_slots __weight_slots)
   (setq _state __state)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:weight_slots
   (&optional __weight_slots)
   (if __weight_slots (setq _weight_slots __weight_slots)) _weight_slots)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; float64[14] _weight_slots
    (* 8    14)
    ;; int64[14] _state
    (* 8    14)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[14] _weight_slots
     (dotimes (i 14)
       (sys::poke (elt _weight_slots i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; int64[14] _state
     (dotimes (i 14)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _state i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _state i)) (= (length ((elt _state i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _state i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _state i) . bv) 1) -1) s))
             ((and (class (elt _state i)) (= (length ((elt _state i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _state i) . bv) 0) s)
              (write-long (if (>= (elt _state i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _state i) s)(write-long (if (>= (elt _state i) 0) 0 #xffffffff) s)))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[14] _weight_slots
   (dotimes (i (length _weight_slots))
     (setf (elt _weight_slots i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; int64[14] _state
   (dotimes (i (length _state))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _state i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _state i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;;
   self)
  )

(setf (get cone_sensor::cs_state_Type :md5sum-) "ed4de7dc8dadb6133b9f1ded06e00707")
(setf (get cone_sensor::cs_state_Type :datatype-) "cone_sensor/cs_state_Type")
(setf (get cone_sensor::cs_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# 14 weight sensor readings in [kg]
float64[14] weight_slots

# 14 sensor error state
int64[14] state



")



(provide :cone_sensor/cs_state_Type "ed4de7dc8dadb6133b9f1ded06e00707")


