all:     example-1.ipynb example-2.ipynb example-3.ipynb example-4.ipynb example-5.ipynb example-lhapdf.ipynb
allhtml: example-1.html example-2.html example-3.html example-4.html example-5.html example-lhapdf.html
example-%.html: example-%.ipynb
	jupyter nbconvert --to html --execute $^ --output $@

example-%.py: example-%.ipynb
	jupyter nbconvert --to python $^

example-%.ipynb: example-%.md
	notedown $^ > $@

#clean:
	#rm -f *.html *.ipynb
