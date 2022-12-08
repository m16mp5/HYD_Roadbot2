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

