// Auto-generated. Do not edit!

// (in-package vision_system.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class vs_send_cali_data_ArgsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.caliD_0 = null;
      this.caliD_1 = null;
      this.caliD_2 = null;
      this.caliD_3 = null;
      this.caliD_4 = null;
      this.caliD_5 = null;
      this.caliD_6 = null;
      this.caliD_7 = null;
      this.Is_HD_check = null;
    }
    else {
      if (initObj.hasOwnProperty('caliD_0')) {
        this.caliD_0 = initObj.caliD_0
      }
      else {
        this.caliD_0 = 0;
      }
      if (initObj.hasOwnProperty('caliD_1')) {
        this.caliD_1 = initObj.caliD_1
      }
      else {
        this.caliD_1 = 0;
      }
      if (initObj.hasOwnProperty('caliD_2')) {
        this.caliD_2 = initObj.caliD_2
      }
      else {
        this.caliD_2 = 0;
      }
      if (initObj.hasOwnProperty('caliD_3')) {
        this.caliD_3 = initObj.caliD_3
      }
      else {
        this.caliD_3 = 0;
      }
      if (initObj.hasOwnProperty('caliD_4')) {
        this.caliD_4 = initObj.caliD_4
      }
      else {
        this.caliD_4 = 0;
      }
      if (initObj.hasOwnProperty('caliD_5')) {
        this.caliD_5 = initObj.caliD_5
      }
      else {
        this.caliD_5 = 0;
      }
      if (initObj.hasOwnProperty('caliD_6')) {
        this.caliD_6 = initObj.caliD_6
      }
      else {
        this.caliD_6 = 0;
      }
      if (initObj.hasOwnProperty('caliD_7')) {
        this.caliD_7 = initObj.caliD_7
      }
      else {
        this.caliD_7 = 0;
      }
      if (initObj.hasOwnProperty('Is_HD_check')) {
        this.Is_HD_check = initObj.Is_HD_check
      }
      else {
        this.Is_HD_check = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type vs_send_cali_data_ArgsRequest
    // Serialize message field [caliD_0]
    bufferOffset = _serializer.int64(obj.caliD_0, buffer, bufferOffset);
    // Serialize message field [caliD_1]
    bufferOffset = _serializer.int64(obj.caliD_1, buffer, bufferOffset);
    // Serialize message field [caliD_2]
    bufferOffset = _serializer.int64(obj.caliD_2, buffer, bufferOffset);
    // Serialize message field [caliD_3]
    bufferOffset = _serializer.int64(obj.caliD_3, buffer, bufferOffset);
    // Serialize message field [caliD_4]
    bufferOffset = _serializer.int64(obj.caliD_4, buffer, bufferOffset);
    // Serialize message field [caliD_5]
    bufferOffset = _serializer.int64(obj.caliD_5, buffer, bufferOffset);
    // Serialize message field [caliD_6]
    bufferOffset = _serializer.int64(obj.caliD_6, buffer, bufferOffset);
    // Serialize message field [caliD_7]
    bufferOffset = _serializer.int64(obj.caliD_7, buffer, bufferOffset);
    // Serialize message field [Is_HD_check]
    bufferOffset = _serializer.bool(obj.Is_HD_check, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type vs_send_cali_data_ArgsRequest
    let len;
    let data = new vs_send_cali_data_ArgsRequest(null);
    // Deserialize message field [caliD_0]
    data.caliD_0 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_1]
    data.caliD_1 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_2]
    data.caliD_2 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_3]
    data.caliD_3 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_4]
    data.caliD_4 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_5]
    data.caliD_5 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_6]
    data.caliD_6 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [caliD_7]
    data.caliD_7 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [Is_HD_check]
    data.Is_HD_check = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 65;
  }

  static datatype() {
    // Returns string type for a service object
    return 'vision_system/vs_send_cali_data_ArgsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '270e49b9f757c4b2764adbe2f5b508e2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 caliD_0
    int64 caliD_1
    int64 caliD_2
    int64 caliD_3
    int64 caliD_4
    int64 caliD_5
    int64 caliD_6
    int64 caliD_7
    bool Is_HD_check
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new vs_send_cali_data_ArgsRequest(null);
    if (msg.caliD_0 !== undefined) {
      resolved.caliD_0 = msg.caliD_0;
    }
    else {
      resolved.caliD_0 = 0
    }

    if (msg.caliD_1 !== undefined) {
      resolved.caliD_1 = msg.caliD_1;
    }
    else {
      resolved.caliD_1 = 0
    }

    if (msg.caliD_2 !== undefined) {
      resolved.caliD_2 = msg.caliD_2;
    }
    else {
      resolved.caliD_2 = 0
    }

    if (msg.caliD_3 !== undefined) {
      resolved.caliD_3 = msg.caliD_3;
    }
    else {
      resolved.caliD_3 = 0
    }

    if (msg.caliD_4 !== undefined) {
      resolved.caliD_4 = msg.caliD_4;
    }
    else {
      resolved.caliD_4 = 0
    }

    if (msg.caliD_5 !== undefined) {
      resolved.caliD_5 = msg.caliD_5;
    }
    else {
      resolved.caliD_5 = 0
    }

    if (msg.caliD_6 !== undefined) {
      resolved.caliD_6 = msg.caliD_6;
    }
    else {
      resolved.caliD_6 = 0
    }

    if (msg.caliD_7 !== undefined) {
      resolved.caliD_7 = msg.caliD_7;
    }
    else {
      resolved.caliD_7 = 0
    }

    if (msg.Is_HD_check !== undefined) {
      resolved.Is_HD_check = msg.Is_HD_check;
    }
    else {
      resolved.Is_HD_check = false
    }

    return resolved;
    }
};

class vs_send_cali_data_ArgsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.response = null;
      this.result_code = null;
    }
    else {
      if (initObj.hasOwnProperty('response')) {
        this.response = initObj.response
      }
      else {
        this.response = 0;
      }
      if (initObj.hasOwnProperty('result_code')) {
        this.result_code = initObj.result_code
      }
      else {
        this.result_code = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type vs_send_cali_data_ArgsResponse
    // Serialize message field [response]
    bufferOffset = _serializer.int64(obj.response, buffer, bufferOffset);
    // Serialize message field [result_code]
    bufferOffset = _serializer.int64(obj.result_code, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type vs_send_cali_data_ArgsResponse
    let len;
    let data = new vs_send_cali_data_ArgsResponse(null);
    // Deserialize message field [response]
    data.response = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [result_code]
    data.result_code = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'vision_system/vs_send_cali_data_ArgsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '639fa62f1f362e30fed370855c664bd5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int64 response
    
    
    int64 result_code
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new vs_send_cali_data_ArgsResponse(null);
    if (msg.response !== undefined) {
      resolved.response = msg.response;
    }
    else {
      resolved.response = 0
    }

    if (msg.result_code !== undefined) {
      resolved.result_code = msg.result_code;
    }
    else {
      resolved.result_code = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: vs_send_cali_data_ArgsRequest,
  Response: vs_send_cali_data_ArgsResponse,
  md5sum() { return 'f30152e5d2a43a58c59d2b40816d1dd0'; },
  datatype() { return 'vision_system/vs_send_cali_data_Args'; }
};
