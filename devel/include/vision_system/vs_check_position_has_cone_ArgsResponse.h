// Generated by gencpp from file vision_system/vs_check_position_has_cone_ArgsResponse.msg
// DO NOT EDIT!


#ifndef VISION_SYSTEM_MESSAGE_VS_CHECK_POSITION_HAS_CONE_ARGSRESPONSE_H
#define VISION_SYSTEM_MESSAGE_VS_CHECK_POSITION_HAS_CONE_ARGSRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace vision_system
{
template <class ContainerAllocator>
struct vs_check_position_has_cone_ArgsResponse_
{
  typedef vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> Type;

  vs_check_position_has_cone_ArgsResponse_()
    : response(0)
    , result_code(0)  {
    }
  vs_check_position_has_cone_ArgsResponse_(const ContainerAllocator& _alloc)
    : response(0)
    , result_code(0)  {
  (void)_alloc;
    }



   typedef int64_t _response_type;
  _response_type response;

   typedef int64_t _result_code_type;
  _result_code_type result_code;





  typedef boost::shared_ptr< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> const> ConstPtr;

}; // struct vs_check_position_has_cone_ArgsResponse_

typedef ::vision_system::vs_check_position_has_cone_ArgsResponse_<std::allocator<void> > vs_check_position_has_cone_ArgsResponse;

typedef boost::shared_ptr< ::vision_system::vs_check_position_has_cone_ArgsResponse > vs_check_position_has_cone_ArgsResponsePtr;
typedef boost::shared_ptr< ::vision_system::vs_check_position_has_cone_ArgsResponse const> vs_check_position_has_cone_ArgsResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator1> & lhs, const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator2> & rhs)
{
  return lhs.response == rhs.response &&
    lhs.result_code == rhs.result_code;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator1> & lhs, const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace vision_system

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "639fa62f1f362e30fed370855c664bd5";
  }

  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x639fa62f1f362e30ULL;
  static const uint64_t static_value2 = 0xfed370855c664bd5ULL;
};

template<class ContainerAllocator>
struct DataType< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "vision_system/vs_check_position_has_cone_ArgsResponse";
  }

  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"int64 response\n"
"\n"
"\n"
"int64 result_code\n"
"\n"
"\n"
;
  }

  static const char* value(const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.response);
      stream.next(m.result_code);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct vs_check_position_has_cone_ArgsResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::vision_system::vs_check_position_has_cone_ArgsResponse_<ContainerAllocator>& v)
  {
    s << indent << "response: ";
    Printer<int64_t>::stream(s, indent + "  ", v.response);
    s << indent << "result_code: ";
    Printer<int64_t>::stream(s, indent + "  ", v.result_code);
  }
};

} // namespace message_operations
} // namespace ros

#endif // VISION_SYSTEM_MESSAGE_VS_CHECK_POSITION_HAS_CONE_ARGSRESPONSE_H
