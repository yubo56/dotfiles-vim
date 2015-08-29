CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -Wstrict-prototypes

CC = g++
CFLAGS = -g -Wall --std=c++0x

#command: dependencies
#	 $(CC) $(CFLAGS) programs.c

%.o: %.cpp
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f *.o testgraph
	
.PHONY: all clean
