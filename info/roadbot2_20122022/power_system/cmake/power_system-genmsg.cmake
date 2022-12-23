# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "power_system: 1 messages, 2 services")

set(MSG_I_FLAGS "-Ipower_system:/home/user/Desktop/SrcLink/src/power_system/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(power_system_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" NAME_WE)
add_custom_target(_power_system_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "power_system" "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" NAME_WE)
add_custom_target(_power_system_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "power_system" "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" NAME_WE)
add_custom_target(_power_system_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "power_system" "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(power_system
  "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/power_system
)

### Generating Services
_generate_srv_cpp(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/power_system
)
_generate_srv_cpp(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/power_system
)

### Generating Module File
_generate_module_cpp(power_system
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/power_system
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(power_system_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(power_system_generate_messages power_system_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_cpp _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" NAME_WE)
add_dependencies(power_system_generate_messages_cpp _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_cpp _power_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(power_system_gencpp)
add_dependencies(power_system_gencpp power_system_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS power_system_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(power_system
  "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/power_system
)

### Generating Services
_generate_srv_eus(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/power_system
)
_generate_srv_eus(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/power_system
)

### Generating Module File
_generate_module_eus(power_system
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/power_system
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(power_system_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(power_system_generate_messages power_system_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_eus _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" NAME_WE)
add_dependencies(power_system_generate_messages_eus _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_eus _power_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(power_system_geneus)
add_dependencies(power_system_geneus power_system_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS power_system_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(power_system
  "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/power_system
)

### Generating Services
_generate_srv_lisp(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/power_system
)
_generate_srv_lisp(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/power_system
)

### Generating Module File
_generate_module_lisp(power_system
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/power_system
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(power_system_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(power_system_generate_messages power_system_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_lisp _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" NAME_WE)
add_dependencies(power_system_generate_messages_lisp _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_lisp _power_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(power_system_genlisp)
add_dependencies(power_system_genlisp power_system_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS power_system_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(power_system
  "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/power_system
)

### Generating Services
_generate_srv_nodejs(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/power_system
)
_generate_srv_nodejs(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/power_system
)

### Generating Module File
_generate_module_nodejs(power_system
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/power_system
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(power_system_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(power_system_generate_messages power_system_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_nodejs _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" NAME_WE)
add_dependencies(power_system_generate_messages_nodejs _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_nodejs _power_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(power_system_gennodejs)
add_dependencies(power_system_gennodejs power_system_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS power_system_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(power_system
  "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system
)

### Generating Services
_generate_srv_py(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system
)
_generate_srv_py(power_system
  "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system
)

### Generating Module File
_generate_module_py(power_system
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(power_system_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(power_system_generate_messages power_system_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_bool_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_py _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/msg/ps_state_Type.msg" NAME_WE)
add_dependencies(power_system_generate_messages_py _power_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/power_system/srv/ps_set_double_Args.srv" NAME_WE)
add_dependencies(power_system_generate_messages_py _power_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(power_system_genpy)
add_dependencies(power_system_genpy power_system_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS power_system_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/power_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/power_system
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(power_system_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/power_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/power_system
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(power_system_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/power_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/power_system
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(power_system_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/power_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/power_system
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(power_system_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/power_system
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(power_system_generate_messages_py std_msgs_generate_messages_py)
endif()
