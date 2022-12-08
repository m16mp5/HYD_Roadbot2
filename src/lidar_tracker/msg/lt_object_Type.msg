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

