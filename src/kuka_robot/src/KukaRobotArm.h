/*
 * KukaRobotArm.h
 *
 *  Created on: 5 Jun 2019
 *      Author: IY
 */

#ifndef KUKA_ROBOT_SRC_KUKAROBOTARM_H_
#define KUKA_ROBOT_SRC_KUKAROBOTARM_H_

#include <mutex>

#include "PracticalSocket.h"
#include "KukaVarProxyMsg.h"

#define KVP_TCPPORT						7000
#define BATCH_MOV_MAX_BLOCK				512

// Marco defined in KRC4 Rob_MotServer
#define MOVJ_BYJOINTS_ACTION_TYPE				2
#define MOVL_BYJOINTS_ACTION_TYPE				4
#define MOVJREL_BYJOINTS_ACTION_TYPE			6
//#define MOVLREL_BYJOINTS_ACTION_TYPE			00		// not possible
#define MOVJRELTOOL_BYJOINTS_ACTION_TYPE		106
//#define MOVLRELTOOL_BYJOINTS_ACTION_TYPE		00		// not possible

#define MOVJ_BYPOSE_ACTION_TYPE					1
#define MOVL_BYPOSE_ACTION_TYPE					3
#define MOVJREL_BYPOSE_ACTION_TYPE				5
#define MOVLREL_BYPOSE_ACTION_TYPE				7
#define MOVJRELTOOL_BYPOSE_ACTION_TYPE			105
#define MOVLRELTOOL_BYPOSE_ACTION_TYPE			107

#define DO_ACTION_TYPE							51

struct AXIS
{
	double A1;
	double A2;
	double A3;
	double A4;
	double A5;
	double A6;
};

struct E6AXIS
{
	double A1;
	double A2;
	double A3;
	double A4;
	double A5;
	double A6;
	double E1;
	double E2;
	double E3;
	double E4;
	double E5;
	double E6;
};

struct FRAME
{
	double X;
	double Y;
	double Z;
	double A;
	double B;
	double C;
};

struct POS
{
	double X;
	double Y;
	double Z;
	double A;
	double B;
	double C;
	double S;
	double T;
};

struct E6POS
{
	double X;
	double Y;
	double Z;
	double A;
	double B;
	double C;
	double E1;
	double E2;
	double E3;
	double E4;
	double E5;
	double E6;
	double S;
	double T;
};

struct PAYLOAD
{
	double Mass;
	FRAME CenterOfGravity;
	FRAME Inertia;
};

struct APO
{
	int CVEL;
	int CPTP;
	double CDIS;
	double CORI;
};

struct VEL
{
	double CP;
	double ORI1;
	double ORI2;
};

struct ERROR_T
{
	int number;
	string interpreter;						// #R_INT
	string int_type;						// #I_NORMAL
	unsigned short int_prio;
	unsigned int line_nr;
	string module;							// max 23 chars
	string up_name;							// max 23 chars
	string trigger_type;					// #TRG_NONE
};

struct BATCH_MOV_BLK
{
	E6AXIS BATCH_E6AXIS;
	POS BATCH_POS;
	int DO_MASK;
	int DO_VALUE;
	double DO_SETSEC;
	int BATCH_ACTION;
	double BATCH_ROUNDM;
};

class KukaRobotArm
{
private:
	TCPSocket krc4sock;
	KukaVarProxyMsg kvp_msg;
	mutex sock_mu;
	mutex value_mu;

	int last_read_slow_member_pos;

	// Default member
	double default_mov_roundm;

	// Serial string to value
	int extractValueByTag(const string serialvalue, const string tag, double* pval);
	int extractValueByTag(const string serialvalue, const string tag, int* pval);
	int extractValueByTag(const string serialvalue, const string tag, bool* pval);
	int extractValueByTag(const string serialvalue, const string tag, string* pval);
	int extractValueByTag(const string serialvalue, const string tag, E6AXIS* pval);
	int extractValueByTag(const string serialvalue, const string tag, E6POS* pval);
	int extractValueByTag(const string serialvalue, const string tag, POS* pval);
	int extractValueByTag(const string serialvalue, const string tag, FRAME* pval);
	int writeMemberBySerializeValue(const string name, const string serialvalue);

	// Value to serial string
	string ToSerializeValue(const double* pvalue);
	string ToSerializeValue(const int* pvalue);
	string ToSerializeValue(const bool* pvalue);
	string ToSerializeValue(const AXIS* pvalue);
	string ToSerializeValue(const E6AXIS* pvalue);
	string ToSerializeValue(const FRAME* pvalue);
	string ToSerializeValue(const POS* pvalue);
	string ToSerializeValue(const E6POS* pvalue);
	string ToSerializeValue(const PAYLOAD* pvalue);
	string ToSerializeValue(const BATCH_MOV_BLK* pvalue);

public:
	KukaRobotArm();
	virtual ~KukaRobotArm();

	int writeVarToKrc4(const string name, const string serialvalue);
	int readVarFromKrc4(const string name, string* pserialvalue);
	int connectKrc4(const string ipAddress);
	int disconnectKrc4();

	int moveJ(POS* pose);
	int moveJ(E6AXIS* joints);
	int moveL(POS* pose);
	int moveL(E6AXIS* joints);
	int moveJRel(POS* deltapose);
	int moveJRel(E6AXIS* deltajoints);
	int moveLRel(POS* deltapose);
	int moveJRelTool(POS* deltapose);
	int moveJRelTool(E6AXIS* deltajoints);
	int moveLRelTool(POS* deltapose);
	int setDigitalOutput(int mask, int value, double settle_sec);

	int batchMoveJSetup(POS* pose, double round, int BlockNum);
	int batchMoveJSetup(E6AXIS* joints, double round, int BlockNum);
	int batchMoveLSetup(POS* pose, double round, int BlockNum);
	int batchMoveLSetup(E6AXIS* joints, double round, int BlockNum);
	int batchMoveJRelSetup(POS* deltapose, double round, int BlockNum);
	int batchMoveJRelSetup(E6AXIS* deltajoints, double round, int BlockNum);
	int batchMoveLRelSetup(POS* deltapose, double round, int BlockNum);
	int batchMoveJRelToolSetup(POS* deltapose, double round, int BlockNum);
	int batchMoveJRelToolSetup(E6AXIS* deltajoints, double round, int BlockNum);
	int batchMoveLRelToolSetup(POS* deltapose, double round, int BlockNum);
	int batchSetDigitalOutputSetup(int mask, int value, double settle_sec, int BlockNum);
	int batchMoveRun(int startBlockNum, int finBlockNum);

	int rampdown_stop(int mode);			// mode: 0-resume, 1-stop-pause, 2-stop-cancel
	int checkMotionCompleted();

	int setSpeedScale(int scale);
	int setDefaultMoveRound(double round);
	int setDefaultAccVel(double acc, double acc_swivel, double acc_rot, double vel, double vel_swivel, double vel_rol);
	int setPayload(PAYLOAD* load, PAYLOAD* load_a1, PAYLOAD* load_a2, PAYLOAD* load_a3);
	int setBaseCoord(POS* pose);
	int setToolCoord(POS* pose);

	int convertJointsToPose(POS* pose, E6AXIS* joints);

	int startAutoExternalMode();
	int setMoveEnableSignal(bool state);

	int updateAllMember();
/*	const string member = 	"$AXIS_ACT $AXIS_ACT_MEAS $POS_ACT $POS_ACT_MES "
			"$DIST_NEXT $VEL_ACT $VEL_AXIS_ACT[] $CURR_ACT[] $MOT_TEMP[] "
			"COM_ACTION COM_MOTSTOP COM_LAST_MOT_TIME "
			"COM_DI_PORT_VALUE COM_DO_PORT_VALUE ";
			//"COM_E6AXIS COM_POS COM_E6AXIS_DELTA COM_POS_DELTA COM_BATCH_MOV_CURR_BLK ";
	const string slow_member = //"$LOAD $LOAD_A1 $LOAD_A2 $LOAD_A3 "
			"$MODE_OP $OV_PRO $POWER_FAIL $BRAKE_SIG "
			"COM_MOVE_ENABLE COM_AUTEXT_START "
			"COM_ERROR_NO COM_ALARM_NORMAL ";*/

	// kuka robot state variables (mirror of krc4)
	E6AXIS  axis_act;						// "$AXIS_ACT"		// setp {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
	E6AXIS  axis_act_meas;					// "$AXIS_ACT_MEAS"
	E6POS   pos_act;						// "$POS_ACT"		// setp {E6POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, S 6, T 19, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
	E6POS   pos_act_mes;					// "$POS_ACT_MES"

	double  dist_next;						// "$DIST_NEXT"		// distance to next point -875.0
	double  vel_act;						// "$VEL_ACT"		// 1.5

	double  vel_axis_act[6];				// "$VEL_AXIS_ACT[1~6]"		// [0~5] %
	double  curr_act[6];					// "$CURR_ACT[1~6]"	// [0~5] %
	int  mot_temp[6];						// "$MOT_TEMP[1~6]"	// [0~5] (K) to (C)

	string  mode_op;						// "$MODE_OP"		// #T1/T2/AUT/EX
	int     ov_pro;							// "$OV_PRO"		// 100
	bool    power_fail;						// "$POWER_FAIL"	// TRUE/FALSE
	int     brake_sig;						// "$BRAKE_SIG"		// B100000

	// No sync
	PAYLOAD load;							// "$LOAD"			// advance run {M Mass , CM Center of gravity , J Inertia}
	PAYLOAD load_a1;						// "$LOAD_A1"
	PAYLOAD load_a2;						// "$LOAD_A2"
	PAYLOAD load_a3;						// "$LOAD_A3"

	APO     apo;							// "$APO"			// Approximation parameters CPTP/CDIS
	VEL     vel;							// "$VEL"			// advance run vel limit
	double  vel_axis[6];					// "$VEL_AXIS"		// advance run vel limit
	bool    rvm;							// "$RVM"			// avoid resonance if pos too close TRUE/FALSE
	unsigned short  torqmon;				// "$TORQMON"		// 200
	unsigned short  torqmon_com;			// "$TORQMON_COM"	// 200
	double  torque_axis_act[6];				// "$TORQUE_AXIS_ACT[1~6]"	// 10.0 (Nm)

	string  safety_sw;						// "$SAFETY_SW"		// #PRESSED/RELEASED
	ERROR_T err;							// "$ERR"

	// Interface program cmd variables (mirror of krc4)
	int     com_actcnt;						// "COM_ACTCNT";
	int     com_action;						// "COM_ACTION";
	double  com_roundm;						// "COM_ROUNDM";
	double  com_value1;						// "COM_VALUE1";
	double  com_value2;						// "COM_VALUE2";
	double  com_value3;						// "COM_VALUE3";
	double  com_value4;						// "COM_VALUE4";
	E6AXIS  com_e6axis;						// "COM_E6AXIS";
	FRAME   com_frame;						// "COM_FRAME";
	POS     com_pos;						// "COM_POS";

	E6AXIS  com_e6axis_delta;				// "COM_E6AXIS_DELTA";
	POS     com_pos_delta;					// "COM_POS_DELTA";

	int    com_motstop;						// "COM_MOTSTOP";
	int    com_error_no;					// "COM_ERROR_NO"
	bool   com_alarm_normal;				// "COM_ALARM_NORMAL"

	int    com_batch_mov_sta_blk;			// "COM_BATCH_MOV_STA_BLK";
	int    com_batch_mov_end_blk;			// "COM_BATCH_MOV_END_BLK";
	int    com_batch_mov_curr_blk;			// "COM_BATCH_MOV_CURR_BLK";

	int    com_last_mot_time;				// "COM_LAST_MOT_TIME" // time elapsed

	bool   com_move_enable;				    // "COM_MOVE_ENABLE"   // for auto ext mode
	bool   com_autext_start;				// "COM_AUTEXT_START"  // for auto ext mode

	int    com_di_port_value;				// "COM_DI_PORT_VALUE"	// 16 $IN ports value
	int    com_do_port_value;				// "COM_DO_PORT_VALUE"	// 16 $OUT ports value

	string krc4_ipAddress;
};

#endif /* KUKA_ROBOT_SRC_KUKAROBOTARM_H_ */
