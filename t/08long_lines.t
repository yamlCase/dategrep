#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/lib";
use Test::Dategrep;

$ENV{DATEGREP_DEFAULT_FORMAT} = '%Y-%m-%d %H:%M';

test_dategrep [
    '--start=2014-03-23 14:16', '--end=2014-03-23 14:18',
    '--blocksize=10',           '--multiline',
    "$Bin/files/multiline01.log"
  ],
  <<'EOF', 'test --multiline';
2014-03-23 14:16 line 1
                 more information
2014-03-23 14:17 line 1
                 more information
EOF

test_dategrep [
    '--start=2014-03-23 14:16',          '--end=2014-03-23 14:18',
    '--blocksize=1024',                  '--multiline',
    '--format=%a %b %d %T(.[0-9]+)? %Y', "$Bin/files/long_lines.log"
  ],
  <<'EOF', 'test --multiline';
EOF

done_testing();
