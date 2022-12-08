// Auto-generated. Do not edit!

// (in-package power_system.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ps_set_double_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.num = null;
    }
    else {
      if (initObj.hasOwnProperty('num')) {
        this.num = initObj.num
      }
      else {
        this.num = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ps_set_double_ArgsRequest
    // Serialize message field [num]
    bufferOffset = _serializer.float64(obj.num, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ps_set_double_ArgsRequest
    let len;
    let data = new ps_set_double_ArgsRequest(null);
    // Deserialize message field [num]
    data.num = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'power_system/ps_set_double_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f942a3e0cbd340847b2a0e5b31a783fe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    float64 num
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ps_set_double_ArgsRequest(null);
    if (msg.num !== undefined) {
      resolved.num = msg.num;
    }
    else {
      resolved.num = 0.0
    }

    return resolved;
    }
};

class ps_set_double_ArgsResponse {
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
    // Serializes a message object of type ps_set_double_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ps_set_double_ArgsResponse
    let len;
    let data = new ps_set_double_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'power_system/ps_set_double_ArgsResponse';
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
    const resolved = new ps_set_double_ArgsResponse(null);
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
  Request: ps_set_double_ArgsRequest,
  Response: ps_set_double_ArgsResponse,
  md5sum() { return '1320d4a929ea6ef2a246c2b190a9f356'; },
  datatype() { return 'power_system/ps_set_double_Args'; }
};
