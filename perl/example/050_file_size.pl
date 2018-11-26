#! /usr/bin/env perl
#################################################################################
#     File Name           :     050_file_size.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 23:09]
#     Last Modified       :     [2018-06-19 23:12]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $i;

$i = -s "043_sort_hash.pl";
print "File Size: ", $i, " bytes\n";

if ($i > 1000)
{
    print "File is bigger than 1000 bytes\n";
}
else
{
    print "File is smaller than 1000 bytes\n";
}


