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


