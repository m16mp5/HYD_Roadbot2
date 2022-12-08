// Generated by gencpp from file lantern_rack/lr_set_mode_ArgsResponse.msg
// DO NOT EDIT!


#ifndef LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGSRESPONSE_H
#define LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGSRESPONSE_H


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
struct lr_set_mode_ArgsResponse_
{
  typedef lr_set_mode_ArgsResponse_<ContainerAllocator> Type;

  lr_set_mode_ArgsResponse_()
    : response(0)  {
    }
  lr_set_mode_ArgsResponse_(const ContainerAllocator& _alloc)
    : response(0)  {
  (void)_alloc;
    }



   typedef int64_t _response_type;
  _response_type response;





  typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> const> ConstPtr;

}; // struct lr_set_mode_ArgsResponse_

typedef ::lantern_rack::lr_set_mode_ArgsResponse_<std::allocator<void> > lr_set_mode_ArgsResponse;

typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsResponse > lr_set_mode_ArgsResponsePtr;
typedef boost::shared_ptr< ::lantern_rack::lr_set_mode_ArgsResponse const> lr_set_mode_ArgsResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator1> & lhs, const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator2> & rhs)
{
  return lhs.response == rhs.response;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator1> & lhs, const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace lantern_rack

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "4bf37bc717f68787645077428bea3751";
  }

  static const char* value(const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x4bf37bc717f68787ULL;
  static const uint64_t static_value2 = 0x645077428bea3751ULL;
};

template<class ContainerAllocator>
struct DataType< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "lantern_rack/lr_set_mode_ArgsResponse";
  }

  static const char* value(const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"int64 response\n"
"\n"
"\n"
;
  }

  static const char* value(const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.response);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct lr_set_mode_ArgsResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::lantern_rack::lr_set_mode_ArgsResponse_<ContainerAllocator>& v)
  {
    s << indent << "response: ";
    Printer<int64_t>::stream(s, indent + "  ", v.response);
  }
};

} // namespace message_operations
} // namespace ros

#endif // LANTERN_RACK_MESSAGE_LR_SET_MODE_ARGSRESPONSE_H
