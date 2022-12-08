;; Auto-generated. Do not edit!


(when (boundp 'vision_system::vs_send_cali_data_Args)
  (if (not (find-package "VISION_SYSTEM"))
    (make-package "VISION_SYSTEM"))
  (shadow 'vs_send_cali_data_Args (find-package "VISION_SYSTEM")))
(unless (find-package "VISION_SYSTEM::VS_SEND_CALI_DATA_ARGS")
  (make-package "VISION_SYSTEM::VS_SEND_CALI_DATA_ARGS"))
(unless (find-package "VISION_SYSTEM::VS_SEND_CALI_DATA_ARGSREQUEST")
  (make-package "VISION_SYSTEM::VS_SEND_CALI_DATA_ARGSREQUEST"))
(unless (find-package "VISION_SYSTEM::VS_SEND_CALI_DATA_ARGSRESPONSE")
  (make-package "VISION_SYSTEM::VS_SEND_CALI_DATA_ARGSRESPONSE"))

(in-package "ROS")





(defclass vision_system::vs_send_cali_data_ArgsRequest
  :super ros::object
  :slots (_caliD_0 _caliD_1 _caliD_2 _caliD_3 _caliD_4 _caliD_5 _caliD_6 _caliD_7 _Is_HD_check ))

(defmethod vision_system::vs_send_cali_data_ArgsRequest
  (:init
   (&key
    ((:caliD_0 __caliD_0) 0)
    ((:caliD_1 __caliD_1) 0)
    ((:caliD_2 __caliD_2) 0)
    ((:caliD_3 __caliD_3) 0)
    ((:caliD_4 __caliD_4) 0)
    ((:caliD_5 __caliD_5) 0)
    ((:caliD_6 __caliD_6) 0)
    ((:caliD_7 __caliD_7) 0)
    ((:Is_HD_check __Is_HD_check) nil)
    )
   (send-super :init)
   (setq _caliD_0 (round __caliD_0))
   (setq _caliD_1 (round __caliD_1))
   (setq _caliD_2 (round __caliD_2))
   (setq _caliD_3 (round __caliD_3))
   (setq _caliD_4 (round __caliD_4))
   (setq _caliD_5 (round __caliD_5))
   (setq _caliD_6 (round __caliD_6))
   (setq _caliD_7 (round __caliD_7))
   (setq _Is_HD_check __Is_HD_check)
   self)
  (:caliD_0
   (&optional __caliD_0)
   (if __caliD_0 (setq _caliD_0 __caliD_0)) _caliD_0)
  (:caliD_1
   (&optional __caliD_1)
   (if __caliD_1 (setq _caliD_1 __caliD_1)) _caliD_1)
  (:caliD_2
   (&optional __caliD_2)
   (if __caliD_2 (setq _caliD_2 __caliD_2)) _caliD_2)
  (:caliD_3
   (&optional __caliD_3)
   (if __caliD_3 (setq _caliD_3 __caliD_3)) _caliD_3)
  (:caliD_4
   (&optional __caliD_4)
   (if __caliD_4 (setq _caliD_4 __caliD_4)) _caliD_4)
  (:caliD_5
   (&optional __caliD_5)
   (if __caliD_5 (setq _caliD_5 __caliD_5)) _caliD_5)
  (:caliD_6
   (&optional __caliD_6)
   (if __caliD_6 (setq _caliD_6 __caliD_6)) _caliD_6)
  (:caliD_7
   (&optional __caliD_7)
   (if __caliD_7 (setq _caliD_7 __caliD_7)) _caliD_7)
  (:Is_HD_check
   (&optional __Is_HD_check)
   (if __Is_HD_check (setq _Is_HD_check __Is_HD_check)) _Is_HD_check)
  (:serialization-length
   ()
   (+
    ;; int64 _caliD_0
    8
    ;; int64 _caliD_1
    8
    ;; int64 _caliD_2
    8
    ;; int64 _caliD_3
    8
    ;; int64 _caliD_4
    8
    ;; int64 _caliD_5
    8
    ;; int64 _caliD_6
    8
    ;; int64 _caliD_7
    8
    ;; bool _Is_HD_check
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _caliD_0
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_0 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_0) (= (length (_caliD_0 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_0 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_0 . bv) 1) -1) s))
             ((and (class _caliD_0) (= (length (_caliD_0 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_0 . bv) 0) s)
              (write-long (if (>= _caliD_0 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_0 s)(write-long (if (>= _caliD_0 0) 0 #xffffffff) s)))
     ;; int64 _caliD_1
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_1 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_1) (= (length (_caliD_1 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_1 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_1 . bv) 1) -1) s))
             ((and (class _caliD_1) (= (length (_caliD_1 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_1 . bv) 0) s)
              (write-long (if (>= _caliD_1 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_1 s)(write-long (if (>= _caliD_1 0) 0 #xffffffff) s)))
     ;; int64 _caliD_2
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_2 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_2) (= (length (_caliD_2 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_2 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_2 . bv) 1) -1) s))
             ((and (class _caliD_2) (= (length (_caliD_2 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_2 . bv) 0) s)
              (write-long (if (>= _caliD_2 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_2 s)(write-long (if (>= _caliD_2 0) 0 #xffffffff) s)))
     ;; int64 _caliD_3
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_3 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_3) (= (length (_caliD_3 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_3 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_3 . bv) 1) -1) s))
             ((and (class _caliD_3) (= (length (_caliD_3 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_3 . bv) 0) s)
              (write-long (if (>= _caliD_3 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_3 s)(write-long (if (>= _caliD_3 0) 0 #xffffffff) s)))
     ;; int64 _caliD_4
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_4 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_4) (= (length (_caliD_4 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_4 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_4 . bv) 1) -1) s))
             ((and (class _caliD_4) (= (length (_caliD_4 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_4 . bv) 0) s)
              (write-long (if (>= _caliD_4 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_4 s)(write-long (if (>= _caliD_4 0) 0 #xffffffff) s)))
     ;; int64 _caliD_5
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_5 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_5) (= (length (_caliD_5 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_5 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_5 . bv) 1) -1) s))
             ((and (class _caliD_5) (= (length (_caliD_5 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_5 . bv) 0) s)
              (write-long (if (>= _caliD_5 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_5 s)(write-long (if (>= _caliD_5 0) 0 #xffffffff) s)))
     ;; int64 _caliD_6
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_6 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_6) (= (length (_caliD_6 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_6 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_6 . bv) 1) -1) s))
             ((and (class _caliD_6) (= (length (_caliD_6 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_6 . bv) 0) s)
              (write-long (if (>= _caliD_6 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_6 s)(write-long (if (>= _caliD_6 0) 0 #xffffffff) s)))
     ;; int64 _caliD_7
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _caliD_7 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _caliD_7) (= (length (_caliD_7 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_caliD_7 . bv) 0) 0) s)
              (write-long (ash (elt (_caliD_7 . bv) 1) -1) s))
             ((and (class _caliD_7) (= (length (_caliD_7 . bv)) 1)) ;; big1
              (write-long (elt (_caliD_7 . bv) 0) s)
              (write-long (if (>= _caliD_7 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _caliD_7 s)(write-long (if (>= _caliD_7 0) 0 #xffffffff) s)))
     ;; bool _Is_HD_check
       (if _Is_HD_check (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _caliD_0
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_0 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_0 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_1
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_1 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_1 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_2
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_2 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_2 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_3
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_3 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_3 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_4
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_4 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_4 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_5
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_5 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_5 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_6
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_6 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_6 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _caliD_7
#+(or :alpha :irix6 :x86_64)
      (setf _caliD_7 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _caliD_7 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _Is_HD_check
     (setq _Is_HD_check (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass vision_system::vs_send_cali_data_ArgsResponse
  :super ros::object
  :slots (_response _result_code ))

(defmethod vision_system::vs_send_cali_data_ArgsResponse
  (:init
   (&key
    ((:response __response) 0)
    ((:result_code __result_code) 0)
    )
   (send-super :init)
   (setq _response (round __response))
   (setq _result_code (round __result_code))
   self)
  (:response
   (&optional __response)
   (if __response (setq _response __response)) _response)
  (:result_code
   (&optional __result_code)
   (if __result_code (setq _result_code __result_code)) _result_code)
  (:serialization-length
   ()
   (+
    ;; int64 _response
    8
    ;; int64 _result_code
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
     ;; int64 _result_code
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _result_code (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _result_code) (= (length (_result_code . bv)) 2)) ;; bignum
              (write-long (ash (elt (_result_code . bv) 0) 0) s)
              (write-long (ash (elt (_result_code . bv) 1) -1) s))
             ((and (class _result_code) (= (length (_result_code . bv)) 1)) ;; big1
              (write-long (elt (_result_code . bv) 0) s)
              (write-long (if (>= _result_code 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _result_code s)(write-long (if (>= _result_code 0) 0 #xffffffff) s)))
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
   ;; int64 _result_code
#+(or :alpha :irix6 :x86_64)
      (setf _result_code (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _result_code (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(defclass vision_system::vs_send_cali_data_Args
  :super ros::object
  :slots ())

(setf (get vision_system::vs_send_cali_data_Args :md5sum-) "f30152e5d2a43a58c59d2b40816d1dd0")
(setf (get vision_system::vs_send_cali_data_Args :datatype-) "vision_system/vs_send_cali_data_Args")
(setf (get vision_system::vs_send_cali_data_Args :request) vision_system::vs_send_cali_data_ArgsRequest)
(setf (get vision_system::vs_send_cali_data_Args :response) vision_system::vs_send_cali_data_ArgsResponse)

(defmethod vision_system::vs_send_cali_data_ArgsRequest
  (:response () (instance vision_system::vs_send_cali_data_ArgsResponse :init)))

(setf (get vision_system::vs_send_cali_data_ArgsRequest :md5sum-) "f30152e5d2a43a58c59d2b40816d1dd0")
(setf (get vision_system::vs_send_cali_data_ArgsRequest :datatype-) "vision_system/vs_send_cali_data_ArgsRequest")
(setf (get vision_system::vs_send_cali_data_ArgsRequest :definition-)
      "
int64 caliD_0
int64 caliD_1
int64 caliD_2
int64 caliD_3
int64 caliD_4
int64 caliD_5
int64 caliD_6
int64 caliD_7
bool Is_HD_check

---

int64 response


int64 result_code
")

(setf (get vision_system::vs_send_cali_data_ArgsResponse :md5sum-) "f30152e5d2a43a58c59d2b40816d1dd0")
(setf (get vision_system::vs_send_cali_data_ArgsResponse :datatype-) "vision_system/vs_send_cali_data_ArgsResponse")
(setf (get vision_system::vs_send_cali_data_ArgsResponse :definition-)
      "
int64 caliD_0
int64 caliD_1
int64 caliD_2
int64 caliD_3
int64 caliD_4
int64 caliD_5
int64 caliD_6
int64 caliD_7
bool Is_HD_check

---

int64 response


int64 result_code
")



(provide :vision_system/vs_send_cali_data_Args "f30152e5d2a43a58c59d2b40816d1dd0")


