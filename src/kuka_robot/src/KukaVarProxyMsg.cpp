/*
 * KukaVarProxyMsg.cpp
 *
 *  Created on: 5 Jun 2019
 *      Author: IY
 */

#include "KukaVarProxyMsg.h"

#include <cstring>

KukaVarProxyMsg::KukaVarProxyMsg()
{
	srand(time(0));
	idCounter = rand();

	msgID = 0;
	msgLen = 0;

	RW = 0;

	nameLen = 0;
	name = "";

	valueLen = 0;
	value = "";

	memset(buf, 0, sizeof(buf));
}

KukaVarProxyMsg::~KukaVarProxyMsg()
{
}

unsigned char* KukaVarProxyMsg::formatReadMsg()
{
	msgID = ++idCounter;

	RW = 0;
	msgLen = 1;

	nameLen = strlen(name.c_str());
	msgLen += (2 + nameLen);

	buf[0] = (unsigned char)(msgID >> 8);
	buf[1] = (unsigned char)msgID;
	buf[2] = (unsigned char)(msgLen >> 8);
	buf[3] = (unsigned char)msgLen;
	buf[4] = (unsigned char)RW;
	buf[5] = (unsigned char)(nameLen >> 8);
	buf[6] = (unsigned char)nameLen;
	memcpy(&buf[7], name.c_str(), nameLen);

	return buf;
}

unsigned char* KukaVarProxyMsg::formatWriteMsg()
{
	msgID = ++idCounter;

	RW = 1;
	msgLen = 1;

	nameLen = strlen(name.c_str());
	msgLen += (2 + nameLen);

	valueLen = strlen(value.c_str());
	msgLen += (2 + valueLen);

	buf[0] = (unsigned char)(msgID >> 8);
	buf[1] = (unsigned char)msgID;
	buf[2] = (unsigned char)(msgLen >> 8);
	buf[3] = (unsigned char)msgLen;
	buf[4] = (unsigned char)RW;
	buf[5] = (unsigned char)(nameLen >> 8);
	buf[6] = (unsigned char)nameLen;
	memcpy(&buf[7], name.c_str(), nameLen);

	int buf_pos = 7 + nameLen;
	buf[buf_pos++] = (unsigned char)(valueLen >> 8);
	buf[buf_pos++] = (unsigned char)valueLen;
	memcpy(&buf[buf_pos], value.c_str(), valueLen);

	return buf;
}

int KukaVarProxyMsg::formatMsgToVar()
{
	char tmpbuf[KUKAVARPROXYMSG_BUFLEN];

	msgID = (unsigned short)((unsigned short)buf[0]<<8) + (unsigned short)buf[1];

	valueLen = (unsigned short)((unsigned short)buf[5]<<8) + (unsigned short)buf[6];
	memcpy(tmpbuf, &buf[7], valueLen);
	tmpbuf[valueLen] = 0;
	value = tmpbuf;

	if (buf[7+valueLen+2] != 1)
		return -1;

	return 0;
}
