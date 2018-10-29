INPUT  = $(wildcard exercisePy/example-[1-8].py)  exercisePy/example-lhapdf.py  exercisePy/example-dy.py exercisePy/example-hg.py
NbOutT = $(subst Py,Nb,${INPUT})
NbOut  = $(subst py,ipynb,${NbOutT})
NbOutD = $(subst Nb,NbExec,${NbOut})

all:   ${NbOut}  
allRun: ${NbOutD} 

exerciseNbExec/example-%.ipynb: exerciseNb/example-%.ipynb
	jupyter nbconvert  --ExecutePreprocessor.timeout=80 --to notebook --execute  $^ --output ../$@

exerciseNb/example-%.ipynb: exercisePy/example-%.py
	jupytext --to notebook  $^; mv  exercisePy/$(notdir $@) $@

