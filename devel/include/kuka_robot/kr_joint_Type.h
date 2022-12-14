// Generated by gencpp from file kuka_robot/kr_joint_Type.msg
// DO NOT EDIT!


#ifndef KUKA_ROBOT_MESSAGE_KR_JOINT_TYPE_H
#define KUKA_ROBOT_MESSAGE_KR_JOINT_TYPE_H


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
struct kr_joint_Type_
{
  typedef kr_joint_Type_<ContainerAllocator> Type;

  kr_joint_Type_()
    : A1(0.0)
    , A2(0.0)
    , A3(0.0)
    , A4(0.0)
    , A5(0.0)
    , A6(0.0)  {
    }
  kr_joint_Type_(const ContainerAllocator& _alloc)
    : A1(0.0)
    , A2(0.0)
    , A3(0.0)
    , A4(0.0)
    , A5(0.0)
    , A6(0.0)  {
  (void)_alloc;
    }



   typedef double _A1_type;
  _A1_type A1;

   typedef double _A2_type;
  _A2_type A2;

   typedef double _A3_type;
  _A3_type A3;

   typedef double _A4_type;
  _A4_type A4;

   typedef double _A5_type;
  _A5_type A5;

   typedef double _A6_type;
  _A6_type A6;





  typedef boost::shared_ptr< ::kuka_robot::kr_joint_Type_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::kuka_robot::kr_joint_Type_<ContainerAllocator> const> ConstPtr;

}; // struct kr_joint_Type_

typedef ::kuka_robot::kr_joint_Type_<std::allocator<void> > kr_joint_Type;

typedef boost::shared_ptr< ::kuka_robot::kr_joint_Type > kr_joint_TypePtr;
typedef boost::shared_ptr< ::kuka_robot::kr_joint_Type const> kr_joint_TypeConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::kuka_robot::kr_joint_Type_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::kuka_robot::kr_joint_Type_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_joint_Type_<ContainerAllocator2> & rhs)
{
  return lhs.A1 == rhs.A1 &&
    lhs.A2 == rhs.A2 &&
    lhs.A3 == rhs.A3 &&
    lhs.A4 == rhs.A4 &&
    lhs.A5 == rhs.A5 &&
    lhs.A6 == rhs.A6;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::kuka_robot::kr_joint_Type_<ContainerAllocator1> & lhs, const ::kuka_robot::kr_joint_Type_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace kuka_robot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::kuka_robot::kr_joint_Type_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::kuka_robot::kr_joint_Type_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::kuka_robot::kr_joint_Type_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "75a5288a21ef4ba3c22a3ba34b5bc48c";
  }

  static const char* value(const ::kuka_robot::kr_joint_Type_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x75a5288a21ef4ba3ULL;
  static const uint64_t static_value2 = 0xc22a3ba34b5bc48cULL;
};

template<class ContainerAllocator>
struct DataType< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "kuka_robot/kr_joint_Type";
  }

  static const char* value(const ::kuka_robot::kr_joint_Type_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Joint Angles [degree]\n"
"float64 A1\n"
"float64 A2\n"
"float64 A3\n"
"float64 A4\n"
"float64 A5\n"
"float64 A6\n"
"\n"
;
  }

  static const char* value(const ::kuka_robot::kr_joint_Type_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.A1);
      stream.next(m.A2);
      stream.next(m.A3);
      stream.next(m.A4);
      stream.next(m.A5);
      stream.next(m.A6);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct kr_joint_Type_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::kuka_robot::kr_joint_Type_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::kuka_robot::kr_joint_Type_<ContainerAllocator>& v)
  {
    s << indent << "A1: ";
    Printer<double>::stream(s, indent + "  ", v.A1);
    s << indent << "A2: ";
    Printer<double>::stream(s, indent + "  ", v.A2);
    s << indent << "A3: ";
    Printer<double>::stream(s, indent + "  ", v.A3);
    s << indent << "A4: ";
    Printer<double>::stream(s, indent + "  ", v.A4);
    s << indent << "A5: ";
    Printer<double>::stream(s, indent + "  ", v.A5);
    s << indent << "A6: ";
    Printer<double>::stream(s, indent + "  ", v.A6);
  }
};

} // namespace message_operations
} // namespace ros

#endif // KUKA_ROBOT_MESSAGE_KR_JOINT_TYPE_H
