#ROOT includes + libraries
ROOTCFLAGS = $(shell root-config --cflags)
ROOTLIBS   = $(shell root-config --libs)


#Debugging info + allWarnings + level-3 optimalisation
CFLAGS=-g -Wall -O3

all: example-1 example-2 example-3 example-4 example-5 example-6 example-7 example-8 example-9 example-lhapdf

allRun: example1.txt example2.txt example3.txt example4.txt example5.txt example6.txt example7.txt example8.txt example9.txt examplelhapdf.txt

example%.txt: example-%
	./$^ | tee $@

# Rule to compile examples
example-%: example-%.cc ranlxd.o
	g++ $(CFLAGS) $(ROOTCFLAGS)   $^  $(ROOTLIBS)  -o $@ 

example-9: example-9.cc getpdf.o ranlxd.o
	g++  $(CFLAGS) $(ROOTCFLAGS)  $^  $(ROOTLIBS)  -o $@ 

# Rule to compile Ranlux
ranlxd.o: ranlxd.cc
	g++ $(CFLAGS) -DSSE -c  $^ -o $@  


getpdf.o: getpdf.cc
	g++  $(CFLAGS) -c  $^ -o $@  


clean:
	rm -f *.o example-? example-lhapdf



#LHAPDF includes + libraries
isLHA := $(shell which lhapdf-config > /dev/null; echo $$?)
ifeq ($(isLHA),0)
LHALIBS = $(shell lhapdf-config --libdir)
LHAINC  = $(shell lhapdf-config --incdir)
else
LHAdir=/afs/desy.de/user/z/zlebcr/public/mcSchool/lhapdf5/install
LHALIBS = $(LHAdir)/lib
LHAINC  = $(LHAdir)/include
endif

example-lhapdf: example-lhapdf.cc ranlxd.o
	g++  $(CFLAGS) $(ROOTCFLAGS) -I$(LHAINC)  $^  $(ROOTLIBS) -L$(LHALIBS) -lLHAPDF -Wl,-rpath=$(LHALIBS)   -o $@ 

