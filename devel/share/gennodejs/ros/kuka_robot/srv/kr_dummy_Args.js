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

class kr_dummy_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.dummy = null;
    }
    else {
      if (initObj.hasOwnProperty('dummy')) {
        this.dummy = initObj.dummy
      }
      else {
        this.dummy = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_dummy_ArgsRequest
    // Serialize message field [dummy]
    bufferOffset = _serializer.int64(obj.dummy, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_dummy_ArgsRequest
    let len;
    let data = new kr_dummy_ArgsRequest(null);
    // Deserialize message field [dummy]
    data.dummy = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_dummy_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3a62b28fdf54afb8d2ce8b90d7336086';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 dummy
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_dummy_ArgsRequest(null);
    if (msg.dummy !== undefined) {
      resolved.dummy = msg.dummy;
    }
    else {
      resolved.dummy = 0
    }

    return resolved;
    }
};

class kr_dummy_ArgsResponse {
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
    // Serializes a message object of type kr_dummy_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_dummy_ArgsResponse
    let len;
    let data = new kr_dummy_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_dummy_ArgsResponse';
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
    const resolved = new kr_dummy_ArgsResponse(null);
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
  Request: kr_dummy_ArgsRequest,
  Response: kr_dummy_ArgsResponse,
  md5sum() { return '33736ff8569e3bd56de924f3e76e8121'; },
  datatype() { return 'kuka_robot/kr_dummy_Args'; }
};
