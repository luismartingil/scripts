#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
tcpc.py

Basic snippet tcp client using a reconnection concept.

Author: luismartingil

'''

import socket
import traceback
import time

def connect (log, host, port, precon, pdelta, preconMax, tcpTimeout): 
    '''
    Opens a basic TCP connection.
    '''
    log.debug('connecting to host:%s, port:%s, precon:%s, pdelta:%s, preconMax:%s, tcpTimeout:%s' 
              % (host, port, precon, pdelta, preconMax, tcpTimeout))
    sock, connected, preconTmp = None, False, precon
    while (not connected):
        try:
            sock = None
            sock = socket.socket()
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
            sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
            sock.connect((host, int(port)))
            sock.settimeout(tcpTimeout)
            log.debug('socket:%s connected to %s:%s' % (sock, host, port))
            connected = True
        except:
            if (preconTmp < preconMax): preconTmp += pdelta
            else: preconTmp = preconMax
            trace = traceback.format_exc()
            log.error('Error while connecting to %s:%s. Sleeping:%s. Trace:%s. ' %
                      (host, port, preconTmp, repr(trace)))
            time.sleep(preconTmp)
    if connected: return sock
    else: raise Exception('Unable to connect to %s:%s' % (host, port))

if __name__ == '__main__':
    """ """
    pass
