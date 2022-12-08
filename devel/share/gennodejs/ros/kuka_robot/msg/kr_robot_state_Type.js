// Auto-generated. Do not edit!

// (in-package kuka_robot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let kr_pose_Type = require('./kr_pose_Type.js');
let kr_joint_Type = require('./kr_joint_Type.js');
let kr_robot_error_Type = require('./kr_robot_error_Type.js');

//-----------------------------------------------------------

class kr_robot_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.pos_setpt = null;
      this.axis_setpt = null;
      this.pos_fb = null;
      this.axis_fb = null;
      this.dist_next = null;
      this.vel_act = null;
      this.vel_axis_act = null;
      this.curr_act = null;
      this.mot_temp = null;
      this.brake_sig = null;
      this.com_action = null;
      this.com_motstop = null;
      this.com_last_mot_time = null;
      this.com_di_port_value = null;
      this.com_do_port_value = null;
      this.com_error_no = null;
      this.com_alarm_normal = null;
      this.com_move_enable = null;
      this.com_autext_start = null;
      this.mode_op = null;
      this.ov_pro = null;
      this.power_fail = null;
      this.safety_sw = null;
      this.err = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('pos_setpt')) {
        this.pos_setpt = initObj.pos_setpt
      }
      else {
        this.pos_setpt = new kr_pose_Type();
      }
      if (initObj.hasOwnProperty('axis_setpt')) {
        this.axis_setpt = initObj.axis_setpt
      }
      else {
        this.axis_setpt = new kr_joint_Type();
      }
      if (initObj.hasOwnProperty('pos_fb')) {
        this.pos_fb = initObj.pos_fb
      }
      else {
        this.pos_fb = new kr_pose_Type();
      }
      if (initObj.hasOwnProperty('axis_fb')) {
        this.axis_fb = initObj.axis_fb
      }
      else {
        this.axis_fb = new kr_joint_Type();
      }
      if (initObj.hasOwnProperty('dist_next')) {
        this.dist_next = initObj.dist_next
      }
      else {
        this.dist_next = 0.0;
      }
      if (initObj.hasOwnProperty('vel_act')) {
        this.vel_act = initObj.vel_act
      }
      else {
        this.vel_act = 0.0;
      }
      if (initObj.hasOwnProperty('vel_axis_act')) {
        this.vel_axis_act = initObj.vel_axis_act
      }
      else {
        this.vel_axis_act = new Array(6).fill(0);
      }
      if (initObj.hasOwnProperty('curr_act')) {
        this.curr_act = initObj.curr_act
      }
      else {
        this.curr_act = new Array(6).fill(0);
      }
      if (initObj.hasOwnProperty('mot_temp')) {
        this.mot_temp = initObj.mot_temp
      }
      else {
        this.mot_temp = new Array(6).fill(0);
      }
      if (initObj.hasOwnProperty('brake_sig')) {
        this.brake_sig = initObj.brake_sig
      }
      else {
        this.brake_sig = 0;
      }
      if (initObj.hasOwnProperty('com_action')) {
        this.com_action = initObj.com_action
      }
      else {
        this.com_action = 0;
      }
      if (initObj.hasOwnProperty('com_motstop')) {
        this.com_motstop = initObj.com_motstop
      }
      else {
        this.com_motstop = 0;
      }
      if (initObj.hasOwnProperty('com_last_mot_time')) {
        this.com_last_mot_time = initObj.com_last_mot_time
      }
      else {
        this.com_last_mot_time = 0;
      }
      if (initObj.hasOwnProperty('com_di_port_value')) {
        this.com_di_port_value = initObj.com_di_port_value
      }
      else {
        this.com_di_port_value = 0;
      }
      if (initObj.hasOwnProperty('com_do_port_value')) {
        this.com_do_port_value = initObj.com_do_port_value
      }
      else {
        this.com_do_port_value = 0;
      }
      if (initObj.hasOwnProperty('com_error_no')) {
        this.com_error_no = initObj.com_error_no
      }
      else {
        this.com_error_no = 0;
      }
      if (initObj.hasOwnProperty('com_alarm_normal')) {
        this.com_alarm_normal = initObj.com_alarm_normal
      }
      else {
        this.com_alarm_normal = false;
      }
      if (initObj.hasOwnProperty('com_move_enable')) {
        this.com_move_enable = initObj.com_move_enable
      }
      else {
        this.com_move_enable = false;
      }
      if (initObj.hasOwnProperty('com_autext_start')) {
        this.com_autext_start = initObj.com_autext_start
      }
      else {
        this.com_autext_start = false;
      }
      if (initObj.hasOwnProperty('mode_op')) {
        this.mode_op = initObj.mode_op
      }
      else {
        this.mode_op = '';
      }
      if (initObj.hasOwnProperty('ov_pro')) {
        this.ov_pro = initObj.ov_pro
      }
      else {
        this.ov_pro = 0;
      }
      if (initObj.hasOwnProperty('power_fail')) {
        this.power_fail = initObj.power_fail
      }
      else {
        this.power_fail = false;
      }
      if (initObj.hasOwnProperty('safety_sw')) {
        this.safety_sw = initObj.safety_sw
      }
      else {
        this.safety_sw = '';
      }
      if (initObj.hasOwnProperty('err')) {
        this.err = initObj.err
      }
      else {
        this.err = new kr_robot_error_Type();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type kr_robot_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [pos_setpt]
    bufferOffset = kr_pose_Type.serialize(obj.pos_setpt, buffer, bufferOffset);
    // Serialize message field [axis_setpt]
    bufferOffset = kr_joint_Type.serialize(obj.axis_setpt, buffer, bufferOffset);
    // Serialize message field [pos_fb]
    bufferOffset = kr_pose_Type.serialize(obj.pos_fb, buffer, bufferOffset);
    // Serialize message field [axis_fb]
    bufferOffset = kr_joint_Type.serialize(obj.axis_fb, buffer, bufferOffset);
    // Serialize message field [dist_next]
    bufferOffset = _serializer.float64(obj.dist_next, buffer, bufferOffset);
    // Serialize message field [vel_act]
    bufferOffset = _serializer.float64(obj.vel_act, buffer, bufferOffset);
    // Check that the constant length array field [vel_axis_act] has the right length
    if (obj.vel_axis_act.length !== 6) {
      throw new Error('Unable to serialize array field vel_axis_act - length must be 6')
    }
    // Serialize message field [vel_axis_act]
    bufferOffset = _arraySerializer.float64(obj.vel_axis_act, buffer, bufferOffset, 6);
    // Check that the constant length array field [curr_act] has the right length
    if (obj.curr_act.length !== 6) {
      throw new Error('Unable to serialize array field curr_act - length must be 6')
    }
    // Serialize message field [curr_act]
    bufferOffset = _arraySerializer.float64(obj.curr_act, buffer, bufferOffset, 6);
    // Check that the constant length array field [mot_temp] has the right length
    if (obj.mot_temp.length !== 6) {
      throw new Error('Unable to serialize array field mot_temp - length must be 6')
    }
    // Serialize message field [mot_temp]
    bufferOffset = _arraySerializer.float64(obj.mot_temp, buffer, bufferOffset, 6);
    // Serialize message field [brake_sig]
    bufferOffset = _serializer.int64(obj.brake_sig, buffer, bufferOffset);
    // Serialize message field [com_action]
    bufferOffset = _serializer.int64(obj.com_action, buffer, bufferOffset);
    // Serialize message field [com_motstop]
    bufferOffset = _serializer.int64(obj.com_motstop, buffer, bufferOffset);
    // Serialize message field [com_last_mot_time]
    bufferOffset = _serializer.int64(obj.com_last_mot_time, buffer, bufferOffset);
    // Serialize message field [com_di_port_value]
    bufferOffset = _serializer.int64(obj.com_di_port_value, buffer, bufferOffset);
    // Serialize message field [com_do_port_value]
    bufferOffset = _serializer.int64(obj.com_do_port_value, buffer, bufferOffset);
    // Serialize message field [com_error_no]
    bufferOffset = _serializer.int64(obj.com_error_no, buffer, bufferOffset);
    // Serialize message field [com_alarm_normal]
    bufferOffset = _serializer.bool(obj.com_alarm_normal, buffer, bufferOffset);
    // Serialize message field [com_move_enable]
    bufferOffset = _serializer.bool(obj.com_move_enable, buffer, bufferOffset);
    // Serialize message field [com_autext_start]
    bufferOffset = _serializer.bool(obj.com_autext_start, buffer, bufferOffset);
    // Serialize message field [mode_op]
    bufferOffset = _serializer.string(obj.mode_op, buffer, bufferOffset);
    // Serialize message field [ov_pro]
    bufferOffset = _serializer.int64(obj.ov_pro, buffer, bufferOffset);
    // Serialize message field [power_fail]
    bufferOffset = _serializer.bool(obj.power_fail, buffer, bufferOffset);
    // Serialize message field [safety_sw]
    bufferOffset = _serializer.string(obj.safety_sw, buffer, bufferOffset);
    // Serialize message field [err]
    bufferOffset = kr_robot_error_Type.serialize(obj.err, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type kr_robot_state_Type
    let len;
    let data = new kr_robot_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [pos_setpt]
    data.pos_setpt = kr_pose_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [axis_setpt]
    data.axis_setpt = kr_joint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [pos_fb]
    data.pos_fb = kr_pose_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [axis_fb]
    data.axis_fb = kr_joint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [dist_next]
    data.dist_next = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [vel_act]
    data.vel_act = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [vel_axis_act]
    data.vel_axis_act = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    // Deserialize message field [curr_act]
    data.curr_act = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    // Deserialize message field [mot_temp]
    data.mot_temp = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    // Deserialize message field [brake_sig]
    data.brake_sig = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_action]
    data.com_action = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_motstop]
    data.com_motstop = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_last_mot_time]
    data.com_last_mot_time = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_di_port_value]
    data.com_di_port_value = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_do_port_value]
    data.com_do_port_value = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_error_no]
    data.com_error_no = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [com_alarm_normal]
    data.com_alarm_normal = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [com_move_enable]
    data.com_move_enable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [com_autext_start]
    data.com_autext_start = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mode_op]
    data.mode_op = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [ov_pro]
    data.ov_pro = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [power_fail]
    data.power_fail = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [safety_sw]
    data.safety_sw = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [err]
    data.err = kr_robot_error_Type.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.mode_op.length;
    length += object.safety_sw.length;
    length += kr_robot_error_Type.getMessageSize(object.err);
    return length + 468;
  }

  static datatype() {
    // Returns string type for a message object
    return 'kuka_robot/kr_robot_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '52f44fa93866f06da1a2394c1fd725bd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
    float64 timestamp
    
    # Pose setpoint [mm, c]
    kuka_robot/kr_pose_Type pos_setpt
    
    # Joints setpoint [c]
    kuka_robot/kr_joint_Type axis_setpt
    
    # Pose feedback [mm, c]
    kuka_robot/kr_pose_Type pos_fb
    
    # Joints feedback [c]
    kuka_robot/kr_joint_Type axis_fb
    
    # Distance next [mm]
    float64 dist_next
    
    # Velocity act [mm]
    float64 vel_act
    
    # Axis velocity act [c/s, 0-A1...5-A6]
    float64[6] vel_axis_act
    
    # Axis current act [%, 0-A1...5-A6]
    float64[6] curr_act
    
    # Axis motor temperature [c, 0-A1...5-A6]
    float64[6] mot_temp
    
    # Motor brake [bitwise, 0-braked 1-released]
    int64 brake_sig
    
    # Command action number [0-idle, xx-moving]
    int64 com_action
    
    # Command motion stop state [0-resume, 1-paused, 2-canceling]
    int64 com_motstop
    
    # Command motion (last one) elapsed time [mm]
    int64 com_last_mot_time
    
    # Command signal input port state [bitwise]
    int64 com_di_port_value
    
    # Command signal output port state [bitwise]
    int64 com_do_port_value
    
    
    # Slow update. Command error number [0~xxxx]
    int64 com_error_no
    
    # Slow update. Command alarm state normal [true/false]
    bool com_alarm_normal
    
    # Slow update. Command signal move enable (to stop auto external mode) [true/false]
    bool com_move_enable
    
    # Slow update. Command signal auto external mode start [true/false]
    bool com_autext_start
    
    # Slow update. Operation mode status [#T1/#T2/#AUT/#EX]
    string mode_op
    
    # Slow update. Overrided speed scale [%, 0~100]
    int64 ov_pro
    
    # Slow update. Power failure status [true/false]
    bool power_fail
    
    # Slow update. Safety switch status [#PRESSED/#RELEASED]
    string safety_sw
    
    # Slow update. Error status
    kuka_robot/kr_robot_error_Type err
    
    
    
    ================================================================================
    MSG: kuka_robot/kr_pose_Type
    # XYZ coordinate [mm]
    float64 X
    float64 Y
    float64 Z
    # ABC orientation [mm]
    float64 A
    float64 B
    float64 C
    # Status and Turn [unit]
    float64 S
    float64 T
    
    ================================================================================
    MSG: kuka_robot/kr_joint_Type
    # Joint Angles [degree]
    float64 A1
    float64 A2
    float64 A3
    float64 A4
    float64 A5
    float64 A6
    
    
    ================================================================================
    MSG: kuka_robot/kr_robot_error_Type
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
    const resolved = new kr_robot_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.pos_setpt !== undefined) {
      resolved.pos_setpt = kr_pose_Type.Resolve(msg.pos_setpt)
    }
    else {
      resolved.pos_setpt = new kr_pose_Type()
    }

    if (msg.axis_setpt !== undefined) {
      resolved.axis_setpt = kr_joint_Type.Resolve(msg.axis_setpt)
    }
    else {
      resolved.axis_setpt = new kr_joint_Type()
    }

    if (msg.pos_fb !== undefined) {
      resolved.pos_fb = kr_pose_Type.Resolve(msg.pos_fb)
    }
    else {
      resolved.pos_fb = new kr_pose_Type()
    }

    if (msg.axis_fb !== undefined) {
      resolved.axis_fb = kr_joint_Type.Resolve(msg.axis_fb)
    }
    else {
      resolved.axis_fb = new kr_joint_Type()
    }

    if (msg.dist_next !== undefined) {
      resolved.dist_next = msg.dist_next;
    }
    else {
      resolved.dist_next = 0.0
    }

    if (msg.vel_act !== undefined) {
      resolved.vel_act = msg.vel_act;
    }
    else {
      resolved.vel_act = 0.0
    }

    if (msg.vel_axis_act !== undefined) {
      resolved.vel_axis_act = msg.vel_axis_act;
    }
    else {
      resolved.vel_axis_act = new Array(6).fill(0)
    }

    if (msg.curr_act !== undefined) {
      resolved.curr_act = msg.curr_act;
    }
    else {
      resolved.curr_act = new Array(6).fill(0)
    }

    if (msg.mot_temp !== undefined) {
      resolved.mot_temp = msg.mot_temp;
    }
    else {
      resolved.mot_temp = new Array(6).fill(0)
    }

    if (msg.brake_sig !== undefined) {
      resolved.brake_sig = msg.brake_sig;
    }
    else {
      resolved.brake_sig = 0
    }

    if (msg.com_action !== undefined) {
      resolved.com_action = msg.com_action;
    }
    else {
      resolved.com_action = 0
    }

    if (msg.com_motstop !== undefined) {
      resolved.com_motstop = msg.com_motstop;
    }
    else {
      resolved.com_motstop = 0
    }

    if (msg.com_last_mot_time !== undefined) {
      resolved.com_last_mot_time = msg.com_last_mot_time;
    }
    else {
      resolved.com_last_mot_time = 0
    }

    if (msg.com_di_port_value !== undefined) {
      resolved.com_di_port_value = msg.com_di_port_value;
    }
    else {
      resolved.com_di_port_value = 0
    }

    if (msg.com_do_port_value !== undefined) {
      resolved.com_do_port_value = msg.com_do_port_value;
    }
    else {
      resolved.com_do_port_value = 0
    }

    if (msg.com_error_no !== undefined) {
      resolved.com_error_no = msg.com_error_no;
    }
    else {
      resolved.com_error_no = 0
    }

    if (msg.com_alarm_normal !== undefined) {
      resolved.com_alarm_normal = msg.com_alarm_normal;
    }
    else {
      resolved.com_alarm_normal = false
    }

    if (msg.com_move_enable !== undefined) {
      resolved.com_move_enable = msg.com_move_enable;
    }
    else {
      resolved.com_move_enable = false
    }

    if (msg.com_autext_start !== undefined) {
      resolved.com_autext_start = msg.com_autext_start;
    }
    else {
      resolved.com_autext_start = false
    }

    if (msg.mode_op !== undefined) {
      resolved.mode_op = msg.mode_op;
    }
    else {
      resolved.mode_op = ''
    }

    if (msg.ov_pro !== undefined) {
      resolved.ov_pro = msg.ov_pro;
    }
    else {
      resolved.ov_pro = 0
    }

    if (msg.power_fail !== undefined) {
      resolved.power_fail = msg.power_fail;
    }
    else {
      resolved.power_fail = false
    }

    if (msg.safety_sw !== undefined) {
      resolved.safety_sw = msg.safety_sw;
    }
    else {
      resolved.safety_sw = ''
    }

    if (msg.err !== undefined) {
      resolved.err = kr_robot_error_Type.Resolve(msg.err)
    }
    else {
      resolved.err = new kr_robot_error_Type()
    }

    return resolved;
    }
};

module.exports = kr_robot_state_Type;
