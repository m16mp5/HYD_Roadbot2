// Generated by gencpp from file roadbot_control/ac_set_double_Args.msg
// DO NOT EDIT!


#ifndef ROADBOT_CONTROL_MESSAGE_AC_SET_DOUBLE_ARGS_H
#define ROADBOT_CONTROL_MESSAGE_AC_SET_DOUBLE_ARGS_H

#include <ros/service_traits.h>


#include <roadbot_control/ac_set_double_ArgsRequest.h>
#include <roadbot_control/ac_set_double_ArgsResponse.h>


namespace roadbot_control
{

struct ac_set_double_Args
{

typedef ac_set_double_ArgsRequest Request;
typedef ac_set_double_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct ac_set_double_Args
} // namespace roadbot_control


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::roadbot_control::ac_set_double_Args > {
  static const char* value()
  {
    return "1320d4a929ea6ef2a246c2b190a9f356";
  }

  static const char* value(const ::roadbot_control::ac_set_double_Args&) { return value(); }
};

template<>
struct DataType< ::roadbot_control::ac_set_double_Args > {
  static const char* value()
  {
    return "roadbot_control/ac_set_double_Args";
  }

  static const char* value(const ::roadbot_control::ac_set_double_Args&) { return value(); }
};


// service_traits::MD5Sum< ::roadbot_control::ac_set_double_ArgsRequest> should match
// service_traits::MD5Sum< ::roadbot_control::ac_set_double_Args >
template<>
struct MD5Sum< ::roadbot_control::ac_set_double_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::roadbot_control::ac_set_double_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_set_double_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::roadbot_control::ac_set_double_ArgsRequest> should match
// service_traits::DataType< ::roadbot_control::ac_set_double_Args >
template<>
struct DataType< ::roadbot_control::ac_set_double_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::roadbot_control::ac_set_double_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_set_double_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::roadbot_control::ac_set_double_ArgsResponse> should match
// service_traits::MD5Sum< ::roadbot_control::ac_set_double_Args >
template<>
struct MD5Sum< ::roadbot_control::ac_set_double_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::roadbot_control::ac_set_double_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_set_double_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::roadbot_control::ac_set_double_ArgsResponse> should match
// service_traits::DataType< ::roadbot_control::ac_set_double_Args >
template<>
struct DataType< ::roadbot_control::ac_set_double_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::roadbot_control::ac_set_double_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_set_double_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ROADBOT_CONTROL_MESSAGE_AC_SET_DOUBLE_ARGS_H
