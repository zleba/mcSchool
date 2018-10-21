all: example-1.ipynb example-2.ipynb
example-%.html: example-%.ipynb
	jupyter nbconvert --to html --execute $^ --output $@

example-%.py: example-%.ipynb
	jupyter nbconvert --to python $^

example-%.ipynb: example-%.md
	notedown $^ > $@

#clean:
	#rm -f *.html *.ipynb
