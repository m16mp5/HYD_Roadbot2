// Generated by gencpp from file lantern_rack/lr_state_Type.msg
// DO NOT EDIT!


#ifndef LANTERN_RACK_MESSAGE_LR_STATE_TYPE_H
#define LANTERN_RACK_MESSAGE_LR_STATE_TYPE_H


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
struct lr_state_Type_
{
  typedef lr_state_Type_<ContainerAllocator> Type;

  lr_state_Type_()
    : timestamp(0.0)
    , state(0)
    , mode()
    , level()
    , sensor_state()  {
      mode.assign(0);

      level.assign(0);

      sensor_state.assign(0);
  }
  lr_state_Type_(const ContainerAllocator& _alloc)
    : timestamp(0.0)
    , state(0)
    , mode()
    , level()
    , sensor_state()  {
  (void)_alloc;
      mode.assign(0);

      level.assign(0);

      sensor_state.assign(0);
  }



   typedef double _timestamp_type;
  _timestamp_type timestamp;

   typedef int64_t _state_type;
  _state_type state;

   typedef boost::array<int64_t, 10>  _mode_type;
  _mode_type mode;

   typedef boost::array<int64_t, 10>  _level_type;
  _level_type level;

   typedef boost::array<int64_t, 10>  _sensor_state_type;
  _sensor_state_type sensor_state;





  typedef boost::shared_ptr< ::lantern_rack::lr_state_Type_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::lantern_rack::lr_state_Type_<ContainerAllocator> const> ConstPtr;

}; // struct lr_state_Type_

typedef ::lantern_rack::lr_state_Type_<std::allocator<void> > lr_state_Type;

typedef boost::shared_ptr< ::lantern_rack::lr_state_Type > lr_state_TypePtr;
typedef boost::shared_ptr< ::lantern_rack::lr_state_Type const> lr_state_TypeConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::lantern_rack::lr_state_Type_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::lantern_rack::lr_state_Type_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::lantern_rack::lr_state_Type_<ContainerAllocator1> & lhs, const ::lantern_rack::lr_state_Type_<ContainerAllocator2> & rhs)
{
  return lhs.timestamp == rhs.timestamp &&
    lhs.state == rhs.state &&
    lhs.mode == rhs.mode &&
    lhs.level == rhs.level &&
    lhs.sensor_state == rhs.sensor_state;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::lantern_rack::lr_state_Type_<ContainerAllocator1> & lhs, const ::lantern_rack::lr_state_Type_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace lantern_rack

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lantern_rack::lr_state_Type_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lantern_rack::lr_state_Type_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lantern_rack::lr_state_Type_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "446242a7e9ff89a4043e4a4889335818";
  }

  static const char* value(const ::lantern_rack::lr_state_Type_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x446242a7e9ff89a4ULL;
  static const uint64_t static_value2 = 0x043e4a4889335818ULL;
};

template<class ContainerAllocator>
struct DataType< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "lantern_rack/lr_state_Type";
  }

  static const char* value(const ::lantern_rack::lr_state_Type_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Timestamp [s]\n"
"float64 timestamp\n"
"\n"
"# Lantern rack controller state\n"
"int64 state\n"
"\n"
"# Lantern rack stack current working mode state [0-down 1-picking 2-filling 3-in trans]\n"
"int64[10] mode\n"
"\n"
"# 10 Lantern rack stack level position\n"
"int64[10] level\n"
"\n"
"# Lantern Racks sensor status\n"
"int64[10] sensor_state\n"
"\n"
;
  }

  static const char* value(const ::lantern_rack::lr_state_Type_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.timestamp);
      stream.next(m.state);
      stream.next(m.mode);
      stream.next(m.level);
      stream.next(m.sensor_state);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct lr_state_Type_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::lantern_rack::lr_state_Type_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::lantern_rack::lr_state_Type_<ContainerAllocator>& v)
  {
    s << indent << "timestamp: ";
    Printer<double>::stream(s, indent + "  ", v.timestamp);
    s << indent << "state: ";
    Printer<int64_t>::stream(s, indent + "  ", v.state);
    s << indent << "mode[]" << std::endl;
    for (size_t i = 0; i < v.mode.size(); ++i)
    {
      s << indent << "  mode[" << i << "]: ";
      Printer<int64_t>::stream(s, indent + "  ", v.mode[i]);
    }
    s << indent << "level[]" << std::endl;
    for (size_t i = 0; i < v.level.size(); ++i)
    {
      s << indent << "  level[" << i << "]: ";
      Printer<int64_t>::stream(s, indent + "  ", v.level[i]);
    }
    s << indent << "sensor_state[]" << std::endl;
    for (size_t i = 0; i < v.sensor_state.size(); ++i)
    {
      s << indent << "  sensor_state[" << i << "]: ";
      Printer<int64_t>::stream(s, indent + "  ", v.sensor_state[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // LANTERN_RACK_MESSAGE_LR_STATE_TYPE_H
