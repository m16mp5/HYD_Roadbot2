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

class kr_setdo_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mask = null;
      this.value = null;
      this.settle_sec = null;
    }
    else {
      if (initObj.hasOwnProperty('mask')) {
        this.mask = initObj.mask
      }
      else {
        this.mask = 0;
      }
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = 0;
      }
      if (initObj.hasOwnProperty('settle_sec')) {
        this.settle_sec = initObj.settle_sec
      }
      else {
        this.settle_sec = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_setdo_ArgsRequest
    // Serialize message field [mask]
    bufferOffset = _serializer.int64(obj.mask, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.int64(obj.value, buffer, bufferOffset);
    // Serialize message field [settle_sec]
    bufferOffset = _serializer.float64(obj.settle_sec, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_setdo_ArgsRequest
    let len;
    let data = new kr_setdo_ArgsRequest(null);
    // Deserialize message field [mask]
    data.mask = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [settle_sec]
    data.settle_sec = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_setdo_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c3ddd3317421f075ba386d86f343289a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 mask
    
    int64 value
    
    float64 settle_sec
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_setdo_ArgsRequest(null);
    if (msg.mask !== undefined) {
      resolved.mask = msg.mask;
    }
    else {
      resolved.mask = 0
    }

    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = 0
    }

    if (msg.settle_sec !== undefined) {
      resolved.settle_sec = msg.settle_sec;
    }
    else {
      resolved.settle_sec = 0.0
    }

    return resolved;
    }
};

class kr_setdo_ArgsResponse {
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
    // Serializes a message object of type kr_setdo_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_setdo_ArgsResponse
    let len;
    let data = new kr_setdo_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_setdo_ArgsResponse';
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
    const resolved = new kr_setdo_ArgsResponse(null);
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
  Request: kr_setdo_ArgsRequest,
  Response: kr_setdo_ArgsResponse,
  md5sum() { return '8961b48420bcf8a003b4c64079fcb6f6'; },
  datatype() { return 'kuka_robot/kr_setdo_Args'; }
};
