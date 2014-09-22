ifndef ROLLMPI
  ROLLMPI = openmpi
endif

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

NAME       = R-module-collection_$(ROLLMPI)_$(ROLLNETWORK)
VERSION    = 1
RELEASE    = 0
PKGROOT    = /opt/R/local/lib

RPM.EXTRAS = AutoReq:No
