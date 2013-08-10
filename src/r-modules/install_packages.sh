# installation script for R packages; pass installation root and openmpi root
# as arguments.

PKGROOT=${1:-/opt/R}
PATCHPATH=${2}
CRANURL=http://cran.stat.ucla.edu
yum -y install curl-devel
# R_LIBS might be needed for package dependencies
export R_LIBS=${PKGROOT}/local/lib
mkdir -p ${R_LIBS}

. /etc/profile.d/modules.sh
module load gdal
module load geos
module load proj

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


# biocLite can't be installed from cran
source("http://bioconductor.org/biocLite.R")
biocLite()

Sys.setenv(CPPFLAGS="-I /opt/proj/include")
Sys.setenv(LDFLAGS="-L /opt/proj/lib")
Sys.setenv(PKG_CPPFLAGS="-I /opt/proj/include")
Sys.setenv(PKG_LDFLAGS="-L /opt/proj/lib")
path<-Sys.getenv("LD_LIBRARY_PATH")
path<-paste("/opt/proj/lib:",path,sep="")
Sys.setenv(LD_LIBRARY_PATH=path)
# Other packages require no special handling
localPackages <- c(
  'abind',
  'akima',
  'alr3',
  'base64',
  'base64enc',
  'bdsmatrix',
  'bitops',
  'car',
  'colorspace',
  'combinat',
  'cubature',
  'DatABEL',
  'DBI',
  'devtools',
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
  'gridExtra',
  'gstat',
  'GWAF',
  'haplo.stats',
  'hexbin',
  'Hmisc',
  'ineq',
  'iterators',
  'kernlab',
  'knitr',
  'lattice',
  'ldlasso',
  'leaps',
  'lme4',
  'logspline',
  'maps',
  'maptools',
  'markdown',
  'matlab',
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
  'raster',
  'rattle',
  'RColorBrewer',
  'RCurl',
  'rgenoud',
  'rgeos',
  'rgl',
  'rjson',
  'rmeta',
  'robustbase',
  'ROCR',
  'RSAGA',
  'rworldmap',
  'RUnit',
  'scatterplot3d',
  'sem',
  'sgeostat',
  'SimHap',
  'slam',
  'sna',
  'sp',
  'spacetime',
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
END
# for whatever reason when rgdal is installed, it cant find /opt/proj files, so I hacked the configure script
/opt/R/bin/R CMD INSTALL ${PATCHPATH}/rgdal_0.8-9.tar.gz -l /opt/R/local/lib 
