#! /usr/bin/env perl
#################################################################################
#     File Name           :     030_dec_or_hex_to_bin.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-02 03:38]
#     Last Modified       :     [2018-05-02 04:02]
#     Description         :      
#################################################################################

use strict;
use warnings;

# hex to bin
printf("%b\n", 0xff);
printf("%#b\n", 0xff);

printf("%08b\n", 0x0);

printf("%016b\n", 0xffff);
printf("%#016b\n", 0xffff);

printf("%016b\n", 0x0);

printf("%032b\n", 0xff);
printf("%#032b\n", 0xff);

printf("%032b\n", 0x0);

# dec to bin
printf("%032b\n", 525323232);

my $s = sprintf "%032b\n", 525323232;
print $s, "\n";


