# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from kuka_robot/kr_mv_byjoint_ArgsRequest.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import kuka_robot.msg

class kr_mv_byjoint_ArgsRequest(genpy.Message):
  _md5sum = "7db351d4fc356ec8dca75d8666dbe8dc"
  _type = "kuka_robot/kr_mv_byjoint_ArgsRequest"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """
kr_joint_Type joints

================================================================================
MSG: kuka_robot/kr_joint_Type
# Joint Angles [degree]
float64 A1
float64 A2
float64 A3
float64 A4
float64 A5
float64 A6

"""
  __slots__ = ['joints']
  _slot_types = ['kuka_robot/kr_joint_Type']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       joints

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(kr_mv_byjoint_ArgsRequest, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.joints is None:
        self.joints = kuka_robot.msg.kr_joint_Type()
    else:
      self.joints = kuka_robot.msg.kr_joint_Type()

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
      buff.write(_get_struct_6d().pack(_x.joints.A1, _x.joints.A2, _x.joints.A3, _x.joints.A4, _x.joints.A5, _x.joints.A6))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      if self.joints is None:
        self.joints = kuka_robot.msg.kr_joint_Type()
      end = 0
      _x = self
      start = end
      end += 48
      (_x.joints.A1, _x.joints.A2, _x.joints.A3, _x.joints.A4, _x.joints.A5, _x.joints.A6,) = _get_struct_6d().unpack(str[start:end])
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
      buff.write(_get_struct_6d().pack(_x.joints.A1, _x.joints.A2, _x.joints.A3, _x.joints.A4, _x.joints.A5, _x.joints.A6))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      if self.joints is None:
        self.joints = kuka_robot.msg.kr_joint_Type()
      end = 0
      _x = self
      start = end
      end += 48
      (_x.joints.A1, _x.joints.A2, _x.joints.A3, _x.joints.A4, _x.joints.A5, _x.joints.A6,) = _get_struct_6d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_6d = None
def _get_struct_6d():
    global _struct_6d
    if _struct_6d is None:
        _struct_6d = struct.Struct("<6d")
    return _struct_6d
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from kuka_robot/kr_mv_byjoint_ArgsResponse.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class kr_mv_byjoint_ArgsResponse(genpy.Message):
  _md5sum = "4bf37bc717f68787645077428bea3751"
  _type = "kuka_robot/kr_mv_byjoint_ArgsResponse"
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
      super(kr_mv_byjoint_ArgsResponse, self).__init__(*args, **kwds)
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
class kr_mv_byjoint_Args(object):
  _type          = 'kuka_robot/kr_mv_byjoint_Args'
  _md5sum = '1ffacecfaa4c500ecb39aa7cf1b68d2f'
  _request_class  = kr_mv_byjoint_ArgsRequest
  _response_class = kr_mv_byjoint_ArgsResponse
