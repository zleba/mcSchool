INPUT  = $(wildcard exercisePy/example-[1-8].py)  exercisePy/example-lhapdf.py  exercisePy/example-dy.py exercisePy/example-hg.py
NbOutT = $(subst Py,Nb,${INPUT})
NbOut  = $(subst py,ipynb,${NbOutT})
NbOutD = $(subst Nb,NbExec,${NbOut})

all:   ${NbOut}  # exerciseNb/example-lhapdf.ipynb
allRun: ${NbOutD}  #exerciseNbExec/example-lhapdf.ipynb
allPy:     exercisePy/example-1.py exercisePy/example-2.py exercisePy/example-3.py exercisePy/example-4.py exercisePy/example-5.py   exercisePy/example-6.py   exercisePy/example-7.py  exercisePy/example-8.py  exercisePy/example-lhapdf.py

exerciseNbExec/example-%.ipynb: exerciseNb/example-%.ipynb
	jupyter nbconvert  --ExecutePreprocessor.timeout=80 --to notebook --execute  $^ --output ../$@

exerciseNb/example-%.ipynb: exercisePy/example-%.py
	jupytext --to notebook  $^; mv  exercisePy/$(notdir $@) $@

