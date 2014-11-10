#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
server_requests_count.py

Given a server that has requests coming in.
Design a data structure such that you can fetch 
the count of the number requests in the last
second, minute and hour

Goal is to have O(1) in the access.

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com. www.luismartingil.com
'''

import datetime
import random
import threading
import time

class Status(object):
    actual_key = None
    hash = None
    counter = None

    def __init__(self, hash):
        self.actual_key = ''
        self.hash = hash
        self.counter = 0
        
    def incrementCounter(self):
        self.counter += 1

    def resetCounter(self):
        self.counter = 0

    def getCounter(self):
        return self.counter

    def getHash(self):
        return self.hash

    def getActualKey(self):
        return self.actual_key

    def setActualKey(self, key):
        self.actual_key = key

class CountReq(object):

    count = None # Dict for the counts
    all_reqs = None # Saves all requests
    lock = None

    def __init__(self):
        self.lock = threading.Lock()
        self.count = {
            'sec'  : Status(lambda x:x.strftime("%m/%d/%y:%HH:%MM:%SS")),
            'min'  : Status(lambda x:x.strftime("%m/%d/%y:%HH:%MM")),
            'hour' : Status(lambda x:x.strftime("%m/%d/%y:%HH"))
            }
        self.all_reqs = []

    def insert(self, req):
        with self.lock:
            self.all_reqs.append(req)
            now = datetime.datetime.today()
            for key, status in self.count.iteritems():
                actual_key = status.getActualKey()
                hash = status.getHash()
                hashed_req = hash(req)
                hashed_now = hash(now)
                if actual_key != hashed_now:
                    status.setActualKey(hashed_now)
                    status.resetCounter()
                if actual_key == hashed_req:
                    status.incrementCounter()

    def getCount(self, key):
        ret = None
        with self.lock:
            try:
                ret = self.count[key].getCounter()
            except:
                pass
        return ret

    def getAll(self):
        output = ""
        with self.lock:
            n1=datetime.datetime.now()
            for key, stats in self.count.iteritems():
                output += '  "%s":%.18i' % (key, stats.getCounter())
            n2=datetime.datetime.now()
            delta=n2-n1
        return output, delta.microseconds
            

def myFun(my_cr):
    """ Fun to get a request from the queue and insert"""    
    while(True):
        req = datetime.datetime.today()
        my_cr.insert(req)
        time.sleep(0.05)

if __name__ == "__main__":

    cr = CountReq()
    N_THREADS = 100

    # Lets create some threads
    for i in range (0, N_THREADS):
        w = threading.Thread(name='worker_%s' % (i),
                             target=myFun,
                             args=(cr,))
        w.setDaemon(True)
        w.start()

    i = 0
    while(True):
        output, elapsed = cr.getAll()
        print '%.3i' % i, output, '\t', 'time_elapsed(usecs):%s' % elapsed
        i += 1
        time.sleep(1)

    # Output
    # See the constant value for the time_elapsed when the number of requests gets high

#         000   "sec":000000000000000099  "hour":000000000000000099  "min":000000000000000099 time_elapsed(usecs):14
#         001   "sec":000000000000000100  "hour":000000000000002000  "min":000000000000000100 time_elapsed(usecs):48
#         002   "sec":000000000000000183  "hour":000000000000003999  "min":000000000000002099 time_elapsed(usecs):79
#         003   "sec":000000000000000115  "hour":000000000000005915  "min":000000000000004015 time_elapsed(usecs):22
#         004   "sec":000000000000000179  "hour":000000000000007900  "min":000000000000006000 time_elapsed(usecs):41
#         005   "sec":000000000000000122  "hour":000000000000009823  "min":000000000000007923 time_elapsed(usecs):49
#         006   "sec":000000000000000187  "hour":000000000000011811  "min":000000000000009911 time_elapsed(usecs):20
#         007   "sec":000000000000000128  "hour":000000000000013745  "min":000000000000011845 time_elapsed(usecs):19
#         008   "sec":000000000000000177  "hour":000000000000015723  "min":000000000000013823 time_elapsed(usecs):34
#         009   "sec":000000000000000137  "hour":000000000000017661  "min":000000000000015761 time_elapsed(usecs):33
#         010   "sec":000000000000000172  "hour":000000000000019628  "min":000000000000017728 time_elapsed(usecs):44
#         011   "sec":000000000000000187  "hour":000000000000021611  "min":000000000000019711 time_elapsed(usecs):38
#         012   "sec":000000000000000178  "hour":000000000000023543  "min":000000000000021643 time_elapsed(usecs):29
#         013   "sec":000000000000000183  "hour":000000000000025521  "min":000000000000023621 time_elapsed(usecs):14
#         014   "sec":000000000000000178  "hour":000000000000027452  "min":000000000000025552 time_elapsed(usecs):53
#         015   "sec":000000000000000178  "hour":000000000000029423  "min":000000000000027523 time_elapsed(usecs):61
#         016   "sec":000000000000000189  "hour":000000000000031374  "min":000000000000029474 time_elapsed(usecs):42
#         017   "sec":000000000000000196  "hour":000000000000033345  "min":000000000000031445 time_elapsed(usecs):20
#         018   "sec":000000000000000188  "hour":000000000000035295  "min":000000000000033395 time_elapsed(usecs):14
#         019   "sec":000000000000000199  "hour":000000000000037251  "min":000000000000035351 time_elapsed(usecs):25
#         020   "sec":000000000000000198  "hour":000000000000039229  "min":000000000000037329 time_elapsed(usecs):13
#         021   "sec":000000000000000199  "hour":000000000000041157  "min":000000000000039257 time_elapsed(usecs):48
#         022   "sec":000000000000000199  "hour":000000000000043132  "min":000000000000041232 time_elapsed(usecs):48
#         023   "sec":000000000000000223  "hour":000000000000045084  "min":000000000000043184 time_elapsed(usecs):25
#         024   "sec":000000000000000206  "hour":000000000000047057  "min":000000000000045157 time_elapsed(usecs):25
#         025   "sec":000000000000000212  "hour":000000000000048999  "min":000000000000047099 time_elapsed(usecs):23
#         026   "sec":000000000000000208  "hour":000000000000050967  "min":000000000000049067 time_elapsed(usecs):22
#         027   "sec":000000000000000210  "hour":000000000000052910  "min":000000000000051010 time_elapsed(usecs):63
#         028   "sec":000000000000000235  "hour":000000000000054895  "min":000000000000052995 time_elapsed(usecs):46
#         029   "sec":000000000000000222  "hour":000000000000056828  "min":000000000000054928 time_elapsed(usecs):48
#         030   "sec":000000000000000227  "hour":000000000000058805  "min":000000000000056905 time_elapsed(usecs):58
#         031   "sec":000000000000000231  "hour":000000000000060747  "min":000000000000058847 time_elapsed(usecs):32
#         032   "sec":000000000000000221  "hour":000000000000062709  "min":000000000000060809 time_elapsed(usecs):35
#         033   "sec":000000000000000243  "hour":000000000000064678  "min":000000000000062778 time_elapsed(usecs):25
#         034   "sec":000000000000000205  "hour":000000000000066614  "min":000000000000064714 time_elapsed(usecs):116
#         035   "sec":000000000000000267  "hour":000000000000068609  "min":000000000000066709 time_elapsed(usecs):25
#         036   "sec":000000000000000229  "hour":000000000000070542  "min":000000000000068642 time_elapsed(usecs):30
#         037   "sec":000000000000000269  "hour":000000000000072512  "min":000000000000070612 time_elapsed(usecs):42
#         038   "sec":000000000000000227  "hour":000000000000074448  "min":000000000000072548 time_elapsed(usecs):42
#         039   "sec":000000000000000271  "hour":000000000000076431  "min":000000000000074531 time_elapsed(usecs):37
#         040   "sec":000000000000000237  "hour":000000000000078370  "min":000000000000076470 time_elapsed(usecs):38
#         041   "sec":000000000000000270  "hour":000000000000080340  "min":000000000000078440 time_elapsed(usecs):37
#         042   "sec":000000000000000244  "hour":000000000000082292  "min":000000000000080392 time_elapsed(usecs):42
#         043   "sec":000000000000000267  "hour":000000000000084260  "min":000000000000082360 time_elapsed(usecs):50
#         044   "sec":000000000000000279  "hour":000000000000086240  "min":000000000000084340 time_elapsed(usecs):25
#         045   "sec":000000000000000258  "hour":000000000000088177  "min":000000000000086277 time_elapsed(usecs):37
#         046   "sec":000000000000000276  "hour":000000000000090153  "min":000000000000088253 time_elapsed(usecs):24
#         047   "sec":000000000000000252  "hour":000000000000092084  "min":000000000000090184 time_elapsed(usecs):19
#         048   "sec":000000000000000288  "hour":000000000000094068  "min":000000000000092168 time_elapsed(usecs):47
#         049   "sec":000000000000000249  "hour":000000000000095997  "min":000000000000094097 time_elapsed(usecs):40
#         050   "sec":000000000000000293  "hour":000000000000097981  "min":000000000000096081 time_elapsed(usecs):43
#         051   "sec":000000000000000276  "hour":000000000000099935  "min":000000000000098035 time_elapsed(usecs):21
#         052   "sec":000000000000000293  "hour":000000000000101891  "min":000000000000099991 time_elapsed(usecs):41
#         053   "sec":000000000000000250  "hour":000000000000103832  "min":000000000000101932 time_elapsed(usecs):14
#         054   "sec":000000000000000298  "hour":000000000000105797  "min":000000000000103897 time_elapsed(usecs):40
#         055   "sec":000000000000000275  "hour":000000000000107767  "min":000000000000105867 time_elapsed(usecs):22
#         056   "sec":000000000000000294  "hour":000000000000109699  "min":000000000000107799 time_elapsed(usecs):47
#         057   "sec":000000000000000299  "hour":000000000000111692  "min":000000000000109792 time_elapsed(usecs):96
#         058   "sec":000000000000000299  "hour":000000000000113624  "min":000000000000111724 time_elapsed(usecs):42
#         059   "sec":000000000000000301  "hour":000000000000115602  "min":000000000000113702 time_elapsed(usecs):31
#         060   "sec":000000000000000312  "hour":000000000000117539  "min":000000000000115639 time_elapsed(usecs):18
#         061   "sec":000000000000000304  "hour":000000000000119513  "min":000000000000000304 time_elapsed(usecs):18
