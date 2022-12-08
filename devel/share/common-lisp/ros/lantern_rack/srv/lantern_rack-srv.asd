
(cl:in-package :asdf)

(defsystem "lantern_rack-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "lr_set_double_Args" :depends-on ("_package_lr_set_double_Args"))
    (:file "_package_lr_set_double_Args" :depends-on ("_package"))
    (:file "lr_set_mode_Args" :depends-on ("_package_lr_set_mode_Args"))
    (:file "_package_lr_set_mode_Args" :depends-on ("_package"))
  ))