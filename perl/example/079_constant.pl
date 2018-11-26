#! /usr/bin/env perl
#################################################################################
#     File Name           :     079_constant.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 23:55]
#     Last Modified       :     [2018-06-21 00:00]
#     Description         :      
#################################################################################

use strict;
use warnings;

# single constant
use constant PI    => 3.14159265358979323846;
use constant SIZE  => 255;
use constant NAME  => "SG";

# multiple constant
use constant {
    SEC     => 0,
    MIN     => 1,
    HOUR    => 2,
    MDAY    => 3,
    MON     => 4,
    YEAR    => 5,
    WDAY    => 6,
    YDAY    => 7,
    ISDST   => 8,
};

# list constant
use constant WEEKDAYS => qw/ Sunday Monday Tuesday Wednesday Thursday Friday Saturday /;

print PI, "\n";
print SIZE, "\n";
print NAME, "\n";
print YEAR, "\n";
print WEEKDAYS, "\n";

