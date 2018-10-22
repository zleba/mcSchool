INPUT  = $(wildcard exerciseMd/example-[1-8].md)  exerciseMd/example-lhapdf.md
NbOutT = $(subst Md,Nb,${INPUT})
NbOut  = $(subst md,ipynb,${NbOutT})
NbOutD = $(subst Nb,NbExec,${NbOut})

all:   ${NbOut}  # exerciseNb/example-lhapdf.ipynb
allRun: ${NbOutD}  #exerciseNbExec/example-lhapdf.ipynb
allPy:     exercisePy/example-1.py exercisePy/example-2.py exercisePy/example-3.py exercisePy/example-4.py exercisePy/example-5.py   exercisePy/example-6.py   exercisePy/example-7.py  exercisePy/example-8.py  exercisePy/example-lhapdf.py

#
#example-%.py: example-%.ipynb
#	jupyter nbconvert --to python $^
#

exerciseNbExec/example-%.ipynb: exerciseNb/example-%.ipynb
	jupyter nbconvert  --ExecutePreprocessor.timeout=80 --to notebook --execute  $^ --output ../$@
exerciseNbExec/example-lhapdf.ipynb: exerciseNb/example-lhapdf.ipynb
	jupyter nbconvert  --ExecutePreprocessor.timeout=80 --to notebook --execute  $^ --output ../$@

exercisePy/example-%.py: exerciseNb/example-%.ipynb
	jupyter nbconvert --to python   $^ --output ../$@
exercisePy/example-lhapdf.py: exerciseNb/example-lhapdf.ipynb
	jupyter nbconvert --to python  $^ --output ../$@


exerciseNb/example-%.ipynb: exerciseMd/example-%.md
	notedown  $^  > $@
exerciseNb/example-lhapdf.ipynb: exerciseMd/example-lhapdf.md
	notedown $^   > $@


#clean:
	#rm -f *.html *.ipynb
