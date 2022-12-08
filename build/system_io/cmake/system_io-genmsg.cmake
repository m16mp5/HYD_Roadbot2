# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "system_io: 1 messages, 3 services")

set(MSG_I_FLAGS "-Isystem_io:/home/user/Desktop/SrcLink/src/system_io/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(system_io_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" NAME_WE)
add_custom_target(_system_io_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "system_io" "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" NAME_WE)
add_custom_target(_system_io_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "system_io" "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" NAME_WE)
add_custom_target(_system_io_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "system_io" "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" ""
)

get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" NAME_WE)
add_custom_target(_system_io_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "system_io" "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io
)

### Generating Services
_generate_srv_cpp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io
)
_generate_srv_cpp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io
)
_generate_srv_cpp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io
)

### Generating Module File
_generate_module_cpp(system_io
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(system_io_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(system_io_generate_messages system_io_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" NAME_WE)
add_dependencies(system_io_generate_messages_cpp _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_cpp _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_cpp _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_cpp _system_io_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(system_io_gencpp)
add_dependencies(system_io_gencpp system_io_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS system_io_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(system_io
  "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io
)

### Generating Services
_generate_srv_eus(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io
)
_generate_srv_eus(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io
)
_generate_srv_eus(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io
)

### Generating Module File
_generate_module_eus(system_io
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(system_io_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(system_io_generate_messages system_io_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" NAME_WE)
add_dependencies(system_io_generate_messages_eus _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_eus _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_eus _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_eus _system_io_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(system_io_geneus)
add_dependencies(system_io_geneus system_io_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS system_io_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io
)

### Generating Services
_generate_srv_lisp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io
)
_generate_srv_lisp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io
)
_generate_srv_lisp(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io
)

### Generating Module File
_generate_module_lisp(system_io
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(system_io_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(system_io_generate_messages system_io_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" NAME_WE)
add_dependencies(system_io_generate_messages_lisp _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_lisp _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_lisp _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_lisp _system_io_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(system_io_genlisp)
add_dependencies(system_io_genlisp system_io_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS system_io_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(system_io
  "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io
)

### Generating Services
_generate_srv_nodejs(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io
)
_generate_srv_nodejs(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io
)
_generate_srv_nodejs(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io
)

### Generating Module File
_generate_module_nodejs(system_io
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(system_io_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(system_io_generate_messages system_io_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" NAME_WE)
add_dependencies(system_io_generate_messages_nodejs _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_nodejs _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_nodejs _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_nodejs _system_io_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(system_io_gennodejs)
add_dependencies(system_io_gennodejs system_io_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS system_io_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(system_io
  "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io
)

### Generating Services
_generate_srv_py(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io
)
_generate_srv_py(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io
)
_generate_srv_py(system_io
  "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io
)

### Generating Module File
_generate_module_py(system_io
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(system_io_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(system_io_generate_messages system_io_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/msg/sio_state_Type.msg" NAME_WE)
add_dependencies(system_io_generate_messages_py _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_double_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_py _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_value_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_py _system_io_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/user/Desktop/SrcLink/src/system_io/srv/sio_set_bool_Args.srv" NAME_WE)
add_dependencies(system_io_generate_messages_py _system_io_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(system_io_genpy)
add_dependencies(system_io_genpy system_io_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS system_io_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/system_io
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(system_io_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/system_io
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(system_io_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/system_io
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(system_io_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/system_io
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(system_io_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/system_io
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(system_io_generate_messages_py std_msgs_generate_messages_py)
endif()
