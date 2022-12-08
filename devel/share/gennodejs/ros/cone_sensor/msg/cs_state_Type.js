// Auto-generated. Do not edit!

// (in-package cone_sensor.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class cs_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.weight_slots = null;
      this.state = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('weight_slots')) {
        this.weight_slots = initObj.weight_slots
      }
      else {
        this.weight_slots = new Array(14).fill(0);
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = new Array(14).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type cs_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Check that the constant length array field [weight_slots] has the right length
    if (obj.weight_slots.length !== 14) {
      throw new Error('Unable to serialize array field weight_slots - length must be 14')
    }
    // Serialize message field [weight_slots]
    bufferOffset = _arraySerializer.float64(obj.weight_slots, buffer, bufferOffset, 14);
    // Check that the constant length array field [state] has the right length
    if (obj.state.length !== 14) {
      throw new Error('Unable to serialize array field state - length must be 14')
    }
    // Serialize message field [state]
    bufferOffset = _arraySerializer.int64(obj.state, buffer, bufferOffset, 14);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type cs_state_Type
    let len;
    let data = new cs_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [weight_slots]
    data.weight_slots = _arrayDeserializer.float64(buffer, bufferOffset, 14)
    // Deserialize message field [state]
    data.state = _arrayDeserializer.int64(buffer, bufferOffset, 14)
    return data;
  }

  static getMessageSize(object) {
    return 232;
  }

  static datatype() {
    // Returns string type for a message object
    return 'cone_sensor/cs_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ed4de7dc8dadb6133b9f1ded06e00707';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
    float64 timestamp
    
    # 14 weight sensor readings in [kg]
    float64[14] weight_slots
    
    # 14 sensor error state
    int64[14] state
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new cs_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.weight_slots !== undefined) {
      resolved.weight_slots = msg.weight_slots;
    }
    else {
      resolved.weight_slots = new Array(14).fill(0)
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = new Array(14).fill(0)
    }

    return resolved;
    }
};

module.exports = cs_state_Type;
