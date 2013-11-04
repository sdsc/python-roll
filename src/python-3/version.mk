NAME		= opt-python-3
PKGROOT		= /opt/python
ARCHIVENAME    	= Python
VERSION 	= 3.3.2
RELEASE 	= 3
TARBALL_POSTFIX	= tgz

SRC_SUBDIR	= python-3

PYTHON3_NAME	= $(ARCHIVENAME)
PYTHON3_VERSION	= $(VERSION)

# List of *.tgz packages that are part of THIS package
TGZ_PKGS = $(PYTHON3_NAME)-$(PYTHON3_VERSION).$(TARBALL_POSTFIX)
