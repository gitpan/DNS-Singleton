use strict;
use Test::More tests => 1;
my $pkg = 'DNS::Singleton';

# Test documentation
use Pod::Coverage;
my $pc = Pod::Coverage->new(package => $pkg);
ok($pc->coverage == 1, "POD Coverage");


