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

R must be installed with an environment modulefile that adds it to your PATH.
(The R-roll provides this.)

netcdf must be installed with an environment modulefile that sets NETCDFHOME.
(The netcdf-roll provides this.)

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


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll r-modules
% cd /export/rocks/install
% rocks create distro
% rocks run roll r-modules | bash
```

## Testing

The r-modules-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/r-modules.t 
```
