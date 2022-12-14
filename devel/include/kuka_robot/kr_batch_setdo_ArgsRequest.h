// Generated by gencpp from file kuka_robot/kr_batch_setdo_ArgsRequest.msg
// DO NOT EDIT!


#ifndef KUKA_ROBOT_MESSAGE_KR_BATCH_SETDO_ARGSREQUEST_H
#define KUKA_ROBOT_MESSAGE_KR_BATCH_SETDO_ARGSREQUEST_H


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
struct kr_batch_setdo_ArgsRequest_
{
  typedef kr_batch_setdo_ArgsRequest_<ContainerAllocator> Type;

  kr_batch_setdo_ArgsRequest_()
    : mask(0)
    , value(0)
    , settle_sec(0.0)
    , block(0)  {
    }
  kr_batch_setdo_ArgsRequest_(const ContainerAllocator& _alloc)
    : mask(0)
    , value(0)
    , settle_sec(0.0)
    , block(0)  {
  (void)_alloc;
    }



   typedef int64_t _mask_type;
  _mask_type mask;

   typedef int64_t _value_type;
  _value_type value;

   typedef double _settle_sec_type;
  _settle_sec_type settle_sec;

   typedef int64_t _block_type;
  _block_type block;





  typedef boost::shared_ptr< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct kr_batch_setdo_ArgsRequest_

typedef ::kuka_robot::kr_batch_setdo_ArgsRequest_<std::allocator<void> > kr_batch_setdo_ArgsRequest;

typedef boost::shared_ptr< ::kuka_robot::kr_batch_setdo_ArgsRequest > kr_batch_setdo_ArgsRequestPtr;
typedef boost::shared_ptr< ::kuka_robot::kr_batch_setdo_ArgsRequest const> kr_batch_setdo_ArgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.mask == rhs.mask &&
    lhs.value == rhs.value &&
    lhs.settle_sec == rhs.settle_sec &&
    lhs.block == rhs.block;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace kuka_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "0b779f188571f21b4c940a0fbbf24126";
  }

  static const char* value(const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x0b779f188571f21bULL;
  static const uint64_t static_value2 = 0x4c940a0fbbf24126ULL;
};

template<class ContainerAllocator>
struct DataType< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "kuka_robot/kr_batch_setdo_ArgsRequest";
  }

  static const char* value(const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"int64 mask\n"
"\n"
"int64 value\n"
"\n"
"float64 settle_sec\n"
"\n"
"int64 block\n"
;
  }

  static const char* value(const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.mask);
      stream.next(m.value);
      stream.next(m.settle_sec);
      stream.next(m.block);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct kr_batch_setdo_ArgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::kuka_robot::kr_batch_setdo_ArgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "mask: ";
    Printer<int64_t>::stream(s, indent + "  ", v.mask);
    s << indent << "value: ";
    Printer<int64_t>::stream(s, indent + "  ", v.value);
    s << indent << "settle_sec: ";
    Printer<double>::stream(s, indent + "  ", v.settle_sec);
    s << indent << "block: ";
    Printer<int64_t>::stream(s, indent + "  ", v.block);
  }
};

} // namespace message_operations
} // namespace ros

#endif // KUKA_ROBOT_MESSAGE_KR_BATCH_SETDO_ARGSREQUEST_H
