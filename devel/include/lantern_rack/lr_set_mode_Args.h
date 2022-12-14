// Generated by gencpp from file lantern_rack/lr_set_mode_Args.msg
// DO NOT EDIT!


#ifndef LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGS_H
#define LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGS_H

#include <ros/service_traits.h>


#include <lantern_rack/lr_set_mode_ArgsRequest.h>
#include <lantern_rack/lr_set_mode_ArgsResponse.h>


namespace lantern_rack
{

struct lr_set_mode_Args
{

typedef lr_set_mode_ArgsRequest Request;
typedef lr_set_mode_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct lr_set_mode_Args
} // namespace lantern_rack


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::lantern_rack::lr_set_mode_Args > {
  static const char* value()
  {
    return "2e6307ffb6c6a15962ad11ee62cabe85";
  }

  static const char* value(const ::lantern_rack::lr_set_mode_Args&) { return value(); }
};

template<>
struct DataType< ::lantern_rack::lr_set_mode_Args > {
  static const char* value()
  {
    return "lantern_rack/lr_set_mode_Args";
  }

  static const char* value(const ::lantern_rack::lr_set_mode_Args&) { return value(); }
};


// service_traits::MD5Sum< ::lantern_rack::lr_set_mode_ArgsRequest> should match
// service_traits::MD5Sum< ::lantern_rack::lr_set_mode_Args >
template<>
struct MD5Sum< ::lantern_rack::lr_set_mode_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::lantern_rack::lr_set_mode_Args >::value();
  }
  static const char* value(const ::lantern_rack::lr_set_mode_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::lantern_rack::lr_set_mode_ArgsRequest> should match
// service_traits::DataType< ::lantern_rack::lr_set_mode_Args >
template<>
struct DataType< ::lantern_rack::lr_set_mode_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::lantern_rack::lr_set_mode_Args >::value();
  }
  static const char* value(const ::lantern_rack::lr_set_mode_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::lantern_rack::lr_set_mode_ArgsResponse> should match
// service_traits::MD5Sum< ::lantern_rack::lr_set_mode_Args >
template<>
struct MD5Sum< ::lantern_rack::lr_set_mode_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::lantern_rack::lr_set_mode_Args >::value();
  }
  static const char* value(const ::lantern_rack::lr_set_mode_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::lantern_rack::lr_set_mode_ArgsResponse> should match
// service_traits::DataType< ::lantern_rack::lr_set_mode_Args >
template<>
struct DataType< ::lantern_rack::lr_set_mode_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::lantern_rack::lr_set_mode_Args >::value();
  }
  static const char* value(const ::lantern_rack::lr_set_mode_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGS_H
