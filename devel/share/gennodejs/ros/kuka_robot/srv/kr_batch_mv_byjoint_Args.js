// Auto-generated. Do not edit!

// (in-package kuka_robot.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let kr_joint_Type = require('../msg/kr_joint_Type.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class kr_batch_mv_byjoint_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joints = null;
      this.round = null;
      this.block = null;
    }
    else {
      if (initObj.hasOwnProperty('joints')) {
        this.joints = initObj.joints
      }
      else {
        this.joints = new kr_joint_Type();
      }
      if (initObj.hasOwnProperty('round')) {
        this.round = initObj.round
      }
      else {
        this.round = 0.0;
      }
      if (initObj.hasOwnProperty('block')) {
        this.block = initObj.block
      }
      else {
        this.block = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_batch_mv_byjoint_ArgsRequest
    // Serialize message field [joints]
    bufferOffset = kr_joint_Type.serialize(obj.joints, buffer, bufferOffset);
    // Serialize message field [round]
    bufferOffset = _serializer.float64(obj.round, buffer, bufferOffset);
    // Serialize message field [block]
    bufferOffset = _serializer.int64(obj.block, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_batch_mv_byjoint_ArgsRequest
    let len;
    let data = new kr_batch_mv_byjoint_ArgsRequest(null);
    // Deserialize message field [joints]
    data.joints = kr_joint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [round]
    data.round = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [block]
    data.block = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 64;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_batch_mv_byjoint_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4c72f42e6339dc5ac71f40e401a90e17';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    kr_joint_Type joints
    
    float64 round
    
    int64 block
    
    ================================================================================
    MSG: kuka_robot/kr_joint_Type
    # Joint Angles [degree]
    float64 A1
    float64 A2
    float64 A3
    float64 A4
    float64 A5
    float64 A6
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_batch_mv_byjoint_ArgsRequest(null);
    if (msg.joints !== undefined) {
      resolved.joints = kr_joint_Type.Resolve(msg.joints)
    }
    else {
      resolved.joints = new kr_joint_Type()
    }

    if (msg.round !== undefined) {
      resolved.round = msg.round;
    }
    else {
      resolved.round = 0.0
    }

    if (msg.block !== undefined) {
      resolved.block = msg.block;
    }
    else {
      resolved.block = 0
    }

    return resolved;
    }
};

class kr_batch_mv_byjoint_ArgsResponse {
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
    // Serializes a message object of type kr_batch_mv_byjoint_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_batch_mv_byjoint_ArgsResponse
    let len;
    let data = new kr_batch_mv_byjoint_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_batch_mv_byjoint_ArgsResponse';
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
    const resolved = new kr_batch_mv_byjoint_ArgsResponse(null);
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
  Request: kr_batch_mv_byjoint_ArgsRequest,
  Response: kr_batch_mv_byjoint_ArgsResponse,
  md5sum() { return '9cf269bbffea0d211457cbe74178bb95'; },
  datatype() { return 'kuka_robot/kr_batch_mv_byjoint_Args'; }
};
