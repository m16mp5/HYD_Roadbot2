
(cl:in-package :asdf)

(defsystem "lidar_tracker-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "lt_datapoint_Type" :depends-on ("_package_lt_datapoint_Type"))
    (:file "_package_lt_datapoint_Type" :depends-on ("_package"))
    (:file "lt_object_Type" :depends-on ("_package_lt_object_Type"))
    (:file "_package_lt_object_Type" :depends-on ("_package"))
    (:file "lt_state_Type" :depends-on ("_package_lt_state_Type"))
    (:file "_package_lt_state_Type" :depends-on ("_package"))
  ))