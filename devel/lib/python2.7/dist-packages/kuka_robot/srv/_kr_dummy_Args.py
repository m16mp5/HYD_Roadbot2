# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from kuka_robot/kr_dummy_ArgsRequest.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class kr_dummy_ArgsRequest(genpy.Message):
  _md5sum = "3a62b28fdf54afb8d2ce8b90d7336086"
  _type = "kuka_robot/kr_dummy_ArgsRequest"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """
int64 dummy
"""
  __slots__ = ['dummy']
  _slot_types = ['int64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       dummy

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(kr_dummy_ArgsRequest, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.dummy is None:
        self.dummy = 0
    else:
      self.dummy = 0

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
      buff.write(_get_struct_q().pack(self.dummy))
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
      (self.dummy,) = _get_struct_q().unpack(str[start:end])
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
      buff.write(_get_struct_q().pack(self.dummy))
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
      (self.dummy,) = _get_struct_q().unpack(str[start:end])
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
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from kuka_robot/kr_dummy_ArgsResponse.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class kr_dummy_ArgsResponse(genpy.Message):
  _md5sum = "4bf37bc717f68787645077428bea3751"
  _type = "kuka_robot/kr_dummy_ArgsResponse"
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
      super(kr_dummy_ArgsResponse, self).__init__(*args, **kwds)
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
class kr_dummy_Args(object):
  _type          = 'kuka_robot/kr_dummy_Args'
  _md5sum = '33736ff8569e3bd56de924f3e76e8121'
  _request_class  = kr_dummy_ArgsRequest
  _response_class = kr_dummy_ArgsResponse
