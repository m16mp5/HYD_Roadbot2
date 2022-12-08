// Auto-generated. Do not edit!

// (in-package kuka_robot.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class kr_set_accvel_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.acc = null;
      this.acc_swivel = null;
      this.acc_rot = null;
      this.vel = null;
      this.vel_swivel = null;
      this.vel_rot = null;
    }
    else {
      if (initObj.hasOwnProperty('acc')) {
        this.acc = initObj.acc
      }
      else {
        this.acc = 0.0;
      }
      if (initObj.hasOwnProperty('acc_swivel')) {
        this.acc_swivel = initObj.acc_swivel
      }
      else {
        this.acc_swivel = 0.0;
      }
      if (initObj.hasOwnProperty('acc_rot')) {
        this.acc_rot = initObj.acc_rot
      }
      else {
        this.acc_rot = 0.0;
      }
      if (initObj.hasOwnProperty('vel')) {
        this.vel = initObj.vel
      }
      else {
        this.vel = 0.0;
      }
      if (initObj.hasOwnProperty('vel_swivel')) {
        this.vel_swivel = initObj.vel_swivel
      }
      else {
        this.vel_swivel = 0.0;
      }
      if (initObj.hasOwnProperty('vel_rot')) {
        this.vel_rot = initObj.vel_rot
      }
      else {
        this.vel_rot = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_set_accvel_ArgsRequest
    // Serialize message field [acc]
    bufferOffset = _serializer.float64(obj.acc, buffer, bufferOffset);
    // Serialize message field [acc_swivel]
    bufferOffset = _serializer.float64(obj.acc_swivel, buffer, bufferOffset);
    // Serialize message field [acc_rot]
    bufferOffset = _serializer.float64(obj.acc_rot, buffer, bufferOffset);
    // Serialize message field [vel]
    bufferOffset = _serializer.float64(obj.vel, buffer, bufferOffset);
    // Serialize message field [vel_swivel]
    bufferOffset = _serializer.float64(obj.vel_swivel, buffer, bufferOffset);
    // Serialize message field [vel_rot]
    bufferOffset = _serializer.float64(obj.vel_rot, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_set_accvel_ArgsRequest
    let len;
    let data = new kr_set_accvel_ArgsRequest(null);
    // Deserialize message field [acc]
    data.acc = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [acc_swivel]
    data.acc_swivel = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [acc_rot]
    data.acc_rot = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [vel]
    data.vel = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [vel_swivel]
    data.vel_swivel = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [vel_rot]
    data.vel_rot = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_set_accvel_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '705361753af8b429ac30c80b343ed051';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    float64 acc
    
    float64 acc_swivel
    
    float64 acc_rot
    
    float64 vel
    
    float64 vel_swivel
    
    float64 vel_rot
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_set_accvel_ArgsRequest(null);
    if (msg.acc !== undefined) {
      resolved.acc = msg.acc;
    }
    else {
      resolved.acc = 0.0
    }

    if (msg.acc_swivel !== undefined) {
      resolved.acc_swivel = msg.acc_swivel;
    }
    else {
      resolved.acc_swivel = 0.0
    }

    if (msg.acc_rot !== undefined) {
      resolved.acc_rot = msg.acc_rot;
    }
    else {
      resolved.acc_rot = 0.0
    }

    if (msg.vel !== undefined) {
      resolved.vel = msg.vel;
    }
    else {
      resolved.vel = 0.0
    }

    if (msg.vel_swivel !== undefined) {
      resolved.vel_swivel = msg.vel_swivel;
    }
    else {
      resolved.vel_swivel = 0.0
    }

    if (msg.vel_rot !== undefined) {
      resolved.vel_rot = msg.vel_rot;
    }
    else {
      resolved.vel_rot = 0.0
    }

    return resolved;
    }
};

class kr_set_accvel_ArgsResponse {
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
    // Serializes a message object of type kr_set_accvel_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_set_accvel_ArgsResponse
    let len;
    let data = new kr_set_accvel_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_set_accvel_ArgsResponse';
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
    const resolved = new kr_set_accvel_ArgsResponse(null);
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
  Request: kr_set_accvel_ArgsRequest,
  Response: kr_set_accvel_ArgsResponse,
  md5sum() { return '8daacbb0ad8522dab063be7060ee20fc'; },
  datatype() { return 'kuka_robot/kr_set_accvel_Args'; }
};
