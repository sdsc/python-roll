NAME		= opt-python-27
PKGROOT		= /opt/python
ARCHIVENAME    	= Python
VERSION 	= 2.7.3
RELEASE 	= 2
TARBALL_POSTFIX	= tgz

SRC_SUBDIR	= python-2

PYTHON2_NAME	= $(ARCHIVENAME)
PYTHON2_VERSION	= $(VERSION)

# List of *.tgz packages that are part of THIS package
TGZ_PKGS = $(PYTHON2_NAME)-$(PYTHON2_VERSION).$(TARBALL_POSTFIX)
