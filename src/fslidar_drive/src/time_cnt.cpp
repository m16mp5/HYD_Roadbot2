#include "time_cnt.h"
#include "iostream"
#include "sys/time.h"


time_counter::time_counter()
{
    gettimeofday(&this->time_tmp,NULL);
    this->time_now = 1000000.*this->time_tmp.tv_sec+this->time_tmp.tv_usec;
    this->delta_t = this->time_now - this->time_last;
    this->time_last = this->time_now;
    if(delta_t>500000)
        delta_t=-1;//
}

void time_counter::record()
{
    gettimeofday(&this->time_tmp,NULL);
    this->time_now = 1000000.*this->time_tmp.tv_sec+this->time_tmp.tv_usec;
    this->delta_t = (this->time_now - this->time_last)/1000.;
    this->time_last = this->time_now;
    if(delta_t>700000)
    {
        delta_t=-1;//
    }
}

float time_counter::get_delta_t()
{
    return this->delta_t;
}

double time_counter::get_time_now()
{
    return this->time_now;
}


