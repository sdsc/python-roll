REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

build:

$(VERSION_INC): $(VERSION2_SRC) $(VERSION3_SRC)
	/bin/echo 'VERSION = 1' > $@
	/bin/grep 'VERSION.*=' $(VERSION2_SRC) | sed 's/VERSION/VERSION2/g' >> $@
	/bin/grep 'VERSION.*=' $(VERSION3_SRC) | sed 's/VERSION/VERSION3/g' >> $@
	
install:: typical-modulefile-install
	# Additional replacement required for the Python modulefile
	perl -pi -e 's#VERSION2#$(VERSION2)#g;' \
	         -e 's#VERSION3#$(VERSION3)#g;' \
	  $(ROOT)/$(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/$(VERSION)

clean::
	rm -f $(VERSION_INC)
