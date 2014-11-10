#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    0001.py
    ~~~~~~~

    Project euler solution

    Author: luismartingil

"""

def magic(atoms, n):
    """ atoms is a list for multiples. 
    n max number """
    ret = None
    for i in range(1, n):
        if any(map(lambda x: (i % x == 0) , atoms)):
            ret = ret + i if ret else i
    return ret

if __name__ == "__main__":
    n = 10
    atoms = [3, 5]
    print magic(atoms, n)

    n = 1000
    atoms = [3, 5]
    print magic(atoms, n)

    n = 10000000
    atoms = [3, 5]
    print magic(atoms, n)
