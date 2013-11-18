# Based on https://github.com/tavendo/AutobahnPython/tree/master/examples
#
# Test with autobahn lib.
# https://github.com/luismartingil

import sys

from twisted.python import log
from twisted.internet import reactor
from twisted.internet.protocol import ReconnectingClientFactory
from twisted.internet.defer import Deferred, DeferredList

from autobahn.websocket import connectWS
from autobahn.wamp import WampClientFactory, WampClientProtocol

url = "http://test/"
init_channel = "%s%s/%s" % (url, "all", "bi")
diff_channel = "%s%s/%s" % (url, "diff", "bi")

class MyFactory(ReconnectingClientFactory, WampClientFactory):

   maxDelay = 10
   maxRetries = 5

   def clientConnectionLost(self, connector, reason):
      print 'Lost connection.  Reason:', reason
      ReconnectingClientFactory.clientConnectionLost(self, connector, reason)

   def clientConnectionFailed(self, connector, reason):
      print 'Connection failed. Reason:', reason
      ReconnectingClientFactory.clientConnectionFailed(self, connector, reason)

class MyClientProtocol(WampClientProtocol):
   """
   Demonstrates simple Publish & Subscribe (PubSub) with Autobahn WebSockets.
   """

#    def show(self, result):
#       print "SUCCESS:", result

#    def logerror(self, e):
#       erroruri, errodesc = e.value.args
#       print "ERROR: %s ('%s')" % (erroruri, errodesc)

   def pprint(self, topicUri, event):
      print topicUri, event

   def switch(self, topicUri, event):
      self.pprint(topicUri, event)
      self.unsubscribe(init_channel)
      self.subscribe(diff_channel, self.pprint)

   def onSessionOpen(self):
      self.subscribe(init_channel, self.switch)

if __name__ == '__main__':

   log.startLogging(sys.stdout)
   factory = MyFactory("ws://10.22.22.110:9000")
   factory.protocol = MyClientProtocol
   connectWS(factory)
   reactor.run()