# $< mean first requirement, $^ means all requirements, $@ means target
BIN = main
TEX_FN = hw

CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -Wstrict-prototypes -lm
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: $(BIN) run

.PHONY: cleanrun
cleanrun: clean $(BIN) run

.PHONY: run
run: $(BIN)
	@echo ''
	./$(BIN)

.PHONY: clean
clean:
	rm -f *.o $(BIN)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BIN)

$(TEX_FN).pdf: $(TEX_FN).tex $(BIN)
	compiletex $(TEX_FN).tex
