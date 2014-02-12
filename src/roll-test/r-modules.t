#!/usr/bin/perl -w
# r-modules roll installation test.  Usage:
# r-modules.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $isCompute = $appliance eq 'Compute';
my $isFe = $appliance eq 'Frontend';
my $isLogin = $appliance eq 'Login';
my $output;

my $TESTFILE = 'tmprmod';

SKIP: {
  my @RMODULES = (
  'tcltk2',
  'PBSmodelling',
  'PredictABEL',
  'tkrplot',
  'abind',
  'akima',
  'alr3',
  'bdsmatrix',
  'bitops',
  'bnlearn',
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
  'zoo',
  'Biobase',
  'Rmpi',
  'rlecuyer',
  'ncdf4'
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
  $output = `/bin/bash $TESTFILE.sh 2>&1`;
  foreach my $module(@RMODULES) {
    ok($output =~ /$module/, "$module R module installed");
  }
}

`/bin/rm -fr $TESTFILE*`;
