# In order for nosetests to be named correctly we MUST build python-3 before 
# python-27
SRCDIRS = `find . -maxdepth 1 -type d \
	-not -name CVS \
	-not -name . \
	-not -name python-2` \
	python-2

