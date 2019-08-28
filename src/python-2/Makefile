#
# $Id$
#
# @Copyright@
#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzinita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk
.PHONY: $(PYTHON_PACKAGES)

SETUPOPTS =
WITHICC=
ifeq ("$(COMPILERNAME)", "intel")
  SETUPOPTS = --compiler=intelem --fcompiler=intelem
  WITHICC=--with-icc
endif

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_MKL) \
	) > $@

LICENSE: $(PYTHON_PACKAGES)
	for F in $(PYTHON_NAMES); do \
          if test "$${F}" != "Python"; then \
              if test -e $${F}-*/LICENSE; then \
	          cp $${F}-*/LICENSE $(SOURCE_DIR)/$$F-LICENSE; \
              fi; \
              if test -e $${F}-*/LICENSE.txt; then \
                  cp $${F}-*/LICENSE.txt $(SOURCE_DIR)/$$F-LICENSE.txt; \
              fi; \
              if test -e $${F}-*/PKG-INFO; then \
	          cp $${F}-*/PKG-INFO $(SOURCE_DIR)/$$F-PKG-INFO; \
              fi; \
          fi; \
	done
	$(CHECK_LICENSE_FILES)
	echo Python and LGPL and BSD and MIT and PSF > $@

build: $(PYTHON_PACKAGES)
	patch $(MORE-ITERTOOLS_DIR)/setup.py patch-files/setup.py-more-itertools.patch
	( \
	  $(MODULE_LOAD_CC); \
	  cd $(PYTHON_DIR); \
	  ./configure --enable-shared --prefix=$(PKGROOT) $(WITHICC); \
	  $(MAKE) \
	)
	
install:: $(PYTHON_PACKAGES)
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	$(PKGROOT_BIND_MOUNT)
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MKL); \
	  export PATH=$(PKGROOT)/bin:$${PATH}; \
	  export LD_LIBRARY_PATH=$(PKGROOT)/lib:$${LD_LIBRARY_PATH}; \
	  export LIBPATH=$(PKGROOT)/lib:$${LIBPATH}; \
	  for module in $(PYTHON_PACKAGES); do \
	    echo === Building $$module; \
	    cd $${module}; \
            if test "$${module}" = "$(PYTHON_DIR)"; then \
	       cd $(PYTHON_DIR); \
	       $(MAKE) DESTDIR=/ altinstall;\
	    elif [[ "$$module" =~ "Cython" ]]; then \
	      python$(MAJOR.MINOR) setup.py install --prefix=$(PKGROOT) --root=/ --single-version-externally-managed; \
	    else \
	      python$(MAJOR.MINOR) setup.py install --prefix=$(PKGROOT); \
	    fi; \
            cd ..; \
	  done; \
          cd $(PKGROOT)/bin; \
          ln -s python$(MAJOR.MINOR) python; \
          ln -s pytest pytest2.7; \
          ln -s py.test py.test2.7 \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)

clean::
	rm -rf $(PYTHON_PACKAGES) DESCRIPTION LICENSE
