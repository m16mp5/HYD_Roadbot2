// Generated by gencpp from file power_system/ps_set_double_ArgsResponse.msg
// DO NOT EDIT!


#ifndef POWER_SYSTEM_MESSAGE_PS_SET_DOUBLE_ARGSRESPONSE_H
#define POWER_SYSTEM_MESSAGE_PS_SET_DOUBLE_ARGSRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace power_system
{
template <class ContainerAllocator>
struct ps_set_double_ArgsResponse_
{
  typedef ps_set_double_ArgsResponse_<ContainerAllocator> Type;

  ps_set_double_ArgsResponse_()
    : response(0)  {
    }
  ps_set_double_ArgsResponse_(const ContainerAllocator& _alloc)
    : response(0)  {
  (void)_alloc;
    }



   typedef int64_t _response_type;
  _response_type response;





  typedef boost::shared_ptr< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> const> ConstPtr;

}; // struct ps_set_double_ArgsResponse_

typedef ::power_system::ps_set_double_ArgsResponse_<std::allocator<void> > ps_set_double_ArgsResponse;

typedef boost::shared_ptr< ::power_system::ps_set_double_ArgsResponse > ps_set_double_ArgsResponsePtr;
typedef boost::shared_ptr< ::power_system::ps_set_double_ArgsResponse const> ps_set_double_ArgsResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator1> & lhs, const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator2> & rhs)
{
  return lhs.response == rhs.response;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator1> & lhs, const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace power_system

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4bf37bc717f68787645077428bea3751";
  }

  static const char* value(const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4bf37bc717f68787ULL;
  static const uint64_t static_value2 = 0x645077428bea3751ULL;
};

template<class ContainerAllocator>
struct DataType< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "power_system/ps_set_double_ArgsResponse";
  }

  static const char* value(const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"int64 response\n"
"\n"
"\n"
;
  }

  static const char* value(const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.response);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ps_set_double_ArgsResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::power_system::ps_set_double_ArgsResponse_<ContainerAllocator>& v)
  {
    s << indent << "response: ";
    Printer<int64_t>::stream(s, indent + "  ", v.response);
  }
};

} // namespace message_operations
} // namespace ros

#endif // POWER_SYSTEM_MESSAGE_PS_SET_DOUBLE_ARGSRESPONSE_H
