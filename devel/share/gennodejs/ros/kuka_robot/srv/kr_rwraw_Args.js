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

class kr_rwraw_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.value = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_rwraw_ArgsRequest
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.string(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_rwraw_ArgsRequest
    let len;
    let data = new kr_rwraw_ArgsRequest(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    length += object.value.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_rwraw_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bc6ccc4a57f61779c8eaae61e9f422e0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string name
    string value
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_rwraw_ArgsRequest(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = ''
    }

    return resolved;
    }
};

class kr_rwraw_ArgsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.response = null;
      this.serialvalue = null;
    }
    else {
      if (initObj.hasOwnProperty('response')) {
        this.response = initObj.response
      }
      else {
        this.response = 0;
      }
      if (initObj.hasOwnProperty('serialvalue')) {
        this.serialvalue = initObj.serialvalue
      }
      else {
        this.serialvalue = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_rwraw_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    // Serialize message field [serialvalue]
    bufferOffset = _serializer.string(obj.serialvalue, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_rwraw_ArgsResponse
    let len;
    let data = new kr_rwraw_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [serialvalue]
    data.serialvalue = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.serialvalue.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'kuka_robot/kr_rwraw_ArgsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd6a54f58241acce87d227df2668b7e81';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 response
    
    string serialvalue
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_rwraw_ArgsResponse(null);
    if (msg.response !== undefined) {
      resolved.response = msg.response;
    }
    else {
      resolved.response = 0
    }

    if (msg.serialvalue !== undefined) {
      resolved.serialvalue = msg.serialvalue;
    }
    else {
      resolved.serialvalue = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: kr_rwraw_ArgsRequest,
  Response: kr_rwraw_ArgsResponse,
  md5sum() { return '11c5a51efafea631b2d1acda167e91ef'; },
  datatype() { return 'kuka_robot/kr_rwraw_Args'; }
};
