// Auto-generated. Do not edit!

// (in-package kuka_robot.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let kr_pose_Type = require('../msg/kr_pose_Type.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class kr_mv_bypose_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pose = null;
    }
    else {
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new kr_pose_Type();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_mv_bypose_ArgsRequest
    // Serialize message field [pose]
    bufferOffset = kr_pose_Type.serialize(obj.pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_mv_bypose_ArgsRequest
    let len;
    let data = new kr_mv_bypose_ArgsRequest(null);
    // Deserialize message field [pose]
    data.pose = kr_pose_Type.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 64;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_mv_bypose_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7bf6e731aff03d837f23d1de7dce5c0f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    kr_pose_Type pose
    
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
    const resolved = new kr_mv_bypose_ArgsRequest(null);
    if (msg.pose !== undefined) {
      resolved.pose = kr_pose_Type.Resolve(msg.pose)
    }
    else {
      resolved.pose = new kr_pose_Type()
    }

    return resolved;
    }
};

class kr_mv_bypose_ArgsResponse {
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
    // Serializes a message object of type kr_mv_bypose_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_mv_bypose_ArgsResponse
    let len;
    let data = new kr_mv_bypose_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_mv_bypose_ArgsResponse';
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
    const resolved = new kr_mv_bypose_ArgsResponse(null);
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
  Request: kr_mv_bypose_ArgsRequest,
  Response: kr_mv_bypose_ArgsResponse,
  md5sum() { return '8c20ec7ca823ece0c21366ed77a91e58'; },
  datatype() { return 'kuka_robot/kr_mv_bypose_Args'; }
};
