
(cl:in-package :asdf)

(defsystem "vision_system-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "vs_check_position_has_cone_Args" :depends-on ("_package_vs_check_position_has_cone_Args"))
    (:file "_package_vs_check_position_has_cone_Args" :depends-on ("_package"))
    (:file "vs_get_white_marking_position_Args" :depends-on ("_package_vs_get_white_marking_position_Args"))
    (:file "_package_vs_get_white_marking_position_Args" :depends-on ("_package"))
    (:file "vs_send_cali_data_Args" :depends-on ("_package_vs_send_cali_data_Args"))
    (:file "_package_vs_send_cali_data_Args" :depends-on ("_package"))
  ))