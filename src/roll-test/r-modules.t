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

SKIP: {
  my @RMODULES = (
    'tcltk2',
    'PBSmodelling',
    'PredicatABEL',
    'tkrplot',
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
    'degreenet',
    'e1071',
    'Ecdat',
    'ellipse',
    'epitools',
    'fEcofin',
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
    'PredictABEL',
    'pspline',
    'quadprog',
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
    'zoo',
    'Biobase',
  );
  skip 'R not installed', int(@RMODULES) + 1 if ! -d '/opt/R';
  $ENV{'R_LIBS'} = '/opt/R/local/lib';
  ok(-d $ENV{'R_LIBS'}, 'R library created');
  $output = `echo 'library()' | /opt/R/bin/R --vanilla`;
  foreach my $module(@RMODULES) {
    ok($output =~ /$module/, "$module R module installed");
  }
}
