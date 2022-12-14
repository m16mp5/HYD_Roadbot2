// Generated by gencpp from file roadbot_control/ac_go_collect_Args.msg
// DO NOT EDIT!


#ifndef ROADBOT_CONTROL_MESSAGE_AC_GO_COLLECT_ARGS_H
#define ROADBOT_CONTROL_MESSAGE_AC_GO_COLLECT_ARGS_H

#include <ros/service_traits.h>


#include <roadbot_control/ac_go_collect_ArgsRequest.h>
#include <roadbot_control/ac_go_collect_ArgsResponse.h>


namespace roadbot_control
{

struct ac_go_collect_Args
{

typedef ac_go_collect_ArgsRequest Request;
typedef ac_go_collect_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct ac_go_collect_Args
} // namespace roadbot_control


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::roadbot_control::ac_go_collect_Args > {
  static const char* value()
  {
    return "21a374c41adc123047cf3f40397fcf04";
  }

  static const char* value(const ::roadbot_control::ac_go_collect_Args&) { return value(); }
};

template<>
struct DataType< ::roadbot_control::ac_go_collect_Args > {
  static const char* value()
  {
    return "roadbot_control/ac_go_collect_Args";
  }

  static const char* value(const ::roadbot_control::ac_go_collect_Args&) { return value(); }
};


// service_traits::MD5Sum< ::roadbot_control::ac_go_collect_ArgsRequest> should match
// service_traits::MD5Sum< ::roadbot_control::ac_go_collect_Args >
template<>
struct MD5Sum< ::roadbot_control::ac_go_collect_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::roadbot_control::ac_go_collect_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_go_collect_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::roadbot_control::ac_go_collect_ArgsRequest> should match
// service_traits::DataType< ::roadbot_control::ac_go_collect_Args >
template<>
struct DataType< ::roadbot_control::ac_go_collect_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::roadbot_control::ac_go_collect_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_go_collect_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::roadbot_control::ac_go_collect_ArgsResponse> should match
// service_traits::MD5Sum< ::roadbot_control::ac_go_collect_Args >
template<>
struct MD5Sum< ::roadbot_control::ac_go_collect_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::roadbot_control::ac_go_collect_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_go_collect_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::roadbot_control::ac_go_collect_ArgsResponse> should match
// service_traits::DataType< ::roadbot_control::ac_go_collect_Args >
template<>
struct DataType< ::roadbot_control::ac_go_collect_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::roadbot_control::ac_go_collect_Args >::value();
  }
  static const char* value(const ::roadbot_control::ac_go_collect_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ROADBOT_CONTROL_MESSAGE_AC_GO_COLLECT_ARGS_H
