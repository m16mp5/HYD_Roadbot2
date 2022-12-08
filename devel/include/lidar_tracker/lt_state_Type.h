// Generated by gencpp from file lidar_tracker/lt_state_Type.msg
// DO NOT EDIT!


#ifndef LIDAR_TRACKER_MESSAGE_LT_STATE_TYPE_H
#define LIDAR_TRACKER_MESSAGE_LT_STATE_TYPE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <lidar_tracker/lt_object_Type.h>

namespace lidar_tracker
{
template <class ContainerAllocator>
struct lt_state_Type_
{
  typedef lt_state_Type_<ContainerAllocator> Type;

  lt_state_Type_()
    : timestamp(0.0)
    , lidars_difftime(0.0)
    , objects()
    , trackedcone_indexes()
    , noncone_indexes()
    , num_of_fusedobjects(0)
    , columnscan_up_dist()
    , columnscan_down_dist()  {
      columnscan_up_dist.assign(0.0);

      columnscan_down_dist.assign(0.0);
  }
  lt_state_Type_(const ContainerAllocator& _alloc)
    : timestamp(0.0)
    , lidars_difftime(0.0)
    , objects(_alloc)
    , trackedcone_indexes(_alloc)
    , noncone_indexes(_alloc)
    , num_of_fusedobjects(0)
    , columnscan_up_dist()
    , columnscan_down_dist()  {
  (void)_alloc;
      columnscan_up_dist.assign(0.0);

      columnscan_down_dist.assign(0.0);
  }



   typedef double _timestamp_type;
  _timestamp_type timestamp;

   typedef double _lidars_difftime_type;
  _lidars_difftime_type lidars_difftime;

   typedef std::vector< ::lidar_tracker::lt_object_Type_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::lidar_tracker::lt_object_Type_<ContainerAllocator> >::other >  _objects_type;
  _objects_type objects;

   typedef std::vector<int64_t, typename ContainerAllocator::template rebind<int64_t>::other >  _trackedcone_indexes_type;
  _trackedcone_indexes_type trackedcone_indexes;

   typedef std::vector<int64_t, typename ContainerAllocator::template rebind<int64_t>::other >  _noncone_indexes_type;
  _noncone_indexes_type noncone_indexes;

   typedef int64_t _num_of_fusedobjects_type;
  _num_of_fusedobjects_type num_of_fusedobjects;

   typedef boost::array<double, 8>  _columnscan_up_dist_type;
  _columnscan_up_dist_type columnscan_up_dist;

   typedef boost::array<double, 8>  _columnscan_down_dist_type;
  _columnscan_down_dist_type columnscan_down_dist;





  typedef boost::shared_ptr< ::lidar_tracker::lt_state_Type_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::lidar_tracker::lt_state_Type_<ContainerAllocator> const> ConstPtr;

}; // struct lt_state_Type_

typedef ::lidar_tracker::lt_state_Type_<std::allocator<void> > lt_state_Type;

typedef boost::shared_ptr< ::lidar_tracker::lt_state_Type > lt_state_TypePtr;
typedef boost::shared_ptr< ::lidar_tracker::lt_state_Type const> lt_state_TypeConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::lidar_tracker::lt_state_Type_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::lidar_tracker::lt_state_Type_<ContainerAllocator1> & lhs, const ::lidar_tracker::lt_state_Type_<ContainerAllocator2> & rhs)
{
  return lhs.timestamp == rhs.timestamp &&
    lhs.lidars_difftime == rhs.lidars_difftime &&
    lhs.objects == rhs.objects &&
    lhs.trackedcone_indexes == rhs.trackedcone_indexes &&
    lhs.noncone_indexes == rhs.noncone_indexes &&
    lhs.num_of_fusedobjects == rhs.num_of_fusedobjects &&
    lhs.columnscan_up_dist == rhs.columnscan_up_dist &&
    lhs.columnscan_down_dist == rhs.columnscan_down_dist;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::lidar_tracker::lt_state_Type_<ContainerAllocator1> & lhs, const ::lidar_tracker::lt_state_Type_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace lidar_tracker

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lidar_tracker::lt_state_Type_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lidar_tracker::lt_state_Type_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lidar_tracker::lt_state_Type_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "e1e182e21c664b2dc04f11764f16b6e9";
  }

  static const char* value(const ::lidar_tracker::lt_state_Type_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xe1e182e21c664b2dULL;
  static const uint64_t static_value2 = 0xc04f11764f16b6e9ULL;
};

template<class ContainerAllocator>
struct DataType< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "lidar_tracker/lt_state_Type";
  }

  static const char* value(const ::lidar_tracker::lt_state_Type_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Timestamp [s]\n"
"float64 timestamp\n"
"\n"
"# DiffTime [s]\n"
"float64 lidars_difftime\n"
"\n"
"# Detected Objects\n"
"lidar_tracker/lt_object_Type[] objects\n"
"int64[] trackedcone_indexes \n"
"int64[] noncone_indexes \n"
"\n"
"# Detected Objects Stat\n"
"int64 num_of_fusedobjects\n"
"\n"
"# Detected dist(X) for 8 column(Y) scanners\n"
"float64[8] columnscan_up_dist  \n"
"float64[8] columnscan_down_dist  \n"
"\n"
"================================================================================\n"
"MSG: lidar_tracker/lt_object_Type\n"
"# Object ID\n"
"int64 ID\n"
"float64 IDTimestamp\n"
"\n"
"# Interval [s]\n"
"float64 UpdateInterval\n"
"\n"
"# Matching ratio\n"
"float64 RatioM\n"
"\n"
"# Object feature points\n"
"lidar_tracker/lt_datapoint_Type MinPoint\n"
"lidar_tracker/lt_datapoint_Type IncEdge\n"
"lidar_tracker/lt_datapoint_Type DecEdge\n"
"lidar_tracker/lt_datapoint_Type CenterPoint\n"
"lidar_tracker/lt_datapoint_Type StableRefPoint\n"
"\n"
"# Object size [m]\n"
"float64 Size\n"
"\n"
"# Object is cone\n"
"bool Is_Cone\n"
"# Object is tracked\n"
"bool Is_Tracked\n"
"\n"
"# Estimated Vel Acc\n"
"lidar_tracker/lt_datapoint_Type Est_Vel\n"
"lidar_tracker/lt_datapoint_Type Est_Acc\n"
"\n"
"# Lidar data fused object\n"
"bool Is_Fused\n"
"\n"
"# Estimated incline angle [rad]\n"
"lidar_tracker/lt_datapoint_Type Incline\n"
"# Estimated rotated angle [rad]\n"
"float64 Rotate\n"
"\n"
"\n"
"================================================================================\n"
"MSG: lidar_tracker/lt_datapoint_Type\n"
"# XY coordinate [m]\n"
"float64  Dist\n"
"float64  Angle\n"
"float64  x\n"
"float64  y\n"
"# RSSI [0~255]\n"
"float64  intensity\n"
"\n"
;
  }

  static const char* value(const ::lidar_tracker::lt_state_Type_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.timestamp);
      stream.next(m.lidars_difftime);
      stream.next(m.objects);
      stream.next(m.trackedcone_indexes);
      stream.next(m.noncone_indexes);
      stream.next(m.num_of_fusedobjects);
      stream.next(m.columnscan_up_dist);
      stream.next(m.columnscan_down_dist);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct lt_state_Type_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::lidar_tracker::lt_state_Type_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::lidar_tracker::lt_state_Type_<ContainerAllocator>& v)
  {
    s << indent << "timestamp: ";
    Printer<double>::stream(s, indent + "  ", v.timestamp);
    s << indent << "lidars_difftime: ";
    Printer<double>::stream(s, indent + "  ", v.lidars_difftime);
    s << indent << "objects[]" << std::endl;
    for (size_t i = 0; i < v.objects.size(); ++i)
    {
      s << indent << "  objects[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::lidar_tracker::lt_object_Type_<ContainerAllocator> >::stream(s, indent + "    ", v.objects[i]);
    }
    s << indent << "trackedcone_indexes[]" << std::endl;
    for (size_t i = 0; i < v.trackedcone_indexes.size(); ++i)
    {
      s << indent << "  trackedcone_indexes[" << i << "]: ";
      Printer<int64_t>::stream(s, indent + "  ", v.trackedcone_indexes[i]);
    }
    s << indent << "noncone_indexes[]" << std::endl;
    for (size_t i = 0; i < v.noncone_indexes.size(); ++i)
    {
      s << indent << "  noncone_indexes[" << i << "]: ";
      Printer<int64_t>::stream(s, indent + "  ", v.noncone_indexes[i]);
    }
    s << indent << "num_of_fusedobjects: ";
    Printer<int64_t>::stream(s, indent + "  ", v.num_of_fusedobjects);
    s << indent << "columnscan_up_dist[]" << std::endl;
    for (size_t i = 0; i < v.columnscan_up_dist.size(); ++i)
    {
      s << indent << "  columnscan_up_dist[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.columnscan_up_dist[i]);
    }
    s << indent << "columnscan_down_dist[]" << std::endl;
    for (size_t i = 0; i < v.columnscan_down_dist.size(); ++i)
    {
      s << indent << "  columnscan_down_dist[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.columnscan_down_dist[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // LIDAR_TRACKER_MESSAGE_LT_STATE_TYPE_H
