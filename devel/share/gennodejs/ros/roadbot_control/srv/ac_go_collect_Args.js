// Auto-generated. Do not edit!

// (in-package roadbot_control.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ac_go_collect_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.number_of_cones = null;
      this.mode = null;
    }
    else {
      if (initObj.hasOwnProperty('number_of_cones')) {
        this.number_of_cones = initObj.number_of_cones
      }
      else {
        this.number_of_cones = 0;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ac_go_collect_ArgsRequest
    // Serialize message field [number_of_cones]
    bufferOffset = _serializer.int64(obj.number_of_cones, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.int64(obj.mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_go_collect_ArgsRequest
    let len;
    let data = new ac_go_collect_ArgsRequest(null);
    // Deserialize message field [number_of_cones]
    data.number_of_cones = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'roadbot_control/ac_go_collect_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '70673fa31e53dfa187c90f953409dc66';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 number_of_cones
    int64 mode
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ac_go_collect_ArgsRequest(null);
    if (msg.number_of_cones !== undefined) {
      resolved.number_of_cones = msg.number_of_cones;
    }
    else {
      resolved.number_of_cones = 0
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    return resolved;
    }
};

class ac_go_collect_ArgsResponse {
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
    // Serializes a message object of type ac_go_collect_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_go_collect_ArgsResponse
    let len;
    let data = new ac_go_collect_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'roadbot_control/ac_go_collect_ArgsResponse';
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
    const resolved = new ac_go_collect_ArgsResponse(null);
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
  Request: ac_go_collect_ArgsRequest,
  Response: ac_go_collect_ArgsResponse,
  md5sum() { return '21a374c41adc123047cf3f40397fcf04'; },
  datatype() { return 'roadbot_control/ac_go_collect_Args'; }
};
