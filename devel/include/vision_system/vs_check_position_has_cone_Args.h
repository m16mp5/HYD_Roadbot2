// Generated by gencpp from file vision_system/vs_check_position_has_cone_Args.msg
// DO NOT EDIT!


#ifndef VISION_SYSTEM_MESSAGE_VS_CHECK_POSITION_HAS_CONE_ARGS_H
#define VISION_SYSTEM_MESSAGE_VS_CHECK_POSITION_HAS_CONE_ARGS_H

#include <ros/service_traits.h>


#include <vision_system/vs_check_position_has_cone_ArgsRequest.h>
#include <vision_system/vs_check_position_has_cone_ArgsResponse.h>


namespace vision_system
{

struct vs_check_position_has_cone_Args
{

typedef vs_check_position_has_cone_ArgsRequest Request;
typedef vs_check_position_has_cone_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct vs_check_position_has_cone_Args
} // namespace vision_system


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::vision_system::vs_check_position_has_cone_Args > {
  static const char* value()
  {
    return "abbd5f4e52593080e85548c693299665";
  }

  static const char* value(const ::vision_system::vs_check_position_has_cone_Args&) { return value(); }
};

template<>
struct DataType< ::vision_system::vs_check_position_has_cone_Args > {
  static const char* value()
  {
    return "vision_system/vs_check_position_has_cone_Args";
  }

  static const char* value(const ::vision_system::vs_check_position_has_cone_Args&) { return value(); }
};


// service_traits::MD5Sum< ::vision_system::vs_check_position_has_cone_ArgsRequest> should match
// service_traits::MD5Sum< ::vision_system::vs_check_position_has_cone_Args >
template<>
struct MD5Sum< ::vision_system::vs_check_position_has_cone_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::vision_system::vs_check_position_has_cone_Args >::value();
  }
  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::vision_system::vs_check_position_has_cone_ArgsRequest> should match
// service_traits::DataType< ::vision_system::vs_check_position_has_cone_Args >
template<>
struct DataType< ::vision_system::vs_check_position_has_cone_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::vision_system::vs_check_position_has_cone_Args >::value();
  }
  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::vision_system::vs_check_position_has_cone_ArgsResponse> should match
// service_traits::MD5Sum< ::vision_system::vs_check_position_has_cone_Args >
template<>
struct MD5Sum< ::vision_system::vs_check_position_has_cone_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::vision_system::vs_check_position_has_cone_Args >::value();
  }
  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::vision_system::vs_check_position_has_cone_ArgsResponse> should match
// service_traits::DataType< ::vision_system::vs_check_position_has_cone_Args >
template<>
struct DataType< ::vision_system::vs_check_position_has_cone_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::vision_system::vs_check_position_has_cone_Args >::value();
  }
  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // VISION_SYSTEM_MESSAGE_VS_CHECK_POSITION_HAS_CONE_ARGS_H
