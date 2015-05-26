Test serving a dummy HTTP service using Apache + WSGI + Flask.

Testing with ab:
```
	ab -n 1000000 -c 10 http://10.22.22.152/add
	ab -n 1000000 -c 10 http://10.22.22.152/sub
	ab -v 4 -n 1000000 -c 10 http://10.22.22.152/
```
