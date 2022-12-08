
(cl:in-package :asdf)

(defsystem "power_system-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ps_state_Type" :depends-on ("_package_ps_state_Type"))
    (:file "_package_ps_state_Type" :depends-on ("_package"))
  ))