#! /usr/bin/env perl
#################################################################################
#     File Name           :     044_unlink_rmdir.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 01:21]
#     Last Modified       :     [2018-06-19 01:48]
#     Description         :      
#################################################################################

use strict;
use warnings;

unlink "0.tst";
unlink "1.tst";

my $delCount = unlink <*.tst>;
print $delCount, " is/are removed\n";

print "delete failed\n" if !rmdir "1";

