#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    Protected.py

    ~~~~~~~~~~~~~~~~~~~~
Implements a dummy Protected Object.

    Author:
    Luis Martin Gil. martingil.luis@gmail.com
    www.luismartingil.com
"""

import logging
import time
import threading

class MyProtectedD(object):
    """ Threaded-safe object """

    delay_lock = None
    delay_work = None
    counter = None
    lock = None

    def __init__(self,
                 delay_lock=1.0,
                 delay_work=1.0):

        self.counter = 0
        self.lock = threading.Lock()
        self.delay_lock = delay_lock
        self.delay_work = delay_work

    def _do_safe(self, f, *args, **kwargs):

        ret = ''
        with self.lock:
            logging.debug('lock acquired')

            # Simulates some work with the lock
            time.sleep(self.delay_lock)

            # Executing function passed as param in a thread-safe mode
            f(*args, **kwargs)
            ret = '{0}. "{1}" by thread {2}'.format(f.__name__,
                                                    self.counter,
                                                    threading.current_thread().name)
            logging.debug('lock released')

        # Sleep simulates other work
        time.sleep(self.delay_work)
        logging.info(ret)
        return ret
            
    def add(self):

        def f_add(*args, **kwargs):
            self.counter += 1
        return self._do_safe(f_add)
                    
    def sub(self):

        def f_sub(*args, **kwargs):
            self.counter -= 1
        return self._do_safe(f_sub)
        
    def __str__(self):

        def dumb(*args, **kwargs):
            pass

        return self._do_safe(dumb)
