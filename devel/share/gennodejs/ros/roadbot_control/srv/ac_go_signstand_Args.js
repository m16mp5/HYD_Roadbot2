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

class ac_go_signstand_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.position_y = null;
      this.position_x = null;
      this.lb_location = null;
    }
    else {
      if (initObj.hasOwnProperty('position_y')) {
        this.position_y = initObj.position_y
      }
      else {
        this.position_y = 0.0;
      }
      if (initObj.hasOwnProperty('position_x')) {
        this.position_x = initObj.position_x
      }
      else {
        this.position_x = 0.0;
      }
      if (initObj.hasOwnProperty('lb_location')) {
        this.lb_location = initObj.lb_location
      }
      else {
        this.lb_location = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ac_go_signstand_ArgsRequest
    // Serialize message field [position_y]
    bufferOffset = _serializer.float64(obj.position_y, buffer, bufferOffset);
    // Serialize message field [position_x]
    bufferOffset = _serializer.float64(obj.position_x, buffer, bufferOffset);
    // Serialize message field [lb_location]
    bufferOffset = _serializer.int64(obj.lb_location, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_go_signstand_ArgsRequest
    let len;
    let data = new ac_go_signstand_ArgsRequest(null);
    // Deserialize message field [position_y]
    data.position_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [position_x]
    data.position_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [lb_location]
    data.lb_location = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a service object
    return 'roadbot_control/ac_go_signstand_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '738f20e8f6ccbabd4b9be9a38350a552';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    float64 position_y
    float64 position_x
    
    
    int64 lb_location
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ac_go_signstand_ArgsRequest(null);
    if (msg.position_y !== undefined) {
      resolved.position_y = msg.position_y;
    }
    else {
      resolved.position_y = 0.0
    }

    if (msg.position_x !== undefined) {
      resolved.position_x = msg.position_x;
    }
    else {
      resolved.position_x = 0.0
    }

    if (msg.lb_location !== undefined) {
      resolved.lb_location = msg.lb_location;
    }
    else {
      resolved.lb_location = 0
    }

    return resolved;
    }
};

class ac_go_signstand_ArgsResponse {
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
    // Serializes a message object of type ac_go_signstand_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_go_signstand_ArgsResponse
    let len;
    let data = new ac_go_signstand_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'roadbot_control/ac_go_signstand_ArgsResponse';
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
    const resolved = new ac_go_signstand_ArgsResponse(null);
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
  Request: ac_go_signstand_ArgsRequest,
  Response: ac_go_signstand_ArgsResponse,
  md5sum() { return 'caec67dc8933c4357cb62028f1056dfe'; },
  datatype() { return 'roadbot_control/ac_go_signstand_Args'; }
};
