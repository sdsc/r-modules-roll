NAME               = r-modules
RELEASE            = 8
PKGROOT            = /opt/R

SRC_SUBDIR         = r-modules


RPM.EXTRAS         = AutoReq:No

NLOPTR_NAME        = nloptr
NLOPTR_VERSION     = 1.0.0
NLOPTR_SUFFIX      = tar.gz
NLOPTR_PKG         = $(NLOPTR_NAME)_$(NLOPTR_VERSION).$(NLOPTR_SUFFIX)
NLOPTR_DIR         = nloptr

TAR_GZ_PKGS        = $(NLOPTR_PKG)
