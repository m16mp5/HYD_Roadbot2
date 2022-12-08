// Auto-generated. Do not edit!

// (in-package system_io.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class sio_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.state = null;
      this.input_pin = null;
      this.output_pin = null;
      this.llb_has_cone = null;
      this.rlb_has_cone = null;
      this.rear_slider_down = null;
      this.cone_slider_extend = null;
      this.airpump_on = null;
      this.arrowlight_on = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = 0;
      }
      if (initObj.hasOwnProperty('input_pin')) {
        this.input_pin = initObj.input_pin
      }
      else {
        this.input_pin = new Array(18).fill(0);
      }
      if (initObj.hasOwnProperty('output_pin')) {
        this.output_pin = initObj.output_pin
      }
      else {
        this.output_pin = new Array(18).fill(0);
      }
      if (initObj.hasOwnProperty('llb_has_cone')) {
        this.llb_has_cone = initObj.llb_has_cone
      }
      else {
        this.llb_has_cone = false;
      }
      if (initObj.hasOwnProperty('rlb_has_cone')) {
        this.rlb_has_cone = initObj.rlb_has_cone
      }
      else {
        this.rlb_has_cone = false;
      }
      if (initObj.hasOwnProperty('rear_slider_down')) {
        this.rear_slider_down = initObj.rear_slider_down
      }
      else {
        this.rear_slider_down = false;
      }
      if (initObj.hasOwnProperty('cone_slider_extend')) {
        this.cone_slider_extend = initObj.cone_slider_extend
      }
      else {
        this.cone_slider_extend = false;
      }
      if (initObj.hasOwnProperty('airpump_on')) {
        this.airpump_on = initObj.airpump_on
      }
      else {
        this.airpump_on = false;
      }
      if (initObj.hasOwnProperty('arrowlight_on')) {
        this.arrowlight_on = initObj.arrowlight_on
      }
      else {
        this.arrowlight_on = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type sio_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = _serializer.int64(obj.state, buffer, bufferOffset);
    // Check that the constant length array field [input_pin] has the right length
    if (obj.input_pin.length !== 18) {
      throw new Error('Unable to serialize array field input_pin - length must be 18')
    }
    // Serialize message field [input_pin]
    bufferOffset = _arraySerializer.int64(obj.input_pin, buffer, bufferOffset, 18);
    // Check that the constant length array field [output_pin] has the right length
    if (obj.output_pin.length !== 18) {
      throw new Error('Unable to serialize array field output_pin - length must be 18')
    }
    // Serialize message field [output_pin]
    bufferOffset = _arraySerializer.int64(obj.output_pin, buffer, bufferOffset, 18);
    // Serialize message field [llb_has_cone]
    bufferOffset = _serializer.bool(obj.llb_has_cone, buffer, bufferOffset);
    // Serialize message field [rlb_has_cone]
    bufferOffset = _serializer.bool(obj.rlb_has_cone, buffer, bufferOffset);
    // Serialize message field [rear_slider_down]
    bufferOffset = _serializer.bool(obj.rear_slider_down, buffer, bufferOffset);
    // Serialize message field [cone_slider_extend]
    bufferOffset = _serializer.bool(obj.cone_slider_extend, buffer, bufferOffset);
    // Serialize message field [airpump_on]
    bufferOffset = _serializer.bool(obj.airpump_on, buffer, bufferOffset);
    // Serialize message field [arrowlight_on]
    bufferOffset = _serializer.bool(obj.arrowlight_on, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type sio_state_Type
    let len;
    let data = new sio_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [input_pin]
    data.input_pin = _arrayDeserializer.int64(buffer, bufferOffset, 18)
    // Deserialize message field [output_pin]
    data.output_pin = _arrayDeserializer.int64(buffer, bufferOffset, 18)
    // Deserialize message field [llb_has_cone]
    data.llb_has_cone = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rlb_has_cone]
    data.rlb_has_cone = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rear_slider_down]
    data.rear_slider_down = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [cone_slider_extend]
    data.cone_slider_extend = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [airpump_on]
    data.airpump_on = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [arrowlight_on]
    data.arrowlight_on = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 310;
  }

  static datatype() {
    // Returns string type for a message object
    return 'system_io/sio_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bb6f89f27eead6c5199e33a55449f841';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
    float64 timestamp
    
    # Ethernet IO raw states
    int64 state
    int64[18] input_pin
    int64[18] output_pin
    
    # LB states
    bool llb_has_cone
    bool rlb_has_cone
    
    # slider switch states
    bool rear_slider_down
    bool cone_slider_extend
    
    # air pump switch states
    bool airpump_on
    
    # arrow light switch states
    bool arrowlight_on
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new sio_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = 0
    }

    if (msg.input_pin !== undefined) {
      resolved.input_pin = msg.input_pin;
    }
    else {
      resolved.input_pin = new Array(18).fill(0)
    }

    if (msg.output_pin !== undefined) {
      resolved.output_pin = msg.output_pin;
    }
    else {
      resolved.output_pin = new Array(18).fill(0)
    }

    if (msg.llb_has_cone !== undefined) {
      resolved.llb_has_cone = msg.llb_has_cone;
    }
    else {
      resolved.llb_has_cone = false
    }

    if (msg.rlb_has_cone !== undefined) {
      resolved.rlb_has_cone = msg.rlb_has_cone;
    }
    else {
      resolved.rlb_has_cone = false
    }

    if (msg.rear_slider_down !== undefined) {
      resolved.rear_slider_down = msg.rear_slider_down;
    }
    else {
      resolved.rear_slider_down = false
    }

    if (msg.cone_slider_extend !== undefined) {
      resolved.cone_slider_extend = msg.cone_slider_extend;
    }
    else {
      resolved.cone_slider_extend = false
    }

    if (msg.airpump_on !== undefined) {
      resolved.airpump_on = msg.airpump_on;
    }
    else {
      resolved.airpump_on = false
    }

    if (msg.arrowlight_on !== undefined) {
      resolved.arrowlight_on = msg.arrowlight_on;
    }
    else {
      resolved.arrowlight_on = false
    }

    return resolved;
    }
};

module.exports = sio_state_Type;
