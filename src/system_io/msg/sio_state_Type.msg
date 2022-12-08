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
