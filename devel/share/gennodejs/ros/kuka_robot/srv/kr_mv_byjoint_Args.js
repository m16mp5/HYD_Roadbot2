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

class kr_mv_byjoint_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joints = null;
    }
    else {
      if (initObj.hasOwnProperty('joints')) {
        this.joints = initObj.joints
      }
      else {
        this.joints = new kr_joint_Type();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_mv_byjoint_ArgsRequest
    // Serialize message field [joints]
    bufferOffset = kr_joint_Type.serialize(obj.joints, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_mv_byjoint_ArgsRequest
    let len;
    let data = new kr_mv_byjoint_ArgsRequest(null);
    // Deserialize message field [joints]
    data.joints = kr_joint_Type.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_mv_byjoint_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7db351d4fc356ec8dca75d8666dbe8dc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    kr_joint_Type joints
    
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
    const resolved = new kr_mv_byjoint_ArgsRequest(null);
    if (msg.joints !== undefined) {
      resolved.joints = kr_joint_Type.Resolve(msg.joints)
    }
    else {
      resolved.joints = new kr_joint_Type()
    }

    return resolved;
    }
};

class kr_mv_byjoint_ArgsResponse {
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
    // Serializes a message object of type kr_mv_byjoint_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_mv_byjoint_ArgsResponse
    let len;
    let data = new kr_mv_byjoint_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_mv_byjoint_ArgsResponse';
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
    const resolved = new kr_mv_byjoint_ArgsResponse(null);
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
  Request: kr_mv_byjoint_ArgsRequest,
  Response: kr_mv_byjoint_ArgsResponse,
  md5sum() { return '1ffacecfaa4c500ecb39aa7cf1b68d2f'; },
  datatype() { return 'kuka_robot/kr_mv_byjoint_Args'; }
};
