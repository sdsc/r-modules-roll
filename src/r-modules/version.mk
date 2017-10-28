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
RELEASE    = 10
PKGROOT    = /opt/R/local/lib

RPM.EXTRAS = AutoReq:No
RPM.PREFIX = $(PKGROOT)
