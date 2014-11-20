# In order for nosetests to be named correctly we MUST build python-3 before 
# python-27
SRCDIRS = `find . -type d -maxdepth 1 \
	-not -name CVS \
	-not -name . \
	-not -name python-2` \
	python-2

