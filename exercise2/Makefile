#ROOT includes + libraries
ROOTCFLAGS = $(shell root-config --cflags)
ROOTLIBS   = $(shell root-config --libs)

# Debugging informations + allWarnings + level-3 optimalisation
CFLAGS=-g -Wall -O2

all: example-6 example-7

# Rule to compile examples
example-%: example-%.cc ranlxd.o
	g++  $(CFLAGS) $(ROOTCFLAGS)  $^  $(ROOTLIBS)  -o $@ 

# Rule to compile Ranlux
ranlxd.o: ranlxd.cc
	g++  $(CFLAGS) -DSSE -c  $^ -o $@  

clean:
	rm -f *.o example-?
