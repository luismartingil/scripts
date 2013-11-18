# Based on https://github.com/tavendo/AutobahnPython/tree/master/examples
#
# Test with autobahn lib.
# https://github.com/luismartingil

import random, string, json

class Monitor(object):
   id_str = None
   version = None
   counter = None

   def __init__(self, id_str):
      self.id_str = id_str
      self.version = None
      self.counter = 0

   def change(self):
      self.version = ''.join(random.choice(string.lowercase) for x in range(10))
      self.counter += 1

   def __str__(self):
      return str(json.dumps(self.__dict__))