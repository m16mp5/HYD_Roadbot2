#ifndef _STATE_MACHINE_H
#define _STATE_MACHINE_H

#include <mutex>
#include <stdio.h>

using namespace std;

class EventData 
{
public:
    virtual ~EventData() {};  
};

struct StateStruct;
 
// base class for state machines
class StateMachine
{
public:
    StateMachine(unsigned char maxStates);
    virtual ~StateMachine() {}
    unsigned char previousState;
    unsigned char currentState;
protected:
    enum { EVENT_IGNORED = 0xFE, CANNOT_HAPPEN };
    void ExternalEvent(unsigned char, EventData* = NULL);
    void InternalEvent(unsigned char, EventData* = NULL);
    virtual const StateStruct* GetStateMap() = 0;
    mutex accesskey;
    unsigned char _maxStates;
private:
    bool _eventGenerated;
    EventData* _pEventData;
    void StateEngine(void);
};
 
typedef void (StateMachine::*StateFunc)(EventData *);
struct StateStruct 
{
    StateFunc pStateFunc;    
};
 
#define BEGIN_STATE_MAP \
public:\
virtual const StateStruct* GetStateMap() {\
    static const StateStruct StateMap[] = { 
 
#define STATE_MAP_ENTRY(stateFunc)\
    { reinterpret_cast<StateFunc>(stateFunc) },
 
#define END_STATE_MAP \
    }; \
    return &StateMap[0]; }
 
#define BEGIN_TRANSITION_MAP \
    static const unsigned char TRANSITIONS[] = {\
 
#define TRANSITION_MAP_ENTRY(entry)\
    entry,
 
#define END_TRANSITION_MAP(data) \
    0 };\
    ExternalEvent(TRANSITIONS[currentState], data);
 
#endif //STATE_MACHINE_H
