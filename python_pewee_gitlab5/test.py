#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
Tests gitlab5.py

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

https://github.com/luismartingil
www.luismartingil.com
'''
from gitlab5 import database, Projects, Users
from pprint import pprint

d = {}

# Prints a dict with { owner : list of projects the owner owns}
for p in Projects.select():
    creator = p.creator
    author_name = Users.get(Users.id == p.creator).name
    if d.has_key(author_name):
        d[author_name].append(p.name)
    else:
        d[author_name] = [p.name]

pprint(d)