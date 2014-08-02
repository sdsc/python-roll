#!/usr/bin/perl -w
# python roll installation test.  Usage:
# python.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/python';
my $output;

my @MODULES = (
  'numpy'
);
my @PYTHONS = ( 'python2', 'python3' );

my $TESTFILE = 'tmppython';

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
if test -f /etc/profile.d/modules.sh; then
  . /etc/profile.d/modules.sh
  module load python
  module load intel
fi
\$1 <<ENDPY
import \$2
help(\$2)
print "\$2 name %s" % \$2.__name__
ENDPY
END
close(OUT);

# python-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'python installed');
} else {
  ok(! $isInstalled, 'python not installed');
}
SKIP: {

  skip 'python not installed', 3 if ! $isInstalled;
  foreach my $python(@PYTHONS) {
    foreach my $module(@MODULES) {
      $output = `bash $TESTFILE.sh $python $module 2>&1`;
      like($output, qr/$module name/, "$module/$python module $module load works");
    }
  }

  skip 'modules not installed', 3 if ! -f '/etc/profile.d/modules.sh';
  `/bin/ls /opt/modulefiles/applications/python/[0-9]* 2>&1`;
  ok($? == 0, 'python module installed');
  `/bin/ls /opt/modulefiles/applications/python/.version.[0-9]* 2>&1`;
  ok($? == 0, 'python version module installed');
  ok(-l '/opt/modulefiles/applications/python/.version',
     'python version module link created');

}

# python-doc.xml
SKIP: {
  skip 'not server', 1 if $appliance ne 'Frontend';
  ok(-d '/var/www/html/roll-documentation/python', 'doc installed');
}

`rm -fr $TESTFILE*`;
