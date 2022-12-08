
(cl:in-package :asdf)

(defsystem "system_io-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "sio_set_bool_Args" :depends-on ("_package_sio_set_bool_Args"))
    (:file "_package_sio_set_bool_Args" :depends-on ("_package"))
    (:file "sio_set_double_Args" :depends-on ("_package_sio_set_double_Args"))
    (:file "_package_sio_set_double_Args" :depends-on ("_package"))
    (:file "sio_set_value_Args" :depends-on ("_package_sio_set_value_Args"))
    (:file "_package_sio_set_value_Args" :depends-on ("_package"))
  ))