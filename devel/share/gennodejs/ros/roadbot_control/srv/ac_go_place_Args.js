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

class ac_go_place_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.number_of_cones = null;
      this.lantern_pattern = null;
      this.cone_spacing = null;
      this.start_position_y = null;
      this.start_position_x = null;
      this.end_position_y = null;
      this.end_position_x = null;
      this.mode = null;
    }
    else {
      if (initObj.hasOwnProperty('number_of_cones')) {
        this.number_of_cones = initObj.number_of_cones
      }
      else {
        this.number_of_cones = [];
      }
      if (initObj.hasOwnProperty('lantern_pattern')) {
        this.lantern_pattern = initObj.lantern_pattern
      }
      else {
        this.lantern_pattern = [];
      }
      if (initObj.hasOwnProperty('cone_spacing')) {
        this.cone_spacing = initObj.cone_spacing
      }
      else {
        this.cone_spacing = [];
      }
      if (initObj.hasOwnProperty('start_position_y')) {
        this.start_position_y = initObj.start_position_y
      }
      else {
        this.start_position_y = [];
      }
      if (initObj.hasOwnProperty('start_position_x')) {
        this.start_position_x = initObj.start_position_x
      }
      else {
        this.start_position_x = [];
      }
      if (initObj.hasOwnProperty('end_position_y')) {
        this.end_position_y = initObj.end_position_y
      }
      else {
        this.end_position_y = [];
      }
      if (initObj.hasOwnProperty('end_position_x')) {
        this.end_position_x = initObj.end_position_x
      }
      else {
        this.end_position_x = [];
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
    // Serializes a message object of type ac_go_place_ArgsRequest
    // Serialize message field [number_of_cones]
    bufferOffset = _arraySerializer.int64(obj.number_of_cones, buffer, bufferOffset, null);
    // Serialize message field [lantern_pattern]
    bufferOffset = _arraySerializer.int64(obj.lantern_pattern, buffer, bufferOffset, null);
    // Serialize message field [cone_spacing]
    bufferOffset = _arraySerializer.float64(obj.cone_spacing, buffer, bufferOffset, null);
    // Serialize message field [start_position_y]
    bufferOffset = _arraySerializer.float64(obj.start_position_y, buffer, bufferOffset, null);
    // Serialize message field [start_position_x]
    bufferOffset = _arraySerializer.float64(obj.start_position_x, buffer, bufferOffset, null);
    // Serialize message field [end_position_y]
    bufferOffset = _arraySerializer.float64(obj.end_position_y, buffer, bufferOffset, null);
    // Serialize message field [end_position_x]
    bufferOffset = _arraySerializer.float64(obj.end_position_x, buffer, bufferOffset, null);
    // Serialize message field [mode]
    bufferOffset = _serializer.int64(obj.mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_go_place_ArgsRequest
    let len;
    let data = new ac_go_place_ArgsRequest(null);
    // Deserialize message field [number_of_cones]
    data.number_of_cones = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [lantern_pattern]
    data.lantern_pattern = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [cone_spacing]
    data.cone_spacing = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [start_position_y]
    data.start_position_y = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [start_position_x]
    data.start_position_x = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [end_position_y]
    data.end_position_y = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [end_position_x]
    data.end_position_x = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [mode]
    data.mode = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.number_of_cones.length;
    length += 8 * object.lantern_pattern.length;
    length += 8 * object.cone_spacing.length;
    length += 8 * object.start_position_y.length;
    length += 8 * object.start_position_x.length;
    length += 8 * object.end_position_y.length;
    length += 8 * object.end_position_x.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a service object
    return 'roadbot_control/ac_go_place_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bd41a1b223bec6ddc89d6e1da3c9a7c7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64[] number_of_cones
    
    int64[] lantern_pattern
    
    float64[] cone_spacing
    
    float64[] start_position_y
    float64[] start_position_x
    float64[] end_position_y
    float64[] end_position_x
    
    
    int64 mode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ac_go_place_ArgsRequest(null);
    if (msg.number_of_cones !== undefined) {
      resolved.number_of_cones = msg.number_of_cones;
    }
    else {
      resolved.number_of_cones = []
    }

    if (msg.lantern_pattern !== undefined) {
      resolved.lantern_pattern = msg.lantern_pattern;
    }
    else {
      resolved.lantern_pattern = []
    }

    if (msg.cone_spacing !== undefined) {
      resolved.cone_spacing = msg.cone_spacing;
    }
    else {
      resolved.cone_spacing = []
    }

    if (msg.start_position_y !== undefined) {
      resolved.start_position_y = msg.start_position_y;
    }
    else {
      resolved.start_position_y = []
    }

    if (msg.start_position_x !== undefined) {
      resolved.start_position_x = msg.start_position_x;
    }
    else {
      resolved.start_position_x = []
    }

    if (msg.end_position_y !== undefined) {
      resolved.end_position_y = msg.end_position_y;
    }
    else {
      resolved.end_position_y = []
    }

    if (msg.end_position_x !== undefined) {
      resolved.end_position_x = msg.end_position_x;
    }
    else {
      resolved.end_position_x = []
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

class ac_go_place_ArgsResponse {
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
    // Serializes a message object of type ac_go_place_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_go_place_ArgsResponse
    let len;
    let data = new ac_go_place_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'roadbot_control/ac_go_place_ArgsResponse';
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
    const resolved = new ac_go_place_ArgsResponse(null);
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
  Request: ac_go_place_ArgsRequest,
  Response: ac_go_place_ArgsResponse,
  md5sum() { return '39ebae836b3ef946be77dc87891f2639'; },
  datatype() { return 'roadbot_control/ac_go_place_Args'; }
};
