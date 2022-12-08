// Auto-generated. Do not edit!

// (in-package roadbot_control.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ac_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.reararm_sm = null;
      this.frontarm_sm = null;
      this.target_id = null;
      this.target_pos_X = null;
      this.target_pos_Y = null;
      this.target_pos_Z = null;
      this.target_vel_X = null;
      this.target_vel_Y = null;
      this.target_vel_Z = null;
      this.target_acc_X = null;
      this.target_acc_Y = null;
      this.target_acc_Z = null;
      this.roadmarkline_pos_X = null;
      this.roadmarkline_pos_Y = null;
      this.progress_place_count = null;
      this.progress_place_in_total = null;
      this.progress_collect_count = null;
      this.progress_collect_in_total = null;
      this.sb_slider_position = null;
      this.sb_cones_in_total = null;
      this.sb_cones_in_stack = null;
      this.sb_current_stack = null;
      this.sb_current_stacklevel = null;
      this.lb_left_slot = null;
      this.lb_right_slot = null;
      this.lr_lanterns_in_total = null;
      this.lr_lanterns_in_stack = null;
      this.lr_current_stack = null;
      this.lr_current_stacklevel = null;
      this.rearDetectObjectInDeadZone = null;
      this.rearDetectObjectInPlaceZoneRight = null;
      this.rearDetectObjectInPlaceZoneCenter = null;
      this.rearDetectObjectInPlaceZoneLeft = null;
      this.rearDetectNonLockObjectInOperationZone = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('reararm_sm')) {
        this.reararm_sm = initObj.reararm_sm
      }
      else {
        this.reararm_sm = 0;
      }
      if (initObj.hasOwnProperty('frontarm_sm')) {
        this.frontarm_sm = initObj.frontarm_sm
      }
      else {
        this.frontarm_sm = 0;
      }
      if (initObj.hasOwnProperty('target_id')) {
        this.target_id = initObj.target_id
      }
      else {
        this.target_id = 0;
      }
      if (initObj.hasOwnProperty('target_pos_X')) {
        this.target_pos_X = initObj.target_pos_X
      }
      else {
        this.target_pos_X = 0.0;
      }
      if (initObj.hasOwnProperty('target_pos_Y')) {
        this.target_pos_Y = initObj.target_pos_Y
      }
      else {
        this.target_pos_Y = 0.0;
      }
      if (initObj.hasOwnProperty('target_pos_Z')) {
        this.target_pos_Z = initObj.target_pos_Z
      }
      else {
        this.target_pos_Z = 0.0;
      }
      if (initObj.hasOwnProperty('target_vel_X')) {
        this.target_vel_X = initObj.target_vel_X
      }
      else {
        this.target_vel_X = 0.0;
      }
      if (initObj.hasOwnProperty('target_vel_Y')) {
        this.target_vel_Y = initObj.target_vel_Y
      }
      else {
        this.target_vel_Y = 0.0;
      }
      if (initObj.hasOwnProperty('target_vel_Z')) {
        this.target_vel_Z = initObj.target_vel_Z
      }
      else {
        this.target_vel_Z = 0.0;
      }
      if (initObj.hasOwnProperty('target_acc_X')) {
        this.target_acc_X = initObj.target_acc_X
      }
      else {
        this.target_acc_X = 0.0;
      }
      if (initObj.hasOwnProperty('target_acc_Y')) {
        this.target_acc_Y = initObj.target_acc_Y
      }
      else {
        this.target_acc_Y = 0.0;
      }
      if (initObj.hasOwnProperty('target_acc_Z')) {
        this.target_acc_Z = initObj.target_acc_Z
      }
      else {
        this.target_acc_Z = 0.0;
      }
      if (initObj.hasOwnProperty('roadmarkline_pos_X')) {
        this.roadmarkline_pos_X = initObj.roadmarkline_pos_X
      }
      else {
        this.roadmarkline_pos_X = 0.0;
      }
      if (initObj.hasOwnProperty('roadmarkline_pos_Y')) {
        this.roadmarkline_pos_Y = initObj.roadmarkline_pos_Y
      }
      else {
        this.roadmarkline_pos_Y = 0.0;
      }
      if (initObj.hasOwnProperty('progress_place_count')) {
        this.progress_place_count = initObj.progress_place_count
      }
      else {
        this.progress_place_count = 0;
      }
      if (initObj.hasOwnProperty('progress_place_in_total')) {
        this.progress_place_in_total = initObj.progress_place_in_total
      }
      else {
        this.progress_place_in_total = 0;
      }
      if (initObj.hasOwnProperty('progress_collect_count')) {
        this.progress_collect_count = initObj.progress_collect_count
      }
      else {
        this.progress_collect_count = 0;
      }
      if (initObj.hasOwnProperty('progress_collect_in_total')) {
        this.progress_collect_in_total = initObj.progress_collect_in_total
      }
      else {
        this.progress_collect_in_total = 0;
      }
      if (initObj.hasOwnProperty('sb_slider_position')) {
        this.sb_slider_position = initObj.sb_slider_position
      }
      else {
        this.sb_slider_position = 0;
      }
      if (initObj.hasOwnProperty('sb_cones_in_total')) {
        this.sb_cones_in_total = initObj.sb_cones_in_total
      }
      else {
        this.sb_cones_in_total = 0;
      }
      if (initObj.hasOwnProperty('sb_cones_in_stack')) {
        this.sb_cones_in_stack = initObj.sb_cones_in_stack
      }
      else {
        this.sb_cones_in_stack = [];
      }
      if (initObj.hasOwnProperty('sb_current_stack')) {
        this.sb_current_stack = initObj.sb_current_stack
      }
      else {
        this.sb_current_stack = 0;
      }
      if (initObj.hasOwnProperty('sb_current_stacklevel')) {
        this.sb_current_stacklevel = initObj.sb_current_stacklevel
      }
      else {
        this.sb_current_stacklevel = 0;
      }
      if (initObj.hasOwnProperty('lb_left_slot')) {
        this.lb_left_slot = initObj.lb_left_slot
      }
      else {
        this.lb_left_slot = 0;
      }
      if (initObj.hasOwnProperty('lb_right_slot')) {
        this.lb_right_slot = initObj.lb_right_slot
      }
      else {
        this.lb_right_slot = 0;
      }
      if (initObj.hasOwnProperty('lr_lanterns_in_total')) {
        this.lr_lanterns_in_total = initObj.lr_lanterns_in_total
      }
      else {
        this.lr_lanterns_in_total = 0;
      }
      if (initObj.hasOwnProperty('lr_lanterns_in_stack')) {
        this.lr_lanterns_in_stack = initObj.lr_lanterns_in_stack
      }
      else {
        this.lr_lanterns_in_stack = [];
      }
      if (initObj.hasOwnProperty('lr_current_stack')) {
        this.lr_current_stack = initObj.lr_current_stack
      }
      else {
        this.lr_current_stack = 0;
      }
      if (initObj.hasOwnProperty('lr_current_stacklevel')) {
        this.lr_current_stacklevel = initObj.lr_current_stacklevel
      }
      else {
        this.lr_current_stacklevel = 0;
      }
      if (initObj.hasOwnProperty('rearDetectObjectInDeadZone')) {
        this.rearDetectObjectInDeadZone = initObj.rearDetectObjectInDeadZone
      }
      else {
        this.rearDetectObjectInDeadZone = false;
      }
      if (initObj.hasOwnProperty('rearDetectObjectInPlaceZoneRight')) {
        this.rearDetectObjectInPlaceZoneRight = initObj.rearDetectObjectInPlaceZoneRight
      }
      else {
        this.rearDetectObjectInPlaceZoneRight = false;
      }
      if (initObj.hasOwnProperty('rearDetectObjectInPlaceZoneCenter')) {
        this.rearDetectObjectInPlaceZoneCenter = initObj.rearDetectObjectInPlaceZoneCenter
      }
      else {
        this.rearDetectObjectInPlaceZoneCenter = false;
      }
      if (initObj.hasOwnProperty('rearDetectObjectInPlaceZoneLeft')) {
        this.rearDetectObjectInPlaceZoneLeft = initObj.rearDetectObjectInPlaceZoneLeft
      }
      else {
        this.rearDetectObjectInPlaceZoneLeft = false;
      }
      if (initObj.hasOwnProperty('rearDetectNonLockObjectInOperationZone')) {
        this.rearDetectNonLockObjectInOperationZone = initObj.rearDetectNonLockObjectInOperationZone
      }
      else {
        this.rearDetectNonLockObjectInOperationZone = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ac_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [reararm_sm]
    bufferOffset = _serializer.int64(obj.reararm_sm, buffer, bufferOffset);
    // Serialize message field [frontarm_sm]
    bufferOffset = _serializer.int64(obj.frontarm_sm, buffer, bufferOffset);
    // Serialize message field [target_id]
    bufferOffset = _serializer.int64(obj.target_id, buffer, bufferOffset);
    // Serialize message field [target_pos_X]
    bufferOffset = _serializer.float64(obj.target_pos_X, buffer, bufferOffset);
    // Serialize message field [target_pos_Y]
    bufferOffset = _serializer.float64(obj.target_pos_Y, buffer, bufferOffset);
    // Serialize message field [target_pos_Z]
    bufferOffset = _serializer.float64(obj.target_pos_Z, buffer, bufferOffset);
    // Serialize message field [target_vel_X]
    bufferOffset = _serializer.float64(obj.target_vel_X, buffer, bufferOffset);
    // Serialize message field [target_vel_Y]
    bufferOffset = _serializer.float64(obj.target_vel_Y, buffer, bufferOffset);
    // Serialize message field [target_vel_Z]
    bufferOffset = _serializer.float64(obj.target_vel_Z, buffer, bufferOffset);
    // Serialize message field [target_acc_X]
    bufferOffset = _serializer.float64(obj.target_acc_X, buffer, bufferOffset);
    // Serialize message field [target_acc_Y]
    bufferOffset = _serializer.float64(obj.target_acc_Y, buffer, bufferOffset);
    // Serialize message field [target_acc_Z]
    bufferOffset = _serializer.float64(obj.target_acc_Z, buffer, bufferOffset);
    // Serialize message field [roadmarkline_pos_X]
    bufferOffset = _serializer.float64(obj.roadmarkline_pos_X, buffer, bufferOffset);
    // Serialize message field [roadmarkline_pos_Y]
    bufferOffset = _serializer.float64(obj.roadmarkline_pos_Y, buffer, bufferOffset);
    // Serialize message field [progress_place_count]
    bufferOffset = _serializer.int64(obj.progress_place_count, buffer, bufferOffset);
    // Serialize message field [progress_place_in_total]
    bufferOffset = _serializer.int64(obj.progress_place_in_total, buffer, bufferOffset);
    // Serialize message field [progress_collect_count]
    bufferOffset = _serializer.int64(obj.progress_collect_count, buffer, bufferOffset);
    // Serialize message field [progress_collect_in_total]
    bufferOffset = _serializer.int64(obj.progress_collect_in_total, buffer, bufferOffset);
    // Serialize message field [sb_slider_position]
    bufferOffset = _serializer.int64(obj.sb_slider_position, buffer, bufferOffset);
    // Serialize message field [sb_cones_in_total]
    bufferOffset = _serializer.int64(obj.sb_cones_in_total, buffer, bufferOffset);
    // Serialize message field [sb_cones_in_stack]
    bufferOffset = _arraySerializer.int64(obj.sb_cones_in_stack, buffer, bufferOffset, null);
    // Serialize message field [sb_current_stack]
    bufferOffset = _serializer.int64(obj.sb_current_stack, buffer, bufferOffset);
    // Serialize message field [sb_current_stacklevel]
    bufferOffset = _serializer.int64(obj.sb_current_stacklevel, buffer, bufferOffset);
    // Serialize message field [lb_left_slot]
    bufferOffset = _serializer.int64(obj.lb_left_slot, buffer, bufferOffset);
    // Serialize message field [lb_right_slot]
    bufferOffset = _serializer.int64(obj.lb_right_slot, buffer, bufferOffset);
    // Serialize message field [lr_lanterns_in_total]
    bufferOffset = _serializer.int64(obj.lr_lanterns_in_total, buffer, bufferOffset);
    // Serialize message field [lr_lanterns_in_stack]
    bufferOffset = _arraySerializer.int64(obj.lr_lanterns_in_stack, buffer, bufferOffset, null);
    // Serialize message field [lr_current_stack]
    bufferOffset = _serializer.int64(obj.lr_current_stack, buffer, bufferOffset);
    // Serialize message field [lr_current_stacklevel]
    bufferOffset = _serializer.int64(obj.lr_current_stacklevel, buffer, bufferOffset);
    // Serialize message field [rearDetectObjectInDeadZone]
    bufferOffset = _serializer.bool(obj.rearDetectObjectInDeadZone, buffer, bufferOffset);
    // Serialize message field [rearDetectObjectInPlaceZoneRight]
    bufferOffset = _serializer.bool(obj.rearDetectObjectInPlaceZoneRight, buffer, bufferOffset);
    // Serialize message field [rearDetectObjectInPlaceZoneCenter]
    bufferOffset = _serializer.bool(obj.rearDetectObjectInPlaceZoneCenter, buffer, bufferOffset);
    // Serialize message field [rearDetectObjectInPlaceZoneLeft]
    bufferOffset = _serializer.bool(obj.rearDetectObjectInPlaceZoneLeft, buffer, bufferOffset);
    // Serialize message field [rearDetectNonLockObjectInOperationZone]
    bufferOffset = _serializer.bool(obj.rearDetectNonLockObjectInOperationZone, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ac_state_Type
    let len;
    let data = new ac_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [reararm_sm]
    data.reararm_sm = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [frontarm_sm]
    data.frontarm_sm = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [target_id]
    data.target_id = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [target_pos_X]
    data.target_pos_X = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_pos_Y]
    data.target_pos_Y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_pos_Z]
    data.target_pos_Z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_vel_X]
    data.target_vel_X = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_vel_Y]
    data.target_vel_Y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_vel_Z]
    data.target_vel_Z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_acc_X]
    data.target_acc_X = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_acc_Y]
    data.target_acc_Y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [target_acc_Z]
    data.target_acc_Z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [roadmarkline_pos_X]
    data.roadmarkline_pos_X = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [roadmarkline_pos_Y]
    data.roadmarkline_pos_Y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [progress_place_count]
    data.progress_place_count = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [progress_place_in_total]
    data.progress_place_in_total = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [progress_collect_count]
    data.progress_collect_count = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [progress_collect_in_total]
    data.progress_collect_in_total = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [sb_slider_position]
    data.sb_slider_position = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [sb_cones_in_total]
    data.sb_cones_in_total = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [sb_cones_in_stack]
    data.sb_cones_in_stack = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [sb_current_stack]
    data.sb_current_stack = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [sb_current_stacklevel]
    data.sb_current_stacklevel = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lb_left_slot]
    data.lb_left_slot = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lb_right_slot]
    data.lb_right_slot = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lr_lanterns_in_total]
    data.lr_lanterns_in_total = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lr_lanterns_in_stack]
    data.lr_lanterns_in_stack = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [lr_current_stack]
    data.lr_current_stack = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lr_current_stacklevel]
    data.lr_current_stacklevel = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [rearDetectObjectInDeadZone]
    data.rearDetectObjectInDeadZone = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rearDetectObjectInPlaceZoneRight]
    data.rearDetectObjectInPlaceZoneRight = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rearDetectObjectInPlaceZoneCenter]
    data.rearDetectObjectInPlaceZoneCenter = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rearDetectObjectInPlaceZoneLeft]
    data.rearDetectObjectInPlaceZoneLeft = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [rearDetectNonLockObjectInOperationZone]
    data.rearDetectNonLockObjectInOperationZone = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.sb_cones_in_stack.length;
    length += 8 * object.lr_lanterns_in_stack.length;
    return length + 237;
  }

  static datatype() {
    // Returns string type for a message object
    return 'roadbot_control/ac_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ab807b4f227aecbfa526561d1e53b40a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
    float64 timestamp
    
    # Robot Arm State Machine states
    int64 reararm_sm
    int64 frontarm_sm
    
    # Robot Arm Target Lock states
    int64 target_id
    float64 target_pos_X
    float64 target_pos_Y
    float64 target_pos_Z
    float64 target_vel_X
    float64 target_vel_Y
    float64 target_vel_Z
    float64 target_acc_X
    float64 target_acc_Y
    float64 target_acc_Z
    
    # Robot Arm Line Track states
    float64 roadmarkline_pos_X
    float64 roadmarkline_pos_Y
    
    # Place and Collect progress
    int64 progress_place_count
    int64 progress_place_in_total
    int64 progress_collect_count
    int64 progress_collect_in_total
    
    # Cone Storage states
    int64 sb_slider_position
    int64 sb_cones_in_total
    int64[] sb_cones_in_stack
    int64 sb_current_stack
    int64 sb_current_stacklevel
    
    # Loading Bay States
    int64 lb_left_slot
    int64 lb_right_slot
    
    # Lanterns Rack States
    int64 lr_lanterns_in_total
    int64[] lr_lanterns_in_stack
    int64 lr_current_stack
    int64 lr_current_stacklevel
    
    # Rear blockage detection
    bool rearDetectObjectInDeadZone
    bool rearDetectObjectInPlaceZoneRight
    bool rearDetectObjectInPlaceZoneCenter
    bool rearDetectObjectInPlaceZoneLeft
    bool rearDetectNonLockObjectInOperationZone
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ac_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.reararm_sm !== undefined) {
      resolved.reararm_sm = msg.reararm_sm;
    }
    else {
      resolved.reararm_sm = 0
    }

    if (msg.frontarm_sm !== undefined) {
      resolved.frontarm_sm = msg.frontarm_sm;
    }
    else {
      resolved.frontarm_sm = 0
    }

    if (msg.target_id !== undefined) {
      resolved.target_id = msg.target_id;
    }
    else {
      resolved.target_id = 0
    }

    if (msg.target_pos_X !== undefined) {
      resolved.target_pos_X = msg.target_pos_X;
    }
    else {
      resolved.target_pos_X = 0.0
    }

    if (msg.target_pos_Y !== undefined) {
      resolved.target_pos_Y = msg.target_pos_Y;
    }
    else {
      resolved.target_pos_Y = 0.0
    }

    if (msg.target_pos_Z !== undefined) {
      resolved.target_pos_Z = msg.target_pos_Z;
    }
    else {
      resolved.target_pos_Z = 0.0
    }

    if (msg.target_vel_X !== undefined) {
      resolved.target_vel_X = msg.target_vel_X;
    }
    else {
      resolved.target_vel_X = 0.0
    }

    if (msg.target_vel_Y !== undefined) {
      resolved.target_vel_Y = msg.target_vel_Y;
    }
    else {
      resolved.target_vel_Y = 0.0
    }

    if (msg.target_vel_Z !== undefined) {
      resolved.target_vel_Z = msg.target_vel_Z;
    }
    else {
      resolved.target_vel_Z = 0.0
    }

    if (msg.target_acc_X !== undefined) {
      resolved.target_acc_X = msg.target_acc_X;
    }
    else {
      resolved.target_acc_X = 0.0
    }

    if (msg.target_acc_Y !== undefined) {
      resolved.target_acc_Y = msg.target_acc_Y;
    }
    else {
      resolved.target_acc_Y = 0.0
    }

    if (msg.target_acc_Z !== undefined) {
      resolved.target_acc_Z = msg.target_acc_Z;
    }
    else {
      resolved.target_acc_Z = 0.0
    }

    if (msg.roadmarkline_pos_X !== undefined) {
      resolved.roadmarkline_pos_X = msg.roadmarkline_pos_X;
    }
    else {
      resolved.roadmarkline_pos_X = 0.0
    }

    if (msg.roadmarkline_pos_Y !== undefined) {
      resolved.roadmarkline_pos_Y = msg.roadmarkline_pos_Y;
    }
    else {
      resolved.roadmarkline_pos_Y = 0.0
    }

    if (msg.progress_place_count !== undefined) {
      resolved.progress_place_count = msg.progress_place_count;
    }
    else {
      resolved.progress_place_count = 0
    }

    if (msg.progress_place_in_total !== undefined) {
      resolved.progress_place_in_total = msg.progress_place_in_total;
    }
    else {
      resolved.progress_place_in_total = 0
    }

    if (msg.progress_collect_count !== undefined) {
      resolved.progress_collect_count = msg.progress_collect_count;
    }
    else {
      resolved.progress_collect_count = 0
    }

    if (msg.progress_collect_in_total !== undefined) {
      resolved.progress_collect_in_total = msg.progress_collect_in_total;
    }
    else {
      resolved.progress_collect_in_total = 0
    }

    if (msg.sb_slider_position !== undefined) {
      resolved.sb_slider_position = msg.sb_slider_position;
    }
    else {
      resolved.sb_slider_position = 0
    }

    if (msg.sb_cones_in_total !== undefined) {
      resolved.sb_cones_in_total = msg.sb_cones_in_total;
    }
    else {
      resolved.sb_cones_in_total = 0
    }

    if (msg.sb_cones_in_stack !== undefined) {
      resolved.sb_cones_in_stack = msg.sb_cones_in_stack;
    }
    else {
      resolved.sb_cones_in_stack = []
    }

    if (msg.sb_current_stack !== undefined) {
      resolved.sb_current_stack = msg.sb_current_stack;
    }
    else {
      resolved.sb_current_stack = 0
    }

    if (msg.sb_current_stacklevel !== undefined) {
      resolved.sb_current_stacklevel = msg.sb_current_stacklevel;
    }
    else {
      resolved.sb_current_stacklevel = 0
    }

    if (msg.lb_left_slot !== undefined) {
      resolved.lb_left_slot = msg.lb_left_slot;
    }
    else {
      resolved.lb_left_slot = 0
    }

    if (msg.lb_right_slot !== undefined) {
      resolved.lb_right_slot = msg.lb_right_slot;
    }
    else {
      resolved.lb_right_slot = 0
    }

    if (msg.lr_lanterns_in_total !== undefined) {
      resolved.lr_lanterns_in_total = msg.lr_lanterns_in_total;
    }
    else {
      resolved.lr_lanterns_in_total = 0
    }

    if (msg.lr_lanterns_in_stack !== undefined) {
      resolved.lr_lanterns_in_stack = msg.lr_lanterns_in_stack;
    }
    else {
      resolved.lr_lanterns_in_stack = []
    }

    if (msg.lr_current_stack !== undefined) {
      resolved.lr_current_stack = msg.lr_current_stack;
    }
    else {
      resolved.lr_current_stack = 0
    }

    if (msg.lr_current_stacklevel !== undefined) {
      resolved.lr_current_stacklevel = msg.lr_current_stacklevel;
    }
    else {
      resolved.lr_current_stacklevel = 0
    }

    if (msg.rearDetectObjectInDeadZone !== undefined) {
      resolved.rearDetectObjectInDeadZone = msg.rearDetectObjectInDeadZone;
    }
    else {
      resolved.rearDetectObjectInDeadZone = false
    }

    if (msg.rearDetectObjectInPlaceZoneRight !== undefined) {
      resolved.rearDetectObjectInPlaceZoneRight = msg.rearDetectObjectInPlaceZoneRight;
    }
    else {
      resolved.rearDetectObjectInPlaceZoneRight = false
    }

    if (msg.rearDetectObjectInPlaceZoneCenter !== undefined) {
      resolved.rearDetectObjectInPlaceZoneCenter = msg.rearDetectObjectInPlaceZoneCenter;
    }
    else {
      resolved.rearDetectObjectInPlaceZoneCenter = false
    }

    if (msg.rearDetectObjectInPlaceZoneLeft !== undefined) {
      resolved.rearDetectObjectInPlaceZoneLeft = msg.rearDetectObjectInPlaceZoneLeft;
    }
    else {
      resolved.rearDetectObjectInPlaceZoneLeft = false
    }

    if (msg.rearDetectNonLockObjectInOperationZone !== undefined) {
      resolved.rearDetectNonLockObjectInOperationZone = msg.rearDetectNonLockObjectInOperationZone;
    }
    else {
      resolved.rearDetectNonLockObjectInOperationZone = false
    }

    return resolved;
    }
};

module.exports = ac_state_Type;
