#ifndef TIME_COUNTER_H
#define TIME_COUNTER_H
#include "time.h"
#include "sys/time.h"
#include "iostream"

class time_counter
{
public:
    time_counter();
    void record();
    float get_delta_t();
    double get_time_now();


private:
    timeval time_tmp;
    double time_last;
    double time_now;
    float delta_t;
};

#endif // TIME_COUNTER_H
