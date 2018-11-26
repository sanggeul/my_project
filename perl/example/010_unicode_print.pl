#! /usr/bin/env perl
#################################################################################
#     File Name           :     010_unicode_print.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-15 21:47]
#     Last Modified       :     [2018-04-17 23:19]
#     Description         :      
#################################################################################

use strict;
use warnings;

use encoding "utf8", STDOUT => "utf8";

#foreach my $i ( 0xac00 .. 0xd7a3 ) {
foreach my $i ( 0x0000 .. 0x0100 ) {
    printf("%04X : %s\n", $i, chr($i));
}


