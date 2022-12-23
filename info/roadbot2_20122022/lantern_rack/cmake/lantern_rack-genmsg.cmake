# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "lantern_rack: 1 messages, 2 services")

set(MSG_I_FLAGS "-Ilantern_rack:/home/user/Desktop/SrcLink/src/lantern_rack/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(lantern_rack_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" NAME_WE)
add_custom_target(_lantern_rack_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lantern_rack" "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" NAME_WE)
add_custom_target(_lantern_rack_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lantern_rack" "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" NAME_WE)
add_custom_target(_lantern_rack_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lantern_rack" "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lantern_rack
)

### Generating Services
_generate_srv_cpp(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lantern_rack
)
_generate_srv_cpp(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lantern_rack
)

### Generating Module File
_generate_module_cpp(lantern_rack
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lantern_rack
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(lantern_rack_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(lantern_rack_generate_messages lantern_rack_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" NAME_WE)
add_dependencies(lantern_rack_generate_messages_cpp _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_cpp _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_cpp _lantern_rack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lantern_rack_gencpp)
add_dependencies(lantern_rack_gencpp lantern_rack_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lantern_rack_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lantern_rack
)

### Generating Services
_generate_srv_eus(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lantern_rack
)
_generate_srv_eus(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lantern_rack
)

### Generating Module File
_generate_module_eus(lantern_rack
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lantern_rack
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(lantern_rack_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(lantern_rack_generate_messages lantern_rack_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" NAME_WE)
add_dependencies(lantern_rack_generate_messages_eus _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_eus _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_eus _lantern_rack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lantern_rack_geneus)
add_dependencies(lantern_rack_geneus lantern_rack_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lantern_rack_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lantern_rack
)

### Generating Services
_generate_srv_lisp(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lantern_rack
)
_generate_srv_lisp(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lantern_rack
)

### Generating Module File
_generate_module_lisp(lantern_rack
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lantern_rack
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(lantern_rack_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(lantern_rack_generate_messages lantern_rack_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" NAME_WE)
add_dependencies(lantern_rack_generate_messages_lisp _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_lisp _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_lisp _lantern_rack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lantern_rack_genlisp)
add_dependencies(lantern_rack_genlisp lantern_rack_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lantern_rack_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lantern_rack
)

### Generating Services
_generate_srv_nodejs(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lantern_rack
)
_generate_srv_nodejs(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lantern_rack
)

### Generating Module File
_generate_module_nodejs(lantern_rack
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lantern_rack
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(lantern_rack_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(lantern_rack_generate_messages lantern_rack_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" NAME_WE)
add_dependencies(lantern_rack_generate_messages_nodejs _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_nodejs _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_nodejs _lantern_rack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lantern_rack_gennodejs)
add_dependencies(lantern_rack_gennodejs lantern_rack_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lantern_rack_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack
)

### Generating Services
_generate_srv_py(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack
)
_generate_srv_py(lantern_rack
  "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack
)

### Generating Module File
_generate_module_py(lantern_rack
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(lantern_rack_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(lantern_rack_generate_messages lantern_rack_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/msg/lr_state_Type.msg" NAME_WE)
add_dependencies(lantern_rack_generate_messages_py _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_mode_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_py _lantern_rack_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/lantern_rack/srv/lr_set_double_Args.srv" NAME_WE)
add_dependencies(lantern_rack_generate_messages_py _lantern_rack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lantern_rack_genpy)
add_dependencies(lantern_rack_genpy lantern_rack_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lantern_rack_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lantern_rack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lantern_rack
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(lantern_rack_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lantern_rack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lantern_rack
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(lantern_rack_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lantern_rack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lantern_rack
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(lantern_rack_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lantern_rack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lantern_rack
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(lantern_rack_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lantern_rack
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(lantern_rack_generate_messages_py std_msgs_generate_messages_py)
endif()
