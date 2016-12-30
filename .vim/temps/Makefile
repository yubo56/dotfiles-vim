CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -Wstrict-prototypes -lm

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: main run

.PHONY: cleanrun
cleanrun: clean main run

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

.PHONY: main
main: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BIN)

.PHONY: run
run: main
	@echo ''
	./$(BIN)

.PHONY: clean
clean:
	rm -f *.o $(BIN)
