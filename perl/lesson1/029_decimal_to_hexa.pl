#! /usr/bin/env perl
#################################################################################
#     File Name           :     029_decimal_to_hexa.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-05-02 03:36]
#     Last Modified       :     [2018-05-02 03:37]
#     Description         :      
#################################################################################

use strict;
use warnings;

printf("%X\n", 255);
printf("%x\n", 255);
printf("%X\n", 10);
printf("%02X\n", 10);
printf("%04X\n", 1535);

$_ = sprintf("%x\n", 1000);
print;



