#!/usr/bin/python
# -*- coding: utf-8 -*-
 
'''
MyStats.py
 
Implements a safe-threaded stats object.

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

http://www.luismartingil.com
'''

import logging

import threading
from datetime import datetime
import time

class MyStats(object):
    lock = None
    start = None
    stop = None
    threads = None
    total = None
    succ, err = None, None

    def __init__(self):
        self.lock = threading.Lock()
        self.threads = {}
        self.total = 0
        self.succ, self.err = 0, 0

    def thread_stamp(self, count_total=True):
        name = threading.current_thread().getName()
        if count_total:
            self.total += 1
        if self.threads.has_key(name):
            self.threads[name] += 1
        else:
            self.threads[name] = 1

    def start_stamp(self):
        with self.lock:
            self.thread_stamp(count_total=False)
            if self.start is None:
                self.start = datetime.now()

    def stop_stamp(self, error=False):
        with self.lock:
            if error: self.err += 1
            else: self.succ += 1
            # Update
            self.thread_stamp()
            self.stop = datetime.now()

    def getResults(self):
        return self.succ, self.err

    def getThreads(self):
        threads = None
        with self.lock:
            threads = self.threads
        return threads

    def getTotal(self):
        total = None
        with self.lock:
            total = self.total
        return total

    def getTimeDiff(self):
        time_diff = None
        with self.lock:
            if (self.stop and self.start):
                time_diff = str(float(((self.stop - self.start).seconds)))
        return time_diff