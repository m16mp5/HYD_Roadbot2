# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from kuka_robot/kr_set_load_ArgsRequest.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import kuka_robot.msg

class kr_set_load_ArgsRequest(genpy.Message):
  _md5sum = "9b0c62385da61d849c73f59805952adf"
  _type = "kuka_robot/kr_set_load_ArgsRequest"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """
kr_payload_Type load

kr_payload_Type load_a1

kr_payload_Type load_a2

kr_payload_Type load_a3

================================================================================
MSG: kuka_robot/kr_payload_Type
# Mass [kg]
float64 mass

# Center of mass [mm]
kuka_robot/kr_pose_Type CenterOfGravity

# Inertia [kg-m^2]
kuka_robot/kr_pose_Type Inertia


================================================================================
MSG: kuka_robot/kr_pose_Type
# XYZ coordinate [mm]
float64 X
float64 Y
float64 Z
# ABC orientation [mm]
float64 A
float64 B
float64 C
# Status and Turn [unit]
float64 S
float64 T
"""
  __slots__ = ['load','load_a1','load_a2','load_a3']
  _slot_types = ['kuka_robot/kr_payload_Type','kuka_robot/kr_payload_Type','kuka_robot/kr_payload_Type','kuka_robot/kr_payload_Type']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       load,load_a1,load_a2,load_a3

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(kr_set_load_ArgsRequest, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.load is None:
        self.load = kuka_robot.msg.kr_payload_Type()
      if self.load_a1 is None:
        self.load_a1 = kuka_robot.msg.kr_payload_Type()
      if self.load_a2 is None:
        self.load_a2 = kuka_robot.msg.kr_payload_Type()
      if self.load_a3 is None:
        self.load_a3 = kuka_robot.msg.kr_payload_Type()
    else:
      self.load = kuka_robot.msg.kr_payload_Type()
      self.load_a1 = kuka_robot.msg.kr_payload_Type()
      self.load_a2 = kuka_robot.msg.kr_payload_Type()
      self.load_a3 = kuka_robot.msg.kr_payload_Type()

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
      buff.write(_get_struct_68d().pack(_x.load.mass, _x.load.CenterOfGravity.X, _x.load.CenterOfGravity.Y, _x.load.CenterOfGravity.Z, _x.load.CenterOfGravity.A, _x.load.CenterOfGravity.B, _x.load.CenterOfGravity.C, _x.load.CenterOfGravity.S, _x.load.CenterOfGravity.T, _x.load.Inertia.X, _x.load.Inertia.Y, _x.load.Inertia.Z, _x.load.Inertia.A, _x.load.Inertia.B, _x.load.Inertia.C, _x.load.Inertia.S, _x.load.Inertia.T, _x.load_a1.mass, _x.load_a1.CenterOfGravity.X, _x.load_a1.CenterOfGravity.Y, _x.load_a1.CenterOfGravity.Z, _x.load_a1.CenterOfGravity.A, _x.load_a1.CenterOfGravity.B, _x.load_a1.CenterOfGravity.C, _x.load_a1.CenterOfGravity.S, _x.load_a1.CenterOfGravity.T, _x.load_a1.Inertia.X, _x.load_a1.Inertia.Y, _x.load_a1.Inertia.Z, _x.load_a1.Inertia.A, _x.load_a1.Inertia.B, _x.load_a1.Inertia.C, _x.load_a1.Inertia.S, _x.load_a1.Inertia.T, _x.load_a2.mass, _x.load_a2.CenterOfGravity.X, _x.load_a2.CenterOfGravity.Y, _x.load_a2.CenterOfGravity.Z, _x.load_a2.CenterOfGravity.A, _x.load_a2.CenterOfGravity.B, _x.load_a2.CenterOfGravity.C, _x.load_a2.CenterOfGravity.S, _x.load_a2.CenterOfGravity.T, _x.load_a2.Inertia.X, _x.load_a2.Inertia.Y, _x.load_a2.Inertia.Z, _x.load_a2.Inertia.A, _x.load_a2.Inertia.B, _x.load_a2.Inertia.C, _x.load_a2.Inertia.S, _x.load_a2.Inertia.T, _x.load_a3.mass, _x.load_a3.CenterOfGravity.X, _x.load_a3.CenterOfGravity.Y, _x.load_a3.CenterOfGravity.Z, _x.load_a3.CenterOfGravity.A, _x.load_a3.CenterOfGravity.B, _x.load_a3.CenterOfGravity.C, _x.load_a3.CenterOfGravity.S, _x.load_a3.CenterOfGravity.T, _x.load_a3.Inertia.X, _x.load_a3.Inertia.Y, _x.load_a3.Inertia.Z, _x.load_a3.Inertia.A, _x.load_a3.Inertia.B, _x.load_a3.Inertia.C, _x.load_a3.Inertia.S, _x.load_a3.Inertia.T))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      if self.load is None:
        self.load = kuka_robot.msg.kr_payload_Type()
      if self.load_a1 is None:
        self.load_a1 = kuka_robot.msg.kr_payload_Type()
      if self.load_a2 is None:
        self.load_a2 = kuka_robot.msg.kr_payload_Type()
      if self.load_a3 is None:
        self.load_a3 = kuka_robot.msg.kr_payload_Type()
      end = 0
      _x = self
      start = end
      end += 544
      (_x.load.mass, _x.load.CenterOfGravity.X, _x.load.CenterOfGravity.Y, _x.load.CenterOfGravity.Z, _x.load.CenterOfGravity.A, _x.load.CenterOfGravity.B, _x.load.CenterOfGravity.C, _x.load.CenterOfGravity.S, _x.load.CenterOfGravity.T, _x.load.Inertia.X, _x.load.Inertia.Y, _x.load.Inertia.Z, _x.load.Inertia.A, _x.load.Inertia.B, _x.load.Inertia.C, _x.load.Inertia.S, _x.load.Inertia.T, _x.load_a1.mass, _x.load_a1.CenterOfGravity.X, _x.load_a1.CenterOfGravity.Y, _x.load_a1.CenterOfGravity.Z, _x.load_a1.CenterOfGravity.A, _x.load_a1.CenterOfGravity.B, _x.load_a1.CenterOfGravity.C, _x.load_a1.CenterOfGravity.S, _x.load_a1.CenterOfGravity.T, _x.load_a1.Inertia.X, _x.load_a1.Inertia.Y, _x.load_a1.Inertia.Z, _x.load_a1.Inertia.A, _x.load_a1.Inertia.B, _x.load_a1.Inertia.C, _x.load_a1.Inertia.S, _x.load_a1.Inertia.T, _x.load_a2.mass, _x.load_a2.CenterOfGravity.X, _x.load_a2.CenterOfGravity.Y, _x.load_a2.CenterOfGravity.Z, _x.load_a2.CenterOfGravity.A, _x.load_a2.CenterOfGravity.B, _x.load_a2.CenterOfGravity.C, _x.load_a2.CenterOfGravity.S, _x.load_a2.CenterOfGravity.T, _x.load_a2.Inertia.X, _x.load_a2.Inertia.Y, _x.load_a2.Inertia.Z, _x.load_a2.Inertia.A, _x.load_a2.Inertia.B, _x.load_a2.Inertia.C, _x.load_a2.Inertia.S, _x.load_a2.Inertia.T, _x.load_a3.mass, _x.load_a3.CenterOfGravity.X, _x.load_a3.CenterOfGravity.Y, _x.load_a3.CenterOfGravity.Z, _x.load_a3.CenterOfGravity.A, _x.load_a3.CenterOfGravity.B, _x.load_a3.CenterOfGravity.C, _x.load_a3.CenterOfGravity.S, _x.load_a3.CenterOfGravity.T, _x.load_a3.Inertia.X, _x.load_a3.Inertia.Y, _x.load_a3.Inertia.Z, _x.load_a3.Inertia.A, _x.load_a3.Inertia.B, _x.load_a3.Inertia.C, _x.load_a3.Inertia.S, _x.load_a3.Inertia.T,) = _get_struct_68d().unpack(str[start:end])
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
      buff.write(_get_struct_68d().pack(_x.load.mass, _x.load.CenterOfGravity.X, _x.load.CenterOfGravity.Y, _x.load.CenterOfGravity.Z, _x.load.CenterOfGravity.A, _x.load.CenterOfGravity.B, _x.load.CenterOfGravity.C, _x.load.CenterOfGravity.S, _x.load.CenterOfGravity.T, _x.load.Inertia.X, _x.load.Inertia.Y, _x.load.Inertia.Z, _x.load.Inertia.A, _x.load.Inertia.B, _x.load.Inertia.C, _x.load.Inertia.S, _x.load.Inertia.T, _x.load_a1.mass, _x.load_a1.CenterOfGravity.X, _x.load_a1.CenterOfGravity.Y, _x.load_a1.CenterOfGravity.Z, _x.load_a1.CenterOfGravity.A, _x.load_a1.CenterOfGravity.B, _x.load_a1.CenterOfGravity.C, _x.load_a1.CenterOfGravity.S, _x.load_a1.CenterOfGravity.T, _x.load_a1.Inertia.X, _x.load_a1.Inertia.Y, _x.load_a1.Inertia.Z, _x.load_a1.Inertia.A, _x.load_a1.Inertia.B, _x.load_a1.Inertia.C, _x.load_a1.Inertia.S, _x.load_a1.Inertia.T, _x.load_a2.mass, _x.load_a2.CenterOfGravity.X, _x.load_a2.CenterOfGravity.Y, _x.load_a2.CenterOfGravity.Z, _x.load_a2.CenterOfGravity.A, _x.load_a2.CenterOfGravity.B, _x.load_a2.CenterOfGravity.C, _x.load_a2.CenterOfGravity.S, _x.load_a2.CenterOfGravity.T, _x.load_a2.Inertia.X, _x.load_a2.Inertia.Y, _x.load_a2.Inertia.Z, _x.load_a2.Inertia.A, _x.load_a2.Inertia.B, _x.load_a2.Inertia.C, _x.load_a2.Inertia.S, _x.load_a2.Inertia.T, _x.load_a3.mass, _x.load_a3.CenterOfGravity.X, _x.load_a3.CenterOfGravity.Y, _x.load_a3.CenterOfGravity.Z, _x.load_a3.CenterOfGravity.A, _x.load_a3.CenterOfGravity.B, _x.load_a3.CenterOfGravity.C, _x.load_a3.CenterOfGravity.S, _x.load_a3.CenterOfGravity.T, _x.load_a3.Inertia.X, _x.load_a3.Inertia.Y, _x.load_a3.Inertia.Z, _x.load_a3.Inertia.A, _x.load_a3.Inertia.B, _x.load_a3.Inertia.C, _x.load_a3.Inertia.S, _x.load_a3.Inertia.T))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      if self.load is None:
        self.load = kuka_robot.msg.kr_payload_Type()
      if self.load_a1 is None:
        self.load_a1 = kuka_robot.msg.kr_payload_Type()
      if self.load_a2 is None:
        self.load_a2 = kuka_robot.msg.kr_payload_Type()
      if self.load_a3 is None:
        self.load_a3 = kuka_robot.msg.kr_payload_Type()
      end = 0
      _x = self
      start = end
      end += 544
      (_x.load.mass, _x.load.CenterOfGravity.X, _x.load.CenterOfGravity.Y, _x.load.CenterOfGravity.Z, _x.load.CenterOfGravity.A, _x.load.CenterOfGravity.B, _x.load.CenterOfGravity.C, _x.load.CenterOfGravity.S, _x.load.CenterOfGravity.T, _x.load.Inertia.X, _x.load.Inertia.Y, _x.load.Inertia.Z, _x.load.Inertia.A, _x.load.Inertia.B, _x.load.Inertia.C, _x.load.Inertia.S, _x.load.Inertia.T, _x.load_a1.mass, _x.load_a1.CenterOfGravity.X, _x.load_a1.CenterOfGravity.Y, _x.load_a1.CenterOfGravity.Z, _x.load_a1.CenterOfGravity.A, _x.load_a1.CenterOfGravity.B, _x.load_a1.CenterOfGravity.C, _x.load_a1.CenterOfGravity.S, _x.load_a1.CenterOfGravity.T, _x.load_a1.Inertia.X, _x.load_a1.Inertia.Y, _x.load_a1.Inertia.Z, _x.load_a1.Inertia.A, _x.load_a1.Inertia.B, _x.load_a1.Inertia.C, _x.load_a1.Inertia.S, _x.load_a1.Inertia.T, _x.load_a2.mass, _x.load_a2.CenterOfGravity.X, _x.load_a2.CenterOfGravity.Y, _x.load_a2.CenterOfGravity.Z, _x.load_a2.CenterOfGravity.A, _x.load_a2.CenterOfGravity.B, _x.load_a2.CenterOfGravity.C, _x.load_a2.CenterOfGravity.S, _x.load_a2.CenterOfGravity.T, _x.load_a2.Inertia.X, _x.load_a2.Inertia.Y, _x.load_a2.Inertia.Z, _x.load_a2.Inertia.A, _x.load_a2.Inertia.B, _x.load_a2.Inertia.C, _x.load_a2.Inertia.S, _x.load_a2.Inertia.T, _x.load_a3.mass, _x.load_a3.CenterOfGravity.X, _x.load_a3.CenterOfGravity.Y, _x.load_a3.CenterOfGravity.Z, _x.load_a3.CenterOfGravity.A, _x.load_a3.CenterOfGravity.B, _x.load_a3.CenterOfGravity.C, _x.load_a3.CenterOfGravity.S, _x.load_a3.CenterOfGravity.T, _x.load_a3.Inertia.X, _x.load_a3.Inertia.Y, _x.load_a3.Inertia.Z, _x.load_a3.Inertia.A, _x.load_a3.Inertia.B, _x.load_a3.Inertia.C, _x.load_a3.Inertia.S, _x.load_a3.Inertia.T,) = _get_struct_68d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_68d = None
def _get_struct_68d():
    global _struct_68d
    if _struct_68d is None:
        _struct_68d = struct.Struct("<68d")
    return _struct_68d
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from kuka_robot/kr_set_load_ArgsResponse.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class kr_set_load_ArgsResponse(genpy.Message):
  _md5sum = "4bf37bc717f68787645077428bea3751"
  _type = "kuka_robot/kr_set_load_ArgsResponse"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """
int64 response


"""
  __slots__ = ['response']
  _slot_types = ['int64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       response

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(kr_set_load_ArgsResponse, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.response is None:
        self.response = 0
    else:
      self.response = 0

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
      buff.write(_get_struct_q().pack(self.response))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      end = 0
      start = end
      end += 8
      (self.response,) = _get_struct_q().unpack(str[start:end])
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
      buff.write(_get_struct_q().pack(self.response))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      end = 0
      start = end
      end += 8
      (self.response,) = _get_struct_q().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_q = None
def _get_struct_q():
    global _struct_q
    if _struct_q is None:
        _struct_q = struct.Struct("<q")
    return _struct_q
class kr_set_load_Args(object):
  _type          = 'kuka_robot/kr_set_load_Args'
  _md5sum = '621c48a444ec50a2e8cd24b61ee09b4c'
  _request_class  = kr_set_load_ArgsRequest
  _response_class = kr_set_load_ArgsResponse
