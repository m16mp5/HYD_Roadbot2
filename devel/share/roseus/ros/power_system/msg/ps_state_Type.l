;; Auto-generated. Do not edit!


(when (boundp 'power_system::ps_state_Type)
  (if (not (find-package "POWER_SYSTEM"))
    (make-package "POWER_SYSTEM"))
  (shadow 'ps_state_Type (find-package "POWER_SYSTEM")))
(unless (find-package "POWER_SYSTEM::PS_STATE_TYPE")
  (make-package "POWER_SYSTEM::PS_STATE_TYPE"))

(in-package "ROS")
;;//! \htmlinclude ps_state_Type.msg.html


(defclass power_system::ps_state_Type
  :super ros::object
  :slots (_timestamp _th_temperature _th_humidity _meter_phA_V _meter_phB_V _meter_phC_V _meter_phA_I _meter_phB_I _meter_phC_I _meter_tot_W _meter_phA_W _meter_phB_W _meter_phC_W _mcb_V _mcb_I _mcb_sw_pos _state_temphum _state_meter _state_mcb ))

(defmethod power_system::ps_state_Type
  (:init
   (&key
    ((:timestamp __timestamp) 0.0)
    ((:th_temperature __th_temperature) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:th_humidity __th_humidity) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phA_V __meter_phA_V) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phB_V __meter_phB_V) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phC_V __meter_phC_V) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phA_I __meter_phA_I) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phB_I __meter_phB_I) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phC_I __meter_phC_I) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_tot_W __meter_tot_W) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phA_W __meter_phA_W) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phB_W __meter_phB_W) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:meter_phC_W __meter_phC_W) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:mcb_V __mcb_V) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:mcb_I __mcb_I) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:mcb_sw_pos __mcb_sw_pos) (make-array 2 :initial-element 0 :element-type :integer))
    ((:state_temphum __state_temphum) (make-array 2 :initial-element 0 :element-type :integer))
    ((:state_meter __state_meter) (make-array 2 :initial-element 0 :element-type :integer))
    ((:state_mcb __state_mcb) (make-array 2 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _timestamp (float __timestamp))
   (setq _th_temperature __th_temperature)
   (setq _th_humidity __th_humidity)
   (setq _meter_phA_V __meter_phA_V)
   (setq _meter_phB_V __meter_phB_V)
   (setq _meter_phC_V __meter_phC_V)
   (setq _meter_phA_I __meter_phA_I)
   (setq _meter_phB_I __meter_phB_I)
   (setq _meter_phC_I __meter_phC_I)
   (setq _meter_tot_W __meter_tot_W)
   (setq _meter_phA_W __meter_phA_W)
   (setq _meter_phB_W __meter_phB_W)
   (setq _meter_phC_W __meter_phC_W)
   (setq _mcb_V __mcb_V)
   (setq _mcb_I __mcb_I)
   (setq _mcb_sw_pos __mcb_sw_pos)
   (setq _state_temphum __state_temphum)
   (setq _state_meter __state_meter)
   (setq _state_mcb __state_mcb)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:th_temperature
   (&optional __th_temperature)
   (if __th_temperature (setq _th_temperature __th_temperature)) _th_temperature)
  (:th_humidity
   (&optional __th_humidity)
   (if __th_humidity (setq _th_humidity __th_humidity)) _th_humidity)
  (:meter_phA_V
   (&optional __meter_phA_V)
   (if __meter_phA_V (setq _meter_phA_V __meter_phA_V)) _meter_phA_V)
  (:meter_phB_V
   (&optional __meter_phB_V)
   (if __meter_phB_V (setq _meter_phB_V __meter_phB_V)) _meter_phB_V)
  (:meter_phC_V
   (&optional __meter_phC_V)
   (if __meter_phC_V (setq _meter_phC_V __meter_phC_V)) _meter_phC_V)
  (:meter_phA_I
   (&optional __meter_phA_I)
   (if __meter_phA_I (setq _meter_phA_I __meter_phA_I)) _meter_phA_I)
  (:meter_phB_I
   (&optional __meter_phB_I)
   (if __meter_phB_I (setq _meter_phB_I __meter_phB_I)) _meter_phB_I)
  (:meter_phC_I
   (&optional __meter_phC_I)
   (if __meter_phC_I (setq _meter_phC_I __meter_phC_I)) _meter_phC_I)
  (:meter_tot_W
   (&optional __meter_tot_W)
   (if __meter_tot_W (setq _meter_tot_W __meter_tot_W)) _meter_tot_W)
  (:meter_phA_W
   (&optional __meter_phA_W)
   (if __meter_phA_W (setq _meter_phA_W __meter_phA_W)) _meter_phA_W)
  (:meter_phB_W
   (&optional __meter_phB_W)
   (if __meter_phB_W (setq _meter_phB_W __meter_phB_W)) _meter_phB_W)
  (:meter_phC_W
   (&optional __meter_phC_W)
   (if __meter_phC_W (setq _meter_phC_W __meter_phC_W)) _meter_phC_W)
  (:mcb_V
   (&optional __mcb_V)
   (if __mcb_V (setq _mcb_V __mcb_V)) _mcb_V)
  (:mcb_I
   (&optional __mcb_I)
   (if __mcb_I (setq _mcb_I __mcb_I)) _mcb_I)
  (:mcb_sw_pos
   (&optional __mcb_sw_pos)
   (if __mcb_sw_pos (setq _mcb_sw_pos __mcb_sw_pos)) _mcb_sw_pos)
  (:state_temphum
   (&optional __state_temphum)
   (if __state_temphum (setq _state_temphum __state_temphum)) _state_temphum)
  (:state_meter
   (&optional __state_meter)
   (if __state_meter (setq _state_meter __state_meter)) _state_meter)
  (:state_mcb
   (&optional __state_mcb)
   (if __state_mcb (setq _state_mcb __state_mcb)) _state_mcb)
  (:serialization-length
   ()
   (+
    ;; float64 _timestamp
    8
    ;; float64[2] _th_temperature
    (* 8    2)
    ;; float64[2] _th_humidity
    (* 8    2)
    ;; float64[2] _meter_phA_V
    (* 8    2)
    ;; float64[2] _meter_phB_V
    (* 8    2)
    ;; float64[2] _meter_phC_V
    (* 8    2)
    ;; float64[2] _meter_phA_I
    (* 8    2)
    ;; float64[2] _meter_phB_I
    (* 8    2)
    ;; float64[2] _meter_phC_I
    (* 8    2)
    ;; float64[2] _meter_tot_W
    (* 8    2)
    ;; float64[2] _meter_phA_W
    (* 8    2)
    ;; float64[2] _meter_phB_W
    (* 8    2)
    ;; float64[2] _meter_phC_W
    (* 8    2)
    ;; float64[2] _mcb_V
    (* 8    2)
    ;; float64[2] _mcb_I
    (* 8    2)
    ;; int64[2] _mcb_sw_pos
    (* 8    2)
    ;; int64[2] _state_temphum
    (* 8    2)
    ;; int64[2] _state_meter
    (* 8    2)
    ;; int64[2] _state_mcb
    (* 8    2)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _timestamp
       (sys::poke _timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[2] _th_temperature
     (dotimes (i 2)
       (sys::poke (elt _th_temperature i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _th_humidity
     (dotimes (i 2)
       (sys::poke (elt _th_humidity i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phA_V
     (dotimes (i 2)
       (sys::poke (elt _meter_phA_V i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phB_V
     (dotimes (i 2)
       (sys::poke (elt _meter_phB_V i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phC_V
     (dotimes (i 2)
       (sys::poke (elt _meter_phC_V i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phA_I
     (dotimes (i 2)
       (sys::poke (elt _meter_phA_I i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phB_I
     (dotimes (i 2)
       (sys::poke (elt _meter_phB_I i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phC_I
     (dotimes (i 2)
       (sys::poke (elt _meter_phC_I i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_tot_W
     (dotimes (i 2)
       (sys::poke (elt _meter_tot_W i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phA_W
     (dotimes (i 2)
       (sys::poke (elt _meter_phA_W i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phB_W
     (dotimes (i 2)
       (sys::poke (elt _meter_phB_W i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _meter_phC_W
     (dotimes (i 2)
       (sys::poke (elt _meter_phC_W i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _mcb_V
     (dotimes (i 2)
       (sys::poke (elt _mcb_V i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[2] _mcb_I
     (dotimes (i 2)
       (sys::poke (elt _mcb_I i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; int64[2] _mcb_sw_pos
     (dotimes (i 2)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _mcb_sw_pos i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _mcb_sw_pos i)) (= (length ((elt _mcb_sw_pos i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _mcb_sw_pos i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _mcb_sw_pos i) . bv) 1) -1) s))
             ((and (class (elt _mcb_sw_pos i)) (= (length ((elt _mcb_sw_pos i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _mcb_sw_pos i) . bv) 0) s)
              (write-long (if (>= (elt _mcb_sw_pos i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _mcb_sw_pos i) s)(write-long (if (>= (elt _mcb_sw_pos i) 0) 0 #xffffffff) s)))
       )
     ;; int64[2] _state_temphum
     (dotimes (i 2)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _state_temphum i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _state_temphum i)) (= (length ((elt _state_temphum i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _state_temphum i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _state_temphum i) . bv) 1) -1) s))
             ((and (class (elt _state_temphum i)) (= (length ((elt _state_temphum i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _state_temphum i) . bv) 0) s)
              (write-long (if (>= (elt _state_temphum i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _state_temphum i) s)(write-long (if (>= (elt _state_temphum i) 0) 0 #xffffffff) s)))
       )
     ;; int64[2] _state_meter
     (dotimes (i 2)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _state_meter i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _state_meter i)) (= (length ((elt _state_meter i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _state_meter i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _state_meter i) . bv) 1) -1) s))
             ((and (class (elt _state_meter i)) (= (length ((elt _state_meter i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _state_meter i) . bv) 0) s)
              (write-long (if (>= (elt _state_meter i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _state_meter i) s)(write-long (if (>= (elt _state_meter i) 0) 0 #xffffffff) s)))
       )
     ;; int64[2] _state_mcb
     (dotimes (i 2)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _state_mcb i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _state_mcb i)) (= (length ((elt _state_mcb i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _state_mcb i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _state_mcb i) . bv) 1) -1) s))
             ((and (class (elt _state_mcb i)) (= (length ((elt _state_mcb i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _state_mcb i) . bv) 0) s)
              (write-long (if (>= (elt _state_mcb i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _state_mcb i) s)(write-long (if (>= (elt _state_mcb i) 0) 0 #xffffffff) s)))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _timestamp
     (setq _timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[2] _th_temperature
   (dotimes (i (length _th_temperature))
     (setf (elt _th_temperature i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _th_humidity
   (dotimes (i (length _th_humidity))
     (setf (elt _th_humidity i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phA_V
   (dotimes (i (length _meter_phA_V))
     (setf (elt _meter_phA_V i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phB_V
   (dotimes (i (length _meter_phB_V))
     (setf (elt _meter_phB_V i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phC_V
   (dotimes (i (length _meter_phC_V))
     (setf (elt _meter_phC_V i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phA_I
   (dotimes (i (length _meter_phA_I))
     (setf (elt _meter_phA_I i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phB_I
   (dotimes (i (length _meter_phB_I))
     (setf (elt _meter_phB_I i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phC_I
   (dotimes (i (length _meter_phC_I))
     (setf (elt _meter_phC_I i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_tot_W
   (dotimes (i (length _meter_tot_W))
     (setf (elt _meter_tot_W i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phA_W
   (dotimes (i (length _meter_phA_W))
     (setf (elt _meter_phA_W i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phB_W
   (dotimes (i (length _meter_phB_W))
     (setf (elt _meter_phB_W i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _meter_phC_W
   (dotimes (i (length _meter_phC_W))
     (setf (elt _meter_phC_W i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _mcb_V
   (dotimes (i (length _mcb_V))
     (setf (elt _mcb_V i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[2] _mcb_I
   (dotimes (i (length _mcb_I))
     (setf (elt _mcb_I i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; int64[2] _mcb_sw_pos
   (dotimes (i (length _mcb_sw_pos))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _mcb_sw_pos i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _mcb_sw_pos i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; int64[2] _state_temphum
   (dotimes (i (length _state_temphum))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _state_temphum i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _state_temphum i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; int64[2] _state_meter
   (dotimes (i (length _state_meter))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _state_meter i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _state_meter i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; int64[2] _state_mcb
   (dotimes (i (length _state_mcb))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _state_mcb i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _state_mcb i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get power_system::ps_state_Type :md5sum-) "e128e49adf15f8c39cb073cd0ec61c2e")
(setf (get power_system::ps_state_Type :datatype-) "power_system/ps_state_Type")
(setf (get power_system::ps_state_Type :definition-)
      "# Timestamp [s]
float64 timestamp

# 2 humidity and sensor readings
float64[2] th_temperature
float64[2] th_humidity

# 2 3-phase meter sensor readings
float64[2] meter_phA_V
float64[2] meter_phB_V
float64[2] meter_phC_V
float64[2] meter_phA_I
float64[2] meter_phB_I
float64[2] meter_phC_I
float64[2] meter_tot_W
float64[2] meter_phA_W
float64[2] meter_phB_W
float64[2] meter_phC_W

# 2 3-phase inverter MCB readings
float64[2] mcb_V
float64[2] mcb_I
int64[2] mcb_sw_pos

# sensor boxes error state
int64[2] state_temphum
int64[2] state_meter
int64[2] state_mcb

")



(provide :power_system/ps_state_Type "e128e49adf15f8c39cb073cd0ec61c2e")


