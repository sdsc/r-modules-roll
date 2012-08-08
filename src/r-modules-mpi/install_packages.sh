# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
MPIROOT=${2}
ROLLMPI=${3}
ROLLNETWORK=${4}
CRANURL=http://cran.stat.ucla.edu
yum -y install curl-devel
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib/${ROLLMPI}/${ROLLNETWORK}
mkdir -p ${R_LIBS}

${PKGROOT}/bin/R --vanilla << END
# Specify where to pull package source from
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
# MPI packages require some configuration arguments
mpiConfig <- c(
  "--with-mpi=${MPIROOT}"
)
localPackages <- c(
  'Rmpi',
  'rlecuyer',
  'ncdf4'
)
for (package in localPackages) {
  install.packages(package, configure.args=mpiConfig, lib="${R_LIBS}", INSTALL_opts="--no-clean-on-error")
}
END
