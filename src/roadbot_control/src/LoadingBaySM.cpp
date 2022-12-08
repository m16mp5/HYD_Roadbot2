#include <assert.h>
#include <iostream>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "LoadingBaySM.h"

// external event
void LoadingBaySM::OnUpdateRearRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
    kr1_state_accesskey.lock();
	rearRobotArmState = msg;
	double tcpx = rearRobotArmState->pos_fb.X;
	double tcpy = rearRobotArmState->pos_fb.Y;
	double tcpz = rearRobotArmState->pos_fb.Z;
    kr1_state_accesskey.unlock();

	double dx, dy;
	dx = tcpx - left_loadingbay_reararmtcp_pos_x; //LEFT_LOADINGBAY_REARARMTCP_POS_X;
	dy = tcpy - left_loadingbay_reararmtcp_pos_y; //LEFT_LOADINGBAY_REARARMTCP_POS_Y;
	double rearArmTCP_LeftLoadingBay_Dist = sqrt(dx*dx + dy*dy);
	dx = tcpx - right_loadingbay_reararmtcp_pos_x; //RIGHT_LOADINGBAY_REARARMTCP_POS_X;
	dy = tcpy - right_loadingbay_reararmtcp_pos_y; //RIGHT_LOADINGBAY_REARARMTCP_POS_Y;
	double rearArmTCP_RightLoadingBay_Dist = sqrt(dx*dx + dy*dy);

	lb_accesskey.lock();
	// Identify if TCP out -> in of left LB
//	if (!leftLoadingBayRearArmIn)
		if (rearArmTCP_LeftLoadingBay_Dist <= LOADINGBAY_INBOUND_RADIUS)
		{
			leftLoadingBayRearArmIn = true;
		}

	// Identify if TCP in -> out of left LB
	if (leftLoadingBayRearArmIn)
		if (rearArmTCP_LeftLoadingBay_Dist >= LOADINGBAY_OUTBOUND_RADIUS)
		{
			leftLoadingBayRearArmIn = false;

			if (llbExclusiveLock_MovOutUnlock)
			{
				if (releaseLLB_ExclusiveLock(1))
				{
					ROS_INFO("Reserve in LLB freed.");
					llbExclusiveLock_MovOutUnlock = false;
				}
			}
		}

	// Identify if TCP out -> in of right LB
//	if (!rightLoadingBayRearArmIn)
		if (rearArmTCP_RightLoadingBay_Dist <= LOADINGBAY_INBOUND_RADIUS)
		{
			rightLoadingBayRearArmIn = true;
		}

	// Identify if TCP in -> out of right LB
	if (rightLoadingBayRearArmIn)
		if (rearArmTCP_RightLoadingBay_Dist >= LOADINGBAY_OUTBOUND_RADIUS)
		{
			rightLoadingBayRearArmIn = false;

			if (rlbExclusiveLock_MovOutUnlock)
			{
				if (releaseRLB_ExclusiveLock(1))
				{
					ROS_INFO("Reserve in RLB freed.");
					rlbExclusiveLock_MovOutUnlock = false;
				}
			}
		}
	lb_accesskey.unlock();
}

// external event
void LoadingBaySM::OnUpdateFrontRobotArmState(const kuka_robot::kr_robot_state_Type::ConstPtr& msg)
{
    kr2_state_accesskey.lock();
	frontRobotArmState = msg;
	double tcpx = frontRobotArmState->pos_fb.X;
	double tcpy = frontRobotArmState->pos_fb.Y;
	double tcpz = frontRobotArmState->pos_fb.Z;
    kr2_state_accesskey.unlock();

	double dx, dy;
	dx = tcpx - left_loadingbay_frontarmtcp_pos_x; //LEFT_LOADINGBAY_FRONTARMTCP_POS_X;
	dy = tcpy - left_loadingbay_frontarmtcp_pos_y; //LEFT_LOADINGBAY_FRONTARMTCP_POS_Y;
	double frontArmTCP_LeftLoadingBay_Dist = sqrt(dx*dx + dy*dy);
	dx = tcpx - right_loadingbay_frontarmtcp_pos_x; //RIGHT_LOADINGBAY_FRONTARMTCP_POS_X;
	dy = tcpy - right_loadingbay_frontarmtcp_pos_y; //RIGHT_LOADINGBAY_FRONTARMTCP_POS_Y;
	double frontArmTCP_RightLoadingBay_Dist = sqrt(dx*dx + dy*dy);

	lb_accesskey.lock();
	// Identify if TCP out -> in of left LB
//	if (!leftLoadingBayFrontArmIn)
		if (frontArmTCP_LeftLoadingBay_Dist <= LOADINGBAY_INBOUND_RADIUS)
		{
			leftLoadingBayFrontArmIn = true;
		}

	// Identify if TCP in -> out of left LB
	if (leftLoadingBayFrontArmIn)
		if (frontArmTCP_LeftLoadingBay_Dist >= LOADINGBAY_OUTBOUND_RADIUS)
		{
			leftLoadingBayFrontArmIn = false;

			if (llbExclusiveLock_MovOutUnlock)
			{
				if (releaseLLB_ExclusiveLock(2))
				{
					ROS_INFO("Reserve in LLB freed.");
					llbExclusiveLock_MovOutUnlock = false;
				}
			}
		}

	// Identify if TCP out -> in of right LB
//	if (!rightLoadingBayFrontArmIn)
		if (frontArmTCP_RightLoadingBay_Dist <= LOADINGBAY_INBOUND_RADIUS)
		{
			rightLoadingBayFrontArmIn = true;
		}

	// Identify if TCP in -> out of right LB
	if (rightLoadingBayFrontArmIn)
		if (frontArmTCP_RightLoadingBay_Dist >= LOADINGBAY_OUTBOUND_RADIUS)
		{
			rightLoadingBayFrontArmIn = false;

			if (rlbExclusiveLock_MovOutUnlock)
			{
				if (releaseRLB_ExclusiveLock(2))
				{
					ROS_INFO("Reserve in RLB freed.");
					rlbExclusiveLock_MovOutUnlock = false;
				}
			}
		}
	lb_accesskey.unlock();
}

// external event
void LoadingBaySM::OnUpdateSioState(const system_io::sio_state_Type::ConstPtr& msg)
{
	if (msg->state != 0)
		return;

	sio_state_accesskey.lock();
	lbSensorState = msg;
	double leftLBSensorValue = msg->llb_has_cone;
	double rightLBSensorValue = msg->rlb_has_cone;
	sio_state_accesskey.unlock();

	lb_accesskey.lock();
	// Identified any cone in left LB
	if (leftLBSensorValue)
		leftLoadingBayLoaded = 1;
	else
		leftLoadingBayLoaded = 0;

	// Identified any cone in right LB
	if (rightLBSensorValue)
		rightLoadingBayLoaded = 1;
	else
		rightLoadingBayLoaded = 0;
	lb_accesskey.unlock();
}

bool LoadingBaySM::enable_ReleaseLB_ExclusiveLock_IfMovOut(int byArm)
{
	if (checkLLB_ExclusiveLock_Owner(byArm))
	{
		lb_accesskey.lock();
		// if already out, unlock directly
		if ((byArm == 2) && (!leftLoadingBayFrontArmIn))
			releaseLLB_ExclusiveLock(2);
		else if ((byArm == 1) && (!leftLoadingBayRearArmIn))
			releaseLLB_ExclusiveLock(1);
		else
			llbExclusiveLock_MovOutUnlock = true;
		lb_accesskey.unlock();
		return true;
	}

	if (checkRLB_ExclusiveLock_Owner(byArm))
	{
		// if already out, unlock directly
		lb_accesskey.lock();
		if ((byArm == 2) && (!rightLoadingBayFrontArmIn))
			releaseRLB_ExclusiveLock(2);
		else if ((byArm == 1) && (!rightLoadingBayRearArmIn))
			releaseRLB_ExclusiveLock(1);
		else
			rlbExclusiveLock_MovOutUnlock = true;
		lb_accesskey.unlock();
		return true;
	}

	return false;
}

// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
bool LoadingBaySM::acquireLLB_ExclusiveLock(int fromArm)
{
	bool retval = false;
	llbExclusiveLock_accesskey.lock();
	if (llbExclusiveLockOwner == 0)
	{
		llbExclusiveLockOwner = fromArm;
		retval = true;
	}
	else if (llbExclusiveLockOwner == fromArm)
	{
		retval = true;
	}
	llbExclusiveLock_accesskey.unlock();
	return retval;
}

// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
bool LoadingBaySM::acquireRLB_ExclusiveLock(int fromArm)
{
	bool retval = false;
	rlbExclusiveLock_accesskey.lock();
	if (rlbExclusiveLockOwner == 0)
	{
		rlbExclusiveLockOwner = fromArm;
		retval = true;
	}
	else if (rlbExclusiveLockOwner == fromArm)
	{
		retval = true;
	}
	rlbExclusiveLock_accesskey.unlock();
	return retval;
}

// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
bool LoadingBaySM::releaseLLB_ExclusiveLock(int fromArm)
{
	bool retval = false;
	llbExclusiveLock_accesskey.lock();
	if (llbExclusiveLockOwner == fromArm)
	{
		llbExclusiveLockOwner = 0;
		retval = true;
	}
	llbExclusiveLock_accesskey.unlock();
	return retval;
}

// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
bool LoadingBaySM::releaseRLB_ExclusiveLock(int fromArm)
{
	bool retval = false;
	rlbExclusiveLock_accesskey.lock();
	if (rlbExclusiveLockOwner == fromArm)
	{
		rlbExclusiveLockOwner = 0;
		retval = true;
	}
	rlbExclusiveLock_accesskey.unlock();
	return retval;
}

// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
bool LoadingBaySM::checkLLB_ExclusiveLock_Owner(int byArm)
{
	bool retval = false;
	llbExclusiveLock_accesskey.lock();
	if (llbExclusiveLockOwner == byArm)
	{
		retval = true;
	}
	llbExclusiveLock_accesskey.unlock();
	return retval;
}

// 0-No Lock, 1-Locked by rear (kr1), 2-Locked by front (kr2)
bool LoadingBaySM::checkRLB_ExclusiveLock_Owner(int byArm)
{
	bool retval = false;
	rlbExclusiveLock_accesskey.lock();
	if (rlbExclusiveLockOwner == byArm)
	{
		retval = true;
	}
	rlbExclusiveLock_accesskey.unlock();
	return retval;
}


// To be invoked by frontArmSM (kr2)
int LoadingBaySM::getReadyLB_StorageToLoad()
{
	// check if any LB ready locked by kr2
	if (checkLLB_ExclusiveLock_Owner(2))
		return LB_LEFT;
	else if (checkRLB_ExclusiveLock_Owner(2))
		return LB_RIGHT;

	// check if LLB or RLB have space and can be reserved
	if (leftLoadingBayLoaded == 0)
	{
		if (acquireLLB_ExclusiveLock(2))
			return LB_LEFT;
	}

	if (rightLoadingBayLoaded == 0)
	{
		if (acquireRLB_ExclusiveLock(2))
			return LB_RIGHT;
	}

	return LB_NOTAVAL;
}

// To be invoked by rearArmSM (kr1)
int LoadingBaySM::getReadyLB_LoadToPlace()
{
	// check if any LB ready locked by kr1
	if (checkLLB_ExclusiveLock_Owner(1))
		return LB_LEFT;
	else if (checkRLB_ExclusiveLock_Owner(1))
		return LB_RIGHT;

	// check if LLB or RLB have cone and can be reserved, pick priorty given to next LB
	if (lastRRAWorkingLB == LB_RIGHT)
	{
		if (leftLoadingBayLoaded > 0)
		{
			if (acquireLLB_ExclusiveLock(1))
			{
				lastRRAWorkingLB = LB_LEFT;
				return LB_LEFT;
			}
		}
		if (rightLoadingBayLoaded > 0)
		{
			if (acquireRLB_ExclusiveLock(1))
			{
				lastRRAWorkingLB = LB_RIGHT;
				return LB_RIGHT;
			}
		}
	}
	else
	{
		if (rightLoadingBayLoaded > 0)
		{
			if (acquireRLB_ExclusiveLock(1))
			{
				lastRRAWorkingLB = LB_RIGHT;
				return LB_RIGHT;
			}
		}
		if (leftLoadingBayLoaded > 0)
		{
			if (acquireLLB_ExclusiveLock(1))
			{
				lastRRAWorkingLB = LB_LEFT;
				return LB_LEFT;
			}
		}
	}

	return LB_NOTAVAL;
}

// To be invoked by rearArmSM (kr1)
int LoadingBaySM::getReadyLB_CollectToLoad()
{
	// check if any LB ready locked by kr1
	if (checkLLB_ExclusiveLock_Owner(1))
		return LB_LEFT;
	else if (checkRLB_ExclusiveLock_Owner(1))
		return LB_RIGHT;

	// check if LLB or RLB have space and can be reserved
	if (leftLoadingBayLoaded == 0)
	{
		if (acquireLLB_ExclusiveLock(1))
			return LB_LEFT;
	}

	if (rightLoadingBayLoaded == 0)
	{
		if (acquireRLB_ExclusiveLock(1))
			return LB_RIGHT;
	}

	return LB_NOTAVAL;
}

// To be invoked by frontArmSM (kr2)
int LoadingBaySM::getReadyLB_LoadToStorage()
{
	// check if any LB ready locked by kr2
	if (checkLLB_ExclusiveLock_Owner(2))
		return LB_LEFT;
	else if (checkRLB_ExclusiveLock_Owner(2))
		return LB_RIGHT;

	// check if LLB or RLB have cone and can be reserved
	if (leftLoadingBayLoaded > 0)
	{
		if (acquireLLB_ExclusiveLock(2))
			return LB_LEFT;
	}

	if (rightLoadingBayLoaded > 0)
	{
		if (acquireRLB_ExclusiveLock(2))
			return LB_RIGHT;
	}

	return LB_NOTAVAL;
}


void LoadingBaySM::ST_HaveSpace(EventData* pData)
{
	ROS_INFO("LoadingBaySM::ST_HaveSpace");
}

void LoadingBaySM::ST_Full(EventData* pData)
{
	ROS_INFO("LoadingBaySM::ST_Full");
}

void LoadingBaySM::ST_Error(EventData* pData)
{
	ROS_INFO("LoadingBaySM::ST_Error");
}


