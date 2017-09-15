# $< mean first requirement, $^ means all requirements, $@ means target
CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -Wstrict-prototypes -lm

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
BIN = bin

.PHONY: all
all: main run

.PHONY: cleanrun
cleanrun: clean main run

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: run
run: main
	@echo ''
	./$(BIN)

.PHONY: clean
clean:
	rm -f *.o $(BIN)
