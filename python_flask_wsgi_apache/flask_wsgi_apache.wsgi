import sys

p = '/home/vagrant/_toremove/myenv-flask-test/src/'
sys.path.insert(0, p)

activate_this = '/home/vagrant/_toremove/myenv-flask-test/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))

from flask_wsgi_apache import app as application