#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
psutils_test.py

psutils testing to grab info about the actual running process/system,
giving back the information based on a valid-json python dict.

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

https://github.com/luismartingil
www.luismartingil.com
'''

import psutil
import json
import pprint
import os
import datetime

def process(ret_dict, prefix, function, jsonize, args, **kwargs):
    """ Basically executes the function with the given args / kawrgs and makes the result a valid-json
    based on the passed jsonize function """
    ret_obj, ret_json = None, None
    try:
        ret_obj = function(*args, **kwargs)
        try:
            ret_json = jsonize(ret_obj)
        except Exception, err:
            print err
    except Exception, err:
        print 'Error. %s' % err
    else:
        ret_dict.update({ '%s_%s' % (prefix, function.__name__): ret_json})

def get_cpu_stats(p):
    """ Will return some information of the process and system based on the psutil lib. Returned object
    is an json dict. """
    ret = {}
    process_prefix, system_prefix = 'process', 'system'
    # Defined structure to make the calls to process using the DRY concept.
    # [prefix, psutil_function, make_json_function, *tuple(args for psutil_function), *{kwargs for psutil_function}]
    # * are optionals parameters
    all_funs = [
        # process based stats
        [process_prefix, p.get_connections, lambda x: json.dumps([value._asdict() for value in x])],
        [process_prefix, p.get_open_files, lambda x: json.dumps([value.path for value in x])],
        [process_prefix, p.get_num_fds, lambda x: json.dumps(x)],
        [process_prefix, p.get_cpu_percent, lambda x: json.dumps(x), {'interval':0.005}],
        [process_prefix, p.get_memory_percent, lambda x: json.dumps("%.1f" % x)],
        [process_prefix, p.get_memory_info, lambda x: json.dumps(x._asdict())],
        [process_prefix, p.get_num_ctx_switches, lambda x: x._asdict()],
        [process_prefix, p.get_num_threads, lambda x: json.dumps(x)],
        # system stats
        [system_prefix, psutil.disk_usage, lambda x: json.dumps("%.1f" % x.percent), tuple('/')],
        [system_prefix, psutil.get_users, lambda x: json.dumps([value.name for value in x])],
        [system_prefix, psutil.get_boot_time, lambda x: json.dumps(datetime.datetime.fromtimestamp(x).strftime("%Y-%m-%d %H:%M:%S"))],
        [system_prefix, psutil.net_io_counters, lambda x: dict([(key, value._asdict()) for key, value in x.iteritems()]), dict(pernic=True)]
        ]
    # Lets go over the structure and prepare the parameters into 'params' to call the process()
    for items in all_funs:
        params = {'ret_dict' : ret, 'prefix' : items[0], 'function' : items[1], 'jsonize' : items[2], 'args' : tuple()} # Default, args = tuple()
        map(lambda x : params.update({'args' : x}), [x for x in items if isinstance(x, tuple)]) # If any tuple...
        map(lambda x : params.update(x), [x for x in items if isinstance(x, dict)]) # If any kwargs...
        process(**params)
    return ret

if __name__ == '__main__':
    # Lets go!
    p = psutil.Process(os.getpid())
    result = get_cpu_stats(p)
    pprint.pprint(result)

#     # Lets do some timing
#     import timeit
#     count = 1
#     do_str = """import psutil;
# import json;
# import pprint;
# import os;
# import datetime;
# p = psutil.Process(os.getpid());
# get_cpu_stats(p)"""
#     ret = timeit.timeit(do_str,
#                         setup="from __main__ import get_cpu_stats",
#                         number=count)
#     print ret/count

# Outputs
# {'process_get_connections': '[]',
#  'process_get_cpu_percent': '0.0',
#  'process_get_memory_info': '{"vms": 36503552, "rss": 7008256}',
#  'process_get_memory_percent': '"1.3"',
#  'process_get_num_ctx_switches': {'involuntary': 3, 'voluntary': 1},
#  'process_get_num_fds': '4',
#  'process_get_num_threads': '1',
#  'process_get_open_files': '[]',
#  'system_disk_usage': '"48.8"',
#  'system_get_boot_time': '"2013-10-01 12:46:26"',
#  'system_get_users': '["vagrant", "vagrant", "vagrant", "vagrant"]',
#  'system_net_io_counters': {'eth0': {'bytes_recv': 503688981,
#                                      'bytes_sent': 10942920,
#                                      'dropin': 0,
#                                      'dropout': 0,
#                                      'errin': 0,
#                                      'errout': 0,
#                                      'packets_recv': 640585,
#                                      'packets_sent': 150904},
#                             'eth1': {'bytes_recv': 8223685,
#                                      'bytes_sent': 15420230,
#                                      'dropin': 0,
#                                      'dropout': 0,
#                                      'errin': 0,
#                                      'errout': 0,
#                                      'packets_recv': 24874,
#                                      'packets_sent': 23454},
#                             'lo': {'bytes_recv': 1664,
#                                    'bytes_sent': 1664,
#                                    'dropin': 0,
#                                    'dropout': 0,
#                                    'errin': 0,
#                                    'errout': 0,
#                                    'packets_recv': 16,
#                                    'packets_sent': 16}}}