all:     exerciseNb/example-1.ipynb exerciseNb/example-2.ipynb exerciseNb/example-3.ipynb exerciseNb/example-4.ipynb exerciseNb/example-5.ipynb   exerciseNb/example-6.ipynb   exerciseNb/example-7.ipynb    exerciseNb/example-8.ipynb  # exerciseNb/example-lhapdf.ipynb
allRun: exerciseNbDone/example-1.ipynb exerciseNbDone/example-2.ipynb exerciseNbDone/example-3.ipynb exerciseNbDone/example-4.ipynb exerciseNbDone/example-5.ipynb   exerciseNbDone/example-6.ipynb  exerciseNbDone/example-7.ipynb  exerciseNbDone/example-8.ipynb  #exerciseNbDone/example-lhapdf.ipynb
allPy:     exercisePy/example-1.py exercisePy/example-2.py exercisePy/example-3.py exercisePy/example-4.py exercisePy/example-5.py   exercisePy/example-6.py   exercisePy/example-7.py  exercisePy/example-8.py  #exercisePy/example-lhapdf.py

#
#example-%.py: example-%.ipynb
#	jupyter nbconvert --to python $^
#

exerciseNbDone/example-%.ipynb: exerciseNb/example-%.ipynb
	jupyter nbconvert --to notebook --execute  $^ --output ../$@
exerciseNbDone/example-lhapdf.ipynb: exerciseNb/example-lhapdf.ipynb
	jupyter nbconvert  --ExecutePreprocessor.timeout=80 --to notebook --execute  $^ --output ../$@

exercisePy/example-%.py: exerciseNb/example-%.ipynb
	jupyter nbconvert --to python   $^ --output ../$@
exercisePy/example-lhapdf.py: exerciseNb/example-lhapdf.ipynb
	jupyter nbconvert   --to python  $^ --output ../$@


exerciseNb/example-%.ipynb: exerciseMd/example-%.md
	notedown  $^  > $@
exerciseNb/example-lhapdf.ipynb: exerciseMd/example-lhapdf.md
	notedown $^   > $@


#clean:
	#rm -f *.html *.ipynb
