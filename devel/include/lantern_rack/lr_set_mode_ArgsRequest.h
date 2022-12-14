// Generated by gencpp from file lantern_rack/lr_set_mode_ArgsRequest.msg
// DO NOT EDIT!


#ifndef LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGSREQUEST_H
#define LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace lantern_rack
{
template <class ContainerAllocator>
struct lr_set_mode_ArgsRequest_
{
  typedef lr_set_mode_ArgsRequest_<ContainerAllocator> Type;

  lr_set_mode_ArgsRequest_()
    : mode(0)  {
    }
  lr_set_mode_ArgsRequest_(const ContainerAllocator& _alloc)
    : mode(0)  {
  (void)_alloc;
    }



   typedef int64_t _mode_type;
  _mode_type mode;





  typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct lr_set_mode_ArgsRequest_

typedef ::lantern_rack::lr_set_mode_ArgsRequest_<std::allocator<void> > lr_set_mode_ArgsRequest;

typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsRequest > lr_set_mode_ArgsRequestPtr;
typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsRequest const> lr_set_mode_ArgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator1> & lhs, const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.mode == rhs.mode;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator1> & lhs, const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace lantern_rack

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "284404659b502753974e60f7457ed2dc";
  }

  static const char* value(const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x284404659b502753ULL;
  static const uint64_t static_value2 = 0x974e60f7457ed2dcULL;
};

template<class ContainerAllocator>
struct DataType< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "lantern_rack/lr_set_mode_ArgsRequest";
  }

  static const char* value(const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"int64 mode\n"
;
  }

  static const char* value(const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.mode);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct lr_set_mode_ArgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::lantern_rack::lr_set_mode_ArgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "mode: ";
    Printer<int64_t>::stream(s, indent + "  ", v.mode);
  }
};

} // namespace message_operations
} // namespace ros

#endif // LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGSREQUEST_H
