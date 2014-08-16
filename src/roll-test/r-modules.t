#!/usr/bin/perl -w
# r-modules roll installation test.  Usage:
# r-modules.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);
my @MPIS = split(/\s+/, 'openmpi mvapich2');
my @NETWORKS = split(/\s+/, 'ib');

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $isCompute = $appliance eq 'Compute';
my $isFe = $appliance eq 'Frontend';
my $isLogin = $appliance eq 'Login';
my $output;

my $TESTFILE = 'tmprmod';

SKIP: {
  my @RMODULES = (
  'abind',
  'akima',
  'alr3',
  'base64',
  'base64enc',
  'bdsmatrix',
  'Biobase',
  'bitops',
  'bnlearn',
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
  'Formula',
  'foreach',
  'fts',
  'gap',
  'gee',
  'geepack',
  'GenABEL',
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
  'PBSmodelling',
  'PredictABEL',
  'pspline',
  'quadprog',
  'randomForest',
  'raster',
  'rattle',
  'RColorBrewer',
  'RCurl',
  'rgenoud',
  'rjson',
  'robustbase',
  'rmeta',
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
  'tcltk2',
  'timeDate',
  'tis',
  'tkrplot',
  'tripack',
  'urca',
  'VGAM',
  'xtable',
  'zoo',
  );
  my @RMPIMODULES = (
     'Rmpi',
     'ncdf4',
     'rlecuyer'
  );
  skip 'R not installed', int(@RMODULES) + 1 if ! -d '/opt/R';
  $ENV{'R_LIBS'} = '/opt/R/local/lib';
  ok(-d $ENV{'R_LIBS'}, 'R library created');
  open(OUTPUT, ">$TESTFILE.sh");
    print OUTPUT <<END;
    . /etc/profile.d/modules.sh
    module load ROLLCOMPILER ROLLMPI_ROLLNETWORK R
    echo 'library()' | R --vanilla
END
   close(OUTPUT);
   $output = `/bin/bash $TESTFILE.sh 2>&1`;
   foreach my $module(@RMODULES) {
        ok($output =~ /$module/, "$module R module installed");
   }
  foreach my $mpi(@MPIS) {
    foreach my $network(@NETWORKS) {
      open(OUTPUT, ">$TESTFILE.sh");
      print OUTPUT <<END;
    . /etc/profile.d/modules.sh
       module load ROLLCOMPILER ROLLMPI_ROLLNETWORK R
       echo 'library()' | R --vanilla
END
      close(OUTPUT);
      $output = `/bin/bash $TESTFILE.sh 2>&1`;
      foreach my $module(@RMPIMODULES) {
        ok($output =~ /$module/, "$module R module ${mpi}_${network} installed");
      }
   }
  }
}
`/bin/rm -fr $TESTFILE*`;
