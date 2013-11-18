# Based on https://github.com/tavendo/AutobahnPython/tree/master/examples
#
# Test with autobahn lib.
# https://github.com/luismartingil

import sys, math, random

from twisted.python import log
from twisted.internet import reactor, defer, task
from twisted.web.server import Site
from twisted.web.static import File

from autobahn.websocket import listenWS
from autobahn.wamp import exportSub, \
                          WampServerFactory, \
                          WampServerProtocol

from monitor import Monitor

# Given webservice root
url_str = "http://test/"

# Two channels : diff, all
url_diff = "%s%s/" % (url_str, 'diff')
url_all = "%s%s/" % (url_str, 'all')

# Four channels : diff, all
subchannels = ['msp', 'bi', 'cmap', 'tm']


class MyTopicService(object):

   def __init__(self, allowedTopicIds):
      self.allowedTopicIds = allowedTopicIds

   @exportSub("", True)
   def subscribe(self, topicUriPrefix, topicUriSuffix):
      ret = False
      print "client wants to subscribe to %s %s. Allowed topic ids:%s" % (topicUriPrefix, topicUriSuffix, self.allowedTopicIds)
      try:
         if topicUriSuffix in self.allowedTopicIds:
            ret = True
            print "Subscribing client to topic %s %s" % (topicUriPrefix, topicUriSuffix)
         else:
            print "Client not allowed to subscribe to topic %s %s" % (topicUriPrefix, topicUriSuffix)
      except Exception , err:
         print "illegal topic - skipped subscription", err
      finally:
         return ret


class MyFactory(WampServerFactory):

   def printSubscriptions(self):
      for key, value in self.subscriptions.iteritems():
         print key, len(value)
      print '\n'

   def onClientSubscribed(self, *a, **k):
      WampServerFactory.onClientSubscribed(self, a, k)
      print '> client subscribed'
      self.printSubscriptions()

   def onClientUnsubscribed(self, *a, **k):
      WampServerFactory.onClientUnsubscribed(self, a, k)
      print '< client unsubscribed'
      self.printSubscriptions()


class MyServerProtocol(WampServerProtocol):

   def onSessionOpen(self):
      self.registerHandlerForPubSub(MyTopicService(ss.keys()), url_all)
      self.registerHandlerForPubSub(MyTopicService(ss.keys()), url_diff)


if __name__ == '__main__':

   if len(sys.argv) > 1 and sys.argv[1] == 'debug':
      log.startLogging(sys.stdout)
      debug = True
   else:
      debug = False

   factory = MyFactory("ws://10.22.22.110:9000", debugWamp = True)
   factory.protocol = MyServerProtocol
   factory.setProtocolOptions(allowHixie76 = True)
   listenWS(factory)

   webdir = File(".")
   web = Site(webdir)
   reactor.listenTCP(8080, web)

   # Lets create some Monitor objects based on the subchannels
   ss = dict([(x, Monitor(x)) for x in subchannels])
   ss_sent = dict([(x, None) for x in subchannels])

   # Task to poll for the objects of the channel 'diff'
   def monitor_task_diff():
      """ Task to poll for the information in the 'diff' channels. """
      for key, value in ss.iteritems():
         content = str(value)
         if ss_sent[key] != content:
            ss_sent[key] = content
            factory.dispatch('%s%s' % (url_diff, key), content)

   lp_diff = task.LoopingCall(monitor_task_diff)
   lp_diff.start(2.0)

   # Task to poll for the objects of the channel 'all'
   def monitor_task_all():
      """ Task to poll for the information in the 'all' channels. """
      for key, value in ss.iteritems():
         content = str(value)
         factory.dispatch('%s%s' % (url_all, key), content)

   lp_all = task.LoopingCall(monitor_task_all)
   lp_all.start(2.0)

   # Task to occasionaly change the objects
   def change_task():
      """ Fake method to change objects. """
      s = random.choice(ss.keys())
      ss[s].change()

   lp_change = task.LoopingCall(change_task)
   lp_change.start(0.2)

   reactor.run()