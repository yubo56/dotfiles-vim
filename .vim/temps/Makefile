CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -Wstrict-prototypes -lm

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
BIN = main
TEX_FN = hw

.PHONY: all
all: ${BIN} run

.PHONY: cleanrun
cleanrun: clean ${BIN} run

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

.PHONY: ${BIN}
${BIN}: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $(BIN)

.PHONY: run
run: ${BIN}
	@echo ''
	./$(BIN)

.PHONY: clean
clean:
	rm -f *.o $(BIN)

${TEX_FN}.pdf: ${TEX_FN}.tex ${SRCS}
	compiletex ${TEX_FN}.tex
