// Auto-generated. Do not edit!

// (in-package lidar_tracker.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let lt_datapoint_Type = require('./lt_datapoint_Type.js');

//-----------------------------------------------------------

class lt_object_Type {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ID = null;
      this.IDTimestamp = null;
      this.UpdateInterval = null;
      this.RatioM = null;
      this.MinPoint = null;
      this.IncEdge = null;
      this.DecEdge = null;
      this.CenterPoint = null;
      this.StableRefPoint = null;
      this.Size = null;
      this.Is_Cone = null;
      this.Is_Tracked = null;
      this.Est_Vel = null;
      this.Est_Acc = null;
      this.Is_Fused = null;
      this.Incline = null;
      this.Rotate = null;
    }
    else {
      if (initObj.hasOwnProperty('ID')) {
        this.ID = initObj.ID
      }
      else {
        this.ID = 0;
      }
      if (initObj.hasOwnProperty('IDTimestamp')) {
        this.IDTimestamp = initObj.IDTimestamp
      }
      else {
        this.IDTimestamp = 0.0;
      }
      if (initObj.hasOwnProperty('UpdateInterval')) {
        this.UpdateInterval = initObj.UpdateInterval
      }
      else {
        this.UpdateInterval = 0.0;
      }
      if (initObj.hasOwnProperty('RatioM')) {
        this.RatioM = initObj.RatioM
      }
      else {
        this.RatioM = 0.0;
      }
      if (initObj.hasOwnProperty('MinPoint')) {
        this.MinPoint = initObj.MinPoint
      }
      else {
        this.MinPoint = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('IncEdge')) {
        this.IncEdge = initObj.IncEdge
      }
      else {
        this.IncEdge = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('DecEdge')) {
        this.DecEdge = initObj.DecEdge
      }
      else {
        this.DecEdge = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('CenterPoint')) {
        this.CenterPoint = initObj.CenterPoint
      }
      else {
        this.CenterPoint = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('StableRefPoint')) {
        this.StableRefPoint = initObj.StableRefPoint
      }
      else {
        this.StableRefPoint = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('Size')) {
        this.Size = initObj.Size
      }
      else {
        this.Size = 0.0;
      }
      if (initObj.hasOwnProperty('Is_Cone')) {
        this.Is_Cone = initObj.Is_Cone
      }
      else {
        this.Is_Cone = false;
      }
      if (initObj.hasOwnProperty('Is_Tracked')) {
        this.Is_Tracked = initObj.Is_Tracked
      }
      else {
        this.Is_Tracked = false;
      }
      if (initObj.hasOwnProperty('Est_Vel')) {
        this.Est_Vel = initObj.Est_Vel
      }
      else {
        this.Est_Vel = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('Est_Acc')) {
        this.Est_Acc = initObj.Est_Acc
      }
      else {
        this.Est_Acc = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('Is_Fused')) {
        this.Is_Fused = initObj.Is_Fused
      }
      else {
        this.Is_Fused = false;
      }
      if (initObj.hasOwnProperty('Incline')) {
        this.Incline = initObj.Incline
      }
      else {
        this.Incline = new lt_datapoint_Type();
      }
      if (initObj.hasOwnProperty('Rotate')) {
        this.Rotate = initObj.Rotate
      }
      else {
        this.Rotate = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type lt_object_Type
    // Serialize message field [ID]
    bufferOffset = _serializer.int64(obj.ID, buffer, bufferOffset);
    // Serialize message field [IDTimestamp]
    bufferOffset = _serializer.float64(obj.IDTimestamp, buffer, bufferOffset);
    // Serialize message field [UpdateInterval]
    bufferOffset = _serializer.float64(obj.UpdateInterval, buffer, bufferOffset);
    // Serialize message field [RatioM]
    bufferOffset = _serializer.float64(obj.RatioM, buffer, bufferOffset);
    // Serialize message field [MinPoint]
    bufferOffset = lt_datapoint_Type.serialize(obj.MinPoint, buffer, bufferOffset);
    // Serialize message field [IncEdge]
    bufferOffset = lt_datapoint_Type.serialize(obj.IncEdge, buffer, bufferOffset);
    // Serialize message field [DecEdge]
    bufferOffset = lt_datapoint_Type.serialize(obj.DecEdge, buffer, bufferOffset);
    // Serialize message field [CenterPoint]
    bufferOffset = lt_datapoint_Type.serialize(obj.CenterPoint, buffer, bufferOffset);
    // Serialize message field [StableRefPoint]
    bufferOffset = lt_datapoint_Type.serialize(obj.StableRefPoint, buffer, bufferOffset);
    // Serialize message field [Size]
    bufferOffset = _serializer.float64(obj.Size, buffer, bufferOffset);
    // Serialize message field [Is_Cone]
    bufferOffset = _serializer.bool(obj.Is_Cone, buffer, bufferOffset);
    // Serialize message field [Is_Tracked]
    bufferOffset = _serializer.bool(obj.Is_Tracked, buffer, bufferOffset);
    // Serialize message field [Est_Vel]
    bufferOffset = lt_datapoint_Type.serialize(obj.Est_Vel, buffer, bufferOffset);
    // Serialize message field [Est_Acc]
    bufferOffset = lt_datapoint_Type.serialize(obj.Est_Acc, buffer, bufferOffset);
    // Serialize message field [Is_Fused]
    bufferOffset = _serializer.bool(obj.Is_Fused, buffer, bufferOffset);
    // Serialize message field [Incline]
    bufferOffset = lt_datapoint_Type.serialize(obj.Incline, buffer, bufferOffset);
    // Serialize message field [Rotate]
    bufferOffset = _serializer.float64(obj.Rotate, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type lt_object_Type
    let len;
    let data = new lt_object_Type(null);
    // Deserialize message field [ID]
    data.ID = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [IDTimestamp]
    data.IDTimestamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [UpdateInterval]
    data.UpdateInterval = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [RatioM]
    data.RatioM = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [MinPoint]
    data.MinPoint = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [IncEdge]
    data.IncEdge = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [DecEdge]
    data.DecEdge = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [CenterPoint]
    data.CenterPoint = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [StableRefPoint]
    data.StableRefPoint = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [Size]
    data.Size = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Is_Cone]
    data.Is_Cone = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [Is_Tracked]
    data.Is_Tracked = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [Est_Vel]
    data.Est_Vel = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [Est_Acc]
    data.Est_Acc = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [Is_Fused]
    data.Is_Fused = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [Incline]
    data.Incline = lt_datapoint_Type.deserialize(buffer, bufferOffset);
    // Deserialize message field [Rotate]
    data.Rotate = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 371;
  }

  static datatype() {
    // Returns string type for a message object
    return 'lidar_tracker/lt_object_Type';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '653a1245a4632ad939226826e9619f93';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new lt_object_Type(null);
    if (msg.ID !== undefined) {
      resolved.ID = msg.ID;
    }
    else {
      resolved.ID = 0
    }

    if (msg.IDTimestamp !== undefined) {
      resolved.IDTimestamp = msg.IDTimestamp;
    }
    else {
      resolved.IDTimestamp = 0.0
    }

    if (msg.UpdateInterval !== undefined) {
      resolved.UpdateInterval = msg.UpdateInterval;
    }
    else {
      resolved.UpdateInterval = 0.0
    }

    if (msg.RatioM !== undefined) {
      resolved.RatioM = msg.RatioM;
    }
    else {
      resolved.RatioM = 0.0
    }

    if (msg.MinPoint !== undefined) {
      resolved.MinPoint = lt_datapoint_Type.Resolve(msg.MinPoint)
    }
    else {
      resolved.MinPoint = new lt_datapoint_Type()
    }

    if (msg.IncEdge !== undefined) {
      resolved.IncEdge = lt_datapoint_Type.Resolve(msg.IncEdge)
    }
    else {
      resolved.IncEdge = new lt_datapoint_Type()
    }

    if (msg.DecEdge !== undefined) {
      resolved.DecEdge = lt_datapoint_Type.Resolve(msg.DecEdge)
    }
    else {
      resolved.DecEdge = new lt_datapoint_Type()
    }

    if (msg.CenterPoint !== undefined) {
      resolved.CenterPoint = lt_datapoint_Type.Resolve(msg.CenterPoint)
    }
    else {
      resolved.CenterPoint = new lt_datapoint_Type()
    }

    if (msg.StableRefPoint !== undefined) {
      resolved.StableRefPoint = lt_datapoint_Type.Resolve(msg.StableRefPoint)
    }
    else {
      resolved.StableRefPoint = new lt_datapoint_Type()
    }

    if (msg.Size !== undefined) {
      resolved.Size = msg.Size;
    }
    else {
      resolved.Size = 0.0
    }

    if (msg.Is_Cone !== undefined) {
      resolved.Is_Cone = msg.Is_Cone;
    }
    else {
      resolved.Is_Cone = false
    }

    if (msg.Is_Tracked !== undefined) {
      resolved.Is_Tracked = msg.Is_Tracked;
    }
    else {
      resolved.Is_Tracked = false
    }

    if (msg.Est_Vel !== undefined) {
      resolved.Est_Vel = lt_datapoint_Type.Resolve(msg.Est_Vel)
    }
    else {
      resolved.Est_Vel = new lt_datapoint_Type()
    }

    if (msg.Est_Acc !== undefined) {
      resolved.Est_Acc = lt_datapoint_Type.Resolve(msg.Est_Acc)
    }
    else {
      resolved.Est_Acc = new lt_datapoint_Type()
    }

    if (msg.Is_Fused !== undefined) {
      resolved.Is_Fused = msg.Is_Fused;
    }
    else {
      resolved.Is_Fused = false
    }

    if (msg.Incline !== undefined) {
      resolved.Incline = lt_datapoint_Type.Resolve(msg.Incline)
    }
    else {
      resolved.Incline = new lt_datapoint_Type()
    }

    if (msg.Rotate !== undefined) {
      resolved.Rotate = msg.Rotate;
    }
    else {
      resolved.Rotate = 0.0
    }

    return resolved;
    }
};

module.exports = lt_object_Type;
