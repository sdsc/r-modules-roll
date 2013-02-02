# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
CRANURL=http://cran.stat.ucla.edu
yum -y install curl-devel
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib
mkdir -p ${R_LIBS}

${PKGROOT}/bin/R --vanilla << END
# Specify where to pull package source from
repos <- getOption("repos")
repos["CRAN"] = "${CRANURL}"
options(repos = repos)
# Some packages' load test hangs/fails w/no DISPLAY env var
localPackages <- c(
  'GenABEL',
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
  'cubature',
  'DatABEL',
  'DBI',
  'doMC',
  'e1071',
  'Ecdat',
  'ellipse',
  'epitools',
  'foreach',
  'Formula',
  'fts',
  'gap',
  'gee',
  'geepack',
  'genetics',
  'ggplot2',
  'GWAF',
  'haplo.stats',
  'hexbin',
  'Hmisc',
  'ineq',
  'iterators',
  'kernlab',
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
  'randomForest',
  'rattle',
  'RColorBrewer',
  'rgenoud',
  'rgl',
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
