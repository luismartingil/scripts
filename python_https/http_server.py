#
# This file is part of http_server.
#
# http_server is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# http_server is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with http_server.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Basic HTTP server.
# 
# Author: Luis Martin Gil
#         www.luismartingil.com
# Contact:
#         martingil.luis@gmail.com
#
# First version: lmartin, Dec 2011.
#

import string, cgi, time
from os import curdir, sep
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import time
import sys
 
response = '<response>This is the response</response>'
 
class MyHandler(BaseHTTPRequestHandler):
    def __init__(self, delay, *args):
        self.delay = delay  
        self.response = response
        self.subtype = 'application/xml'
        BaseHTTPRequestHandler.__init__(self, *args)
 
    def do_GET(self):
        try:
            time.sleep(self.delay)
            self.send_response(200)
            self.send_header('Content-Type', self.subtype)
            self.end_headers()
            self.wfile.write(self.response)
        except:
            self.send_error(404, 'GET return. File Not Found')
 
    def do_POST(self):
        try:
            time.sleep(self.delay)
            content_len = int(self.headers.getheader('content-length'))
            post_body = self.rfile.read(content_len)
            self.send_response(200)
            self.send_header('Content-Type', self.subtype)
            self.end_headers()
            self.wfile.write(self.response)
        except:
            self.send_error(404, 'POST return. File Not Found')
 
def main():
    if (len(sys.argv) == 4):
        host = sys.argv[1]
        port = sys.argv[2]
        delay = sys.argv[3]
 
        try:
            def handler(*args):
                MyHandler(int(delay), *args)
            server = HTTPServer((host, int(port)), handler)
            server.serve_forever()
        except KeyboardInterrupt:
            server.socket.close()
 
    else: 
        print "usage: python http_server.py <host> <port> <delay[s]>"
        sys.exit()
 
if __name__ == '__main__':
    main()
