REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

build:

$(VERSION_INC): $(VERSION2_SRC) $(VERSION3_SRC)
	/bin/grep 'VERSION.*=' $(VERSION2_SRC) | sed 's/VERSION/VERSION2/g' > $@
	/bin/grep 'VERSION.*=' $(VERSION3_SRC) | sed 's/VERSION/VERSION3/g' >> $@
	
install::
	mkdir -p $(ROOT)/$(PKGROOT)
	cp *.module $(ROOT)/$(PKGROOT)/$(VERSION)
	cp *.version $(ROOT)/$(PKGROOT)/.version.$(VERSION)
	perl -pi -e 's#ROLLCOMPILER#$(ROLLCOMPILER)#g;' \
	         -e 's#ROLLMPI#$(ROLLMPI)#g;' \
	         -e 's#ROLLNETWORK#$(ROLLNETWORK)#g;' \
	         -e 's#VERSION2#$(VERSION2)#g;' \
	         -e 's#VERSION3#$(VERSION3)#g;' \
	         -e 's#VERSION#$(VERSION)#g;' \
	  $(ROOT)/$(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/$(VERSION)
	ln -s $(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/.version

clean::
	rm -f $(VERSION_INC)
