// Generated by gencpp from file vision_system/vs_get_white_marking_position_Args.msg
// DO NOT EDIT!


#ifndef VISION_SYSTEM_MESSAGE_VS_GET_WHITE_MARKING_POSITION_ARGS_H
#define VISION_SYSTEM_MESSAGE_VS_GET_WHITE_MARKING_POSITION_ARGS_H

#include <ros/service_traits.h>


#include <vision_system/vs_get_white_marking_position_ArgsRequest.h>
#include <vision_system/vs_get_white_marking_position_ArgsResponse.h>


namespace vision_system
{

struct vs_get_white_marking_position_Args
{

typedef vs_get_white_marking_position_ArgsRequest Request;
typedef vs_get_white_marking_position_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct vs_get_white_marking_position_Args
} // namespace vision_system


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::vision_system::vs_get_white_marking_position_Args > {
  static const char* value()
  {
    return "f5317cca2c98e2b6437f8911f58cba1c";
  }

  static const char* value(const ::vision_system::vs_get_white_marking_position_Args&) { return value(); }
};

template<>
struct DataType< ::vision_system::vs_get_white_marking_position_Args > {
  static const char* value()
  {
    return "vision_system/vs_get_white_marking_position_Args";
  }

  static const char* value(const ::vision_system::vs_get_white_marking_position_Args&) { return value(); }
};


// service_traits::MD5Sum< ::vision_system::vs_get_white_marking_position_ArgsRequest> should match
// service_traits::MD5Sum< ::vision_system::vs_get_white_marking_position_Args >
template<>
struct MD5Sum< ::vision_system::vs_get_white_marking_position_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::vision_system::vs_get_white_marking_position_Args >::value();
  }
  static const char* value(const ::vision_system::vs_get_white_marking_position_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::vision_system::vs_get_white_marking_position_ArgsRequest> should match
// service_traits::DataType< ::vision_system::vs_get_white_marking_position_Args >
template<>
struct DataType< ::vision_system::vs_get_white_marking_position_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::vision_system::vs_get_white_marking_position_Args >::value();
  }
  static const char* value(const ::vision_system::vs_get_white_marking_position_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::vision_system::vs_get_white_marking_position_ArgsResponse> should match
// service_traits::MD5Sum< ::vision_system::vs_get_white_marking_position_Args >
template<>
struct MD5Sum< ::vision_system::vs_get_white_marking_position_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::vision_system::vs_get_white_marking_position_Args >::value();
  }
  static const char* value(const ::vision_system::vs_get_white_marking_position_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::vision_system::vs_get_white_marking_position_ArgsResponse> should match
// service_traits::DataType< ::vision_system::vs_get_white_marking_position_Args >
template<>
struct DataType< ::vision_system::vs_get_white_marking_position_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::vision_system::vs_get_white_marking_position_Args >::value();
  }
  static const char* value(const ::vision_system::vs_get_white_marking_position_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // VISION_SYSTEM_MESSAGE_VS_GET_WHITE_MARKING_POSITION_ARGS_H
