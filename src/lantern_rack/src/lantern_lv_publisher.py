#!/usr/bin/env python
import rospy 
from lantern_rack.msg import lr_state_Type
import serial
import modbus_tk
import modbus_tk.defines as cst
from modbus_tk import modbus_rtu
import time

PORT = "/dev/ttyS1"
def levelsensor():
    try:	
        #Connect to the slave
        master = modbus_rtu.RtuMaster(
        serial.Serial(port=PORT, baudrate=9600, bytesize=8, parity='N', stopbits=1, xonxoff=0))
        master.set_timeout(5.0)
        master.set_verbose(True)
        #logger.info("connected")
        #logger.info(master.execute(1, cst.READ_HOLDING_REGISTERS, 0, 2))
        respond = master.execute(1, cst.READ_HOLDING_REGISTERS, 0, 2)
        print("distance level = " + str(respond[1]))

        #if (respond[1] > 100):
            #print ("level = 1")

        #else:
            #print("not yet move ")

	return respond[1]


    #send some queries
    #logger.info(master.execute(1, cst.READ_COILS, 0, 10))
    #logger.info(master.execute(1, cst.READ_DISCRETE_INPUTS, 0, 8))
    #logger.info(master.execute(1, cst.READ_INPUT_REGISTERS, 100, 3))
    #logger.info(master.execute(1, cst.READ_HOLDING_REGISTERS, 100, 12))
    #logger.info(master.execute(1, cst.WRITE_SINGLE_COIL, 7, output_value=1))
    #logger.info(master.execute(1, cst.WRITE_SINGLE_REGISTER, 100, output_value=54))
    #logger.info(master.execute(1, cst.WRITE_MULTIPLE_COILS, 0, output_value=))
    #logger.info(master.execute(1, cst.WRITE_MULTIPLE_REGISTERS, 100, output_value=xrange(12)))
    except modbus_tk.modbus.ModbusError as exc:
        logger.error("%s- Code=%d", exc, exc.get_exception_code())

def lr_lv_publisher():
	pub = rospy.Publisher('Lantern_level', lr_state_Type, queue_size=10)
	rospy.init_node('lantern_level_sernsor')
	r = rospy.Rate(1)

	while not rospy.is_shutdown():
		level = lr_state_Type()
		lv = levelsensor()
		if (0 < lv < 210): 
			level.level[0] = 0
		elif (210 < lv < 740):
			level.level[0] = 1
		elif (740 < lv < 1256):
			level.level[0] = 2
		elif (1256 < lv < 1820):
			level.level[0] = 3
		elif (1820 < lv < 2322):
			level.level[0] = 4
		elif (2322 < lv < 2869):
			level.level[0] = 5
		elif (2869 < lv < 3355):
			level.level[0] = 6
		elif (3355 < lv < 3864):
			level.level[0] = 7
		elif (3864 < lv < 4439):
			level.level[0] = 8
		elif (4439 < lv < 4995):
			level.level[0] = 9
		elif (4995 < lv < 5510):
			level.level[0] = 10
		elif (5510 < lv < 6050):
			level.level[0] = 11
		elif (6050 < lv < 6568):
			level.level[0] = 12
		elif (6568 < lv < 7120):
			level.level[0] = 13
		elif (7120 < lv < 7606):
			level.level[0] = 14
		elif (7606 < lv < 8185):
			level.level[0] = 15
		elif (8185 < lv < 8694):
			level.level[0] = 16
		elif (8694 < lv < 8900):
			level.level[0] = 17

         	rospy.loginfo(level.level[0])
		print("Lantern level is " + str(level.level[0]))
		pub.publish(level)
		r.sleep()


if __name__ == '__main__':
    try:
	
        lr_lv_publisher()
    except rospy.ROSInterruptException:
        pass

