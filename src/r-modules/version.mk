ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME       = sdsc-R-module-collection
VERSION    = 2
RELEASE    = 1
PKGROOT    = /opt/R/local/lib

RPM.EXTRAS = AutoReq:No
