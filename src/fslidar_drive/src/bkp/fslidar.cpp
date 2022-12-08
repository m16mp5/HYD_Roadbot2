#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

#include <sys/time.h>
#include <arpa/inet.h>

#include <ros/ros.h>
//#include <duration.h>

#include "fslidar.h"

#include <math.h>
#include <ros/package.h>
#include "std_msgs/Int8.h"
#include <fstream>

using namespace std;

//#define _FAKE
int log_server_sockfd;
int log_client_sockfd;
int portno;

#define BUFFER_SIZE 1500

static unsigned char cbit[256] = {
    0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
    3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
    4,5,5,6,5,6,6,7,5,6,6,7,6,7,7,8,
};


fslidar::fslidar(int align_cnt)
{
    s_fd = -1;
    ldConst.angle_min = -_M_PI + I_RAD / 16;;
    ldConst.angle_max = _M_PI;
    ldConst.angle_increment = _M_PI * 2 / align_cnt;
    ldConst.range_min = 0.0;
    ldConst.range_max = 40.0;
    ldConst.kDistance = 0.01;

	//
    recv_buf = new unsigned char [BUFFER_SIZE+4];
    memset((void *)recv_buf, 0, BUFFER_SIZE+4);
    buf_head = recv_buf;
    buf_rear = recv_buf;
}

fslidar::~fslidar()
{
	if(recv_buf){
		delete recv_buf;
		recv_buf = 0;
	}
}

void fslidar::connect(std::string host, int port)
{
  if (!connected_)
  {
    if ((socket_fd_ = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket error!!!");
        exit(1);
    }

    if (socket_fd_)
    {
      struct sockaddr_in stSockAddr;
      stSockAddr.sin_family = PF_INET;
      stSockAddr.sin_port = htons(port);
      inet_pton(AF_INET, host.c_str(), &stSockAddr.sin_addr);

      int ret = ::connect(socket_fd_, (struct sockaddr *) &stSockAddr, sizeof(stSockAddr));

      if (ret == 0)
      {
        connected_ = true;
      }
    }
  }
}

void fslidar::disconnect()
{
  if (connected_)
  {
    close(socket_fd_);
    connected_ = false;
  }
}

bool fslidar::isConnected()
{
  return connected_;
}

void fslidar::startDevice()
{
  char buf[100],s[] = "#sf 15\r\n";
  sprintf(buf, "%s", s);
  write(socket_fd_, buf, strlen(buf));
}

void fslidar::stopDevice()
{
  char buf[100],s[] = "#sf 0\r\n";
  sprintf(buf, "%s", s);
  write(socket_fd_, buf, strlen(buf));
}

bool fslidar::init()
{
    portno = 12346;
    return true;
}

unsigned char fslidar::crc(unsigned char *buf)
{
    return (cbit[buf[1]]+cbit[buf[2]]+cbit[buf[3]])&0x07;
}

bool fslidar::decode(LaserDataNode *node, unsigned char *buf)
{
    unsigned char crcdata = crc(buf);
    unsigned char crcdata1 = (buf[0]>>4)&0x07;
    if(crcdata1!=  crcdata)
    {
        ROS_INFO("crc error !!.");
        return false;
    }    
        
    unsigned short ustemp;

    //compute distance
    ustemp= (buf[0]&0x0F);
    ustemp<<= 7;
    ustemp+= (buf[1]&0x7F);
    ustemp<<= 1;
    if( buf[2]&0x40)
        ustemp++;

    node->distance = ustemp;

    ustemp= buf[2]&0x3F;
    ustemp<<= 7;
    ustemp+= (buf[3]&0x7F);
    node->angle = ustemp;

    if(ustemp==5768)
        return true;
    if(ustemp>=5760)
        return false;
    
    return true;
}

#define _HEX(S) setw(2) << setfill('0') << hex << (int)(unsigned char)(S)
#define _DEC(S) setw(4) << setfill('0') << dec << (S)

int fslidar::getOnePoint(LaserDataNode *ldn, bool print)
{
    bool decode_rtn;
    int recv_rtn;
    int ldn_cnt = 0;
    int i;
    stringstream log;
    unsigned char *pbuf;
    recv_rtn = recv(socket_fd_,  (char *)buf_rear, BUFFER_SIZE,0); ///接收

    if (recv_rtn <= 0)
    {
        ROS_INFO("socket receive no data.");
        ros::Duration(0.1).sleep();
        return 0;
    }

    buf_rear += recv_rtn;

    while ((buf_rear-buf_head)>=4)
    {
        if ( ((*((int *)buf_head))&0x80808080) != 0x80000000) 
        {
            buf_head++;
            continue;
        }
        
        decode_rtn = decode(ldn, buf_head);
        //将解码的角度和距离信息打印到终端上
        //std::cout << "decode-> " << _DEC(ldn->angle) << ":" << _DEC(ldn->distance) << " " <<std::endl;
        if(decode_rtn)
        {
            ldn++;
            ldn_cnt++;
        }
        else
        {
            //ROS_INFO("decode_rtn false");
        }
        
        buf_head += 4;
    }
    for(i=0;i<(buf_rear-buf_head);i++)
    {
        recv_buf[i] = buf_head[i];
    }
    buf_head = recv_buf;
    buf_rear = recv_buf + i;        
    return ldn_cnt;
}
