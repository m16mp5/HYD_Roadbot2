
(cl:in-package :asdf)

(defsystem "lantern_rack-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "lr_state_Type" :depends-on ("_package_lr_state_Type"))
    (:file "_package_lr_state_Type" :depends-on ("_package"))
  ))