// Generated by gencpp from file kuka_robot/kr_setdo_Args.msg
// DO NOT EDIT!


#ifndef KUKA_ROBOT_MESSAGE_KR_SETDO_ARGS_H
#define KUKA_ROBOT_MESSAGE_KR_SETDO_ARGS_H

#include <ros/service_traits.h>


#include <kuka_robot/kr_setdo_ArgsRequest.h>
#include <kuka_robot/kr_setdo_ArgsResponse.h>


namespace kuka_robot
{

struct kr_setdo_Args
{

typedef kr_setdo_ArgsRequest Request;
typedef kr_setdo_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct kr_setdo_Args
} // namespace kuka_robot


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::kuka_robot::kr_setdo_Args > {
  static const char* value()
  {
    return "8961b48420bcf8a003b4c64079fcb6f6";
  }

  static const char* value(const ::kuka_robot::kr_setdo_Args&) { return value(); }
};

template<>
struct DataType< ::kuka_robot::kr_setdo_Args > {
  static const char* value()
  {
    return "kuka_robot/kr_setdo_Args";
  }

  static const char* value(const ::kuka_robot::kr_setdo_Args&) { return value(); }
};


// service_traits::MD5Sum< ::kuka_robot::kr_setdo_ArgsRequest> should match
// service_traits::MD5Sum< ::kuka_robot::kr_setdo_Args >
template<>
struct MD5Sum< ::kuka_robot::kr_setdo_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::kuka_robot::kr_setdo_Args >::value();
  }
  static const char* value(const ::kuka_robot::kr_setdo_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::kuka_robot::kr_setdo_ArgsRequest> should match
// service_traits::DataType< ::kuka_robot::kr_setdo_Args >
template<>
struct DataType< ::kuka_robot::kr_setdo_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::kuka_robot::kr_setdo_Args >::value();
  }
  static const char* value(const ::kuka_robot::kr_setdo_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::kuka_robot::kr_setdo_ArgsResponse> should match
// service_traits::MD5Sum< ::kuka_robot::kr_setdo_Args >
template<>
struct MD5Sum< ::kuka_robot::kr_setdo_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::kuka_robot::kr_setdo_Args >::value();
  }
  static const char* value(const ::kuka_robot::kr_setdo_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::kuka_robot::kr_setdo_ArgsResponse> should match
// service_traits::DataType< ::kuka_robot::kr_setdo_Args >
template<>
struct DataType< ::kuka_robot::kr_setdo_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::kuka_robot::kr_setdo_Args >::value();
  }
  static const char* value(const ::kuka_robot::kr_setdo_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // KUKA_ROBOT_MESSAGE_KR_SETDO_ARGS_H
