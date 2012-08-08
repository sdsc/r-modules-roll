# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
CRANURL=http://cran.stat.ucla.edu
yum -y install curl-devel
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib
export LD_LIBRARY_PATH=/opt/lapack/gnu/lib:/opt/jags/lib:$LD_LIBRARY_PATH
export JAGS_INCLUDE=/opt/jags/include/JAGS
export JAGS_LIB=/opt/jags/lib
mkdir -p ${R_LIBS}

${PKGROOT}/bin/R --vanilla << END
# Specify where to pull package source from
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
# Some packages' load test hangs/fails w/no DISPLAY env var
localPackages <- c(
  'tcltk2',
  'PBSmodelling',
  'PredictABEL',
  'tkrplot'
)
for (package in localPackages) {
  install.packages(package, lib="${R_LIBS}", INSTALL_opts=c("--no-test-load"))
}
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
  'network',
  'nlme',
  'numDeriv',
  'nws',
  'oz',
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
