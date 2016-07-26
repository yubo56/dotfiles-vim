CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -Wstrict-prototypes -lm

CC = g++
CFLAGS = -g -Wall --std=c++0x

#command: dependencies
#	 $(CC) $(CFLAGS) programs.c

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o a.out
	
.PHONY: all clean
