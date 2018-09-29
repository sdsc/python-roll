ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

# List of added modules sorted in dependency order
ADDED_MODULES = appdirs nose setuptools numpy pip pyparsing six python-dateutil pytz packaging Cython mock pbr funcsigs

NAME               = sdsc-python-3
VERSION            = 3.7.0
MAJOR.MINOR        = 3.7
RELEASE            = 0
PKGROOT            = /opt/python

SRC_SUBDIR         = python-3

SOURCE_NAME        = Python
SOURCE_SUFFIX      = tgz
SOURCE_VERSION     = $(VERSION)
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

APPDIRS_NAME       = appdirs
APPDIRS_SUFFIX     = tar.gz
APPDIRS_VERSION    = 1.4.3
APPDIRS_PKG        = $(APPDIRS_NAME)-$(APPDIRS_VERSION).$(APPDIRS_SUFFIX)
APPDIRS_DIR        = $(APPDIRS_PKG:%.$(APPDIRS_SUFFIX)=%)

CYTHON_NAME        = Cython
CYTHON_SUFFIX      = tar.gz
CYTHON_VERSION     = 0.28.5
CYTHON_PKG         = $(CYTHON_NAME)-$(CYTHON_VERSION).$(CYTHON_SUFFIX)
CYTHON_DIR         = $(CYTHON_PKG:%.$(CYTHON_SUFFIX)=%)

DATEUTILS_NAME     = python-dateutil
DATEUTILS_SUFFIX   = tar.gz
DATEUTILS_VERSION  = 2.7.3
DATEUTILS_PKG      = $(DATEUTILS_NAME)-$(DATEUTILS_VERSION).$(DATEUTILS_SUFFIX)
DATEUTILS_DIR      = $(DATEUTILS_PKG:%.$(DATEUTILS_SUFFIX)=%)

FUNCSIGS_NAME      = funcsigs
FUNCSIGS_SUFFIX    = tar.gz
FUNCSIGS_VERSION   = 1.0.2
FUNCSIGS_PKG       = $(FUNCSIGS_NAME)-$(FUNCSIGS_VERSION).$(FUNCSIGS_SUFFIX)
FUNCSIGS_DIR       = $(FUNCSIGS_PKG:%.$(FUNCSIGS_SUFFIX)=%)

MOCK_NAME          = mock
MOCK_SUFFIX        = tar.gz
MOCK_VERSION       = 2.0.0
MOCK_PKG           = $(MOCK_NAME)-$(MOCK_VERSION).$(MOCK_SUFFIX)
MOCK_DIR           = $(MOCK_PKG:%.$(MOCK_SUFFIX)=%)

NOSE_NAME          = nose
NOSE_SUFFIX        = tar.gz
NOSE_VERSION       = 1.3.7
NOSE_PKG           = $(NOSE_NAME)-$(NOSE_VERSION).$(NOSE_SUFFIX)
NOSE_DIR           = $(NOSE_PKG:%.$(NOSE_SUFFIX)=%)

NUMPY_NAME         = numpy
NUMPY_SUFFIX       = zip
NUMPY_VERSION      = 1.15.2
NUMPY_PKG          = $(NUMPY_NAME)-$(NUMPY_VERSION).$(NUMPY_SUFFIX)
NUMPY_DIR          = $(NUMPY_PKG:%.$(NUMPY_SUFFIX)=%)

PACKAGING_NAME     = packaging
PACKAGING_SUFFIX   = tar.gz
PACKAGING_VERSION  = 18.0
PACKAGING_PKG      = $(PACKAGING_NAME)-$(PACKAGING_VERSION).$(PACKAGING_SUFFIX)
PACKAGING_DIR      = $(PACKAGING_PKG:%.$(PACKAGING_SUFFIX)=%)

PBR_NAME           = pbr
PBR_SUFFIX         = tar.gz
PBR_VERSION        = 4.2.0
PBR_PKG            = $(PBR_NAME)-$(PBR_VERSION).$(PBR_SUFFIX)
PBR_DIR            = $(PBR_PKG:%.$(PBR_SUFFIX)=%)

PIP_NAME           = pip
PIP_SUFFIX         = tar.gz
PIP_VERSION        = 18.0
PIP_PKG            = $(PIP_NAME)-$(PIP_VERSION).$(PIP_SUFFIX)
PIP_DIR            = $(PIP_PKG:%.$(PIP_SUFFIX)=%)

PYPARSING_NAME     = pyparsing
PYPARSING_SUFFIX   = tar.gz
PYPARSING_VERSION  = 2.2.1
PYPARSING_PKG      = $(PYPARSING_NAME)-$(PYPARSING_VERSION).$(PYPARSING_SUFFIX)
PYPARSING_DIR      = $(PYPARSING_PKG:%.$(PYPARSING_SUFFIX)=%)

PYTZ_NAME          = pytz
PYTZ_SUFFIX        = zip
PYTZ_VERSION       = 2017.2
PYTZ_PKG           = $(PYTZ_NAME)-$(PYTZ_VERSION).$(PYTZ_SUFFIX)
PYTZ_DIR           = $(PYTZ_PKG:%.$(PYTZ_SUFFIX)=%)

SETUPTOOLS_NAME    = setuptools
SETUPTOOLS_SUFFIX  = zip
SETUPTOOLS_VERSION = 40.4.3
SETUPTOOLS_PKG     = $(SETUPTOOLS_NAME)-$(SETUPTOOLS_VERSION).$(SETUPTOOLS_SUFFIX)
SETUPTOOLS_DIR     = $(SETUPTOOLS_PKG:%.$(SETUPTOOLS_SUFFIX)=%)

SIX_NAME           = six
SIX_SUFFIX         = tar.gz
SIX_VERSION        = 1.11.0
SIX_PKG            = $(SIX_NAME)-$(SIX_VERSION).$(SIX_SUFFIX)
SIX_DIR            = $(SIX_PKG:%.$(SIX_SUFFIX)=%)

TGZ_PKGS           = $(SOURCE_PKG)
TAR_GZ_PKGS        = $(APPDIRS_PKG) $(CYTHON_PKG) $(DATEUTILS_PKG) $(FUNCSIGS_PKG) $(MOCK_PKG) $(NOSE_PKG) $(PACKAGING_PKG) $(PBR_PKG) $(PIP_PKG) $(PYPARSING_PKG) $(SIX_PKG)
ZIP_PKGS           = $(NUMPY_PKG) $(SETUPTOOLS_PKG) $(PYTZ_PKG)

RPM.EXTRAS         = AutoReq:No\n%global __os_install_post %{nil}
RPM.PREFIX         = $(PKGROOT)
