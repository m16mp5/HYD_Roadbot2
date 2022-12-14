// Generated by gencpp from file roadbot_control/ac_set_bool_ArgsRequest.msg
// DO NOT EDIT!


#ifndef ROADBOT_CONTROL_MESSAGE_AC_SET_BOOL_ARGSREQUEST_H
#define ROADBOT_CONTROL_MESSAGE_AC_SET_BOOL_ARGSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace roadbot_control
{
template <class ContainerAllocator>
struct ac_set_bool_ArgsRequest_
{
  typedef ac_set_bool_ArgsRequest_<ContainerAllocator> Type;

  ac_set_bool_ArgsRequest_()
    : state(false)  {
    }
  ac_set_bool_ArgsRequest_(const ContainerAllocator& _alloc)
    : state(false)  {
  (void)_alloc;
    }



   typedef uint8_t _state_type;
  _state_type state;





  typedef boost::shared_ptr< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct ac_set_bool_ArgsRequest_

typedef ::roadbot_control::ac_set_bool_ArgsRequest_<std::allocator<void> > ac_set_bool_ArgsRequest;

typedef boost::shared_ptr< ::roadbot_control::ac_set_bool_ArgsRequest > ac_set_bool_ArgsRequestPtr;
typedef boost::shared_ptr< ::roadbot_control::ac_set_bool_ArgsRequest const> ac_set_bool_ArgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator1> & lhs, const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.state == rhs.state;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator1> & lhs, const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace roadbot_control

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "001fde3cab9e313a150416ff09c08ee4";
  }

  static const char* value(const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x001fde3cab9e313aULL;
  static const uint64_t static_value2 = 0x150416ff09c08ee4ULL;
};

template<class ContainerAllocator>
struct DataType< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "roadbot_control/ac_set_bool_ArgsRequest";
  }

  static const char* value(const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"bool state\n"
;
  }

  static const char* value(const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.state);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ac_set_bool_ArgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::roadbot_control::ac_set_bool_ArgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "state: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.state);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROADBOT_CONTROL_MESSAGE_AC_SET_BOOL_ARGSREQUEST_H
