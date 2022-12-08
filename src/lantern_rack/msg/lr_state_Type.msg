# Timestamp [s]
float64 timestamp

# Lantern rack controller state
int64 state

# Lantern rack stack current working mode state [0-down 1-picking 2-filling 3-in trans]
int64[10] mode

# 10 Lantern rack stack level position
int64[10] level

# Lantern Racks sensor status
int64[10] sensor_state

