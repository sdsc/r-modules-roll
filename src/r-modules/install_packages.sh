# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
MPIROOT=${2}
CRANURL=http://cran.stat.ucla.edu
yum -y install curl-devel
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib
export LD_LIBRARY_PATH=/opt/lapack/gnu/lib:/opt/jags/lib:$LD_LIBRARY_PATH
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
  'rlecuyer'
)
for (package in localPackages) {
  install.packages(package, configure.args=mpiConfig, lib="${R_LIBS}",INSTALL_opts="--no-clean-on-error")
}
# tcltk2 load test hangs w/no DISPLAY env var
install.packages('tcltk2', lib="${R_LIBS}", INSTALL_opts=c("--no-test-load"))
# Other packages require no special handling
localPackages <- c(
  'abind',
  'akima',
  'alr3',
  'bdsmatrix',
  'bitops',
  'car',
  'colorspace',
  'combinat',
  'CompetingRiskFrailty',
  'cubature',
  'DatABEL',
  'DBI',
  'degreenet',
  'e1071',
  'Ecdat',
  'ellipse',
  'epitools',
  'fEcofin',
  'Formula',
  'fts',
  'fUtilities',
  'gap',
  'gee',
  'geepack',
  'GenABEL',
  'genetics',
  'ggplot2',
  'GWAF',
  'haplo.stats',
  'hexbin',
  'Hmisc',
  'ineq',
  'iterators',
  'kernlab',
  'kinship',
  'lattice',
  'ldlasso',
  'leaps',
  'lme4',
  'logspline',
  'maps',
  'mboost',
  'mclust',
  'MCMCpack',
  'miscTools',
  'mix',
  'mlbench',
  'modeltools',
  'multcomp',
  'multicore',
  'ncdf4',
  'network',
  'nlme',
  'numDeriv',
  'nws',
  'oz',
  'PBSmodelling',
  'PredictABEL',
  'pspline',
  'quadprog',
  'qvalue',
  'randomForest',
  'rattle',
  'RColorBrewer',
  'rgenoud',
  'rgl',
  'rjags',
  'rmeta',
  'robustbase',
  'ROCR',
  'RUnit',
  'scatterplot3d',
  'sem',
  'sgeostat',
  'SimHap',
  'slam',
  'sna',
  'sp',
  'SparseM',
  'statmod',
  'survey',
  'timeDate',
  'tis',
  'tkrplot',
  'tripack',
  'urca',
  'VGAM',
  'xtable',
  'zoo'

)
for (package in localPackages) {
  install.packages(package, lib="${R_LIBS}")
}
# One package not available via CRAN
source("http://bioconductor.org/biocLite.R")
biocLite("Biobase")
END

# These aren't available from CRAN
#${PKGROOT}/bin/R --vanilla CMD INSTALL -l ${PKGROOT}/local/lib Biobase*gz
