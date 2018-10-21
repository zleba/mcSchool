all:     exerciseNb/example-1.ipynb exerciseNb/example-2.ipynb exerciseNb/example-3.ipynb exerciseNb/example-4.ipynb exerciseNb/example-5.ipynb exerciseNb/example-lhapdf.ipynb  exerciseNb/example-6.ipynb exerciseNb/example-8.ipynb
allhtml: exerciseHtml/example-1.html exerciseHtml/example-2.html exerciseHtml/example-3.html exerciseHtml/example-4.html exerciseHtml/example-5.html exerciseHtml/example-lhapdf.html  exerciseHtml/example-6.html exerciseHtml/example-8.html

#
#example-%.py: example-%.ipynb
#	jupyter nbconvert --to python $^
#

exerciseHtml/example-%.html: exerciseNb/example-%.ipynb
	jupyter nbconvert --to html --execute $^ --output ../$@
exerciseHtml/example-lhapdf.html: exerciseNb/example-lhapdf.ipynb
	jupyter nbconvert --to html --execute $^ --output ../$@


exerciseNb/example-%.ipynb: exerciseMd/example-%.md
	notedown $^ > $@
exerciseNb/example-lhapdf.ipynb: exerciseMd/example-lhapdf.md
	notedown $^ > $@

#clean:
	#rm -f *.html *.ipynb
