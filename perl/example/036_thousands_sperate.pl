#! /usr/bin/env perl
#################################################################################
#     File Name           :     036_thousands_sperate.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-08 23:15]
#     Last Modified       :     [2018-05-08 23:19]
#     Description         :      
#################################################################################

use strict;
use warnings;

print commify(6873504617419), "\n"; 
print commify(68735046174190.32634523), "\n"; 
print commify("68735046174190.32634523"), "\n"; 
print commify(26873504617419032634523), "\n"; 
print commify("26873504617419032634523"), "\n"; 

sub commify {
    $_ = $_[0];
    while ( s/(^[+-]?\d+)(\d{3})/$1,$2/ ) {};
    return $_;
}


