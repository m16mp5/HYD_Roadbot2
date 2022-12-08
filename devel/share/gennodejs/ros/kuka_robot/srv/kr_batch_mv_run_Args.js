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

class kr_batch_mv_run_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.start_block = null;
      this.end_block = null;
    }
    else {
      if (initObj.hasOwnProperty('start_block')) {
        this.start_block = initObj.start_block
      }
      else {
        this.start_block = 0;
      }
      if (initObj.hasOwnProperty('end_block')) {
        this.end_block = initObj.end_block
      }
      else {
        this.end_block = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_batch_mv_run_ArgsRequest
    // Serialize message field [start_block]
    bufferOffset = _serializer.int64(obj.start_block, buffer, bufferOffset);
    // Serialize message field [end_block]
    bufferOffset = _serializer.int64(obj.end_block, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_batch_mv_run_ArgsRequest
    let len;
    let data = new kr_batch_mv_run_ArgsRequest(null);
    // Deserialize message field [start_block]
    data.start_block = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [end_block]
    data.end_block = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_batch_mv_run_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b6d269f526c3fea92a58d97e181df9e8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 start_block
    
    int64 end_block
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_batch_mv_run_ArgsRequest(null);
    if (msg.start_block !== undefined) {
      resolved.start_block = msg.start_block;
    }
    else {
      resolved.start_block = 0
    }

    if (msg.end_block !== undefined) {
      resolved.end_block = msg.end_block;
    }
    else {
      resolved.end_block = 0
    }

    return resolved;
    }
};

class kr_batch_mv_run_ArgsResponse {
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
    // Serializes a message object of type kr_batch_mv_run_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_batch_mv_run_ArgsResponse
    let len;
    let data = new kr_batch_mv_run_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_batch_mv_run_ArgsResponse';
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
    const resolved = new kr_batch_mv_run_ArgsResponse(null);
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
  Request: kr_batch_mv_run_ArgsRequest,
  Response: kr_batch_mv_run_ArgsResponse,
  md5sum() { return 'abfd39835045227435d9bb38a4de4de2'; },
  datatype() { return 'kuka_robot/kr_batch_mv_run_Args'; }
};
