PACKAGE      = python
CATEGORY     = compilers

NAME         = opt-$(PACKAGE)-modules
RELEASE      = 5
PKGROOT      = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION2_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)-2/version.mk
VERSION3_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)-3/version.mk
VERSION_INC  = version.inc
include $(VERSION_INC)

RPM.EXTRAS   = AutoReq:No
