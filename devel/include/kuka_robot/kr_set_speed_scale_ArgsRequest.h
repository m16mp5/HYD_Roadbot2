// Generated by gencpp from file kuka_robot/kr_set_speed_scale_ArgsRequest.msg
// DO NOT EDIT!


#ifndef KUKA_ROBOT_MESSAGE_KR_SET_SPEED_SCALE_ARGSREQUEST_H
#define KUKA_ROBOT_MESSAGE_KR_SET_SPEED_SCALE_ARGSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace kuka_robot
{
template <class ContainerAllocator>
struct kr_set_speed_scale_ArgsRequest_
{
  typedef kr_set_speed_scale_ArgsRequest_<ContainerAllocator> Type;

  kr_set_speed_scale_ArgsRequest_()
    : scale(0)  {
    }
  kr_set_speed_scale_ArgsRequest_(const ContainerAllocator& _alloc)
    : scale(0)  {
  (void)_alloc;
    }



   typedef int64_t _scale_type;
  _scale_type scale;





  typedef boost::shared_ptr< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct kr_set_speed_scale_ArgsRequest_

typedef ::kuka_robot::kr_set_speed_scale_ArgsRequest_<std::allocator<void> > kr_set_speed_scale_ArgsRequest;

typedef boost::shared_ptr< ::kuka_robot::kr_set_speed_scale_ArgsRequest > kr_set_speed_scale_ArgsRequestPtr;
typedef boost::shared_ptr< ::kuka_robot::kr_set_speed_scale_ArgsRequest const> kr_set_speed_scale_ArgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.scale == rhs.scale;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace kuka_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "203b71a01c7670d592286580ab8f618f";
  }

  static const char* value(const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x203b71a01c7670d5ULL;
  static const uint64_t static_value2 = 0x92286580ab8f618fULL;
};

template<class ContainerAllocator>
struct DataType< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "kuka_robot/kr_set_speed_scale_ArgsRequest";
  }

  static const char* value(const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"int64 scale\n"
;
  }

  static const char* value(const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.scale);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct kr_set_speed_scale_ArgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::kuka_robot::kr_set_speed_scale_ArgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "scale: ";
    Printer<int64_t>::stream(s, indent + "  ", v.scale);
  }
};

} // namespace message_operations
} // namespace ros

#endif // KUKA_ROBOT_MESSAGE_KR_SET_SPEED_SCALE_ARGSREQUEST_H
