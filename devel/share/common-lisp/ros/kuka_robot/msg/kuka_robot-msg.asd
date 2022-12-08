
(cl:in-package :asdf)

(defsystem "kuka_robot-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "kr_joint_Type" :depends-on ("_package_kr_joint_Type"))
    (:file "_package_kr_joint_Type" :depends-on ("_package"))
    (:file "kr_payload_Type" :depends-on ("_package_kr_payload_Type"))
    (:file "_package_kr_payload_Type" :depends-on ("_package"))
    (:file "kr_pose_Type" :depends-on ("_package_kr_pose_Type"))
    (:file "_package_kr_pose_Type" :depends-on ("_package"))
    (:file "kr_robot_error_Type" :depends-on ("_package_kr_robot_error_Type"))
    (:file "_package_kr_robot_error_Type" :depends-on ("_package"))
    (:file "kr_robot_state_Type" :depends-on ("_package_kr_robot_state_Type"))
    (:file "_package_kr_robot_state_Type" :depends-on ("_package"))
  ))