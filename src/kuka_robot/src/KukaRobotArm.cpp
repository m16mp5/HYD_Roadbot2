/*
 * KukaRobotArm.cpp
 *
 *  Created on: 5 Jun 2019
 *      Author: IY
 */

#include "KukaRobotArm.h"

#include <cstring>
#include <iomanip>
#include <iostream>
#include <unistd.h>

KukaRobotArm::KukaRobotArm()
{
	// kuka robot variables
	memset((void*)&axis_act, 0, sizeof(axis_act));
	memset((void*)&axis_act_meas, 0, sizeof(axis_act_meas));
	memset((void*)&pos_act, 0, sizeof(pos_act));
	memset((void*)&pos_act_mes, 0, sizeof(pos_act_mes));

	dist_next = 0;
	vel_act = 0;
	memset(vel_axis_act, 0, sizeof(vel_axis_act));
	memset(curr_act, 0, sizeof(curr_act));
	memset(mot_temp, 0, sizeof(mot_temp));

	mode_op = "#T1";
	ov_pro = 0;
	power_fail = 0;
	safety_sw = "#RELEASED";
	brake_sig = 0;

	memset((void*)&load, 0, sizeof(load));
	memset((void*)&load_a1, 0, sizeof(load_a1));
	memset((void*)&load_a2, 0, sizeof(load_a2));
	memset((void*)&load_a3, 0, sizeof(load_a3));

	err.number = 0;
	err.int_prio = 0;
	err.line_nr = 0;

	memset((void*)&apo, 0, sizeof(apo));
	memset((void*)&vel, 0, sizeof(vel));
	memset(vel_axis, 0 ,sizeof(vel_axis));
	rvm = 0;
	torqmon = 0;
	torqmon_com = 0;
	memset(torque_axis_act, 0, sizeof(torque_axis_act));

	// Interface driver program variables
	com_actcnt = 0;
	com_action = 0;
	com_roundm = 0;
	com_value1 = 0;
	com_value2 = 0;
	com_value3 = 0;
	com_value4 = 0;
	memset((void*)&com_e6axis, 0, sizeof(com_e6axis));
	memset((void*)&com_frame, 0, sizeof(com_frame));
	memset((void*)&com_pos, 0, sizeof(com_pos));

	com_motstop = 0;

	com_batch_mov_sta_blk = 0;
	com_batch_mov_end_blk = 0;
	com_batch_mov_curr_blk = 0;

	com_last_mot_time = 0;

	default_mov_roundm = 100;

	last_read_slow_member_pos = 0;

	com_move_enable = true;
	com_autext_start = false;
	com_error_no = 0;
	com_alarm_normal = true;

	com_di_port_value = 0;
	com_do_port_value = 0;
}

KukaRobotArm::~KukaRobotArm()
{
	disconnectKrc4();
}

int KukaRobotArm::connectKrc4(const string ipAddress)
{
	try
	{
		krc4_ipAddress = ipAddress;
		krc4sock.connect(ipAddress, KVP_TCPPORT);
	}
	catch(SocketException &e)
	{
		cerr << e.what() << endl;
		return -1;
	}
	return 0;
}

int KukaRobotArm::readVarFromKrc4(const string name, string* pserialvalue)
{
	int retval = 0;
	int bytesReceived = 0;

	pserialvalue->clear();

	sock_mu.lock();
	kvp_msg.name = name;
	kvp_msg.value = "0";
	try
	{
		unsigned char* sendbuf = kvp_msg.formatReadMsg();
		krc4sock.send(sendbuf, kvp_msg.msgLen + KUKAVARPROXYMSG_OVHEAD);
		bytesReceived = krc4sock.recv(kvp_msg.buf, KUKAVARPROXYMSG_BUFLEN);
	}
	catch(SocketException &e)
	{
		cerr << e.what() << endl;
		retval = -3;
	}
	sock_mu.unlock();

	if (bytesReceived)
	{
		if (kvp_msg.formatMsgToVar())
			retval = -4;
		else
			*pserialvalue = kvp_msg.value;
	}
	else
		retval = -4;
	return retval;
}

int KukaRobotArm::writeVarToKrc4(const string name, const string serialvalue)
{
	int retval = 0;
	int bytesReceived = 0;
	KukaVarProxyMsg kvp_write_tmp_msg;				// temp write buff

	sock_mu.lock();
	kvp_write_tmp_msg.name = name;
	kvp_write_tmp_msg.value = serialvalue;
	try
	{
		unsigned char* sendbuf = kvp_write_tmp_msg.formatWriteMsg();
		krc4sock.send(sendbuf, kvp_write_tmp_msg.msgLen + KUKAVARPROXYMSG_OVHEAD);
		bytesReceived = krc4sock.recv(kvp_write_tmp_msg.buf, KUKAVARPROXYMSG_BUFLEN);
	}
	catch(SocketException &e)
	{
		cerr << e.what() << endl;
		retval = -5;
	}
	sock_mu.unlock();

	if (bytesReceived)
	{
		if (kvp_write_tmp_msg.formatMsgToVar())		// discard kvp_write_tmp_msg.value
			retval = -6;
	}
	else
		retval = -6;
	return retval;
}

int KukaRobotArm::disconnectKrc4()
{
	try
	{
		krc4sock.~Socket();
	}
	catch(SocketException &e)
	{
		cerr << e.what() << endl;
		return -2;
	}
	return 0;
}

///// Serial string to values
int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, double* pval)
{
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find(",", stpos);
		if (edpos < stpos)
			edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			string word = serialvalue.substr(stpos, edpos-stpos);
			*pval = stod(word);
			return 0;
		}
	}
	return -1;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, int* pval)
{
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find(",", stpos);
		if (edpos < stpos)
			edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			string word = serialvalue.substr(stpos, edpos-stpos);
			*pval = stoi(word);
			return 0;
		}
	}
	return -1;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, bool* pval)
{
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find(",", stpos);
		if (edpos < stpos)
			edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			string word = serialvalue.substr(stpos, edpos-stpos);
			*pval = (word == "TRUE")? true:false;
			return 0;
		}
	}
	return -1;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, string* pval)
{
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find(",", stpos);
		if (edpos < stpos)
			edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			string word = serialvalue.substr(stpos, edpos-stpos);
			*pval = word;
			return 0;
		}
	}
	return -1;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, E6AXIS* pval)
{
	int retval = 0;
	double dtemp;

	string struc_serialvalue = "";
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			struc_serialvalue = serialvalue.substr(stpos, edpos-stpos);
		}
		else
		{
			struc_serialvalue = "";
			return -1;
		}
	}

	// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, \
	//	E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
	if (extractValueByTag(struc_serialvalue, "A1 ", &dtemp)) retval = -1;
	else pval->A1 = dtemp;
	if (extractValueByTag(struc_serialvalue, "A2 ", &dtemp)) retval = -1;
	else pval->A2 = dtemp;
	if (extractValueByTag(struc_serialvalue, "A3 ", &dtemp)) retval = -1;
	else pval->A3 = dtemp;
	if (extractValueByTag(struc_serialvalue, "A4 ", &dtemp)) retval = -1;
	else pval->A4 = dtemp;
	if (extractValueByTag(struc_serialvalue, "A5 ", &dtemp)) retval = -1;
	else pval->A5 = dtemp;
	if (extractValueByTag(struc_serialvalue, "A6 ", &dtemp)) retval = -1;
	else pval->A6 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E1 ", &dtemp)) retval = -1;
	else pval->E1 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E2 ", &dtemp)) retval = -1;
	else pval->E2 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E3 ", &dtemp)) retval = -1;
	else pval->E3 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E4 ", &dtemp)) retval = -1;
	else pval->E4 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E5 ", &dtemp)) retval = -1;
	else pval->E5 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E6 ", &dtemp)) retval = -1;
	else pval->E6 = dtemp;

	return retval;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, E6POS* pval)
{
	int retval = 0;
	double dtemp;

	string struc_serialvalue = "";
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			struc_serialvalue = serialvalue.substr(stpos, edpos-stpos);
		}
		else
		{
			struc_serialvalue = "";
			return -1;
		}
	}

	// {E6POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
	//	S 6, T 19, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
	if (extractValueByTag(struc_serialvalue, "X ", &dtemp)) retval = -1;
	else pval->X = dtemp;
	if (extractValueByTag(struc_serialvalue, "Y ", &dtemp)) retval = -1;
	else pval->Y = dtemp;
	if (extractValueByTag(struc_serialvalue, "Z ", &dtemp)) retval = -1;
	else pval->Z = dtemp;
	if (extractValueByTag(struc_serialvalue, "A ", &dtemp)) retval = -1;
	else pval->A = dtemp;
	if (extractValueByTag(struc_serialvalue, "B ", &dtemp)) retval = -1;
	else pval->B = dtemp;
	if (extractValueByTag(struc_serialvalue, "C ", &dtemp)) retval = -1;
	else pval->C = dtemp;
	if (extractValueByTag(struc_serialvalue, "S ", &dtemp)) retval = -1;
	else pval->S = dtemp;
	if (extractValueByTag(struc_serialvalue, "T ", &dtemp)) retval = -1;
	else pval->T = dtemp;
	if (extractValueByTag(struc_serialvalue, "E1 ", &dtemp)) retval = -1;
	else pval->E1 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E2 ", &dtemp)) retval = -1;
	else pval->E2 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E3 ", &dtemp)) retval = -1;
	else pval->E3 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E4 ", &dtemp)) retval = -1;
	else pval->E4 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E5 ", &dtemp)) retval = -1;
	else pval->E5 = dtemp;
	if (extractValueByTag(struc_serialvalue, "E6 ", &dtemp)) retval = -1;
	else pval->E6 = dtemp;

	return retval;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, POS* pval)
{
	int retval = 0;
	double dtemp;

	string struc_serialvalue = "";
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			struc_serialvalue = serialvalue.substr(stpos, edpos-stpos);
		}
		else
		{
			struc_serialvalue = "";
			return -1;
		}
	}

	// {POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
	//	S 6, T 19}
	if (extractValueByTag(struc_serialvalue, "X ", &dtemp)) retval = -1;
	else pval->X = dtemp;
	if (extractValueByTag(struc_serialvalue, "Y ", &dtemp)) retval = -1;
	else pval->Y = dtemp;
	if (extractValueByTag(struc_serialvalue, "Z ", &dtemp)) retval = -1;
	else pval->Z = dtemp;
	if (extractValueByTag(struc_serialvalue, "A ", &dtemp)) retval = -1;
	else pval->A = dtemp;
	if (extractValueByTag(struc_serialvalue, "B ", &dtemp)) retval = -1;
	else pval->B = dtemp;
	if (extractValueByTag(struc_serialvalue, "C ", &dtemp)) retval = -1;
	else pval->C = dtemp;
	if (extractValueByTag(struc_serialvalue, "S ", &dtemp)) retval = -1;
	else pval->S = dtemp;
	if (extractValueByTag(struc_serialvalue, "T ", &dtemp)) retval = -1;
	else pval->T = dtemp;

	return retval;
}

int KukaRobotArm::extractValueByTag(const string serialvalue, const string tag, FRAME* pval)
{
	int retval = 0;
	double dtemp;

	string struc_serialvalue = "";
	int stpos, edpos;
	if ((stpos = serialvalue.find(tag, 0)) > 0)
	{
		edpos = serialvalue.find("}", stpos);
		if (edpos > stpos)
		{
			stpos += tag.length();
			struc_serialvalue = serialvalue.substr(stpos, edpos-stpos);
		}
		else
		{
			struc_serialvalue = "";
			return -1;
		}
	}

	// {FRAME: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908}
	if (extractValueByTag(struc_serialvalue, "X ", &dtemp)) retval = -1;
	else pval->X = dtemp;
	if (extractValueByTag(struc_serialvalue, "Y ", &dtemp)) retval = -1;
	else pval->Y = dtemp;
	if (extractValueByTag(struc_serialvalue, "Z ", &dtemp)) retval = -1;
	else pval->Z = dtemp;
	if (extractValueByTag(struc_serialvalue, "A ", &dtemp)) retval = -1;
	else pval->A = dtemp;
	if (extractValueByTag(struc_serialvalue, "B ", &dtemp)) retval = -1;
	else pval->B = dtemp;
	if (extractValueByTag(struc_serialvalue, "C ", &dtemp)) retval = -1;
	else pval->C = dtemp;

	return retval;
}

int KukaRobotArm::writeMemberBySerializeValue(const string name, const string serialvalue)
{
	int retval = 0;
	int itemp;
	double dtemp;
	bool btemp;
	string stemp;

	value_mu.lock();
	if (name == "KR_STATE")
	{
		// {KR_STATE_BLK:
		//    AXIS_ACT {E6AXIS: A1 -35.8241692, A2 -59.9256401, A3 152.869888, A4 65.9462509,
		//      A5 -92.5018616, A6 3.48265696, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0},
		//    AXIS_ACT_MEAS {E6AXIS: A1 -35.8241692, A2 -59.9256325, A3 152.869888, A4 65.9462509,
		//      A5 -92.5018311, A6 3.48270297, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0},
		//    POS_ACT {E6POS: X 0.0, Y 0.0, Z 0.0, A 0.0, B 0.0, C 0.0},
		//    POS_ACT_MES {E6POS: X 0.0, Y 0.0, Z 0.0, A 0.0, B 0.0, C 0.0},
		//    DIST_NEXT 0.0, VEL_ACT 0.0,
		//    VEL_AXIS_ACT1 -0.000443798432, VEL_AXIS_ACT2 -0.000508518540,
		//    VEL_AXIS_ACT3 -0.00133074936, VEL_AXIS_ACT4 0.0,
		//    VEL_AXIS_ACT5 0.0, VEL_AXIS_ACT6 0.0,
		//    CURR_ACT1 0.728368759, CURR_ACT2 -5.24163246, CURR_ACT3 1.51813030,
		//    CURR_ACT4 -1.87873840, CURR_ACT5 -5.35488129, CURR_ACT6 1.21593475,
		//    MOT_TEMP1 298.000, MOT_TEMP2 299.000, MOT_TEMP3 299.000,
		//    MOT_TEMP4 299.000, MOT_TEMP5 298.000, MOT_TEMP6 297.000,
		//    COM_ACTION 0, COM_MOTSTOP 0, COM_LAST_MOT_TIME 0, COM_DI_PORT_VALUE 8, COM_DO_PORT_VALUE 8,
		//    SMODE_OP #EX, OV_PRO 25, POWER_FAIL FALSE, BRAKE_SIG 63,
		//    COM_MOVE_ENABLE TRUE, COM_AUTEXT_START TRUE, COM_ERROR_NO 68, COM_ALARM_NORMAL TRUE
		// }"
		extractValueByTag(serialvalue, "AXIS_ACT {", &axis_act);
		extractValueByTag(serialvalue, "AXIS_ACT_MEAS {", &axis_act_meas);
		extractValueByTag(serialvalue, "POS_ACT {", &pos_act);
		extractValueByTag(serialvalue, "POS_ACT_MES {", &pos_act_mes);
		extractValueByTag(serialvalue, "DIST_NEXT ", &dist_next);
		extractValueByTag(serialvalue, "VEL_ACT ", &vel_act);
		extractValueByTag(serialvalue, "VEL_AXIS_ACT1 ", &vel_axis_act[0]);
		extractValueByTag(serialvalue, "VEL_AXIS_ACT2 ", &vel_axis_act[1]);
		extractValueByTag(serialvalue, "VEL_AXIS_ACT3 ", &vel_axis_act[2]);
		extractValueByTag(serialvalue, "VEL_AXIS_ACT4 ", &vel_axis_act[3]);
		extractValueByTag(serialvalue, "VEL_AXIS_ACT5 ", &vel_axis_act[4]);
		extractValueByTag(serialvalue, "VEL_AXIS_ACT6 ", &vel_axis_act[5]);
		extractValueByTag(serialvalue, "CURR_ACT1 ", &curr_act[0]);
		extractValueByTag(serialvalue, "CURR_ACT2 ", &curr_act[1]);
		extractValueByTag(serialvalue, "CURR_ACT3 ", &curr_act[2]);
		extractValueByTag(serialvalue, "CURR_ACT4 ", &curr_act[3]);
		extractValueByTag(serialvalue, "CURR_ACT5 ", &curr_act[4]);
		extractValueByTag(serialvalue, "CURR_ACT6 ", &curr_act[5]);
		extractValueByTag(serialvalue, "MOT_TEMP1 ", &mot_temp[0]);
		extractValueByTag(serialvalue, "MOT_TEMP2 ", &mot_temp[1]);
		extractValueByTag(serialvalue, "MOT_TEMP3 ", &mot_temp[2]);
		extractValueByTag(serialvalue, "MOT_TEMP4 ", &mot_temp[3]);
		extractValueByTag(serialvalue, "MOT_TEMP5 ", &mot_temp[4]);
		extractValueByTag(serialvalue, "MOT_TEMP6 ", &mot_temp[5]);
		mot_temp[0] -= 273;
		mot_temp[1] -= 273;
		mot_temp[2] -= 273;
		mot_temp[3] -= 273;
		mot_temp[4] -= 273;
		mot_temp[5] -= 273;
		extractValueByTag(serialvalue, "COM_ACTION ", &com_action);
		extractValueByTag(serialvalue, "COM_MOTSTOP ", &com_motstop);
		extractValueByTag(serialvalue, "COM_LAST_MOT_TIME ", &com_last_mot_time);
		extractValueByTag(serialvalue, "COM_DI_PORT_VALUE ", &com_di_port_value);
		extractValueByTag(serialvalue, "COM_DO_PORT_VALUE ", &com_do_port_value);
		extractValueByTag(serialvalue, "SMODE_OP ", &mode_op);
		extractValueByTag(serialvalue, "OV_PRO ", &ov_pro);
		extractValueByTag(serialvalue, "POWER_FAIL ", &power_fail);
		extractValueByTag(serialvalue, "BRAKE_SIG ", &brake_sig);
		extractValueByTag(serialvalue, "COM_MOVE_ENABLE ", &com_move_enable);
		extractValueByTag(serialvalue, "COM_AUTEXT_START ", &com_autext_start);
		extractValueByTag(serialvalue, "COM_ERROR_NO ", &com_error_no);
		extractValueByTag(serialvalue, "COM_ALARM_NORMAL ", &com_alarm_normal);
	}
	else if (name == "$AXIS_ACT")
	{
		// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, \
		//	E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
		retval = extractValueByTag(serialvalue, "{", &axis_act);
	}
	else if (name == "$AXIS_ACT_MEAS")
	{
		// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, \
		//	E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
		retval = extractValueByTag(serialvalue, "{", &axis_act_meas);
	}
	else if (name == "$POS_ACT")
	{
		// {E6POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
		//	S 6, T 19, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
		retval = extractValueByTag(serialvalue, "{", &pos_act);
	}
	else if (name == "$POS_ACT_MES")
	{
		// {E6POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
		//	S 6, T 19, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
		retval = extractValueByTag(serialvalue, "{", &pos_act_mes);
	}
	else if (name == "$DIST_NEXT")
	{
		// 1339.90503
		stringstream ss(serialvalue);
		ss >> dist_next;
	}
	else if (name == "$VEL_ACT")
	{
		// 1.90503
		stringstream ss(serialvalue);
		ss >> vel_act;
	}

	else if (name == "$VEL_AXIS_ACT[]")
	{
		// 19.9309063 19.9579868 -1.32582915 -0.0228880346 -10.3190498 0.294611961 0.0 ...
		stringstream ss(serialvalue);
		ss >> vel_axis_act[0];
		ss >> vel_axis_act[1];
		ss >> vel_axis_act[2];
		ss >> vel_axis_act[3];
		ss >> vel_axis_act[4];
		ss >> vel_axis_act[5];
	}
	else if (name == "$CURR_ACT[]")
	{
		// -9.35971737 -2.67664576 6.82473183 4.10318375 2.83718109 -6.09874725 0.0 ...
		stringstream ss(serialvalue);
		ss >> curr_act[0];
		ss >> curr_act[1];
		ss >> curr_act[2];
		ss >> curr_act[3];
		ss >> curr_act[4];
		ss >> curr_act[5];
	}
	else if (name == "$MOT_TEMP[]")
	{
		// 287 ...
		stringstream ss(serialvalue);
		ss >> mot_temp[0];
		ss >> mot_temp[1];
		ss >> mot_temp[2];
		ss >> mot_temp[3];
		ss >> mot_temp[4];
		ss >> mot_temp[5];
		mot_temp[0] -= 273;
		mot_temp[1] -= 273;
		mot_temp[2] -= 273;
		mot_temp[3] -= 273;
		mot_temp[4] -= 273;
		mot_temp[5] -= 273;
	}

	else if (name == "$MODE_OP")
	{
		// #T1/#T2/#AUT/#EX
		stringstream ss(serialvalue);
		ss >> mode_op;
	}
	else if (name == "$OV_PRO")
	{
		// 100
		stringstream ss(serialvalue);
		ss >> ov_pro;
	}
	else if (name == "$POWER_FAIL")
	{
		// TRUE/FALSE
		if (serialvalue == "TRUE")
			power_fail = true;
		else
			power_fail = false;
	}
	else if (name == "$BRAKE_SIG")
	{
		// 100
		stringstream ss(serialvalue);
		ss >> brake_sig;
	}
	else if (name == "$SAFETY_SW")
	{
		// #PRESSED/#RELEASED
		stringstream ss(serialvalue);
		ss >> safety_sw;
	}

	else if (name == "$LOAD")
	{
		// {LOAD: M 65.0000, CM {FRAME: X 180.000, Y 0.0, Z 150.000, A 0.0, B 0.0, C 0.0},
		//  J {INERTIA: X 19.5000, Y 19.5000, Z 19.5000}}
		if (extractValueByTag(serialvalue, "M ", &dtemp)) retval = -1;
		else load.Mass = dtemp;
		if (extractValueByTag(serialvalue, "X ", &dtemp)) retval = -1;
		else load.CenterOfGravity.X = dtemp;
		if (extractValueByTag(serialvalue, "Y ", &dtemp)) retval = -1;
		else load.CenterOfGravity.Y = dtemp;
		if (extractValueByTag(serialvalue, "Z ", &dtemp)) retval = -1;
		else load.CenterOfGravity.Z = dtemp;
		if (extractValueByTag(serialvalue, "A ", &dtemp)) retval = -1;
		else load.CenterOfGravity.A = dtemp;
		if (extractValueByTag(serialvalue, "B ", &dtemp)) retval = -1;
		else load.CenterOfGravity.B = dtemp;
		if (extractValueByTag(serialvalue, "C ", &dtemp)) retval = -1;
		else load.CenterOfGravity.C = dtemp;
		int stpos = serialvalue.find("INERTIA:", 0);
		string serialJvalue = serialvalue.substr(stpos);
		if (extractValueByTag(serialJvalue, "X ", &dtemp)) retval = -1;
		else load.Inertia.X = dtemp;
		if (extractValueByTag(serialJvalue, "Y ", &dtemp)) retval = -1;
		else load.Inertia.Y = dtemp;
		if (extractValueByTag(serialJvalue, "Z ", &dtemp)) retval = -1;
		else load.Inertia.Z = dtemp;
	}
	else if (name == "$LOAD_A2")
	{
		// {LOAD: M 65.0000, CM {FRAME: X 180.000, Y 0.0, Z 150.000, A 0.0, B 0.0, C 0.0},
		//  J {INERTIA: X 19.5000, Y 19.5000, Z 19.5000}}
		if (extractValueByTag(serialvalue, "M ", &dtemp)) retval = -1;
		else load_a2.Mass = dtemp;
		if (extractValueByTag(serialvalue, "X ", &dtemp)) retval = -1;
		else load_a2.CenterOfGravity.X = dtemp;
		if (extractValueByTag(serialvalue, "Y ", &dtemp)) retval = -1;
		else load_a2.CenterOfGravity.Y = dtemp;
		if (extractValueByTag(serialvalue, "Z ", &dtemp)) retval = -1;
		else load_a2.CenterOfGravity.Z = dtemp;
		if (extractValueByTag(serialvalue, "A ", &dtemp)) retval = -1;
		else load_a2.CenterOfGravity.A = dtemp;
		if (extractValueByTag(serialvalue, "B ", &dtemp)) retval = -1;
		else load_a2.CenterOfGravity.B = dtemp;
		if (extractValueByTag(serialvalue, "C ", &dtemp)) retval = -1;
		else load_a2.CenterOfGravity.C = dtemp;
		int stpos = serialvalue.find("INERTIA:", 0);
		string serialJvalue = serialvalue.substr(stpos);
		if (extractValueByTag(serialJvalue, "X ", &dtemp)) retval = -1;
		else load_a2.Inertia.X = dtemp;
		if (extractValueByTag(serialJvalue, "Y ", &dtemp)) retval = -1;
		else load_a2.Inertia.Y = dtemp;
		if (extractValueByTag(serialJvalue, "Z ", &dtemp)) retval = -1;
		else load_a2.Inertia.Z = dtemp;
	}
	else if (name == "$LOAD_A3")
	{
		// {LOAD: M 65.0000, CM {FRAME: X 180.000, Y 0.0, Z 150.000, A 0.0, B 0.0, C 0.0},
		//  J {INERTIA: X 19.5000, Y 19.5000, Z 19.5000}}
		if (extractValueByTag(serialvalue, "M ", &dtemp)) retval = -1;
		else load_a3.Mass = dtemp;
		if (extractValueByTag(serialvalue, "X ", &dtemp)) retval = -1;
		else load_a3.CenterOfGravity.X = dtemp;
		if (extractValueByTag(serialvalue, "Y ", &dtemp)) retval = -1;
		else load_a3.CenterOfGravity.Y = dtemp;
		if (extractValueByTag(serialvalue, "Z ", &dtemp)) retval = -1;
		else load_a3.CenterOfGravity.Z = dtemp;
		if (extractValueByTag(serialvalue, "A ", &dtemp)) retval = -1;
		else load_a3.CenterOfGravity.A = dtemp;
		if (extractValueByTag(serialvalue, "B ", &dtemp)) retval = -1;
		else load_a3.CenterOfGravity.B = dtemp;
		if (extractValueByTag(serialvalue, "C ", &dtemp)) retval = -1;
		else load_a3.CenterOfGravity.C = dtemp;
		int stpos = serialvalue.find("INERTIA:", 0);
		string serialJvalue = serialvalue.substr(stpos);
		if (extractValueByTag(serialJvalue, "X ", &dtemp)) retval = -1;
		else load_a3.Inertia.X = dtemp;
		if (extractValueByTag(serialJvalue, "Y ", &dtemp)) retval = -1;
		else load_a3.Inertia.Y = dtemp;
		if (extractValueByTag(serialJvalue, "Z ", &dtemp)) retval = -1;
		else load_a3.Inertia.Z = dtemp;
	}
	else if (name == "$ERR")
	{
		// {ERROR_T: NUMBER 0, INTERPRETER #R_INT, INT_TYPE #I_NORMAL, INT_PRIO 0, LINE_NR
		//  0, MODULE[] " ", UP_NAME[] " ", TRIGGER_TYPE #TRG_NONE}
		if (extractValueByTag(serialvalue, "NUMBER ", &itemp)) retval = -1;
		else err.number = itemp;
		if (extractValueByTag(serialvalue, "INTERPRETER ", &stemp)) retval = -1;
		else err.interpreter = stemp;
		if (extractValueByTag(serialvalue, "INT_TYPE ", &stemp)) retval = -1;
		else err.int_type = stemp;
		if (extractValueByTag(serialvalue, "INT_PRIO ", &itemp)) retval = -1;
		else err.int_prio = itemp;
		if (extractValueByTag(serialvalue, "LINE_NR ", &itemp)) retval = -1;
		else err.line_nr = itemp;
		if (extractValueByTag(serialvalue, "MODULE[] ", &stemp)) retval = -1;
		else err.module = stemp;
		if (extractValueByTag(serialvalue, "UP_NAME[] ", &stemp)) retval = -1;
		else err.up_name = stemp;
		if (extractValueByTag(serialvalue, "TRIGGER_TYPE ", &stemp)) retval = -1;
		else err.trigger_type = stemp;
	}

	// COM_ACTION COM_MOTSTOP COM_BATCH_MOV_CURR_BLK COM_ACTCNT
	else if (name == "COM_ACTION")
	{
		// 0~xx
		stringstream ss(serialvalue);
		ss >> com_action;
	}
	else if (name == "COM_MOTSTOP")
	{
		// 0~2
		stringstream ss(serialvalue);
		ss >> com_motstop;
	}
	else if (name == "COM_BATCH_MOV_CURR_BLK")
	{
		// 1~512
		stringstream ss(serialvalue);
		ss >> com_batch_mov_curr_blk;
	}
	else if (name == "COM_ACTCNT")
	{
		// 0~XXXXXXX
		stringstream ss(serialvalue);
		ss >> com_actcnt;
	}
	else if (name == "COM_LAST_MOT_TIME")
	{
		// 12~xxxxxxxms
		stringstream ss(serialvalue);
		ss >> com_last_mot_time;
	}
	else if (name == "COM_MOVE_ENABLE")
	{
		// TRUE/FALSE
		if (serialvalue == "TRUE")
			com_move_enable = true;
		else
			com_move_enable = false;
	}
	else if (name == "COM_AUTEXT_START")
	{
		// TRUE/FALSE
		if (serialvalue == "TRUE")
			com_autext_start = true;
		else
			com_autext_start = false;
	}
	else if (name == "COM_ALARM_NORMAL")
	{
		// TRUE/FALSE
		if (serialvalue == "TRUE")
			com_alarm_normal = true;
		else
			com_alarm_normal = false;
	}
	else if (name == "COM_ERROR_NO")
	{
		// 0~xxxxxxx
		stringstream ss(serialvalue);
		ss >> com_error_no;
	}
	else if (name == "COM_DI_PORT_VALUE")
	{
		// 0~xxxxxxx
		stringstream ss(serialvalue);
		ss >> com_di_port_value;
	}
	else if (name == "COM_DO_PORT_VALUE")
	{
		// 0~xxxxxxx
		stringstream ss(serialvalue);
		ss >> com_do_port_value;
	}

	else if (name == "COM_E6AXIS")
	{
		// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, \
		//	E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
		retval = extractValueByTag(serialvalue, "{", &com_e6axis);
	}
	else if (name == "COM_FRAME")
	{
		// {FRAME: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908}
		retval = extractValueByTag(serialvalue, "{", &com_frame);
	}
	else if (name == "COM_POS")
	{
		// {POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
		//	S 6, T 19}
		retval = extractValueByTag(serialvalue, "{", &com_pos);
	}
	else if (name == "COM_E6AXIS_DELTA")
	{
		// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, \
		//	E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
		retval = extractValueByTag(serialvalue, "{", &com_e6axis_delta);
	}
	else if (name == "COM_POS_DELTA")
	{
		// {POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
		//	S 6, T 19}
		retval = extractValueByTag(serialvalue, "{", &com_pos_delta);
	}
	else
		retval = -2;
	value_mu.unlock();
	return retval;
}

int KukaRobotArm::updateAllMember()
{
	int retval = 0;
	string value;
/*	string name, next_name;*/

	// Get update with KR_STATE struc
	int ret = 0;
	ret |= readVarFromKrc4("KR_STATE", &value);
	ret |= writeMemberBySerializeValue("KR_STATE", value);
	if (ret)
		retval -= 1;
	if (value.empty())
	{
		retval -= 1;
		cerr << "KR_STATE has not ready in krc4[" << krc4_ipAddress << "]." << endl;
	}

/*	// Get rt member every time
	stringstream ss(member);
	while (ss >> name)
	{
		int ret = 0;
		ret |= readVarFromKrc4(name, &value);
		ret |= writeMemberBySerializeValue(name, value);
		if (ret)
			retval -= 1;
		if (value.empty())
		{
			retval -= 1;
			cerr << "Variable:" << name << " has not ready in krc4[" << krc4_ipAddress << "]." << endl;
		}
	}

	// Get one slow update member per call
	int slow_member_pos = 0;
	stringstream ss_slow(slow_member);
	while (ss_slow >> name)
	{
		if (last_read_slow_member_pos == slow_member_pos)
		{
			last_read_slow_member_pos++;
			break;
		}
		slow_member_pos++;
	}

	if (!(ss_slow >> next_name))
	{
		last_read_slow_member_pos = 0;
	}

	int ret = 0;
	ret |= readVarFromKrc4(name, &value);
	ret |= writeMemberBySerializeValue(name, value);
	if (ret)
		retval -= 1;
	if (value.empty())
	{
		retval -= 1;
		cerr << "Variable:" << name << " has not ready in krc4[" << krc4_ipAddress << "]." << endl;
	}*/

	return retval;
}

///// Value to serial string
string KukaRobotArm::ToSerializeValue(const double* pvalue)
{
	return to_string(*pvalue);
}

string KukaRobotArm::ToSerializeValue(const int* pvalue)
{
	return to_string(*pvalue);
}

string KukaRobotArm::ToSerializeValue(const bool* pvalue)
{
	return (*pvalue)?"TRUE":"FALSE";
}

string KukaRobotArm::ToSerializeValue(const AXIS* pvalue)
{
	string serialvalue;
	// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0}
	serialvalue = "{AXIS: ";
	serialvalue += "A1 " + to_string(pvalue->A1) + ", ";
	serialvalue += "A2 " + to_string(pvalue->A2) + ", ";
	serialvalue += "A3 " + to_string(pvalue->A3) + ", ";
	serialvalue += "A4 " + to_string(pvalue->A4) + ", ";
	serialvalue += "A5 " + to_string(pvalue->A5) + ", ";
	serialvalue += "A6 " + to_string(pvalue->A6);
	serialvalue += "}";
	return serialvalue;
}

string KukaRobotArm::ToSerializeValue(const E6AXIS* pvalue)
{
	string serialvalue;
	// {E6AXIS: A1 0.0, A2 -90.0, A3 90.0, A4 0.0, A5 0.0, A6 0.0, \
	//	E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}
	serialvalue = "{E6AXIS: ";
	serialvalue += "A1 " + to_string(pvalue->A1) + ", ";
	serialvalue += "A2 " + to_string(pvalue->A2) + ", ";
	serialvalue += "A3 " + to_string(pvalue->A3) + ", ";
	serialvalue += "A4 " + to_string(pvalue->A4) + ", ";
	serialvalue += "A5 " + to_string(pvalue->A5) + ", ";
	serialvalue += "A6 " + to_string(pvalue->A6) + ", ";
	serialvalue += "E1 " + to_string(pvalue->E1) + ", ";
	serialvalue += "E2 " + to_string(pvalue->E2) + ", ";
	serialvalue += "E3 " + to_string(pvalue->E3) + ", ";
	serialvalue += "E4 " + to_string(pvalue->E4) + ", ";
	serialvalue += "E5 " + to_string(pvalue->E5) + ", ";
	serialvalue += "E6 " + to_string(pvalue->E6);
	serialvalue += "}";
	return serialvalue;
}

string KukaRobotArm::ToSerializeValue(const FRAME* pvalue)
{
	string serialvalue;
	// {FRAME: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908}
	serialvalue = "{FRAME: ";
	serialvalue += "X " + to_string(pvalue->X) + ", ";
	serialvalue += "Y " + to_string(pvalue->Y) + ", ";
	serialvalue += "Z " + to_string(pvalue->Z) + ", ";
	serialvalue += "A " + to_string(pvalue->A) + ", ";
	serialvalue += "B " + to_string(pvalue->B) + ", ";
	serialvalue += "C " + to_string(pvalue->C);
	serialvalue += "}";
	return serialvalue;
}

string KukaRobotArm::ToSerializeValue(const POS* pvalue)
{
	string serialvalue;
	// {POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
	//	S 6, T 19}
	serialvalue = "{POS: ";
	serialvalue += "X " + to_string(pvalue->X) + ", ";
	serialvalue += "Y " + to_string(pvalue->Y) + ", ";
	serialvalue += "Z " + to_string(pvalue->Z) + ", ";
	serialvalue += "A " + to_string(pvalue->A) + ", ";
	serialvalue += "B " + to_string(pvalue->B) + ", ";
	serialvalue += "C " + to_string(pvalue->C) + ", ";
	serialvalue += "S " + to_string(pvalue->S) + ", ";
	serialvalue += "T " + to_string(pvalue->T);
	serialvalue += "}";
	return serialvalue;
}

string KukaRobotArm::ToSerializeValue(const E6POS* pvalue)
{
	string serialvalue;
	// {E6POS: X 1339.90503, Y 15.9216757, Z 1787.32227, A 0.0, B 89.9999466, C -0.680795908, \
	//	S 6, T 19, E1...E6}
	serialvalue = "{POS: ";
	serialvalue += "X " + to_string(pvalue->X) + ", ";
	serialvalue += "Y " + to_string(pvalue->Y) + ", ";
	serialvalue += "Z " + to_string(pvalue->Z) + ", ";
	serialvalue += "A " + to_string(pvalue->A) + ", ";
	serialvalue += "B " + to_string(pvalue->B) + ", ";
	serialvalue += "C " + to_string(pvalue->C) + ", ";
	serialvalue += "S " + to_string(pvalue->S) + ", ";
	serialvalue += "T " + to_string(pvalue->T) + ", ";
	serialvalue += "E1 " + to_string(pvalue->E1) + ", ";
	serialvalue += "E2 " + to_string(pvalue->E2) + ", ";
	serialvalue += "E3 " + to_string(pvalue->E3) + ", ";
	serialvalue += "E4 " + to_string(pvalue->E4) + ", ";
	serialvalue += "E5 " + to_string(pvalue->E5) + ", ";
	serialvalue += "E6 " + to_string(pvalue->E6);
	serialvalue += "}";
	return serialvalue;
}

string KukaRobotArm::ToSerializeValue(const PAYLOAD* pvalue)
{
	string serialvalue;
	// {LOAD: M 65.0000, CM {FRAME: X 180.000, Y 0.0, Z 150.000, A 0.0, B 0.0, C 0.0},
	//  J {INERTIA: X 19.5000, Y 19.5000, Z 19.5000}}
	serialvalue = "{LOAD: ";
	serialvalue += "M " + to_string(pvalue->Mass) + ", CM {FRAME: ";
	serialvalue += "X " + to_string(pvalue->CenterOfGravity.X) + ", ";
	serialvalue += "Y " + to_string(pvalue->CenterOfGravity.Y) + ", ";
	serialvalue += "Z " + to_string(pvalue->CenterOfGravity.Z) + ", ";
	serialvalue += "A " + to_string(pvalue->CenterOfGravity.A) + ", ";
	serialvalue += "B " + to_string(pvalue->CenterOfGravity.B) + ", ";
	serialvalue += "C " + to_string(pvalue->CenterOfGravity.C) + "}, J {INERTIA: ";
	serialvalue += "X " + to_string(pvalue->Inertia.X) + ", ";
	serialvalue += "Y " + to_string(pvalue->Inertia.Y) + ", ";
	serialvalue += "Z " + to_string(pvalue->Inertia.Z);
	serialvalue += "}}";
	return serialvalue;
}

string KukaRobotArm::ToSerializeValue(const BATCH_MOV_BLK* pvalue)
{
	string serialvalue;
	// {BATCH_MOV_BLK: BATCH_E6AXIS {E6AXIS: A1 0.0, A2 0.0, A3 0.0, A4 0.0, A5 0.0, A6 0.0, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0},
	//	BATCH_POS {POS: X 1.0, Y 1.0, Z 1.0, A 0.0, B 90.0, C 0.0, S 6, T 19},
	//	DO_MASK 16, DO_VALUE 16, DO_SETSEC 0.1, BATCH_ACTION 2, BATCH_ROUNDM 100.0}
	serialvalue = "{BATCH_MOV_BLK: BATCH_E6AXIS {E6AXIS: ";
	serialvalue += "A1 " + to_string(pvalue->BATCH_E6AXIS.A1) + ", ";
	serialvalue += "A2 " + to_string(pvalue->BATCH_E6AXIS.A2) + ", ";
	serialvalue += "A3 " + to_string(pvalue->BATCH_E6AXIS.A3) + ", ";
	serialvalue += "A4 " + to_string(pvalue->BATCH_E6AXIS.A4) + ", ";
	serialvalue += "A5 " + to_string(pvalue->BATCH_E6AXIS.A5) + ", ";
	serialvalue += "A6 " + to_string(pvalue->BATCH_E6AXIS.A6) + ", ";
	serialvalue += "E1 " + to_string(pvalue->BATCH_E6AXIS.E1) + ", ";
	serialvalue += "E2 " + to_string(pvalue->BATCH_E6AXIS.E2) + ", ";
	serialvalue += "E3 " + to_string(pvalue->BATCH_E6AXIS.E3) + ", ";
	serialvalue += "E4 " + to_string(pvalue->BATCH_E6AXIS.E4) + ", ";
	serialvalue += "E5 " + to_string(pvalue->BATCH_E6AXIS.E5) + ", ";
	serialvalue += "E6 " + to_string(pvalue->BATCH_E6AXIS.E6) + "}, BATCH_POS {POS: ";
	serialvalue += "X " + to_string(pvalue->BATCH_POS.X) + ", ";
	serialvalue += "Y " + to_string(pvalue->BATCH_POS.Y) + ", ";
	serialvalue += "Z " + to_string(pvalue->BATCH_POS.Z) + ", ";
	serialvalue += "A " + to_string(pvalue->BATCH_POS.A) + ", ";
	serialvalue += "B " + to_string(pvalue->BATCH_POS.B) + ", ";
	serialvalue += "C " + to_string(pvalue->BATCH_POS.C) + ", ";
	serialvalue += "S " + to_string(pvalue->BATCH_POS.S) + ", ";
	serialvalue += "T " + to_string(pvalue->BATCH_POS.T) + "}, ";
	serialvalue += "DO_MASK " + to_string(pvalue->DO_MASK) + ", ";
	serialvalue += "DO_VALUE " + to_string(pvalue->DO_VALUE) + ", ";
	serialvalue += "DO_SETSEC " + to_string(pvalue->DO_SETSEC) + ", ";
	serialvalue += "BATCH_ACTION " + to_string(pvalue->BATCH_ACTION) + ", ";
	serialvalue += "BATCH_ROUNDM " + to_string(pvalue->BATCH_ROUNDM);
	serialvalue += "}";
	return serialvalue;
}

int KukaRobotArm::moveJ(POS* pose)
{
	int action = MOVJ_BYPOSE_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_POS", ToSerializeValue(pose));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveJ(E6AXIS* joints)
{
	int action = MOVJ_BYJOINTS_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_E6AXIS", ToSerializeValue(joints));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveL(POS* pose)
{
	int action = MOVL_BYPOSE_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_POS", ToSerializeValue(pose));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveL(E6AXIS* joints)
{
	int action = MOVL_BYJOINTS_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_E6AXIS", ToSerializeValue(joints));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveJRel(POS* deltapose)
{
	int action = MOVJREL_BYPOSE_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_POS_DELTA", ToSerializeValue(deltapose));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveJRel(E6AXIS* deltajoints)
{
	int action = MOVJREL_BYJOINTS_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_E6AXIS_DELTA", ToSerializeValue(deltajoints));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveLRel(POS* deltapose)
{
	int action = MOVLREL_BYPOSE_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_POS_DELTA", ToSerializeValue(deltapose));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveJRelTool(POS* deltapose)
{
	int action = MOVJRELTOOL_BYPOSE_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_POS_DELTA", ToSerializeValue(deltapose));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveJRelTool(E6AXIS* deltajoints)
{
	int action = MOVJRELTOOL_BYJOINTS_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_E6AXIS_DELTA", ToSerializeValue(deltajoints));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::moveLRelTool(POS* deltapose)
{
	int action = MOVLRELTOOL_BYPOSE_ACTION_TYPE;
//	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	writeVarToKrc4("COM_POS_DELTA", ToSerializeValue(deltapose));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::setDigitalOutput(int mask, int value, double settle_sec)
{
	int action = DO_ACTION_TYPE;
	writeVarToKrc4("COM_DO_MASK", ToSerializeValue(&mask));
	writeVarToKrc4("COM_DO_VALUE", ToSerializeValue(&value));
	writeVarToKrc4("COM_DO_SETSEC", ToSerializeValue(&settle_sec));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}


int KukaRobotArm::batchMoveJSetup(POS* pose, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_POS.X = pose->X;
	temp_blk.BATCH_POS.Y = pose->Y;
	temp_blk.BATCH_POS.Z = pose->Z;
	temp_blk.BATCH_POS.A = pose->A;
	temp_blk.BATCH_POS.B = pose->B;
	temp_blk.BATCH_POS.C = pose->C;
	temp_blk.BATCH_POS.S = pose->S;
	temp_blk.BATCH_POS.T = pose->T;
	temp_blk.BATCH_ACTION = MOVJ_BYPOSE_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveJSetup(E6AXIS* joints, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_E6AXIS.A1 = joints->A1;
	temp_blk.BATCH_E6AXIS.A2 = joints->A2;
	temp_blk.BATCH_E6AXIS.A3 = joints->A3;
	temp_blk.BATCH_E6AXIS.A4 = joints->A4;
	temp_blk.BATCH_E6AXIS.A5 = joints->A5;
	temp_blk.BATCH_E6AXIS.A6 = joints->A6;
	temp_blk.BATCH_E6AXIS.E1 = joints->E1;
	temp_blk.BATCH_E6AXIS.E2 = joints->E2;
	temp_blk.BATCH_E6AXIS.E3 = joints->E3;
	temp_blk.BATCH_E6AXIS.E4 = joints->E4;
	temp_blk.BATCH_E6AXIS.E5 = joints->E5;
	temp_blk.BATCH_E6AXIS.E6 = joints->E6;
	temp_blk.BATCH_ACTION = MOVJ_BYJOINTS_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveLSetup(POS* pose, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_POS.X = pose->X;
	temp_blk.BATCH_POS.Y = pose->Y;
	temp_blk.BATCH_POS.Z = pose->Z;
	temp_blk.BATCH_POS.A = pose->A;
	temp_blk.BATCH_POS.B = pose->B;
	temp_blk.BATCH_POS.C = pose->C;
	temp_blk.BATCH_POS.S = pose->S;
	temp_blk.BATCH_POS.T = pose->T;
	temp_blk.BATCH_ACTION = MOVL_BYPOSE_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveLSetup(E6AXIS* joints, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_E6AXIS.A1 = joints->A1;
	temp_blk.BATCH_E6AXIS.A2 = joints->A2;
	temp_blk.BATCH_E6AXIS.A3 = joints->A3;
	temp_blk.BATCH_E6AXIS.A4 = joints->A4;
	temp_blk.BATCH_E6AXIS.A5 = joints->A5;
	temp_blk.BATCH_E6AXIS.A6 = joints->A6;
	temp_blk.BATCH_E6AXIS.E1 = joints->E1;
	temp_blk.BATCH_E6AXIS.E2 = joints->E2;
	temp_blk.BATCH_E6AXIS.E3 = joints->E3;
	temp_blk.BATCH_E6AXIS.E4 = joints->E4;
	temp_blk.BATCH_E6AXIS.E5 = joints->E5;
	temp_blk.BATCH_E6AXIS.E6 = joints->E6;
	temp_blk.BATCH_ACTION = MOVL_BYJOINTS_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveJRelSetup(POS* deltapose, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_POS.X = deltapose->X;
	temp_blk.BATCH_POS.Y = deltapose->Y;
	temp_blk.BATCH_POS.Z = deltapose->Z;
	temp_blk.BATCH_POS.A = deltapose->A;
	temp_blk.BATCH_POS.B = deltapose->B;
	temp_blk.BATCH_POS.C = deltapose->C;
	temp_blk.BATCH_POS.S = deltapose->S;
	temp_blk.BATCH_POS.T = deltapose->T;
	temp_blk.BATCH_ACTION = MOVJREL_BYPOSE_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveJRelSetup(E6AXIS* deltajoints, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_E6AXIS.A1 = deltajoints->A1;
	temp_blk.BATCH_E6AXIS.A2 = deltajoints->A2;
	temp_blk.BATCH_E6AXIS.A3 = deltajoints->A3;
	temp_blk.BATCH_E6AXIS.A4 = deltajoints->A4;
	temp_blk.BATCH_E6AXIS.A5 = deltajoints->A5;
	temp_blk.BATCH_E6AXIS.A6 = deltajoints->A6;
	temp_blk.BATCH_E6AXIS.E1 = deltajoints->E1;
	temp_blk.BATCH_E6AXIS.E2 = deltajoints->E2;
	temp_blk.BATCH_E6AXIS.E3 = deltajoints->E3;
	temp_blk.BATCH_E6AXIS.E4 = deltajoints->E4;
	temp_blk.BATCH_E6AXIS.E5 = deltajoints->E5;
	temp_blk.BATCH_E6AXIS.E6 = deltajoints->E6;
	temp_blk.BATCH_ACTION = MOVJREL_BYJOINTS_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveLRelSetup(POS* deltapose, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_POS.X = deltapose->X;
	temp_blk.BATCH_POS.Y = deltapose->Y;
	temp_blk.BATCH_POS.Z = deltapose->Z;
	temp_blk.BATCH_POS.A = deltapose->A;
	temp_blk.BATCH_POS.B = deltapose->B;
	temp_blk.BATCH_POS.C = deltapose->C;
	temp_blk.BATCH_POS.S = deltapose->S;
	temp_blk.BATCH_POS.T = deltapose->T;
	temp_blk.BATCH_ACTION = MOVLREL_BYPOSE_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveJRelToolSetup(POS* deltapose, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_POS.X = deltapose->X;
	temp_blk.BATCH_POS.Y = deltapose->Y;
	temp_blk.BATCH_POS.Z = deltapose->Z;
	temp_blk.BATCH_POS.A = deltapose->A;
	temp_blk.BATCH_POS.B = deltapose->B;
	temp_blk.BATCH_POS.C = deltapose->C;
	temp_blk.BATCH_POS.S = deltapose->S;
	temp_blk.BATCH_POS.T = deltapose->T;
	temp_blk.BATCH_ACTION = MOVJRELTOOL_BYPOSE_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveJRelToolSetup(E6AXIS* deltajoints, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_E6AXIS.A1 = deltajoints->A1;
	temp_blk.BATCH_E6AXIS.A2 = deltajoints->A2;
	temp_blk.BATCH_E6AXIS.A3 = deltajoints->A3;
	temp_blk.BATCH_E6AXIS.A4 = deltajoints->A4;
	temp_blk.BATCH_E6AXIS.A5 = deltajoints->A5;
	temp_blk.BATCH_E6AXIS.A6 = deltajoints->A6;
	temp_blk.BATCH_E6AXIS.E1 = deltajoints->E1;
	temp_blk.BATCH_E6AXIS.E2 = deltajoints->E2;
	temp_blk.BATCH_E6AXIS.E3 = deltajoints->E3;
	temp_blk.BATCH_E6AXIS.E4 = deltajoints->E4;
	temp_blk.BATCH_E6AXIS.E5 = deltajoints->E5;
	temp_blk.BATCH_E6AXIS.E6 = deltajoints->E6;
	temp_blk.BATCH_ACTION = MOVJRELTOOL_BYJOINTS_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchMoveLRelToolSetup(POS* deltapose, double round, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.BATCH_POS.X = deltapose->X;
	temp_blk.BATCH_POS.Y = deltapose->Y;
	temp_blk.BATCH_POS.Z = deltapose->Z;
	temp_blk.BATCH_POS.A = deltapose->A;
	temp_blk.BATCH_POS.B = deltapose->B;
	temp_blk.BATCH_POS.C = deltapose->C;
	temp_blk.BATCH_POS.S = deltapose->S;
	temp_blk.BATCH_POS.T = deltapose->T;
	temp_blk.BATCH_ACTION = MOVLRELTOOL_BYPOSE_ACTION_TYPE;
	temp_blk.BATCH_ROUNDM = round;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);
}

int KukaRobotArm::batchSetDigitalOutputSetup(int mask, int value, double settle_sec, int BlockNum)
{
	if ((BlockNum > BATCH_MOV_MAX_BLOCK) || (BlockNum <= 0))
		return 1;

	string Blk_struct_name = "COM_BATCH_MOV_BLK[" + to_string(BlockNum) + "]";
	BATCH_MOV_BLK temp_blk;
	memset((void*)&temp_blk, 0, sizeof(temp_blk));
	temp_blk.DO_MASK = mask;
	temp_blk.DO_VALUE = value;
	temp_blk.DO_SETSEC = settle_sec;
	temp_blk.BATCH_ACTION = DO_ACTION_TYPE;
	string Blk_struct_value = ToSerializeValue(&temp_blk);
	return writeVarToKrc4(Blk_struct_name, Blk_struct_value);

}

int KukaRobotArm::batchMoveRun(int startBlockNum, int endBlockNum)
{
	if ((startBlockNum > BATCH_MOV_MAX_BLOCK) || (startBlockNum <= 0))
		return 1;
	if ((endBlockNum > BATCH_MOV_MAX_BLOCK) || (endBlockNum <= 0))
		return 1;
	if (startBlockNum > endBlockNum)
		return 1;

	int action = 9;
	value_mu.lock();
	com_batch_mov_sta_blk = startBlockNum;
	com_batch_mov_end_blk = endBlockNum;
	value_mu.unlock();
	writeVarToKrc4("COM_BATCH_MOV_STA_BLK", ToSerializeValue(&startBlockNum));
	writeVarToKrc4("COM_BATCH_MOV_END_BLK", ToSerializeValue(&endBlockNum));
	writeVarToKrc4("COM_BATCH_MOV_CURR_BLK", ToSerializeValue(&startBlockNum));
	return writeVarToKrc4("COM_ACTION", ToSerializeValue(&action));
}

int KukaRobotArm::rampdown_stop(int mode)
{
	// mode: 0-resume, 1-stop-pause, 2-stop-cancel
	return writeVarToKrc4("COM_MOTSTOP", ToSerializeValue(&mode));
}

int KukaRobotArm::checkMotionCompleted()
{
	int retval, value;
	string serialvalue;

	retval = readVarFromKrc4("COM_ACTION", &serialvalue);
	if (retval || serialvalue.empty())
		return -1;

	stringstream ss(serialvalue);
	ss >> value;

	return value;			// completed = 0, otherwise == action num
}

int KukaRobotArm::setSpeedScale(int scale)
{
	scale = (scale > 100)?100:scale;
	scale = (scale < 0)?0:scale;
	return writeVarToKrc4("$OV_PRO", ToSerializeValue(&scale));
}

int KukaRobotArm::setDefaultMoveRound(double round)
{
	default_mov_roundm = round;
	writeVarToKrc4("COM_ROUNDM", ToSerializeValue(&default_mov_roundm));
	return 0;
}

int KukaRobotArm::setDefaultAccVel(double acc, double acc_swivel, double acc_rot, double vel, double vel_swivel, double vel_rol)
{
	writeVarToKrc4("SET_ACC_CP", ToSerializeValue(&acc));
	writeVarToKrc4("SET_ACC_ORI1", ToSerializeValue(&acc_swivel));
	writeVarToKrc4("SET_ACC_ORI2", ToSerializeValue(&acc_rot));
	writeVarToKrc4("SET_VEL_ORI1", ToSerializeValue(&vel_swivel));
	writeVarToKrc4("SET_VEL_ORI2", ToSerializeValue(&vel_rol));
	return writeVarToKrc4("SET_VEL_CP", ToSerializeValue(&vel));
}

int KukaRobotArm::setPayload(PAYLOAD* load, PAYLOAD* load_a1, PAYLOAD* load_a2, PAYLOAD* load_a3)
{
	writeVarToKrc4("LOAD_A1_DATA", ToSerializeValue(load_a1));
	writeVarToKrc4("LOAD_A2_DATA", ToSerializeValue(load_a2));
	writeVarToKrc4("LOAD_A3_DATA", ToSerializeValue(load_a3));
	return writeVarToKrc4("LOAD_DATA[1]", ToSerializeValue(load));
}

int KukaRobotArm::setBaseCoord(POS* pose)
{
	FRAME base;
	base.X = pose->X;
	base.Y = pose->Y;
	base.Z = pose->Z;
	base.A = pose->A;
	base.B = pose->B;
	base.C = pose->C;
	return writeVarToKrc4("BASE_DATA[1]", ToSerializeValue(&base));
}

int KukaRobotArm::setToolCoord(POS* pose)
{
	FRAME tool;
	tool.X = pose->X;
	tool.Y = pose->Y;
	tool.Z = pose->Z;
	tool.A = pose->A;
	tool.B = pose->B;
	tool.C = pose->C;
	return writeVarToKrc4("TOOL_DATA[1]", ToSerializeValue(&tool));
}

int KukaRobotArm::convertJointsToPose(POS* pose, E6AXIS* joints)
{
	int retval = 1;
	string serialvalue;
	double dtemp;

	writeVarToKrc4("COM_INT_E6AXIS", ToSerializeValue(joints));
	writeVarToKrc4("COM_INT_CONV", ToSerializeValue(&retval));

	retval = readVarFromKrc4("COM_INT_POS", &serialvalue);
	if (retval || serialvalue.empty())
		return -1;

	if (extractValueByTag(serialvalue, "X ", &dtemp)) retval = -1;
	else pose->X = dtemp;
	if (extractValueByTag(serialvalue, "Y ", &dtemp)) retval = -1;
	else pose->Y = dtemp;
	if (extractValueByTag(serialvalue, "Z ", &dtemp)) retval = -1;
	else pose->Z = dtemp;
	if (extractValueByTag(serialvalue, "A ", &dtemp)) retval = -1;
	else pose->A = dtemp;
	if (extractValueByTag(serialvalue, "B ", &dtemp)) retval = -1;
	else pose->B = dtemp;
	if (extractValueByTag(serialvalue, "C ", &dtemp)) retval = -1;
	else pose->C = dtemp;
	if (extractValueByTag(serialvalue, "S ", &dtemp)) retval = -1;
	else pose->S = dtemp;
	if (extractValueByTag(serialvalue, "T ", &dtemp)) retval = -1;
	else pose->T = dtemp;

	return 0;
}

int KukaRobotArm::startAutoExternalMode()
{
	setMoveEnableSignal(true);
	usleep(15000);
	return writeVarToKrc4("COM_AUTEXT_START", "TRUE");
}

int KukaRobotArm::setMoveEnableSignal(bool state)
{
	return writeVarToKrc4("COM_MOVE_ENABLE", ToSerializeValue(&state));
}

