NAME         = opt-python-modules
VERSION      = 1
RELEASE      = 4
PKGROOT      = /opt/modulefiles/compilers/python

VERSION2_SRC = $(REDHAT.ROOT)/src/python-2/version.mk
VERSION3_SRC = $(REDHAT.ROOT)/src/python-3/version.mk
VERSION_INC  = version.inc
include $(VERSION_INC)

RPM.EXTRAS   = AutoReq:No
