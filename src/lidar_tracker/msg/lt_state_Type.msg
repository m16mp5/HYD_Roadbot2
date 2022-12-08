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
