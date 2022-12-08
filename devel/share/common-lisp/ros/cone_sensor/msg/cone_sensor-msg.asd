
(cl:in-package :asdf)

(defsystem "cone_sensor-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "cs_state_Type" :depends-on ("_package_cs_state_Type"))
    (:file "_package_cs_state_Type" :depends-on ("_package"))
  ))