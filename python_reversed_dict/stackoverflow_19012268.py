#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
stackoverflow_19012268.py

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

https://github.com/luismartingil
www.luismartingil.com
'''

class MyStopReversedList(list):
    """ Implements a list based on a reversed way to iterate over it.
    """
    def __init__(self, stop_item, list):
        self.stop_item = stop_item
        super(MyStopReversedList, self).__init__(list)

    def __iter__(self):
        """ Iterates the list until it reaches stop_item """
        while True:
            try:
                item = list.pop(self)
                if item is self.stop_item: break
                else: yield item
            except:
                break

if __name__ == "__main__":
    # Lets work on some examples
    examples = [
        {
            # Example1. Integers list
            'stop_item' : 3,
            'my_list' : [1, 2, 3, 4, 5, 6, 7, 8, 9, 3, 10, 11, 12, 13]
            },
        {
            # Example2. String
            'stop_item' : '/',
            'my_list' : "abc/123"
            }
        ]

    for example in examples:
        the_list = MyStopReversedList(example['stop_item'],
                                      example['my_list'])
        # Lets try to iterate over the list n times
        n = 4
        print 'Example', example
        for iteration in range(n):
            for item in the_list:
                print '(iteration:%i) %s' % (iteration, item)
            print '-' * 40
        print '\n'

    # Outputs
    # Example {'my_list': [1, 2, 3, 4, 5, 6, 7, 8, 9, 3, 10, 11, 12, 13], 'stop_item': 3}
    # (iteration:0) 13
    # (iteration:0) 12
    # (iteration:0) 11
    # (iteration:0) 10
    # ----------------------------------------
    # (iteration:1) 9
    # (iteration:1) 8
    # (iteration:1) 7
    # (iteration:1) 6
    # (iteration:1) 5
    # (iteration:1) 4
    # ----------------------------------------
    # (iteration:2) 2
    # (iteration:2) 1
    # ----------------------------------------
    # ----------------------------------------


    # Example {'my_list': 'abc/123', 'stop_item': '/'}
    # (iteration:0) 3
    # (iteration:0) 2
    # (iteration:0) 1
    # ----------------------------------------
    # (iteration:1) c
    # (iteration:1) b
    # (iteration:1) a
    # ----------------------------------------
    # ----------------------------------------
    # ----------------------------------------