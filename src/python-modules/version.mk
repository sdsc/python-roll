PACKAGE      = python
CATEGORY     = compilers

NAME         = sdsc-$(PACKAGE)-modules
RELEASE      = 11
PKGROOT      = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)-2/version.mk
VERSION3_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)-3/version.mk
VERSION_INC  = version.inc
include $(VERSION_INC)

RPM.EXTRAS   = AutoReq:No
RPM.PREFIX   = $(PKGROOT)
