// Generated by gencpp from file kuka_robot/kr_mv_byjoint_ArgsRequest.msg
// DO NOT EDIT!


#ifndef KUKA_ROBOT_MESSAGE_KR_MV_BYJOINT_ARGSREQUEST_H
#define KUKA_ROBOT_MESSAGE_KR_MV_BYJOINT_ARGSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <kuka_robot/kr_joint_Type.h>

namespace kuka_robot
{
template <class ContainerAllocator>
struct kr_mv_byjoint_ArgsRequest_
{
  typedef kr_mv_byjoint_ArgsRequest_<ContainerAllocator> Type;

  kr_mv_byjoint_ArgsRequest_()
    : joints()  {
    }
  kr_mv_byjoint_ArgsRequest_(const ContainerAllocator& _alloc)
    : joints(_alloc)  {
  (void)_alloc;
    }



   typedef  ::kuka_robot::kr_joint_Type_<ContainerAllocator>  _joints_type;
  _joints_type joints;





  typedef boost::shared_ptr< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct kr_mv_byjoint_ArgsRequest_

typedef ::kuka_robot::kr_mv_byjoint_ArgsRequest_<std::allocator<void> > kr_mv_byjoint_ArgsRequest;

typedef boost::shared_ptr< ::kuka_robot::kr_mv_byjoint_ArgsRequest > kr_mv_byjoint_ArgsRequestPtr;
typedef boost::shared_ptr< ::kuka_robot::kr_mv_byjoint_ArgsRequest const> kr_mv_byjoint_ArgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.joints == rhs.joints;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace kuka_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "7db351d4fc356ec8dca75d8666dbe8dc";
  }

  static const char* value(const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x7db351d4fc356ec8ULL;
  static const uint64_t static_value2 = 0xdca75d8666dbe8dcULL;
};

template<class ContainerAllocator>
struct DataType< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "kuka_robot/kr_mv_byjoint_ArgsRequest";
  }

  static const char* value(const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"kr_joint_Type joints\n"
"\n"
"================================================================================\n"
"MSG: kuka_robot/kr_joint_Type\n"
"# Joint Angles [degree]\n"
"float64 A1\n"
"float64 A2\n"
"float64 A3\n"
"float64 A4\n"
"float64 A5\n"
"float64 A6\n"
"\n"
;
  }

  static const char* value(const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.joints);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct kr_mv_byjoint_ArgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::kuka_robot::kr_mv_byjoint_ArgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "joints: ";
    s << std::endl;
    Printer< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >::stream(s, indent + "  ", v.joints);
  }
};

} // namespace message_operations
} // namespace ros

#endif // KUKA_ROBOT_MESSAGE_KR_MV_BYJOINT_ARGSREQUEST_H
