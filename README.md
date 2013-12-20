# SDSC "r-modules" roll

## Overview

This roll bundles the R packages listed below for local installation on compute
nodes.

For more information about the various packages included in the r-modules roll
please visit their official web pages which can generally be reached by
appending the R module name to the following URL...

[http://cran.r-project.org/web/packages](http://cran.r-project.org/web/packages)

```
abind       ellipse      iterators   modeltools    rgdal          sna     
akima       epitools     kernlab     multcomp      rgenoud        sp      
alr3        foreach      knitr       multicore     rgeos          spacetime
base64      Formula      lattice     ncdf4         rgl            SparseM 
base64enc   fts          ldlasso     network       rjson          statmod 
bdsmatrix   gap          leaps       nlme          rlecuyer       survey  
biocLite    gee          lme4        numDeriv      rmeta          tcltk2  
bitops      geepack      logspline   nws           Rmpi           timeDate
car         GenABEL      maps        oz            robustbase     tis     
colorspace  genetics     maptools    PBSmodelling  ROCR           tkrplot 
combinat    ggplot2      markdown    PredictABLE   RSAGA          tripack 
cubature    gridExtra    matlab      pspline       RUnit          urca    
DatABEL     gstat        mboost      quadprog      rworldmap      VGAM    
DBI         GWAF         mclust      randomForest  scatterplot3d  xtable  
devtools    haplo.stats  MCMCpack    raster        sem            zoo     
doMC        hexbin       miscTools   rattle        sgeostat
e1071       Hmisc        mix         RColorBrewer  SimHap  
Ecdat       ineq         mlbench     RCurl         slam    
```

## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you will *not* be able to build the r-modules roll as it downloads packages from CRAN directly during the roll building process.

Search online for "R CRAN proxy" to find instructions on how to proxy CRAN traffic and built the r-modules roll.

Your development appliance must also have the OS package curl-devel installed to allow R to download packages from CRAN.


## Dependencies

The following Rocks rolls must be installed *before* attempting to build the r-modules roll:

- [gnucompiler-roll](https://github.com/sdsc/gnucompiler-roll/)
- [gdal-roll](https://github.com/sdsc/gdal-roll/)
- [geos-roll](https://github.com/sdsc/geos-roll/)
- [proj-roll](https://github.com/sdsc/proj-roll/)


## Building

To build the r-modules-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make default 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `r-modules-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.

This roll source supports building for different network fabrics and mpi
flavors.  By default, it builds for openmpi ethernet.  To build for a different
configuration, use the `ROLLMPI` and `ROLLNETWORK` make variables, e.g.,

```shell
% make ROLLMPI=mpich2 ROLLNETWORK=mx 
```

The build process currently supports `ROLLMPI` values "openmpi", "mpich2", and
"mvapich2", defaulting to "openmpi".  It uses any `ROLLNETWORK` variable
value(s) to load appropriate mpi modules, assuming that there are modules named
`$(ROLLMPI)_$(ROLLNETWORK)` available (e.g., openmpi_ib, mpich2_mx, etc.).


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll r-modules
% cd /export/rocks/install
% rocks create distro
% rocks run roll r-modules | bash
```
