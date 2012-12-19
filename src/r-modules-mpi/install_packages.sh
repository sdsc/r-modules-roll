# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
MPIROOT=${2}
ROLLMPI=${3}
ROLLNETWORK=${4}
OPENMPIROOT=${5}
yum -y install curl-devel
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib/mpi/${ROLLMPI}/${ROLLNETWORK}
mkdir -p ${R_LIBS}

${PKGROOT}/bin/R --vanilla << END
# Specify where to pull package source from
CRANURL=http://cran.stat.ucla.edu
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
# MPI packages require some configuration arguments
mpiConfig <- c(
  "--with-mpi=${MPIROOT}"
)
localPackages <- c(
  'rlecuyer',
  'ncdf4'
)
for (package in localPackages) {
  install.packages(package, configure.args=mpiConfig, lib="${R_LIBS}", INSTALL_opts="--no-clean-on-error")
}
export R_LIBS=${PKGROOT}/local/lib/mpi/openmpi/${ROLLNETWORK}
mpiConfig <- c(
  "--with-mpi=${OPENMPIROOT}",
  "--with-Rmpi-type=OPENMPI"
)
install.packages('Rmpi', configure.args=mpiConfig, lib="${R_LIBS}",INSTALL_opts="--no-clean-on-error")
END
