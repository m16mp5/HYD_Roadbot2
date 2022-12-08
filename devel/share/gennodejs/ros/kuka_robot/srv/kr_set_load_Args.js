// Auto-generated. Do not edit!

// (in-package kuka_robot.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let kr_payload_Type = require('../msg/kr_payload_Type.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class kr_set_load_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.load = null;
      this.load_a1 = null;
      this.load_a2 = null;
      this.load_a3 = null;
    }
    else {
      if (initObj.hasOwnProperty('load')) {
        this.load = initObj.load
      }
      else {
        this.load = new kr_payload_Type();
      }
      if (initObj.hasOwnProperty('load_a1')) {
        this.load_a1 = initObj.load_a1
      }
      else {
        this.load_a1 = new kr_payload_Type();
      }
      if (initObj.hasOwnProperty('load_a2')) {
        this.load_a2 = initObj.load_a2
      }
      else {
        this.load_a2 = new kr_payload_Type();
      }
      if (initObj.hasOwnProperty('load_a3')) {
        this.load_a3 = initObj.load_a3
      }
      else {
        this.load_a3 = new kr_payload_Type();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_set_load_ArgsRequest
    // Serialize message field [load]
    bufferOffset = kr_payload_Type.serialize(obj.load, buffer, bufferOffset);
    // Serialize message field [load_a1]
    bufferOffset = kr_payload_Type.serialize(obj.load_a1, buffer, bufferOffset);
    // Serialize message field [load_a2]
    bufferOffset = kr_payload_Type.serialize(obj.load_a2, buffer, bufferOffset);
    // Serialize message field [load_a3]
    bufferOffset = kr_payload_Type.serialize(obj.load_a3, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_set_load_ArgsRequest
    let len;
    let data = new kr_set_load_ArgsRequest(null);
    // Deserialize message field [load]
    data.load = kr_payload_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [load_a1]
    data.load_a1 = kr_payload_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [load_a2]
    data.load_a2 = kr_payload_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [load_a3]
    data.load_a3 = kr_payload_Type.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 544;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_set_load_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9b0c62385da61d849c73f59805952adf';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_set_load_ArgsRequest(null);
    if (msg.load !== undefined) {
      resolved.load = kr_payload_Type.Resolve(msg.load)
    }
    else {
      resolved.load = new kr_payload_Type()
    }

    if (msg.load_a1 !== undefined) {
      resolved.load_a1 = kr_payload_Type.Resolve(msg.load_a1)
    }
    else {
      resolved.load_a1 = new kr_payload_Type()
    }

    if (msg.load_a2 !== undefined) {
      resolved.load_a2 = kr_payload_Type.Resolve(msg.load_a2)
    }
    else {
      resolved.load_a2 = new kr_payload_Type()
    }

    if (msg.load_a3 !== undefined) {
      resolved.load_a3 = kr_payload_Type.Resolve(msg.load_a3)
    }
    else {
      resolved.load_a3 = new kr_payload_Type()
    }

    return resolved;
    }
};

class kr_set_load_ArgsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.response = null;
    }
    else {
      if (initObj.hasOwnProperty('response')) {
        this.response = initObj.response
      }
      else {
        this.response = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_set_load_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_set_load_ArgsResponse
    let len;
    let data = new kr_set_load_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_set_load_ArgsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4bf37bc717f68787645077428bea3751';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 response
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_set_load_ArgsResponse(null);
    if (msg.response !== undefined) {
      resolved.response = msg.response;
    }
    else {
      resolved.response = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: kr_set_load_ArgsRequest,
  Response: kr_set_load_ArgsResponse,
  md5sum() { return '621c48a444ec50a2e8cd24b61ee09b4c'; },
  datatype() { return 'kuka_robot/kr_set_load_Args'; }
};
