// Auto-generated. Do not edit!

// (in-package kuka_robot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class kr_robot_error_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.number = null;
      this.interpreter = null;
      this.int_type = null;
      this.int_prio = null;
      this.line_nr = null;
      this.module = null;
      this.up_name = null;
      this.trigger_type = null;
    }
    else {
      if (initObj.hasOwnProperty('number')) {
        this.number = initObj.number
      }
      else {
        this.number = 0;
      }
      if (initObj.hasOwnProperty('interpreter')) {
        this.interpreter = initObj.interpreter
      }
      else {
        this.interpreter = '';
      }
      if (initObj.hasOwnProperty('int_type')) {
        this.int_type = initObj.int_type
      }
      else {
        this.int_type = '';
      }
      if (initObj.hasOwnProperty('int_prio')) {
        this.int_prio = initObj.int_prio
      }
      else {
        this.int_prio = 0;
      }
      if (initObj.hasOwnProperty('line_nr')) {
        this.line_nr = initObj.line_nr
      }
      else {
        this.line_nr = 0;
      }
      if (initObj.hasOwnProperty('module')) {
        this.module = initObj.module
      }
      else {
        this.module = '';
      }
      if (initObj.hasOwnProperty('up_name')) {
        this.up_name = initObj.up_name
      }
      else {
        this.up_name = '';
      }
      if (initObj.hasOwnProperty('trigger_type')) {
        this.trigger_type = initObj.trigger_type
      }
      else {
        this.trigger_type = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_robot_error_Type
    // Serialize message field [number]
    bufferOffset = _serializer.int64(obj.number, buffer, bufferOffset);
    // Serialize message field [interpreter]
    bufferOffset = _serializer.string(obj.interpreter, buffer, bufferOffset);
    // Serialize message field [int_type]
    bufferOffset = _serializer.string(obj.int_type, buffer, bufferOffset);
    // Serialize message field [int_prio]
    bufferOffset = _serializer.int64(obj.int_prio, buffer, bufferOffset);
    // Serialize message field [line_nr]
    bufferOffset = _serializer.int64(obj.line_nr, buffer, bufferOffset);
    // Serialize message field [module]
    bufferOffset = _serializer.string(obj.module, buffer, bufferOffset);
    // Serialize message field [up_name]
    bufferOffset = _serializer.string(obj.up_name, buffer, bufferOffset);
    // Serialize message field [trigger_type]
    bufferOffset = _serializer.string(obj.trigger_type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_robot_error_Type
    let len;
    let data = new kr_robot_error_Type(null);
    // Deserialize message field [number]
    data.number = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [interpreter]
    data.interpreter = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [int_type]
    data.int_type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [int_prio]
    data.int_prio = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [line_nr]
    data.line_nr = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [module]
    data.module = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [up_name]
    data.up_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [trigger_type]
    data.trigger_type = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.interpreter.length;
    length += object.int_type.length;
    length += object.module.length;
    length += object.up_name.length;
    length += object.trigger_type.length;
    return length + 44;
  }

  static datatype() {
    // Returns string type for a message object
    return 'kuka_robot/kr_robot_error_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '14c7fac1baea6ae7d763b4c80cd47929';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Error number
    int64 number
    
    # R_INT
    string interpreter
    
    # I_NORMAL
    string int_type
    
    # Prio
    int64 int_prio
    
    # Line number
    int64 line_nr
    
    # Module name
    string module
    
    # Up name
    string up_name
    
    # TRG_NONE
    string trigger_type
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new kr_robot_error_Type(null);
    if (msg.number !== undefined) {
      resolved.number = msg.number;
    }
    else {
      resolved.number = 0
    }

    if (msg.interpreter !== undefined) {
      resolved.interpreter = msg.interpreter;
    }
    else {
      resolved.interpreter = ''
    }

    if (msg.int_type !== undefined) {
      resolved.int_type = msg.int_type;
    }
    else {
      resolved.int_type = ''
    }

    if (msg.int_prio !== undefined) {
      resolved.int_prio = msg.int_prio;
    }
    else {
      resolved.int_prio = 0
    }

    if (msg.line_nr !== undefined) {
      resolved.line_nr = msg.line_nr;
    }
    else {
      resolved.line_nr = 0
    }

    if (msg.module !== undefined) {
      resolved.module = msg.module;
    }
    else {
      resolved.module = ''
    }

    if (msg.up_name !== undefined) {
      resolved.up_name = msg.up_name;
    }
    else {
      resolved.up_name = ''
    }

    if (msg.trigger_type !== undefined) {
      resolved.trigger_type = msg.trigger_type;
    }
    else {
      resolved.trigger_type = ''
    }

    return resolved;
    }
};

module.exports = kr_robot_error_Type;
