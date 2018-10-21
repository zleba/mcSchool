example-1.html: example-1.ipynb
	jupyter nbconvert --to html --execute $^ --output $@

example-1.ipynb: example-1.md
	notedown $^ > $@

clean:
	rm -f *.html *.ipynb
