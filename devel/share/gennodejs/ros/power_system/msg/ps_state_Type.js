// Auto-generated. Do not edit!

// (in-package power_system.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ps_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.th_temperature = null;
      this.th_humidity = null;
      this.meter_phA_V = null;
      this.meter_phB_V = null;
      this.meter_phC_V = null;
      this.meter_phA_I = null;
      this.meter_phB_I = null;
      this.meter_phC_I = null;
      this.meter_tot_W = null;
      this.meter_phA_W = null;
      this.meter_phB_W = null;
      this.meter_phC_W = null;
      this.mcb_V = null;
      this.mcb_I = null;
      this.mcb_sw_pos = null;
      this.state_temphum = null;
      this.state_meter = null;
      this.state_mcb = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('th_temperature')) {
        this.th_temperature = initObj.th_temperature
      }
      else {
        this.th_temperature = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('th_humidity')) {
        this.th_humidity = initObj.th_humidity
      }
      else {
        this.th_humidity = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phA_V')) {
        this.meter_phA_V = initObj.meter_phA_V
      }
      else {
        this.meter_phA_V = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phB_V')) {
        this.meter_phB_V = initObj.meter_phB_V
      }
      else {
        this.meter_phB_V = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phC_V')) {
        this.meter_phC_V = initObj.meter_phC_V
      }
      else {
        this.meter_phC_V = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phA_I')) {
        this.meter_phA_I = initObj.meter_phA_I
      }
      else {
        this.meter_phA_I = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phB_I')) {
        this.meter_phB_I = initObj.meter_phB_I
      }
      else {
        this.meter_phB_I = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phC_I')) {
        this.meter_phC_I = initObj.meter_phC_I
      }
      else {
        this.meter_phC_I = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_tot_W')) {
        this.meter_tot_W = initObj.meter_tot_W
      }
      else {
        this.meter_tot_W = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phA_W')) {
        this.meter_phA_W = initObj.meter_phA_W
      }
      else {
        this.meter_phA_W = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phB_W')) {
        this.meter_phB_W = initObj.meter_phB_W
      }
      else {
        this.meter_phB_W = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('meter_phC_W')) {
        this.meter_phC_W = initObj.meter_phC_W
      }
      else {
        this.meter_phC_W = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('mcb_V')) {
        this.mcb_V = initObj.mcb_V
      }
      else {
        this.mcb_V = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('mcb_I')) {
        this.mcb_I = initObj.mcb_I
      }
      else {
        this.mcb_I = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('mcb_sw_pos')) {
        this.mcb_sw_pos = initObj.mcb_sw_pos
      }
      else {
        this.mcb_sw_pos = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('state_temphum')) {
        this.state_temphum = initObj.state_temphum
      }
      else {
        this.state_temphum = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('state_meter')) {
        this.state_meter = initObj.state_meter
      }
      else {
        this.state_meter = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('state_mcb')) {
        this.state_mcb = initObj.state_mcb
      }
      else {
        this.state_mcb = new Array(2).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ps_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Check that the constant length array field [th_temperature] has the right length
    if (obj.th_temperature.length !== 2) {
      throw new Error('Unable to serialize array field th_temperature - length must be 2')
    }
    // Serialize message field [th_temperature]
    bufferOffset = _arraySerializer.float64(obj.th_temperature, buffer, bufferOffset, 2);
    // Check that the constant length array field [th_humidity] has the right length
    if (obj.th_humidity.length !== 2) {
      throw new Error('Unable to serialize array field th_humidity - length must be 2')
    }
    // Serialize message field [th_humidity]
    bufferOffset = _arraySerializer.float64(obj.th_humidity, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phA_V] has the right length
    if (obj.meter_phA_V.length !== 2) {
      throw new Error('Unable to serialize array field meter_phA_V - length must be 2')
    }
    // Serialize message field [meter_phA_V]
    bufferOffset = _arraySerializer.float64(obj.meter_phA_V, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phB_V] has the right length
    if (obj.meter_phB_V.length !== 2) {
      throw new Error('Unable to serialize array field meter_phB_V - length must be 2')
    }
    // Serialize message field [meter_phB_V]
    bufferOffset = _arraySerializer.float64(obj.meter_phB_V, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phC_V] has the right length
    if (obj.meter_phC_V.length !== 2) {
      throw new Error('Unable to serialize array field meter_phC_V - length must be 2')
    }
    // Serialize message field [meter_phC_V]
    bufferOffset = _arraySerializer.float64(obj.meter_phC_V, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phA_I] has the right length
    if (obj.meter_phA_I.length !== 2) {
      throw new Error('Unable to serialize array field meter_phA_I - length must be 2')
    }
    // Serialize message field [meter_phA_I]
    bufferOffset = _arraySerializer.float64(obj.meter_phA_I, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phB_I] has the right length
    if (obj.meter_phB_I.length !== 2) {
      throw new Error('Unable to serialize array field meter_phB_I - length must be 2')
    }
    // Serialize message field [meter_phB_I]
    bufferOffset = _arraySerializer.float64(obj.meter_phB_I, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phC_I] has the right length
    if (obj.meter_phC_I.length !== 2) {
      throw new Error('Unable to serialize array field meter_phC_I - length must be 2')
    }
    // Serialize message field [meter_phC_I]
    bufferOffset = _arraySerializer.float64(obj.meter_phC_I, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_tot_W] has the right length
    if (obj.meter_tot_W.length !== 2) {
      throw new Error('Unable to serialize array field meter_tot_W - length must be 2')
    }
    // Serialize message field [meter_tot_W]
    bufferOffset = _arraySerializer.float64(obj.meter_tot_W, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phA_W] has the right length
    if (obj.meter_phA_W.length !== 2) {
      throw new Error('Unable to serialize array field meter_phA_W - length must be 2')
    }
    // Serialize message field [meter_phA_W]
    bufferOffset = _arraySerializer.float64(obj.meter_phA_W, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phB_W] has the right length
    if (obj.meter_phB_W.length !== 2) {
      throw new Error('Unable to serialize array field meter_phB_W - length must be 2')
    }
    // Serialize message field [meter_phB_W]
    bufferOffset = _arraySerializer.float64(obj.meter_phB_W, buffer, bufferOffset, 2);
    // Check that the constant length array field [meter_phC_W] has the right length
    if (obj.meter_phC_W.length !== 2) {
      throw new Error('Unable to serialize array field meter_phC_W - length must be 2')
    }
    // Serialize message field [meter_phC_W]
    bufferOffset = _arraySerializer.float64(obj.meter_phC_W, buffer, bufferOffset, 2);
    // Check that the constant length array field [mcb_V] has the right length
    if (obj.mcb_V.length !== 2) {
      throw new Error('Unable to serialize array field mcb_V - length must be 2')
    }
    // Serialize message field [mcb_V]
    bufferOffset = _arraySerializer.float64(obj.mcb_V, buffer, bufferOffset, 2);
    // Check that the constant length array field [mcb_I] has the right length
    if (obj.mcb_I.length !== 2) {
      throw new Error('Unable to serialize array field mcb_I - length must be 2')
    }
    // Serialize message field [mcb_I]
    bufferOffset = _arraySerializer.float64(obj.mcb_I, buffer, bufferOffset, 2);
    // Check that the constant length array field [mcb_sw_pos] has the right length
    if (obj.mcb_sw_pos.length !== 2) {
      throw new Error('Unable to serialize array field mcb_sw_pos - length must be 2')
    }
    // Serialize message field [mcb_sw_pos]
    bufferOffset = _arraySerializer.int64(obj.mcb_sw_pos, buffer, bufferOffset, 2);
    // Check that the constant length array field [state_temphum] has the right length
    if (obj.state_temphum.length !== 2) {
      throw new Error('Unable to serialize array field state_temphum - length must be 2')
    }
    // Serialize message field [state_temphum]
    bufferOffset = _arraySerializer.int64(obj.state_temphum, buffer, bufferOffset, 2);
    // Check that the constant length array field [state_meter] has the right length
    if (obj.state_meter.length !== 2) {
      throw new Error('Unable to serialize array field state_meter - length must be 2')
    }
    // Serialize message field [state_meter]
    bufferOffset = _arraySerializer.int64(obj.state_meter, buffer, bufferOffset, 2);
    // Check that the constant length array field [state_mcb] has the right length
    if (obj.state_mcb.length !== 2) {
      throw new Error('Unable to serialize array field state_mcb - length must be 2')
    }
    // Serialize message field [state_mcb]
    bufferOffset = _arraySerializer.int64(obj.state_mcb, buffer, bufferOffset, 2);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ps_state_Type
    let len;
    let data = new ps_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [th_temperature]
    data.th_temperature = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [th_humidity]
    data.th_humidity = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phA_V]
    data.meter_phA_V = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phB_V]
    data.meter_phB_V = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phC_V]
    data.meter_phC_V = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phA_I]
    data.meter_phA_I = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phB_I]
    data.meter_phB_I = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phC_I]
    data.meter_phC_I = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_tot_W]
    data.meter_tot_W = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phA_W]
    data.meter_phA_W = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phB_W]
    data.meter_phB_W = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [meter_phC_W]
    data.meter_phC_W = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [mcb_V]
    data.mcb_V = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [mcb_I]
    data.mcb_I = _arrayDeserializer.float64(buffer, bufferOffset, 2)
    // Deserialize message field [mcb_sw_pos]
    data.mcb_sw_pos = _arrayDeserializer.int64(buffer, bufferOffset, 2)
    // Deserialize message field [state_temphum]
    data.state_temphum = _arrayDeserializer.int64(buffer, bufferOffset, 2)
    // Deserialize message field [state_meter]
    data.state_meter = _arrayDeserializer.int64(buffer, bufferOffset, 2)
    // Deserialize message field [state_mcb]
    data.state_mcb = _arrayDeserializer.int64(buffer, bufferOffset, 2)
    return data;
  }

  static getMessageSize(object) {
    return 296;
  }

  static datatype() {
    // Returns string type for a message object
    return 'power_system/ps_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e128e49adf15f8c39cb073cd0ec61c2e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ps_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.th_temperature !== undefined) {
      resolved.th_temperature = msg.th_temperature;
    }
    else {
      resolved.th_temperature = new Array(2).fill(0)
    }

    if (msg.th_humidity !== undefined) {
      resolved.th_humidity = msg.th_humidity;
    }
    else {
      resolved.th_humidity = new Array(2).fill(0)
    }

    if (msg.meter_phA_V !== undefined) {
      resolved.meter_phA_V = msg.meter_phA_V;
    }
    else {
      resolved.meter_phA_V = new Array(2).fill(0)
    }

    if (msg.meter_phB_V !== undefined) {
      resolved.meter_phB_V = msg.meter_phB_V;
    }
    else {
      resolved.meter_phB_V = new Array(2).fill(0)
    }

    if (msg.meter_phC_V !== undefined) {
      resolved.meter_phC_V = msg.meter_phC_V;
    }
    else {
      resolved.meter_phC_V = new Array(2).fill(0)
    }

    if (msg.meter_phA_I !== undefined) {
      resolved.meter_phA_I = msg.meter_phA_I;
    }
    else {
      resolved.meter_phA_I = new Array(2).fill(0)
    }

    if (msg.meter_phB_I !== undefined) {
      resolved.meter_phB_I = msg.meter_phB_I;
    }
    else {
      resolved.meter_phB_I = new Array(2).fill(0)
    }

    if (msg.meter_phC_I !== undefined) {
      resolved.meter_phC_I = msg.meter_phC_I;
    }
    else {
      resolved.meter_phC_I = new Array(2).fill(0)
    }

    if (msg.meter_tot_W !== undefined) {
      resolved.meter_tot_W = msg.meter_tot_W;
    }
    else {
      resolved.meter_tot_W = new Array(2).fill(0)
    }

    if (msg.meter_phA_W !== undefined) {
      resolved.meter_phA_W = msg.meter_phA_W;
    }
    else {
      resolved.meter_phA_W = new Array(2).fill(0)
    }

    if (msg.meter_phB_W !== undefined) {
      resolved.meter_phB_W = msg.meter_phB_W;
    }
    else {
      resolved.meter_phB_W = new Array(2).fill(0)
    }

    if (msg.meter_phC_W !== undefined) {
      resolved.meter_phC_W = msg.meter_phC_W;
    }
    else {
      resolved.meter_phC_W = new Array(2).fill(0)
    }

    if (msg.mcb_V !== undefined) {
      resolved.mcb_V = msg.mcb_V;
    }
    else {
      resolved.mcb_V = new Array(2).fill(0)
    }

    if (msg.mcb_I !== undefined) {
      resolved.mcb_I = msg.mcb_I;
    }
    else {
      resolved.mcb_I = new Array(2).fill(0)
    }

    if (msg.mcb_sw_pos !== undefined) {
      resolved.mcb_sw_pos = msg.mcb_sw_pos;
    }
    else {
      resolved.mcb_sw_pos = new Array(2).fill(0)
    }

    if (msg.state_temphum !== undefined) {
      resolved.state_temphum = msg.state_temphum;
    }
    else {
      resolved.state_temphum = new Array(2).fill(0)
    }

    if (msg.state_meter !== undefined) {
      resolved.state_meter = msg.state_meter;
    }
    else {
      resolved.state_meter = new Array(2).fill(0)
    }

    if (msg.state_mcb !== undefined) {
      resolved.state_mcb = msg.state_mcb;
    }
    else {
      resolved.state_mcb = new Array(2).fill(0)
    }

    return resolved;
    }
};

module.exports = ps_state_Type;
