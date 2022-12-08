
(cl:in-package :asdf)

(defsystem "power_system-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ps_set_bool_Args" :depends-on ("_package_ps_set_bool_Args"))
    (:file "_package_ps_set_bool_Args" :depends-on ("_package"))
    (:file "ps_set_double_Args" :depends-on ("_package_ps_set_double_Args"))
    (:file "_package_ps_set_double_Args" :depends-on ("_package"))
  ))