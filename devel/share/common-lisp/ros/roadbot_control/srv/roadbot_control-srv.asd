
(cl:in-package :asdf)

(defsystem "roadbot_control-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ac_go_collect_Args" :depends-on ("_package_ac_go_collect_Args"))
    (:file "_package_ac_go_collect_Args" :depends-on ("_package"))
    (:file "ac_go_place_Args" :depends-on ("_package_ac_go_place_Args"))
    (:file "_package_ac_go_place_Args" :depends-on ("_package"))
    (:file "ac_go_signstand_Args" :depends-on ("_package_ac_go_signstand_Args"))
    (:file "_package_ac_go_signstand_Args" :depends-on ("_package"))
    (:file "ac_set_bool_Args" :depends-on ("_package_ac_set_bool_Args"))
    (:file "_package_ac_set_bool_Args" :depends-on ("_package"))
    (:file "ac_set_double_Args" :depends-on ("_package_ac_set_double_Args"))
    (:file "_package_ac_set_double_Args" :depends-on ("_package"))
  ))