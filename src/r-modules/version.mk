ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME       = sdsc-R-module-collection
VERSION    = 1
RELEASE    = 3
PKGROOT    = /opt/R/local/lib

RPM.EXTRAS = AutoReq:No
