# Install script for directory: /home/user/Desktop/SrcLink/src/kuka_robot

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/user/Desktop/SrcLink/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/kuka_robot/msg" TYPE FILE FILES
    "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_joint_Type.msg"
    "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_pose_Type.msg"
    "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_payload_Type.msg"
    "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_error_Type.msg"
    "/home/user/Desktop/SrcLink/src/kuka_robot/msg/kr_robot_state_Type.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/kuka_robot/srv" TYPE FILE FILES
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_add_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rwraw_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_bypose_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_mv_byjoint_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_byjoint_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_bypose_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_mv_run_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_cov_joint_pose_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_rampstop_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_speed_scale_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_load_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_real_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_bool_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_dummy_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_setdo_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_batch_setdo_Args.srv"
    "/home/user/Desktop/SrcLink/src/kuka_robot/srv/kr_set_accvel_Args.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/kuka_robot/cmake" TYPE FILE FILES "/home/user/catkin_ws/build/kuka_robot/catkin_generated/installspace/kuka_robot-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/user/Desktop/SrcLink/devel/include/kuka_robot")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/user/Desktop/SrcLink/devel/share/roseus/ros/kuka_robot")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/user/Desktop/SrcLink/devel/share/common-lisp/ros/kuka_robot")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/user/Desktop/SrcLink/devel/share/gennodejs/ros/kuka_robot")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/user/Desktop/SrcLink/devel/lib/python2.7/dist-packages/kuka_robot")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/user/Desktop/SrcLink/devel/lib/python2.7/dist-packages/kuka_robot")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/user/catkin_ws/build/kuka_robot/catkin_generated/installspace/kuka_robot.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/kuka_robot/cmake" TYPE FILE FILES "/home/user/catkin_ws/build/kuka_robot/catkin_generated/installspace/kuka_robot-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/kuka_robot/cmake" TYPE FILE FILES
    "/home/user/catkin_ws/build/kuka_robot/catkin_generated/installspace/kuka_robotConfig.cmake"
    "/home/user/catkin_ws/build/kuka_robot/catkin_generated/installspace/kuka_robotConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/kuka_robot" TYPE FILE FILES "/home/user/Desktop/SrcLink/src/kuka_robot/package.xml")
endif()

