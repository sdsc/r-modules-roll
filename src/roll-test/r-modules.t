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
  foreach my $module(@RMODULES) {
    $module =~ s/:.*//;
    $output = `module load R ROLLMPI; /bin/echo "require($module, lib.loc='/opt/R/local/lib');(.packages())" | R --vanilla 2>&1`;
    like($output, qr/"$module"/, "$module R module loads");
  }
}
`/bin/rm -fr $TESTFILE*`;
