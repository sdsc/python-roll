NAME               = sdsc-python-27
VERSION            = 2.7.15
MAJOR.MINOR        = 2.7
RELEASE            = 2
PKGROOT            = /opt/python

ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

FILE_TYPES = .tgz .tar.gz .zip .xz .bz2
ZIP.CMD = $(UNZIP.CMD)
ZIP.OPTS = $(UNZIP.OPTS)
TAR.GZ.OPTS = $(TGZ.OPTS)

SOURCE_DIR = Python-$(VERSION)

PYTHON_SOURCE = Python-$(VERSION).tgz setuptools-40.4.3.zip appdirs-1.4.3.tar.gz  atomicwrites-1.3.0.tar.gz attrs-19.1.0.tar.gz  Cython-0.28.5.tar.gz funcsigs-1.0.2.tar.gz pbr-4.2.0.tar.gz mock-2.0.0.tar.gz scandir-1.10.0.tar.gz six-1.12.0.tar.gz pathlib2-2.2.0.tar.gz more-itertools-5.0.0.tar.gz nose-1.3.7.tar.gz pyparsing-2.2.1.tar.gz packaging-18.0.tar.gz  pip-18.0.tar.gz setuptools_scm-3.3.3.tar.gz pluggy-0.11.0.tar.gz py-1.8.0.tar.gz pytest-3.8.2.tar.gz python-dateutil-2.7.3.tar.gz pytz-2017.2.zip

PYTHON_PACKAGES = $(foreach PACKAGE, $(PYTHON_SOURCE),$(subst $(strip $(foreach FILE_TYPE,$(FILE_TYPES),$(findstring $(FILE_TYPE),$(PACKAGE)))), ,$(PACKAGE)))


SRC_SUBDIR         = python-2

$(PYTHON_PACKAGES):$(PYTHON_SOURCE)
	$(eval PYTHON_PACKAGE_TYPE = $(strip $(subst $(strip $(foreach FILE_TYPE,$(FILE_TYPES),$(findstring $(FILE_TYPE),$@))), ,$@)))
	$(eval PYTHON_PACKAGE  = $(shell echo $(PYTHON_PACKAGE_TYPE) |sed 's/-[[:digit:]].[[:digit:]].[[:digit:]].[[:digit:]]\+//g'| sed 's/-[[:digit:]][[:digit:]].[[:digit:]].[[:digit:]]\+//g'|sed 's/-[[:digit:]].[[:digit:]][[:digit:]].[[:digit:]]\+//g'|sed 's/-[[:digit:]].[[:digit:]].[[:digit:]]\+//g' | sed 's/-[[:digit:]][[:digit:]].[[:digit:]]\+//g' |sed 's/-[[:digit:]].[[:digit:]]\+//g' ))
	$(eval UPPER = $(shell echo $(PYTHON_PACKAGE) |tr a-z A-Z))
	$(eval $(UPPER)_VERSION  = $(shell echo $(PYTHON_PACKAGE_TYPE) | sed 's/$(PYTHON_PACKAGE)-//'))
	$(eval $(UPPER)_NAME  = $(PYTHON_PACKAGE))
	$(eval PACKAGE_SOURCE = $(strip $(foreach FILE,$(FILE_TYPES),$(findstring $(PYTHON_PACKAGE_TYPE)$(FILE),$(PYTHON_SOURCE) ) )))
	$(eval FILE_TYPE_DOT = $(strip $(foreach FILE_TYPE,$(FILE_TYPES),$(findstring $(FILE_TYPE),$(PACKAGE_SOURCE)' ))))
	$(eval $(UPPER)_SUFFIX = $(shell echo $(FILE_TYPE_DOT) |sed 's/^\.//'))
	$(eval UPPER_OPTS = $(shell echo $($(UPPER)_SUFFIX) |tr a-z A-Z))
	$(eval $(UPPER)_PKG = $($(UPPER)_NAME)-$($(UPPER)_VERSION).$($(UPPER)_SUFFIX))
	$(eval $(UPPER)_DIR = $($(UPPER)_PKG:%.$($(UPPER)_SUFFIX)=%))
	$(eval PYTHON_NAMES += $($(UPPER)_NAME))
	if [ ! -e "$@" ]; then \
           if test "`echo $($(UPPER)_SUFFIX)|tr a-z A-Z`" = "ZIP"; then \
              $(UNZIP.CMD) $(UNZIP.OPTS) $(PACKAGE_SOURCE); \
           else \
              $(TAR.CMD) $($(UPPER_OPTS).OPTS) $(PACKAGE_SOURCE); \
           fi; \
        else \
              echo "::: $@ unbundled Skipping... :::" ; \
        fi; \
	echo ""


$(PYTHON_SOURCE):
	echo "::: Downloading $(DL.SERVER)/$(DL.PATH)/$@  :::"; \
           if [ -f $@ ]; then \
                echo "::: $@ exists. Skipping... :::" ; \
           else \
                $(DL.CMD) $(DL.OPTS) $(DL.SERVER)/$(DL.PATH)/$@ ; \
                echo "::: Verifying size of $@ :::" ; \
                $(GREP.CMD) `$(STAT.CMD) --printf="%s" $@` $(VERIFY.HASHES) ; \
                echo "::: Verifying hash of $@ :::" ; \
                $(GREP.CMD) `$(VERIFY.CMD) $(VERIFY.OPTS) $@ ` $(VERIFY.HASHES) ; \
                echo "" ; \
           fi; \
	   echo "::: Unbundling $(PACKAGE_SOURCE) :::"; \



RPM.EXTRAS         = AutoReq:No\n%global __os_install_post %{nil}
RPM.PREFIX         = $(PKGROOT)
