#!/usr/bin/python
# -*- coding: utf-8 -*-
 
'''
soap_suds_client.py
 
Soap test client using python suds library.
Testing sync and async SOAP calls using straight suds or Twisted.

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

http://www.luismartingil.com
'''

import logging
from optparse import OptionParser

from twisted.internet import reactor, task

from MyClient import Client_Sync, Client_Async
from MyStats import MyStats

def setup_logging(l):
    # Some logging configuration
    logging.basicConfig(format='%(process)s %(thread)s %(name)s %(levelname)s %(asctime)s %(message)s', level=l)
    # logging.getLogger('suds.client').setLevel(logging.DEBUG)
    # logging.getLogger('suds.transport').setLevel(logging.DEBUG)
    # logging.getLogger('suds.xsd.schema').setLevel(logging.DEBUG)
    # logging.getLogger('suds.wsdl').setLevel(logging.DEBUG)

def create_params(client):
    """ Returns a dict with the params for the soap call. """
    test =  client.factory.create('ns6:param1')
    test.value = 'incoming'
    test2 = client.factory.create('ns7:param2')
    test2.Value = test
    params = {
        'paramX' : '2013-10-21T19:09:53Z',
        'paramY' : test2,
        }
    return params

if __name__ == "__main__":
    usage = 'usage: %prog [times] [sync]'
    parser = OptionParser(usage)

    parser.add_option('-t', '--times', dest='times', help='how many requests per host', type=int)
    parser.add_option('-s', '--sync', action='store_true', help='syncronous soap calls')

    parser.set_defaults(
        sync=False,
        times=10)
    options, args = parser.parse_args()

    times = options.times
    sync = True if options.sync else False

    # Logging, please
    setup_logging(logging.INFO)

    # Some params
    wsdl_url = 'file://' + '/path/to/file'
    hosts = {
        'key1' : 'http://192.2.1.22:80/foo.svc',
        'key2' : 'http://192.2.2.22:8080/bar',
        'key3' : 'http://192.2.3.22:8888/foo.asmx',
        'key4' : 'http://192.2.4.22:80/bar.asmx'
        }

    def check_end(desired, stats):
        if stats.getTotal() == desired:
            tmp = []
            tmp.append('')
            extra_info = 'Success:%s Errors:%s' % stats.getResults()
            tmp.append('Total requests:%s/%s. %s' % (stats.getTotal(), desired, extra_info))
            tmp.append('Seconds elapsed:%s' % stats.getTimeDiff())
            #tmp.append('Started time:%s' % stats.start)
            #tmp.append('Stopped time:%s' % stats.stop)
            tmp.append('Threads used:%s' % len(stats.getThreads().keys()))
            logging.info("\n".join(tmp))
            reactor.stop()
        else:
            logging.debug('Total requests:%s/%s' % (stats.getTotal(), desired))

    def gogo(stats, ctype, ts):
        logging.info('Start!')
        for key, host in hosts.iteritems():
            client = ctype(wsdl_url)#, cache=None)
            client.set_location(host) #print client
            params = create_params(client)
            for i in range(0, ts):
                client.callRemote(stats, 'soap_method_to_be_called', '%s.%s' % (i, key), **params)
            # Turn everything down when done
            desired = times * len(hosts.keys()) # Stop condition
            d = task.LoopingCall(check_end, desired, stats)
            d.start(2)

    # Rock!
    t = Client_Sync if sync else Client_Async
    reactor.callLater(5, gogo, MyStats(), t, times)
    reactor.run()