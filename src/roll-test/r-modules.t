#!/usr/bin/perl -w
# r-modules roll installation test.  Usage:
# r-modules.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);
my @RMODULES = split(/\s+/, "R_MODULES");

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $isCompute = $appliance eq 'Compute';
my $isFe = $appliance eq 'Frontend';
my $isLogin = $appliance eq 'Login';
my $output;

my $TESTFILE = 'tmprmod';

SKIP: {
  skip 'R not installed', int(@RMODULES) + 1 if ! -d '/opt/R';
  ok(-d '/opt/R/local/lib', 'R library created');
  $output = `module load R; R -q -e "library()" 2>&1`;
  foreach my $module(@RMODULES) {
    $module =~ s/:.*//;
    ok($output =~ /$module/, "$module R module installed");
  }
}
`/bin/rm -fr $TESTFILE*`;
