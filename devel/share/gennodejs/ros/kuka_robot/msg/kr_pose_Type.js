// Auto-generated. Do not edit!

// (in-package kuka_robot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class kr_pose_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.X = null;
      this.Y = null;
      this.Z = null;
      this.A = null;
      this.B = null;
      this.C = null;
      this.S = null;
      this.T = null;
    }
    else {
      if (initObj.hasOwnProperty('X')) {
        this.X = initObj.X
      }
      else {
        this.X = 0.0;
      }
      if (initObj.hasOwnProperty('Y')) {
        this.Y = initObj.Y
      }
      else {
        this.Y = 0.0;
      }
      if (initObj.hasOwnProperty('Z')) {
        this.Z = initObj.Z
      }
      else {
        this.Z = 0.0;
      }
      if (initObj.hasOwnProperty('A')) {
        this.A = initObj.A
      }
      else {
        this.A = 0.0;
      }
      if (initObj.hasOwnProperty('B')) {
        this.B = initObj.B
      }
      else {
        this.B = 0.0;
      }
      if (initObj.hasOwnProperty('C')) {
        this.C = initObj.C
      }
      else {
        this.C = 0.0;
      }
      if (initObj.hasOwnProperty('S')) {
        this.S = initObj.S
      }
      else {
        this.S = 0.0;
      }
      if (initObj.hasOwnProperty('T')) {
        this.T = initObj.T
      }
      else {
        this.T = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_pose_Type
    // Serialize message field [X]
    bufferOffset = _serializer.float64(obj.X, buffer, bufferOffset);
    // Serialize message field [Y]
    bufferOffset = _serializer.float64(obj.Y, buffer, bufferOffset);
    // Serialize message field [Z]
    bufferOffset = _serializer.float64(obj.Z, buffer, bufferOffset);
    // Serialize message field [A]
    bufferOffset = _serializer.float64(obj.A, buffer, bufferOffset);
    // Serialize message field [B]
    bufferOffset = _serializer.float64(obj.B, buffer, bufferOffset);
    // Serialize message field [C]
    bufferOffset = _serializer.float64(obj.C, buffer, bufferOffset);
    // Serialize message field [S]
    bufferOffset = _serializer.float64(obj.S, buffer, bufferOffset);
    // Serialize message field [T]
    bufferOffset = _serializer.float64(obj.T, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_pose_Type
    let len;
    let data = new kr_pose_Type(null);
    // Deserialize message field [X]
    data.X = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Y]
    data.Y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Z]
    data.Z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [A]
    data.A = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [B]
    data.B = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [C]
    data.C = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [S]
    data.S = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [T]
    data.T = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'kuka_robot/kr_pose_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '68763b86dc393f24490d032ede03c3ee';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_pose_Type(null);
    if (msg.X !== undefined) {
      resolved.X = msg.X;
    }
    else {
      resolved.X = 0.0
    }

    if (msg.Y !== undefined) {
      resolved.Y = msg.Y;
    }
    else {
      resolved.Y = 0.0
    }

    if (msg.Z !== undefined) {
      resolved.Z = msg.Z;
    }
    else {
      resolved.Z = 0.0
    }

    if (msg.A !== undefined) {
      resolved.A = msg.A;
    }
    else {
      resolved.A = 0.0
    }

    if (msg.B !== undefined) {
      resolved.B = msg.B;
    }
    else {
      resolved.B = 0.0
    }

    if (msg.C !== undefined) {
      resolved.C = msg.C;
    }
    else {
      resolved.C = 0.0
    }

    if (msg.S !== undefined) {
      resolved.S = msg.S;
    }
    else {
      resolved.S = 0.0
    }

    if (msg.T !== undefined) {
      resolved.T = msg.T;
    }
    else {
      resolved.T = 0.0
    }

    return resolved;
    }
};

module.exports = kr_pose_Type;
