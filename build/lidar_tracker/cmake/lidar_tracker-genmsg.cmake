# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "lidar_tracker: 3 messages, 0 services")

set(MSG_I_FLAGS "-Ilidar_tracker:/home/user/Desktop/SrcLink/src/lidar_tracker/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(lidar_tracker_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" NAME_WE)
add_custom_target(_lidar_tracker_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lidar_tracker" "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" NAME_WE)
add_custom_target(_lidar_tracker_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lidar_tracker" "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" "lidar_tracker/lt_object_Type:lidar_tracker/lt_datapoint_Type"
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" NAME_WE)
add_custom_target(_lidar_tracker_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lidar_tracker" "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" "lidar_tracker/lt_datapoint_Type"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lidar_tracker
)
_generate_msg_cpp(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg;/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lidar_tracker
)
_generate_msg_cpp(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lidar_tracker
)

### Generating Services

### Generating Module File
_generate_module_cpp(lidar_tracker
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lidar_tracker
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(lidar_tracker_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(lidar_tracker_generate_messages lidar_tracker_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_cpp _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_cpp _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_cpp _lidar_tracker_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lidar_tracker_gencpp)
add_dependencies(lidar_tracker_gencpp lidar_tracker_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lidar_tracker_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lidar_tracker
)
_generate_msg_eus(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg;/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lidar_tracker
)
_generate_msg_eus(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lidar_tracker
)

### Generating Services

### Generating Module File
_generate_module_eus(lidar_tracker
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lidar_tracker
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(lidar_tracker_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(lidar_tracker_generate_messages lidar_tracker_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_eus _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_eus _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_eus _lidar_tracker_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lidar_tracker_geneus)
add_dependencies(lidar_tracker_geneus lidar_tracker_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lidar_tracker_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lidar_tracker
)
_generate_msg_lisp(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg;/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lidar_tracker
)
_generate_msg_lisp(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lidar_tracker
)

### Generating Services

### Generating Module File
_generate_module_lisp(lidar_tracker
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lidar_tracker
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(lidar_tracker_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(lidar_tracker_generate_messages lidar_tracker_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_lisp _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_lisp _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_lisp _lidar_tracker_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lidar_tracker_genlisp)
add_dependencies(lidar_tracker_genlisp lidar_tracker_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lidar_tracker_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lidar_tracker
)
_generate_msg_nodejs(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg;/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lidar_tracker
)
_generate_msg_nodejs(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lidar_tracker
)

### Generating Services

### Generating Module File
_generate_module_nodejs(lidar_tracker
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lidar_tracker
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(lidar_tracker_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(lidar_tracker_generate_messages lidar_tracker_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_nodejs _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_nodejs _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_nodejs _lidar_tracker_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lidar_tracker_gennodejs)
add_dependencies(lidar_tracker_gennodejs lidar_tracker_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lidar_tracker_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker
)
_generate_msg_py(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg;/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker
)
_generate_msg_py(lidar_tracker
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg"
  "${MSG_I_FLAGS}"
  "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker
)

### Generating Services

### Generating Module File
_generate_module_py(lidar_tracker
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(lidar_tracker_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(lidar_tracker_generate_messages lidar_tracker_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_datapoint_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_py _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_state_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_py _lidar_tracker_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lidar_tracker/msg/lt_object_Type.msg" NAME_WE)
add_dependencies(lidar_tracker_generate_messages_py _lidar_tracker_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lidar_tracker_genpy)
add_dependencies(lidar_tracker_genpy lidar_tracker_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lidar_tracker_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lidar_tracker)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lidar_tracker
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(lidar_tracker_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lidar_tracker)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lidar_tracker
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(lidar_tracker_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lidar_tracker)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lidar_tracker
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(lidar_tracker_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lidar_tracker)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lidar_tracker
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(lidar_tracker_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lidar_tracker
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(lidar_tracker_generate_messages_py std_msgs_generate_messages_py)
endif()
