CC=gcc
CFLAGS=-c -g -Wall -fPIC -D_GNU_SOURCE
LDFLAGS=-lm -Wall
PARAMS=
MAIN=matrixZero.c
SOURCES=test_matrixZero.c $(MAIN) $(PARAMS)
OBJECTS=$(SOURCES:.c=.o)

LIBS=

all: $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o test

.c.o:
	$(CC) $(CFLAGS) $< -o $@
clean:
	rm -f test *.o *~