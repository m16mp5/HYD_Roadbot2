# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "kuka_robot: 5 messages, 17 services")

set(MSG_I_FLAGS "-Ikuka_robot:/home/user/Desktop/SrcLink/src/kuka_robot/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(kuka_robot_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" "kuka_robot/kr_pose_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" "kuka_robot/kr_pose_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" "kuka_robot/kr_joint_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" "kuka_robot/kr_pose_Type:kuka_robot/kr_joint_Type:kuka_robot/kr_robot_error_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" "kuka_robot/kr_joint_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" "kuka_robot/kr_payload_Type:kuka_robot/kr_pose_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" "kuka_robot/kr_pose_Type:kuka_robot/kr_joint_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" NAME_WE)
add_custom_target(_kuka_robot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "kuka_robot" "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" "kuka_robot/kr_pose_Type"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_msg_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_msg_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_msg_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_msg_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)

### Generating Services
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)
_generate_srv_cpp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
)

### Generating Module File
_generate_module_cpp(kuka_robot
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(kuka_robot_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(kuka_robot_generate_messages kuka_robot_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_cpp _kuka_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(kuka_robot_gencpp)
add_dependencies(kuka_robot_gencpp kuka_robot_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS kuka_robot_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_msg_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_msg_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_msg_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_msg_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)

### Generating Services
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)
_generate_srv_eus(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
)

### Generating Module File
_generate_module_eus(kuka_robot
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(kuka_robot_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(kuka_robot_generate_messages kuka_robot_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_eus _kuka_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(kuka_robot_geneus)
add_dependencies(kuka_robot_geneus kuka_robot_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS kuka_robot_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_msg_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_msg_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_msg_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_msg_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)

### Generating Services
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)
_generate_srv_lisp(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
)

### Generating Module File
_generate_module_lisp(kuka_robot
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(kuka_robot_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(kuka_robot_generate_messages kuka_robot_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_lisp _kuka_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(kuka_robot_genlisp)
add_dependencies(kuka_robot_genlisp kuka_robot_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS kuka_robot_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_msg_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_msg_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_msg_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_msg_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)

### Generating Services
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)
_generate_srv_nodejs(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
)

### Generating Module File
_generate_module_nodejs(kuka_robot
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(kuka_robot_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(kuka_robot_generate_messages kuka_robot_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_nodejs _kuka_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(kuka_robot_gennodejs)
add_dependencies(kuka_robot_gennodejs kuka_robot_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS kuka_robot_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_msg_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_msg_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_msg_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_msg_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)

### Generating Services
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg;/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)
_generate_srv_py(kuka_robot
  "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
)

### Generating Module File
_generate_module_py(kuka_robot
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(kuka_robot_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(kuka_robot_generate_messages kuka_robot_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv" NAME_WE)
add_dependencies(kuka_robot_generate_messages_py _kuka_robot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(kuka_robot_genpy)
add_dependencies(kuka_robot_genpy kuka_robot_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS kuka_robot_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/kuka_robot
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(kuka_robot_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/kuka_robot
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(kuka_robot_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/kuka_robot
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(kuka_robot_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/kuka_robot
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(kuka_robot_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/kuka_robot
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(kuka_robot_generate_messages_py std_msgs_generate_messages_py)
endif()
