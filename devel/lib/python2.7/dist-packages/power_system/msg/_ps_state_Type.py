# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from power_system/ps_state_Type.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class ps_state_Type(genpy.Message):
  _md5sum = "e128e49adf15f8c39cb073cd0ec61c2e"
  _type = "power_system/ps_state_Type"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """# Timestamp [s]
float64 timestamp

# 2 humidity and sensor readings
float64[2] th_temperature
float64[2] th_humidity

# 2 3-phase meter sensor readings
float64[2] meter_phA_V
float64[2] meter_phB_V
float64[2] meter_phC_V
float64[2] meter_phA_I
float64[2] meter_phB_I
float64[2] meter_phC_I
float64[2] meter_tot_W
float64[2] meter_phA_W
float64[2] meter_phB_W
float64[2] meter_phC_W

# 2 3-phase inverter MCB readings
float64[2] mcb_V
float64[2] mcb_I
int64[2] mcb_sw_pos

# sensor boxes error state
int64[2] state_temphum
int64[2] state_meter
int64[2] state_mcb
"""
  __slots__ = ['timestamp','th_temperature','th_humidity','meter_phA_V','meter_phB_V','meter_phC_V','meter_phA_I','meter_phB_I','meter_phC_I','meter_tot_W','meter_phA_W','meter_phB_W','meter_phC_W','mcb_V','mcb_I','mcb_sw_pos','state_temphum','state_meter','state_mcb']
  _slot_types = ['float64','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','float64[2]','int64[2]','int64[2]','int64[2]','int64[2]']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       timestamp,th_temperature,th_humidity,meter_phA_V,meter_phB_V,meter_phC_V,meter_phA_I,meter_phB_I,meter_phC_I,meter_tot_W,meter_phA_W,meter_phB_W,meter_phC_W,mcb_V,mcb_I,mcb_sw_pos,state_temphum,state_meter,state_mcb

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(ps_state_Type, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.timestamp is None:
        self.timestamp = 0.
      if self.th_temperature is None:
        self.th_temperature = [0.] * 2
      if self.th_humidity is None:
        self.th_humidity = [0.] * 2
      if self.meter_phA_V is None:
        self.meter_phA_V = [0.] * 2
      if self.meter_phB_V is None:
        self.meter_phB_V = [0.] * 2
      if self.meter_phC_V is None:
        self.meter_phC_V = [0.] * 2
      if self.meter_phA_I is None:
        self.meter_phA_I = [0.] * 2
      if self.meter_phB_I is None:
        self.meter_phB_I = [0.] * 2
      if self.meter_phC_I is None:
        self.meter_phC_I = [0.] * 2
      if self.meter_tot_W is None:
        self.meter_tot_W = [0.] * 2
      if self.meter_phA_W is None:
        self.meter_phA_W = [0.] * 2
      if self.meter_phB_W is None:
        self.meter_phB_W = [0.] * 2
      if self.meter_phC_W is None:
        self.meter_phC_W = [0.] * 2
      if self.mcb_V is None:
        self.mcb_V = [0.] * 2
      if self.mcb_I is None:
        self.mcb_I = [0.] * 2
      if self.mcb_sw_pos is None:
        self.mcb_sw_pos = [0] * 2
      if self.state_temphum is None:
        self.state_temphum = [0] * 2
      if self.state_meter is None:
        self.state_meter = [0] * 2
      if self.state_mcb is None:
        self.state_mcb = [0] * 2
    else:
      self.timestamp = 0.
      self.th_temperature = [0.] * 2
      self.th_humidity = [0.] * 2
      self.meter_phA_V = [0.] * 2
      self.meter_phB_V = [0.] * 2
      self.meter_phC_V = [0.] * 2
      self.meter_phA_I = [0.] * 2
      self.meter_phB_I = [0.] * 2
      self.meter_phC_I = [0.] * 2
      self.meter_tot_W = [0.] * 2
      self.meter_phA_W = [0.] * 2
      self.meter_phB_W = [0.] * 2
      self.meter_phC_W = [0.] * 2
      self.mcb_V = [0.] * 2
      self.mcb_I = [0.] * 2
      self.mcb_sw_pos = [0] * 2
      self.state_temphum = [0] * 2
      self.state_meter = [0] * 2
      self.state_mcb = [0] * 2

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
      buff.write(_get_struct_d().pack(self.timestamp))
      buff.write(_get_struct_2d().pack(*self.th_temperature))
      buff.write(_get_struct_2d().pack(*self.th_humidity))
      buff.write(_get_struct_2d().pack(*self.meter_phA_V))
      buff.write(_get_struct_2d().pack(*self.meter_phB_V))
      buff.write(_get_struct_2d().pack(*self.meter_phC_V))
      buff.write(_get_struct_2d().pack(*self.meter_phA_I))
      buff.write(_get_struct_2d().pack(*self.meter_phB_I))
      buff.write(_get_struct_2d().pack(*self.meter_phC_I))
      buff.write(_get_struct_2d().pack(*self.meter_tot_W))
      buff.write(_get_struct_2d().pack(*self.meter_phA_W))
      buff.write(_get_struct_2d().pack(*self.meter_phB_W))
      buff.write(_get_struct_2d().pack(*self.meter_phC_W))
      buff.write(_get_struct_2d().pack(*self.mcb_V))
      buff.write(_get_struct_2d().pack(*self.mcb_I))
      buff.write(_get_struct_2q().pack(*self.mcb_sw_pos))
      buff.write(_get_struct_2q().pack(*self.state_temphum))
      buff.write(_get_struct_2q().pack(*self.state_meter))
      buff.write(_get_struct_2q().pack(*self.state_mcb))
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
      (self.timestamp,) = _get_struct_d().unpack(str[start:end])
      start = end
      end += 16
      self.th_temperature = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.th_humidity = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phA_V = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phB_V = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phC_V = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phA_I = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phB_I = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phC_I = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_tot_W = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phA_W = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phB_W = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.meter_phC_W = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.mcb_V = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.mcb_I = _get_struct_2d().unpack(str[start:end])
      start = end
      end += 16
      self.mcb_sw_pos = _get_struct_2q().unpack(str[start:end])
      start = end
      end += 16
      self.state_temphum = _get_struct_2q().unpack(str[start:end])
      start = end
      end += 16
      self.state_meter = _get_struct_2q().unpack(str[start:end])
      start = end
      end += 16
      self.state_mcb = _get_struct_2q().unpack(str[start:end])
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
      buff.write(_get_struct_d().pack(self.timestamp))
      buff.write(self.th_temperature.tostring())
      buff.write(self.th_humidity.tostring())
      buff.write(self.meter_phA_V.tostring())
      buff.write(self.meter_phB_V.tostring())
      buff.write(self.meter_phC_V.tostring())
      buff.write(self.meter_phA_I.tostring())
      buff.write(self.meter_phB_I.tostring())
      buff.write(self.meter_phC_I.tostring())
      buff.write(self.meter_tot_W.tostring())
      buff.write(self.meter_phA_W.tostring())
      buff.write(self.meter_phB_W.tostring())
      buff.write(self.meter_phC_W.tostring())
      buff.write(self.mcb_V.tostring())
      buff.write(self.mcb_I.tostring())
      buff.write(self.mcb_sw_pos.tostring())
      buff.write(self.state_temphum.tostring())
      buff.write(self.state_meter.tostring())
      buff.write(self.state_mcb.tostring())
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
      (self.timestamp,) = _get_struct_d().unpack(str[start:end])
      start = end
      end += 16
      self.th_temperature = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.th_humidity = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phA_V = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phB_V = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phC_V = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phA_I = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phB_I = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phC_I = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_tot_W = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phA_W = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phB_W = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.meter_phC_W = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.mcb_V = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.mcb_I = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=2)
      start = end
      end += 16
      self.mcb_sw_pos = numpy.frombuffer(str[start:end], dtype=numpy.int64, count=2)
      start = end
      end += 16
      self.state_temphum = numpy.frombuffer(str[start:end], dtype=numpy.int64, count=2)
      start = end
      end += 16
      self.state_meter = numpy.frombuffer(str[start:end], dtype=numpy.int64, count=2)
      start = end
      end += 16
      self.state_mcb = numpy.frombuffer(str[start:end], dtype=numpy.int64, count=2)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2d = None
def _get_struct_2d():
    global _struct_2d
    if _struct_2d is None:
        _struct_2d = struct.Struct("<2d")
    return _struct_2d
_struct_d = None
def _get_struct_d():
    global _struct_d
    if _struct_d is None:
        _struct_d = struct.Struct("<d")
    return _struct_d
_struct_2q = None
def _get_struct_2q():
    global _struct_2q
    if _struct_2q is None:
        _struct_2q = struct.Struct("<2q")
    return _struct_2q
