TARGET = crypt
CC = gcc
CFLAGS = -g -Wall -Wextra -Werror
LDFLAGS = -lm -lssl -lcrypto

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

.DEFAULT_GOAL := all

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o *~ *.crypt $(TARGET)

test: clean all
	./test.sh

all: clean $(OBJECTS)
	$(CC) $(OBJECTS) $(CFLAGS) -o $(TARGET) $(LDFLAGS)

.PHONY: default test clean all
