#ifndef EPOLL_H
#define EPOLL_H

#include <stdio.h>
#include "sys/epoll.h"
#include <string.h>
#include <stdint.h>
#include <unistd.h>

class my_epoll
{
public:
    my_epoll (uint32_t m_ = 256)
    {
        events_ = new struct epoll_event [m_];
        memset(events_, 0, sizeof(struct epoll_event));

        epfd_ = epoll_create(m_);

        if (-1 == epfd_)
        {
            fprintf(stderr,"epoll create failed");
        }
    }
    ~my_epoll ()
    {
        close(epfd_);
        delete [] events_;
    }

    //ChanX

    void ctrl (int op, int fd, uint32_t event)
    {
        ev_.data.fd = fd;
        ev_.events = event;
        epoll_ctl(epfd_, op, fd, &ev_);
    }

    int poll (int maxevents, int timeout)
    {
        return epoll_wait(epfd_, events_, maxevents, timeout);
    }
    struct epoll_event * get_events()
    {
        return events_;
    }

private:
    int epfd_;
    struct epoll_event *events_;
    struct epoll_event ev_;

};

#endif // EPOLL_H
