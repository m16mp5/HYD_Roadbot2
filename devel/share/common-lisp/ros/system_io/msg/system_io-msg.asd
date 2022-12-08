
(cl:in-package :asdf)

(defsystem "system_io-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "sio_state_Type" :depends-on ("_package_sio_state_Type"))
    (:file "_package_sio_state_Type" :depends-on ("_package"))
  ))