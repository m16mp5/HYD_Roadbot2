# Timestamp [s]
float64 timestamp

# 2 humidity and sensor readings
float64[2] th_temperature
float64[2] th_humidity

# 2 3-phase meter sensor readings
float64[2] meter_phA_V
float64[2] meter_phB_V
float64[2] meter_phC_V
float64[2] meter_phA_I
float64[2] meter_phB_I
float64[2] meter_phC_I
float64[2] meter_tot_W
float64[2] meter_phA_W
float64[2] meter_phB_W
float64[2] meter_phC_W

# 2 3-phase inverter MCB readings
float64[2] mcb_V
float64[2] mcb_I
int64[2] mcb_sw_pos

# sensor boxes error state
int64[2] state_temphum
int64[2] state_meter
int64[2] state_mcb
