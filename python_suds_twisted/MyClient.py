#!/usr/bin/python
# -*- coding: utf-8 -*-
 
'''
MyClient.py
 
Implements SOAP clients using suds library:
- asynchronous, Client_Async. Relays on twisted.
- sync, Client_Sync. Straight use of suds in a synchronous way.

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

http://www.luismartingil.com
'''

import logging

from suds.cache import ObjectCache
from suds.client import Client as SudsClient
from suds.sax.attribute import Attribute
from suds.plugin import MessagePlugin

from twisted.internet.threads import deferToThread

class MyPlugin(MessagePlugin):
    def marshalled(self, context):
        pass
    def sending(self, context):
        pass

def call(stats, method, service, key, *a, **kw):
    stats.start_stamp()
    logging.debug('%40s : calling!' % (key))
    result = service.__getattr__(method)(*a, **kw)
    return result

class MyClient(SudsClient):

    def handleFailure(self, f, key, stats):
        stats.stop_stamp(error=True)
        logging.error("%s. Failure: %s" % (key, str(f)))

    def handleResult(self, result, key, stats):
        stats.stop_stamp(error=False)
        success, text, res = False, None, None
        try:
            success = result.MessageResult.MessageResultCode == 200
            text = result.MessageResult.MessageResultText
            res = result.FooBar
        except Exception, err:
            pass
        logging.debug('%40s : %5s %10s \"%40s\"' % (key, success, text, res))
        logging.debug('%40s : %s' % (key, self.last_sent()))
        logging.debug('%40s : %s' % (key, self.last_received()))

    def do_test(self, msg):
        return self.service.LogEvent(__inject={'msg': msg})

    def clear_cache(self):
        self.options.cache.clear()

    def set_location(self, host):
        self.set_options(location=host)

    def activate_cache(self):
        oc = ObjectCache()
        oc.setduration(days=365)

# Inspired by http://twistedmatrix.com/pipermail/twisted-python/2010-April/022051.html
class Client_Async(MyClient):
    """ Twisted based async client"""
    def callRemote(self, stats, method, key, *args, **kwargs):
        logging.debug('%s. deferring to thread...' % key)
        d = deferToThread(call, stats, method, self.service, key, *args, **kwargs)
        d.addCallback(self.handleResult, key, stats)
        d.addErrback(self.handleFailure, key, stats)
        return d

class Client_Sync(MyClient):
    def callRemote(self, stats,  method, key, *args, **kwargs):
        result = None
        try:
            result = call(stats, method, self.service, key, *args, **kwargs)
        except Exception, err:
            self.handleFailure(err, key, stats)
        else:
            self.handleResult(result, key, stats)