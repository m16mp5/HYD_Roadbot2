// Auto-generated. Do not edit!

// (in-package lidar_tracker.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let lt_object_Type = require('./lt_object_Type.js');

//-----------------------------------------------------------

class lt_state_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.timestamp = null;
      this.lidars_difftime = null;
      this.objects = null;
      this.trackedcone_indexes = null;
      this.noncone_indexes = null;
      this.num_of_fusedobjects = null;
      this.columnscan_up_dist = null;
      this.columnscan_down_dist = null;
    }
    else {
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = 0.0;
      }
      if (initObj.hasOwnProperty('lidars_difftime')) {
        this.lidars_difftime = initObj.lidars_difftime
      }
      else {
        this.lidars_difftime = 0.0;
      }
      if (initObj.hasOwnProperty('objects')) {
        this.objects = initObj.objects
      }
      else {
        this.objects = [];
      }
      if (initObj.hasOwnProperty('trackedcone_indexes')) {
        this.trackedcone_indexes = initObj.trackedcone_indexes
      }
      else {
        this.trackedcone_indexes = [];
      }
      if (initObj.hasOwnProperty('noncone_indexes')) {
        this.noncone_indexes = initObj.noncone_indexes
      }
      else {
        this.noncone_indexes = [];
      }
      if (initObj.hasOwnProperty('num_of_fusedobjects')) {
        this.num_of_fusedobjects = initObj.num_of_fusedobjects
      }
      else {
        this.num_of_fusedobjects = 0;
      }
      if (initObj.hasOwnProperty('columnscan_up_dist')) {
        this.columnscan_up_dist = initObj.columnscan_up_dist
      }
      else {
        this.columnscan_up_dist = new Array(8).fill(0);
      }
      if (initObj.hasOwnProperty('columnscan_down_dist')) {
        this.columnscan_down_dist = initObj.columnscan_down_dist
      }
      else {
        this.columnscan_down_dist = new Array(8).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lt_state_Type
    // Serialize message field [timestamp]
    bufferOffset = _serializer.float64(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [lidars_difftime]
    bufferOffset = _serializer.float64(obj.lidars_difftime, buffer, bufferOffset);
    // Serialize message field [objects]
    // Serialize the length for message field [objects]
    bufferOffset = _serializer.uint32(obj.objects.length, buffer, bufferOffset);
    obj.objects.forEach((val) => {
      bufferOffset = lt_object_Type.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [trackedcone_indexes]
    bufferOffset = _arraySerializer.int64(obj.trackedcone_indexes, buffer, bufferOffset, null);
    // Serialize message field [noncone_indexes]
    bufferOffset = _arraySerializer.int64(obj.noncone_indexes, buffer, bufferOffset, null);
    // Serialize message field [num_of_fusedobjects]
    bufferOffset = _serializer.int64(obj.num_of_fusedobjects, buffer, bufferOffset);
    // Check that the constant length array field [columnscan_up_dist] has the right length
    if (obj.columnscan_up_dist.length !== 8) {
      throw new Error('Unable to serialize array field columnscan_up_dist - length must be 8')
    }
    // Serialize message field [columnscan_up_dist]
    bufferOffset = _arraySerializer.float64(obj.columnscan_up_dist, buffer, bufferOffset, 8);
    // Check that the constant length array field [columnscan_down_dist] has the right length
    if (obj.columnscan_down_dist.length !== 8) {
      throw new Error('Unable to serialize array field columnscan_down_dist - length must be 8')
    }
    // Serialize message field [columnscan_down_dist]
    bufferOffset = _arraySerializer.float64(obj.columnscan_down_dist, buffer, bufferOffset, 8);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lt_state_Type
    let len;
    let data = new lt_state_Type(null);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [lidars_difftime]
    data.lidars_difftime = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [objects]
    // Deserialize array length for message field [objects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.objects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.objects[i] = lt_object_Type.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [trackedcone_indexes]
    data.trackedcone_indexes = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [noncone_indexes]
    data.noncone_indexes = _arrayDeserializer.int64(buffer, bufferOffset, null)
    // Deserialize message field [num_of_fusedobjects]
    data.num_of_fusedobjects = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [columnscan_up_dist]
    data.columnscan_up_dist = _arrayDeserializer.float64(buffer, bufferOffset, 8)
    // Deserialize message field [columnscan_down_dist]
    data.columnscan_down_dist = _arrayDeserializer.float64(buffer, bufferOffset, 8)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 371 * object.objects.length;
    length += 8 * object.trackedcone_indexes.length;
    length += 8 * object.noncone_indexes.length;
    return length + 164;
  }

  static datatype() {
    // Returns string type for a message object
    return 'lidar_tracker/lt_state_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e1e182e21c664b2dc04f11764f16b6e9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Timestamp [s]
    float64 timestamp
    
    # DiffTime [s]
    float64 lidars_difftime
    
    # Detected Objects
    lidar_tracker/lt_object_Type[] objects
    int64[] trackedcone_indexes 
    int64[] noncone_indexes 
    
    # Detected Objects Stat
    int64 num_of_fusedobjects
    
    # Detected dist(X) for 8 column(Y) scanners
    float64[8] columnscan_up_dist  
    float64[8] columnscan_down_dist  
    
    ================================================================================
    MSG: lidar_tracker/lt_object_Type
    # Object ID
    int64 ID
    float64 IDTimestamp
    
    # Interval [s]
    float64 UpdateInterval
    
    # Matching ratio
    float64 RatioM
    
    # Object feature points
    lidar_tracker/lt_datapoint_Type MinPoint
    lidar_tracker/lt_datapoint_Type IncEdge
    lidar_tracker/lt_datapoint_Type DecEdge
    lidar_tracker/lt_datapoint_Type CenterPoint
    lidar_tracker/lt_datapoint_Type StableRefPoint
    
    # Object size [m]
    float64 Size
    
    # Object is cone
    bool Is_Cone
    # Object is tracked
    bool Is_Tracked
    
    # Estimated Vel Acc
    lidar_tracker/lt_datapoint_Type Est_Vel
    lidar_tracker/lt_datapoint_Type Est_Acc
    
    # Lidar data fused object
    bool Is_Fused
    
    # Estimated incline angle [rad]
    lidar_tracker/lt_datapoint_Type Incline
    # Estimated rotated angle [rad]
    float64 Rotate
    
    
    ================================================================================
    MSG: lidar_tracker/lt_datapoint_Type
    # XY coordinate [m]
    float64  Dist
    float64  Angle
    float64  x
    float64  y
    # RSSI [0~255]
    float64  intensity
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new lt_state_Type(null);
    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = 0.0
    }

    if (msg.lidars_difftime !== undefined) {
      resolved.lidars_difftime = msg.lidars_difftime;
    }
    else {
      resolved.lidars_difftime = 0.0
    }

    if (msg.objects !== undefined) {
      resolved.objects = new Array(msg.objects.length);
      for (let i = 0; i < resolved.objects.length; ++i) {
        resolved.objects[i] = lt_object_Type.Resolve(msg.objects[i]);
      }
    }
    else {
      resolved.objects = []
    }

    if (msg.trackedcone_indexes !== undefined) {
      resolved.trackedcone_indexes = msg.trackedcone_indexes;
    }
    else {
      resolved.trackedcone_indexes = []
    }

    if (msg.noncone_indexes !== undefined) {
      resolved.noncone_indexes = msg.noncone_indexes;
    }
    else {
      resolved.noncone_indexes = []
    }

    if (msg.num_of_fusedobjects !== undefined) {
      resolved.num_of_fusedobjects = msg.num_of_fusedobjects;
    }
    else {
      resolved.num_of_fusedobjects = 0
    }

    if (msg.columnscan_up_dist !== undefined) {
      resolved.columnscan_up_dist = msg.columnscan_up_dist;
    }
    else {
      resolved.columnscan_up_dist = new Array(8).fill(0)
    }

    if (msg.columnscan_down_dist !== undefined) {
      resolved.columnscan_down_dist = msg.columnscan_down_dist;
    }
    else {
      resolved.columnscan_down_dist = new Array(8).fill(0)
    }

    return resolved;
    }
};

module.exports = lt_state_Type;
