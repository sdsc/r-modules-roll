# SDSC "r-modules" roll


## Overview

This roll bundles a collection of R modules for local installation on Rocks
compute nodes.  See the file R-module-list for the include set of modules.

For more information about the various packages included in the r-modules roll
please visit their official web pages which can generally be reached by
appending the R module name to the following URL...

[http://cran.r-project.org/web/packages](http://cran.r-project.org/web/packages)

## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you will *not* be able to build the r-modules roll as it downloads packages from CRAN directly during the roll building process.

Search online for "R CRAN proxy" to find instructions on how to proxy CRAN traffic and built the r-modules roll.

Your development appliance must also have the OS package curl-devel installed to allow R to download packages from CRAN.


## Dependencies

yum install libxml2-devel

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler, R, and mpi
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.

The build process requires the NETCDF libraries and assumes that the netcdf
modulefile provided by the SDSC netcdf-roll is available.  It will build without
the modulefile as long as the environment variables it provides are otherwise
defined.


## Building

To build the r-modules-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `r-modules-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers and for different
MPI flavors.  The `ROLLCOMPILER` and `ROLLMPI` make variables can be used to
specify the names of compiler and MPI modulefiles to use for building the
software, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable; any MPI modulefile name may be used as the value of
the `ROLLMPI` variable.  The default values are "gnu" and "rocks-openmpi".

NOTE: it is essential that the ROLLCOMPILER value used in the r-modules-roll
build match the one used to build R-roll, so that R will use the MPI library
with the correct parameter passing convention.


## Installation

To install, first execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll r-modules
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents of
the r-modules-roll.

To avoid cluttering the cluster frontend with unused software, the r-modules-roll is
configured to install only on compute and login nodes. To force installation on
your frontend, run this command after adding the r-modules-roll to your distro

```shell
% rocks run roll r-modules host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.


## Testing

The r-modules-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/r-modules.t 
```
