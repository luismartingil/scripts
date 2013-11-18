#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    csv2mysql.py
    ~~~~~~~~~~~~

    Importing script which reads a csv file and writes it into a MySQL using peewee.

    Usage:
    csv2mysql.py -i <inputfile>

    Author:
    Luis Martin Gil. martingil.luis@gmail.com
    www.luismartingil.com
"""
import csv
import sys
import getopt
import DB1
import DB2

def write_to_database(ice):
    # Lets write in the database
    for db in [DB1, DB2]:
        #from pudb import set_trace; set_trace()
        for item in ice:
            try:
                ali_item = db.MyTable(**item)
                ali_item.save()
            except Exception, err:
                print err
            else:
                print '%s. Success adding elem:%s' % (db.database.database, item)
        print '-' * 60

class CSVContainer (object):
    replies = None
    def __init__(self, f):
        pos = {
            1 : 'val1',
            4 : 'val2',
            5 : 'val3',
            6 : 'val4'
            }
        self.replies = []
        with open(f, 'rb') as csvfile:
            spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
            for row in spamreader:
                elem = {}
                for index in pos.keys():
                    try:
                        item = row[index].strip('"')
                        if len(item):
                            elem[pos[index]] = item
                    except:
                        print 'Error while reading', index
                if len(elem):
                    self.replies.append(elem)

    def __str__(self):
        return str(self.replies)

    def __iter__(self):
        for item in self.replies:
            yield item

def main(argv):
    inputfile = 'input.csv'
    try:
        opts, args = getopt.getopt(argv,"hi:",["ifile="])
    except getopt.GetoptError:
        print 'csv2mysql.py -i <inputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'csv2mysql.py -i <inputfile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
    print 'Input file is', inputfile
    try:
        cont = CSVContainer(inputfile)
    except Exception, err:
        print 'Error while parsing file.', err
        sys.exit(2)
    print 'Succes while parsing file'
    print 'Writting into database'
    write_to_database(cont)

if __name__ == "__main__":
    main(sys.argv[1:])