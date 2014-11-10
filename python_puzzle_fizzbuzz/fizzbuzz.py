#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
fizzbuzz.py

Write a program that prints the numbers from 1 to 100. 
But for multiples of three print "Fizz" instead of the number 
and for the multiples of five print "Buzz". 
For numbers which are multiples of both three and five print "FizzBuzz".

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com
'''

import unittest

MI=0
MA=100

def fbItem(n):
    """ Performs the fizzbuzz problem for a given n"""
    conds = [
        (lambda x : x % 3 == 0 and x % 5 == 0, 'FizzBuzz'),
        (lambda x : x % 3 == 0, 'Fizz'),
        (lambda x : x % 5 == 0, 'Buzz'),
        ]
    output = n
    for fun, val in conds:
        if fun(n): 
            output = val
            break
    return str(output)

def fb(min, max):
    for i in range(min, max + 1):
        print i, fbItem(i)

tests = [ [15, 'FizzBuzz'],
          [30, 'FizzBuzz'],
          [60, 'FizzBuzz'],
          [75, 'FizzBuzz'],
          [3, 'Fizz'],
          [6, 'Fizz'],
          [9, 'Fizz'],
          [12, 'Fizz'],
          [57, 'Fizz'],
          [18, 'Fizz'],
          [10, 'Buzz'],
          [20, 'Buzz'],
          [25, 'Buzz'],
          [55, 'Buzz'],
          [1, '1'],
          [97, '97'],
          ]

class Test_fb(unittest.TestCase):
    pass

def test_fb_(val, expected):

    def test(self):
        self.assertEqual(fbItem(val), expected)

    return test

def attach(where, desc, fun, l):
    """ Attaches tests sets based on params.
    DRY function helper. """
    for a, b in [(desc + str(x[0]), fun(*x)) for x in l]:
        setattr(where, a, b)

def suite():
    test_suite = unittest.TestSuite()
    attach(Test_fb, "test_fb_", test_fb_, tests)
    test_suite.addTest(unittest.makeSuite(Test_fb))
    return test_suite

if __name__ == '__main__':
    fb(MI, MA)
    print '-' * 60
    print 'Some tests:'
    mySuit = suite()
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(mySuit)
