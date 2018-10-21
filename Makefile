all:     exerciseNb/example-1.ipynb exerciseNb/example-2.ipynb exerciseNb/example-3.ipynb exerciseNb/example-4.ipynb exerciseNb/example-5.ipynb exerciseNb/example-lhapdf.ipynb
#allhtml: example-1.html example-2.html example-3.html example-4.html example-5.html example-lhapdf.html
#example-%.html: example-%.ipynb
#	jupyter nbconvert --to html --execute $^ --output $@
#
#example-%.py: example-%.ipynb
#	jupyter nbconvert --to python $^
#
exerciseNb/example-%.ipynb: exerciseMd/example-%.md
	notedown $^ > $@
exerciseNb/example-lhapdf.ipynb: exerciseMd/example-lhapdf.md
	notedown $^ > $@

#clean:
	#rm -f *.html *.ipynb
