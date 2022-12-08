/*
 * KukaVarProxyMsg.h
 *
 *  Created on: 5 Jun 2019
 *      Author: IY
 */

#ifndef KUKAVARPROXYMSG_H_
#define KUKAVARPROXYMSG_H_

#include <string>            			// For string

using namespace std;

/* kukavarproxy message format is
* msg ID in HEX                       2 bytes
* msg length in HEX                   2 bytes
* read (0) or write (1)               1 byte
* variable name length in HEX         2 bytes
* variable name in ASCII              # bytes
* variable value length in HEX        2 bytes
* variable value in ASCII             # bytes
*
* eg. {0x00, 0x01, 0x00, 0x0A, 0x00, 0x00, 0x07, 0x24, 0x4F, 0x56, 0x5F, 0x50, 0x52, 0x4F};
*/

#define KUKAVARPROXYMSG_OVHEAD			4
#define KUKAVARPROXYMSG_BUFLEN			10240

class KukaVarProxyMsg
{
private:
	unsigned short idCounter;

public:
	KukaVarProxyMsg();
	virtual ~KukaVarProxyMsg();

	unsigned char* formatReadMsg();
	unsigned char* formatWriteMsg();
	int formatMsgToVar();

	unsigned short msgID;
	unsigned short msgLen;
	unsigned char RW;

	unsigned short nameLen;
	string name;

	unsigned short valueLen;
	string value;

	unsigned char buf[KUKAVARPROXYMSG_BUFLEN];
};

#endif /* KUKAVARPROXYMSG_H_ */
