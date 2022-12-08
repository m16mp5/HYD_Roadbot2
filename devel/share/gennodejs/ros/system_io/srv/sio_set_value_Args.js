// Auto-generated. Do not edit!

// (in-package system_io.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class sio_set_value_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mask = null;
      this.value = null;
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type sio_set_value_ArgsRequest
    // Serialize message field [mask]
    bufferOffset = _serializer.int64(obj.mask, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.int64(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type sio_set_value_ArgsRequest
    let len;
    let data = new sio_set_value_ArgsRequest(null);
    // Deserialize message field [mask]
    data.mask = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'system_io/sio_set_value_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'efe4a3f733ee9d12e6a99b5b731d228d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 mask
    int64 value
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new sio_set_value_ArgsRequest(null);
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

    return resolved;
    }
};

class sio_set_value_ArgsResponse {
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
    // Serializes a message object of type sio_set_value_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type sio_set_value_ArgsResponse
    let len;
    let data = new sio_set_value_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'system_io/sio_set_value_ArgsResponse';
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
    const resolved = new sio_set_value_ArgsResponse(null);
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
  Request: sio_set_value_ArgsRequest,
  Response: sio_set_value_ArgsResponse,
  md5sum() { return 'ffd2562de9680d6709b20c1fd9d4dc2c'; },
  datatype() { return 'system_io/sio_set_value_Args'; }
};
