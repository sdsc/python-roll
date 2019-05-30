REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

build:

$(VERSION_INC): $(VERSION_SRC) $(VERSION3_SRC)
	/bin/grep 'VERSION.*=' $(VERSION_SRC) > .tmp
	cat .tmp | /bin/grep -v eval  > $@
	/bin/grep 'VERSION.*=' $(VERSION3_SRC) | sed 's/VERSION/VERS3/g' > .tmp
	cat .tmp | /bin/grep -v eval  >> $@
	rm -f .tmp
	
install:: typical-modulefile-install
	# Additional replacement required for the Python modulefile
	perl -pi -e 's#VERS3#$(VERS3)#g;' \
	  $(ROOT)/$(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/$(VERSION)

clean::
	rm -f $(VERSION_INC)
