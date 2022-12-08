// Auto-generated. Do not edit!

// (in-package lidar_tracker.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class lt_datapoint_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Dist = null;
      this.Angle = null;
      this.x = null;
      this.y = null;
      this.intensity = null;
    }
    else {
      if (initObj.hasOwnProperty('Dist')) {
        this.Dist = initObj.Dist
      }
      else {
        this.Dist = 0.0;
      }
      if (initObj.hasOwnProperty('Angle')) {
        this.Angle = initObj.Angle
      }
      else {
        this.Angle = 0.0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0.0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0.0;
      }
      if (initObj.hasOwnProperty('intensity')) {
        this.intensity = initObj.intensity
      }
      else {
        this.intensity = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lt_datapoint_Type
    // Serialize message field [Dist]
    bufferOffset = _serializer.float64(obj.Dist, buffer, bufferOffset);
    // Serialize message field [Angle]
    bufferOffset = _serializer.float64(obj.Angle, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float64(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float64(obj.y, buffer, bufferOffset);
    // Serialize message field [intensity]
    bufferOffset = _serializer.float64(obj.intensity, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lt_datapoint_Type
    let len;
    let data = new lt_datapoint_Type(null);
    // Deserialize message field [Dist]
    data.Dist = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Angle]
    data.Angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [intensity]
    data.intensity = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'lidar_tracker/lt_datapoint_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '856cbb998fe9c851ccd38f03abcbca6e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # XY coordinate [m]
    float64  Dist
    float64  Angle
    float64  x
    float64  y
    # RSSI [0~255]
    float64  intensity
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new lt_datapoint_Type(null);
    if (msg.Dist !== undefined) {
      resolved.Dist = msg.Dist;
    }
    else {
      resolved.Dist = 0.0
    }

    if (msg.Angle !== undefined) {
      resolved.Angle = msg.Angle;
    }
    else {
      resolved.Angle = 0.0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0.0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0.0
    }

    if (msg.intensity !== undefined) {
      resolved.intensity = msg.intensity;
    }
    else {
      resolved.intensity = 0.0
    }

    return resolved;
    }
};

module.exports = lt_datapoint_Type;
