# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "vision_system: 0 messages, 3 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(vision_system_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" NAME_WE)
add_custom_target(_vision_system_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "vision_system" "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" NAME_WE)
add_custom_target(_vision_system_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "vision_system" "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" NAME_WE)
add_custom_target(_vision_system_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "vision_system" "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/vision_system
)
_generate_srv_cpp(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/vision_system
)
_generate_srv_cpp(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/vision_system
)

### Generating Module File
_generate_module_cpp(vision_system
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/vision_system
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(vision_system_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(vision_system_generate_messages vision_system_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_cpp _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_cpp _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_cpp _vision_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(vision_system_gencpp)
add_dependencies(vision_system_gencpp vision_system_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS vision_system_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/vision_system
)
_generate_srv_eus(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/vision_system
)
_generate_srv_eus(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/vision_system
)

### Generating Module File
_generate_module_eus(vision_system
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/vision_system
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(vision_system_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(vision_system_generate_messages vision_system_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_eus _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_eus _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_eus _vision_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(vision_system_geneus)
add_dependencies(vision_system_geneus vision_system_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS vision_system_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/vision_system
)
_generate_srv_lisp(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/vision_system
)
_generate_srv_lisp(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/vision_system
)

### Generating Module File
_generate_module_lisp(vision_system
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/vision_system
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(vision_system_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(vision_system_generate_messages vision_system_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_lisp _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_lisp _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_lisp _vision_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(vision_system_genlisp)
add_dependencies(vision_system_genlisp vision_system_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS vision_system_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/vision_system
)
_generate_srv_nodejs(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/vision_system
)
_generate_srv_nodejs(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/vision_system
)

### Generating Module File
_generate_module_nodejs(vision_system
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/vision_system
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(vision_system_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(vision_system_generate_messages vision_system_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_nodejs _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_nodejs _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_nodejs _vision_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(vision_system_gennodejs)
add_dependencies(vision_system_gennodejs vision_system_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS vision_system_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system
)
_generate_srv_py(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system
)
_generate_srv_py(vision_system
  "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system
)

### Generating Module File
_generate_module_py(vision_system
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(vision_system_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(vision_system_generate_messages vision_system_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_send_cali_data_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_py _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_check_position_has_cone_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_py _vision_system_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/vision_system/srv/vs_get_white_marking_position_Args.srv" NAME_WE)
add_dependencies(vision_system_generate_messages_py _vision_system_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(vision_system_genpy)
add_dependencies(vision_system_genpy vision_system_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS vision_system_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/vision_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/vision_system
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(vision_system_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/vision_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/vision_system
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(vision_system_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/vision_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/vision_system
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(vision_system_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/vision_system)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/vision_system
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(vision_system_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/vision_system
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(vision_system_generate_messages_py std_msgs_generate_messages_py)
endif()
