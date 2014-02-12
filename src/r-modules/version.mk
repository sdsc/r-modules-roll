NAME               = r-modules
RELEASE            = 0
PKGROOT            = /opt/R

SRC_SUBDIR         = r-modules

SOURCE_SUFFIX      = tar.gz

RGDAL_NAME         = rgdal
RGDAL_VERSION      = 0.8-16
RGDAL_PKG          = $(RGDAL_NAME)_$(RGDAL_VERSION).$(SOURCE_SUFFIX)
RGDAL_DIR          = $(RGDAL_PKG:%.$(SOURCE_SUFFIX)=%)

RJAGS_NAME         = rjags
RJAGS_VERSION      = 3-12
RJAGS_PKG          = $(RJAGS_NAME)_$(RJAGS_VERSION).$(SOURCE_SUFFIX)
RJAGS_DIR          = $(RJAGS_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(RGDAL_PKG) $(RJAGS_PKG)

RPM.EXTRAS         = AutoReq:No
