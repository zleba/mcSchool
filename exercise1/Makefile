#ROOT includes + libraries
ROOTCFLAGS = $(shell root-config --cflags)
ROOTLIBS   = $(shell root-config --libs)

#Debugging informations + allWarnings + level-3 optimalisation
CFLAGS=-g -Wall -O3

all: example-1 example-2 example-3 example-4 example-5

# Rule to compile examples
example-%: example-%.cc ranlxd.o
	g++  $(CFLAGS) $(ROOTCFLAGS)   $^  $(ROOTLIBS)  -o $@ 

# Rule to compile Ranlux
ranlxd.o: ranlxd.cc
	g++  $(CFLAGS) -DSSE -c  $^ -o $@  

clean:
	rm -f *.o example-?
