# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from lidar_tracker/lt_object_Type.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import lidar_tracker.msg

class lt_object_Type(genpy.Message):
  _md5sum = "653a1245a4632ad939226826e9619f93"
  _type = "lidar_tracker/lt_object_Type"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """# Object ID
int64 ID
float64 IDTimestamp

# Interval [s]
float64 UpdateInterval

# Matching ratio
float64 RatioM

# Object feature points
lidar_tracker/lt_datapoint_Type MinPoint
lidar_tracker/lt_datapoint_Type IncEdge
lidar_tracker/lt_datapoint_Type DecEdge
lidar_tracker/lt_datapoint_Type CenterPoint
lidar_tracker/lt_datapoint_Type StableRefPoint

# Object size [m]
float64 Size

# Object is cone
bool Is_Cone
# Object is tracked
bool Is_Tracked

# Estimated Vel Acc
lidar_tracker/lt_datapoint_Type Est_Vel
lidar_tracker/lt_datapoint_Type Est_Acc

# Lidar data fused object
bool Is_Fused

# Estimated incline angle [rad]
lidar_tracker/lt_datapoint_Type Incline
# Estimated rotated angle [rad]
float64 Rotate


================================================================================
MSG: lidar_tracker/lt_datapoint_Type
# XY coordinate [m]
float64  Dist
float64  Angle
float64  x
float64  y
# RSSI [0~255]
float64  intensity

"""
  __slots__ = ['ID','IDTimestamp','UpdateInterval','RatioM','MinPoint','IncEdge','DecEdge','CenterPoint','StableRefPoint','Size','Is_Cone','Is_Tracked','Est_Vel','Est_Acc','Is_Fused','Incline','Rotate']
  _slot_types = ['int64','float64','float64','float64','lidar_tracker/lt_datapoint_Type','lidar_tracker/lt_datapoint_Type','lidar_tracker/lt_datapoint_Type','lidar_tracker/lt_datapoint_Type','lidar_tracker/lt_datapoint_Type','float64','bool','bool','lidar_tracker/lt_datapoint_Type','lidar_tracker/lt_datapoint_Type','bool','lidar_tracker/lt_datapoint_Type','float64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       ID,IDTimestamp,UpdateInterval,RatioM,MinPoint,IncEdge,DecEdge,CenterPoint,StableRefPoint,Size,Is_Cone,Is_Tracked,Est_Vel,Est_Acc,Is_Fused,Incline,Rotate

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(lt_object_Type, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.ID is None:
        self.ID = 0
      if self.IDTimestamp is None:
        self.IDTimestamp = 0.
      if self.UpdateInterval is None:
        self.UpdateInterval = 0.
      if self.RatioM is None:
        self.RatioM = 0.
      if self.MinPoint is None:
        self.MinPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.IncEdge is None:
        self.IncEdge = lidar_tracker.msg.lt_datapoint_Type()
      if self.DecEdge is None:
        self.DecEdge = lidar_tracker.msg.lt_datapoint_Type()
      if self.CenterPoint is None:
        self.CenterPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.StableRefPoint is None:
        self.StableRefPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.Size is None:
        self.Size = 0.
      if self.Is_Cone is None:
        self.Is_Cone = False
      if self.Is_Tracked is None:
        self.Is_Tracked = False
      if self.Est_Vel is None:
        self.Est_Vel = lidar_tracker.msg.lt_datapoint_Type()
      if self.Est_Acc is None:
        self.Est_Acc = lidar_tracker.msg.lt_datapoint_Type()
      if self.Is_Fused is None:
        self.Is_Fused = False
      if self.Incline is None:
        self.Incline = lidar_tracker.msg.lt_datapoint_Type()
      if self.Rotate is None:
        self.Rotate = 0.
    else:
      self.ID = 0
      self.IDTimestamp = 0.
      self.UpdateInterval = 0.
      self.RatioM = 0.
      self.MinPoint = lidar_tracker.msg.lt_datapoint_Type()
      self.IncEdge = lidar_tracker.msg.lt_datapoint_Type()
      self.DecEdge = lidar_tracker.msg.lt_datapoint_Type()
      self.CenterPoint = lidar_tracker.msg.lt_datapoint_Type()
      self.StableRefPoint = lidar_tracker.msg.lt_datapoint_Type()
      self.Size = 0.
      self.Is_Cone = False
      self.Is_Tracked = False
      self.Est_Vel = lidar_tracker.msg.lt_datapoint_Type()
      self.Est_Acc = lidar_tracker.msg.lt_datapoint_Type()
      self.Is_Fused = False
      self.Incline = lidar_tracker.msg.lt_datapoint_Type()
      self.Rotate = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_q29d2B10dB6d().pack(_x.ID, _x.IDTimestamp, _x.UpdateInterval, _x.RatioM, _x.MinPoint.Dist, _x.MinPoint.Angle, _x.MinPoint.x, _x.MinPoint.y, _x.MinPoint.intensity, _x.IncEdge.Dist, _x.IncEdge.Angle, _x.IncEdge.x, _x.IncEdge.y, _x.IncEdge.intensity, _x.DecEdge.Dist, _x.DecEdge.Angle, _x.DecEdge.x, _x.DecEdge.y, _x.DecEdge.intensity, _x.CenterPoint.Dist, _x.CenterPoint.Angle, _x.CenterPoint.x, _x.CenterPoint.y, _x.CenterPoint.intensity, _x.StableRefPoint.Dist, _x.StableRefPoint.Angle, _x.StableRefPoint.x, _x.StableRefPoint.y, _x.StableRefPoint.intensity, _x.Size, _x.Is_Cone, _x.Is_Tracked, _x.Est_Vel.Dist, _x.Est_Vel.Angle, _x.Est_Vel.x, _x.Est_Vel.y, _x.Est_Vel.intensity, _x.Est_Acc.Dist, _x.Est_Acc.Angle, _x.Est_Acc.x, _x.Est_Acc.y, _x.Est_Acc.intensity, _x.Is_Fused, _x.Incline.Dist, _x.Incline.Angle, _x.Incline.x, _x.Incline.y, _x.Incline.intensity, _x.Rotate))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      if self.MinPoint is None:
        self.MinPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.IncEdge is None:
        self.IncEdge = lidar_tracker.msg.lt_datapoint_Type()
      if self.DecEdge is None:
        self.DecEdge = lidar_tracker.msg.lt_datapoint_Type()
      if self.CenterPoint is None:
        self.CenterPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.StableRefPoint is None:
        self.StableRefPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.Est_Vel is None:
        self.Est_Vel = lidar_tracker.msg.lt_datapoint_Type()
      if self.Est_Acc is None:
        self.Est_Acc = lidar_tracker.msg.lt_datapoint_Type()
      if self.Incline is None:
        self.Incline = lidar_tracker.msg.lt_datapoint_Type()
      end = 0
      _x = self
      start = end
      end += 371
      (_x.ID, _x.IDTimestamp, _x.UpdateInterval, _x.RatioM, _x.MinPoint.Dist, _x.MinPoint.Angle, _x.MinPoint.x, _x.MinPoint.y, _x.MinPoint.intensity, _x.IncEdge.Dist, _x.IncEdge.Angle, _x.IncEdge.x, _x.IncEdge.y, _x.IncEdge.intensity, _x.DecEdge.Dist, _x.DecEdge.Angle, _x.DecEdge.x, _x.DecEdge.y, _x.DecEdge.intensity, _x.CenterPoint.Dist, _x.CenterPoint.Angle, _x.CenterPoint.x, _x.CenterPoint.y, _x.CenterPoint.intensity, _x.StableRefPoint.Dist, _x.StableRefPoint.Angle, _x.StableRefPoint.x, _x.StableRefPoint.y, _x.StableRefPoint.intensity, _x.Size, _x.Is_Cone, _x.Is_Tracked, _x.Est_Vel.Dist, _x.Est_Vel.Angle, _x.Est_Vel.x, _x.Est_Vel.y, _x.Est_Vel.intensity, _x.Est_Acc.Dist, _x.Est_Acc.Angle, _x.Est_Acc.x, _x.Est_Acc.y, _x.Est_Acc.intensity, _x.Is_Fused, _x.Incline.Dist, _x.Incline.Angle, _x.Incline.x, _x.Incline.y, _x.Incline.intensity, _x.Rotate,) = _get_struct_q29d2B10dB6d().unpack(str[start:end])
      self.Is_Cone = bool(self.Is_Cone)
      self.Is_Tracked = bool(self.Is_Tracked)
      self.Is_Fused = bool(self.Is_Fused)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_q29d2B10dB6d().pack(_x.ID, _x.IDTimestamp, _x.UpdateInterval, _x.RatioM, _x.MinPoint.Dist, _x.MinPoint.Angle, _x.MinPoint.x, _x.MinPoint.y, _x.MinPoint.intensity, _x.IncEdge.Dist, _x.IncEdge.Angle, _x.IncEdge.x, _x.IncEdge.y, _x.IncEdge.intensity, _x.DecEdge.Dist, _x.DecEdge.Angle, _x.DecEdge.x, _x.DecEdge.y, _x.DecEdge.intensity, _x.CenterPoint.Dist, _x.CenterPoint.Angle, _x.CenterPoint.x, _x.CenterPoint.y, _x.CenterPoint.intensity, _x.StableRefPoint.Dist, _x.StableRefPoint.Angle, _x.StableRefPoint.x, _x.StableRefPoint.y, _x.StableRefPoint.intensity, _x.Size, _x.Is_Cone, _x.Is_Tracked, _x.Est_Vel.Dist, _x.Est_Vel.Angle, _x.Est_Vel.x, _x.Est_Vel.y, _x.Est_Vel.intensity, _x.Est_Acc.Dist, _x.Est_Acc.Angle, _x.Est_Acc.x, _x.Est_Acc.y, _x.Est_Acc.intensity, _x.Is_Fused, _x.Incline.Dist, _x.Incline.Angle, _x.Incline.x, _x.Incline.y, _x.Incline.intensity, _x.Rotate))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      if self.MinPoint is None:
        self.MinPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.IncEdge is None:
        self.IncEdge = lidar_tracker.msg.lt_datapoint_Type()
      if self.DecEdge is None:
        self.DecEdge = lidar_tracker.msg.lt_datapoint_Type()
      if self.CenterPoint is None:
        self.CenterPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.StableRefPoint is None:
        self.StableRefPoint = lidar_tracker.msg.lt_datapoint_Type()
      if self.Est_Vel is None:
        self.Est_Vel = lidar_tracker.msg.lt_datapoint_Type()
      if self.Est_Acc is None:
        self.Est_Acc = lidar_tracker.msg.lt_datapoint_Type()
      if self.Incline is None:
        self.Incline = lidar_tracker.msg.lt_datapoint_Type()
      end = 0
      _x = self
      start = end
      end += 371
      (_x.ID, _x.IDTimestamp, _x.UpdateInterval, _x.RatioM, _x.MinPoint.Dist, _x.MinPoint.Angle, _x.MinPoint.x, _x.MinPoint.y, _x.MinPoint.intensity, _x.IncEdge.Dist, _x.IncEdge.Angle, _x.IncEdge.x, _x.IncEdge.y, _x.IncEdge.intensity, _x.DecEdge.Dist, _x.DecEdge.Angle, _x.DecEdge.x, _x.DecEdge.y, _x.DecEdge.intensity, _x.CenterPoint.Dist, _x.CenterPoint.Angle, _x.CenterPoint.x, _x.CenterPoint.y, _x.CenterPoint.intensity, _x.StableRefPoint.Dist, _x.StableRefPoint.Angle, _x.StableRefPoint.x, _x.StableRefPoint.y, _x.StableRefPoint.intensity, _x.Size, _x.Is_Cone, _x.Is_Tracked, _x.Est_Vel.Dist, _x.Est_Vel.Angle, _x.Est_Vel.x, _x.Est_Vel.y, _x.Est_Vel.intensity, _x.Est_Acc.Dist, _x.Est_Acc.Angle, _x.Est_Acc.x, _x.Est_Acc.y, _x.Est_Acc.intensity, _x.Is_Fused, _x.Incline.Dist, _x.Incline.Angle, _x.Incline.x, _x.Incline.y, _x.Incline.intensity, _x.Rotate,) = _get_struct_q29d2B10dB6d().unpack(str[start:end])
      self.Is_Cone = bool(self.Is_Cone)
      self.Is_Tracked = bool(self.Is_Tracked)
      self.Is_Fused = bool(self.Is_Fused)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_q29d2B10dB6d = None
def _get_struct_q29d2B10dB6d():
    global _struct_q29d2B10dB6d
    if _struct_q29d2B10dB6d is None:
        _struct_q29d2B10dB6d = struct.Struct("<q29d2B10dB6d")
    return _struct_q29d2B10dB6d
