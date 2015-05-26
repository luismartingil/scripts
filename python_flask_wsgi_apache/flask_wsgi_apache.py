#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    flask_wsgi_apache.py
    ~~~~~~~~~~~~~~~~~~~~

    Test serving a Flask app using Apache.

    Author:
    Luis Martin Gil. martingil.luis@gmail.com
    www.luismartingil.com
"""

import logging
import time
import threading

from Protected import MyProtectedD

fmt = '%(threadName)20s %(asctime)s %(name)-12s %(levelname)-8s %(message)s'
logging.basicConfig(level=logging.DEBUG,
                    format=fmt,
                    filename='/tmp/flask_wsgi_apache.log',
                    filemode='w')

from flask import Flask
app = Flask(__name__)


# Protected object
pd = MyProtectedD(delay_lock=0.03,
                  delay_work=0.04)

# This thread simulates a concurrent task
# that uses the protected object
def f_background(_pd, pause):
    while True:
        ret = str(_pd)
        logging.info('> Sleeping...')
        time.sleep(pause)
        logging.info('< Waking up...')

t1 = threading.Thread(target=f_background,
                      name='thread-task',
                      args=(pd, 1.0))
t1.start()

# Flask routing
@app.route('/sub')
def f_sub():
    ret = pd.sub()
    return ret

@app.route('/add')
def f_add():
    ret = pd.add()
    return ret

@app.route('/')
def get():
    return str(pd)

if __name__ == '__main__':

    # Starting flask
    app.run(debug=True)
