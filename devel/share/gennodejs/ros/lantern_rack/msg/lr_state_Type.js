// Auto-generated. Do not edit!

// (in-package lantern_rack.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class lr_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.state = null;
      this.mode = null;
      this.level = null;
      this.sensor_state = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = 0;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = new Array(10).fill(0);
      }
      if (initObj.hasOwnProperty('level')) {
        this.level = initObj.level
      }
      else {
        this.level = new Array(10).fill(0);
      }
      if (initObj.hasOwnProperty('sensor_state')) {
        this.sensor_state = initObj.sensor_state
      }
      else {
        this.sensor_state = new Array(10).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lr_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = _serializer.int64(obj.state, buffer, bufferOffset);
    // Check that the constant length array field [mode] has the right length
    if (obj.mode.length !== 10) {
      throw new Error('Unable to serialize array field mode - length must be 10')
    }
    // Serialize message field [mode]
    bufferOffset = _arraySerializer.int64(obj.mode, buffer, bufferOffset, 10);
    // Check that the constant length array field [level] has the right length
    if (obj.level.length !== 10) {
      throw new Error('Unable to serialize array field level - length must be 10')
    }
    // Serialize message field [level]
    bufferOffset = _arraySerializer.int64(obj.level, buffer, bufferOffset, 10);
    // Check that the constant length array field [sensor_state] has the right length
    if (obj.sensor_state.length !== 10) {
      throw new Error('Unable to serialize array field sensor_state - length must be 10')
    }
    // Serialize message field [sensor_state]
    bufferOffset = _arraySerializer.int64(obj.sensor_state, buffer, bufferOffset, 10);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lr_state_Type
    let len;
    let data = new lr_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _arrayDeserializer.int64(buffer, bufferOffset, 10)
    // Deserialize message field [level]
    data.level = _arrayDeserializer.int64(buffer, bufferOffset, 10)
    // Deserialize message field [sensor_state]
    data.sensor_state = _arrayDeserializer.int64(buffer, bufferOffset, 10)
    return data;
  }

  static getMessageSize(object) {
    return 256;
  }

  static datatype() {
    // Returns string type for a message object
    return 'lantern_rack/lr_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '446242a7e9ff89a4043e4a4889335818';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
    float64 timestamp
    
    # Lantern rack controller state
    int64 state
    
    # Lantern rack stack current working mode state [0-down 1-picking 2-filling 3-in trans]
    int64[10] mode
    
    # 10 Lantern rack stack level position
    int64[10] level
    
    # Lantern Racks sensor status
    int64[10] sensor_state
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new lr_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = 0
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = new Array(10).fill(0)
    }

    if (msg.level !== undefined) {
      resolved.level = msg.level;
    }
    else {
      resolved.level = new Array(10).fill(0)
    }

    if (msg.sensor_state !== undefined) {
      resolved.sensor_state = msg.sensor_state;
    }
    else {
      resolved.sensor_state = new Array(10).fill(0)
    }

    return resolved;
    }
};

module.exports = lr_state_Type;
