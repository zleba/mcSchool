#ROOT includes + libraries
ROOTCFLAGS = $(shell root-config --cflags)
ROOTLIBS   = $(shell root-config --libs)

# Debugging informations + level-2 optimalisation
CFLAGS=-g -O2

all: example-8 example-9

# Rule to compile examples
example-8: example-8.cc ranlxd.o
	g++  $(CFLAGS) $(ROOTCFLAGS)  $^  $(ROOTLIBS)  -o $@ 

example-9: example-9.cc getpdf.o ranlxd.o
	g++  $(CFLAGS) $(ROOTCFLAGS)  $^  $(ROOTLIBS)  -o $@ 

# Rule to compile Ranlux
ranlxd.o: ranlxd.cc
	g++  $(CFLAGS) -c  $^ -o $@  

getpdf.o: getpdf.cc
	g++  $(CFLAGS) -c  $^ -o $@  


clean:
	rm -f *.o example-?
