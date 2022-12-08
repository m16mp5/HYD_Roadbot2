cmake_minimum_required(VERSION 2.8.3)
project(fslidar_drive)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  std_msgs
)

catkin_package()

include_directories(
  ${catkin_INCLUDE_DIRS}
  include/fslidar
)

add_executable(fslidar_node
 src/node.cpp
 src/fslidar.cpp
 src/serial.cpp
 src/time_cnt.cpp)
 target_link_libraries(fslidar_node
   ${catkin_LIBRARIES}
 )

