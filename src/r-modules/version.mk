ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME       = R-module-collection_$(MPINAME)
VERSION    = 1
RELEASE    = 2
PKGROOT    = /opt/R/local/lib

RPM.EXTRAS = AutoReq:No
