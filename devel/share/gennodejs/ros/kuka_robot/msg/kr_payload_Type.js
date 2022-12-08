// Auto-generated. Do not edit!

// (in-package kuka_robot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let kr_pose_Type = require('./kr_pose_Type.js');

//-----------------------------------------------------------

class kr_payload_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mass = null;
      this.CenterOfGravity = null;
      this.Inertia = null;
    }
    else {
      if (initObj.hasOwnProperty('mass')) {
        this.mass = initObj.mass
      }
      else {
        this.mass = 0.0;
      }
      if (initObj.hasOwnProperty('CenterOfGravity')) {
        this.CenterOfGravity = initObj.CenterOfGravity
      }
      else {
        this.CenterOfGravity = new kr_pose_Type();
      }
      if (initObj.hasOwnProperty('Inertia')) {
        this.Inertia = initObj.Inertia
      }
      else {
        this.Inertia = new kr_pose_Type();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_payload_Type
    // Serialize message field [mass]
    bufferOffset = _serializer.float64(obj.mass, buffer, bufferOffset);
    // Serialize message field [CenterOfGravity]
    bufferOffset = kr_pose_Type.serialize(obj.CenterOfGravity, buffer, bufferOffset);
    // Serialize message field [Inertia]
    bufferOffset = kr_pose_Type.serialize(obj.Inertia, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_payload_Type
    let len;
    let data = new kr_payload_Type(null);
    // Deserialize message field [mass]
    data.mass = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [CenterOfGravity]
    data.CenterOfGravity = kr_pose_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [Inertia]
    data.Inertia = kr_pose_Type.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 136;
  }

  static datatype() {
    // Returns string type for a message object
    return 'kuka_robot/kr_payload_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'acc9595ae3c243c8e07bdd4ea0d971e4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_payload_Type(null);
    if (msg.mass !== undefined) {
      resolved.mass = msg.mass;
    }
    else {
      resolved.mass = 0.0
    }

    if (msg.CenterOfGravity !== undefined) {
      resolved.CenterOfGravity = kr_pose_Type.Resolve(msg.CenterOfGravity)
    }
    else {
      resolved.CenterOfGravity = new kr_pose_Type()
    }

    if (msg.Inertia !== undefined) {
      resolved.Inertia = kr_pose_Type.Resolve(msg.Inertia)
    }
    else {
      resolved.Inertia = new kr_pose_Type()
    }

    return resolved;
    }
};

module.exports = kr_payload_Type;
