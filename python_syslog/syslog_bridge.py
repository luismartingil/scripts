#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
Implements a new handler for the logging module which uses the pure syslog python module.

@author:  Luis Martin Gil
@year: 2013
'''
import logging
import syslog

class SysLogLibHandler(logging.Handler):
    """A logging handler that emits messages to syslog.syslog."""
    FACILITY = [syslog.LOG_LOCAL0,
                syslog.LOG_LOCAL1,
                syslog.LOG_LOCAL2,
                syslog.LOG_LOCAL3,
                syslog.LOG_LOCAL4,
                syslog.LOG_LOCAL5,
                syslog.LOG_LOCAL6,
                syslog.LOG_LOCAL7]
    def __init__(self, n):
        """ Pre. (0 <= n <= 7) """
        try:
            syslog.openlog(logoption=syslog.LOG_PID, facility=self.FACILITY[n])
        except Exception , err:
            try:
                syslog.openlog(syslog.LOG_PID, self.FACILITY[n])
            except Exception, err:
                raise
        # We got it
        logging.Handler.__init__(self)

    def emit(self, record):
        syslog.syslog(self.format(record))

if __name__ == '__main__':
    """ Lets play with the log class. """
    # Some variables we need
    _id = 'myproj_v2.0'
    logStr = 'debug'
    logFacilityLocalN = 1

    # Defines a logging level and logging format based on a given string key.
    LOG_ATTR = {'debug': (logging.DEBUG,
                          _id + ' %(levelname)-9s %(name)-15s %(threadName)-14s +%(lineno)-4d %(message)s'),
                'info': (logging.INFO,
                         _id + ' %(levelname)-9s %(message)s'),
                'warning': (logging.WARNING,
                            _id + ' %(levelname)-9s %(message)s'),
                'error': (logging.ERROR,
                          _id + ' %(levelname)-9s %(message)s'),
                'critical': (logging.CRITICAL,
                             _id + ' %(levelname)-9s %(message)s')}
    loglevel, logformat = LOG_ATTR[logStr]

    # Configuring the logger
    logger = logging.getLogger()
    logger.setLevel(loglevel)

    # Clearing previous logs
    logger.handlers = []

    # Setting formaters and adding handlers.
    formatter = logging.Formatter(logformat)
    handlers = []
    handlers.append(SysLogLibHandler(logFacilityLocalN))
    for h in handlers:
        h.setFormatter(formatter)
        logger.addHandler(h)

    # Yep!
    logging.debug('test debug')
    logging.info('test info')
    logging.warning('test warning')
    logging.error('test error')
    logging.critical('test critical')