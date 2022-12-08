// Generated by gencpp from file system_io/sio_set_double_Args.msg
// DO NOT EDIT!


#ifndef SYSTEM_IO_MESSAGE_SIO_SET_DOUBLE_ARGS_H
#define SYSTEM_IO_MESSAGE_SIO_SET_DOUBLE_ARGS_H

#include <ros/service_traits.h>


#include <system_io/sio_set_double_ArgsRequest.h>
#include <system_io/sio_set_double_ArgsResponse.h>


namespace system_io
{

struct sio_set_double_Args
{

typedef sio_set_double_ArgsRequest Request;
typedef sio_set_double_ArgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct sio_set_double_Args
} // namespace system_io


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::system_io::sio_set_double_Args > {
  static const char* value()
  {
    return "1320d4a929ea6ef2a246c2b190a9f356";
  }

  static const char* value(const ::system_io::sio_set_double_Args&) { return value(); }
};

template<>
struct DataType< ::system_io::sio_set_double_Args > {
  static const char* value()
  {
    return "system_io/sio_set_double_Args";
  }

  static const char* value(const ::system_io::sio_set_double_Args&) { return value(); }
};


// service_traits::MD5Sum< ::system_io::sio_set_double_ArgsRequest> should match
// service_traits::MD5Sum< ::system_io::sio_set_double_Args >
template<>
struct MD5Sum< ::system_io::sio_set_double_ArgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::system_io::sio_set_double_Args >::value();
  }
  static const char* value(const ::system_io::sio_set_double_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::system_io::sio_set_double_ArgsRequest> should match
// service_traits::DataType< ::system_io::sio_set_double_Args >
template<>
struct DataType< ::system_io::sio_set_double_ArgsRequest>
{
  static const char* value()
  {
    return DataType< ::system_io::sio_set_double_Args >::value();
  }
  static const char* value(const ::system_io::sio_set_double_ArgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::system_io::sio_set_double_ArgsResponse> should match
// service_traits::MD5Sum< ::system_io::sio_set_double_Args >
template<>
struct MD5Sum< ::system_io::sio_set_double_ArgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::system_io::sio_set_double_Args >::value();
  }
  static const char* value(const ::system_io::sio_set_double_ArgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::system_io::sio_set_double_ArgsResponse> should match
// service_traits::DataType< ::system_io::sio_set_double_Args >
template<>
struct DataType< ::system_io::sio_set_double_ArgsResponse>
{
  static const char* value()
  {
    return DataType< ::system_io::sio_set_double_Args >::value();
  }
  static const char* value(const ::system_io::sio_set_double_ArgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SYSTEM_IO_MESSAGE_SIO_SET_DOUBLE_ARGS_H
