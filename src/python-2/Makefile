# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
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
#
# $Log$
# Revision 1.1  2013/08/22 17:07:44  jpg
#
#
# bring back python roll
#
# Revision 1.5  2012/11/27 00:49:12  phil
# Copyright Storm for Emerald Boa
#
# Revision 1.4  2012/10/23 01:15:06  clem
# fix for compilation of sqlite3 module in python 2.7.3
# http://bugs.python.org/issue14572
#
# Revision 1.3  2012/05/06 05:49:19  phil
# Copyright Storm for Mamba
#
# Revision 1.2  2011/07/23 02:31:16  phil
# Viper Copyright
#
# Revision 1.1  2011/06/03 00:18:48  anoop
# Python Roll.
#
# Include python 2.7.1 and python 3.2
#

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include pull.mk

RPM.EXTRAS += "AutoReqProv: no"

COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load gnu; \
  fi

NUMPY_COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module=`module avail 2>&1 | grep -o -m1 "\<$(ROLLCOMPILER)\>"`; \
    if test "$${module}" != "$(ROLLCOMPILER)"; then \
      echo *** ERROR: Compiler module $(ROLLCOMPILER) not found; \
      exit 2; \
    fi; \
    module load $(ROLLCOMPILER); \
  fi; \
  export COMMENTMKL='\#'; \
  export SETUPOPTS=''; \
  if test -n "$${MKL_ROOT}"; then \
    export COMMENTMKL=''; \
    export MKLLIB=`find $${MKL_ROOT}/lib/* -maxdepth 0 | head -1`; \
  fi; \
  if test "$(COMPILERNAME)" = "intel"; then \
    export SETUPOPTS="--compiler=intelem --fcompiler=intelem"; \
  fi


build: $(SRC_DIRS)
	gunzip -c $(ARCHIVENAME)-$(VERSION).$(TARBALL_POSTFIX) | $(TAR) -xf -
	patch -o $(NUMPY_DIR)/site.cfg $(NUMPY_DIR)/site.cfg.example patch-files/site.cfg.example.patch
	patch $(NUMPY_DIR)/numpy/distutils/intelccompiler.py patch-files/intelccompiler.py.patch
	patch $(NUMPY_DIR)/numpy/distutils/fcompiler/intel.py patch-files/intel.py.patch
	patch $(NUMPY_DIR)/numpy/distutils/system_info.py patch-files/system_info.py.patch
	( 					\
                $(COMPILERSETUP); \
		cd $(ARCHIVENAME)-$(VERSION);	\
		./configure --enable-shared --prefix=$(PKGROOT);\
		$(MAKE);			\
	)
	
install::
	mkdir -p $(ROOT)/$(PKGROOT)
	mkdir -p $(REDHAT.ROOT)/src/build-python-modules
	mount --bind $(ROOT)/$(PKGROOT) $(PKGROOT)
	(  \
                $(COMPILERSETUP); \
		cd $(ARCHIVENAME)-$(VERSION); \
                export LDFLAGS=-L$(PKGROOT)/lib; \
		$(MAKE) DESTDIR=/ altinstall; \
                $(NUMPY_COMPILERSETUP); \
                export PATH=$(PKGROOT)/bin:$${PATH}; \
                export LD_LIBRARY_PATH=$(PKGROOT)/lib:$${LD_LIBRARY_PATH}; \
                export LIBPATH=$(PKGROOT)/lib:$${LIBPATH}; \
                cd ../$(NUMPY_DIR); \
                perl -pi -e "s!ROLL_COMMENTMKL\\s*!$${COMMENTMKL}!; s!ROLL_MKLLIB!$${MKLLIB}!; s!ROLL_MKLROOT!$${MKL_ROOT}!" site.cfg; \
                python2.7 setup.py build_src \
                          config $${SETUPOPTS} \
                          build_clib $${SETUPOPTS} \
                          build_ext $${SETUPOPTS}; \
                python2.7 setup.py install --prefix=$(PKGROOT); \
		rm -rf $(PKGROOT)/bin/2to3; 				\
                cd $(PKGROOT)/bin;                                      \
                ln -s 2to3-3.3 2to3; \
                ln -s idle3.3 idle3; \
                ln -s pydoc3.3 pydoc3; \
                ln -s python3.3m-config python3.3-config; \
                ln -s python3.3-config python3-config; \
                ln -s python3.3 python3; \
                ln -s python2 python; \
                ln -s python2.7 python2; \
                ln -s python2.7-config python2-config; \
                ln -s python2-config python-config; \
	)
	-umount $(PKGROOT)
	cat python.module | perl -pi -e "s!MODULEROOT!/opt/modulefiles/applications/python!g;s!VERSION!$(VERSION)!g" \
          > $(REDHAT.ROOT)/src/build-python-modules/python.module


clean::
	rm -rf $(ARCHIVENAME)-$(VERSION)
