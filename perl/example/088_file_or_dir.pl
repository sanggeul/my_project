#! /usr/bin/env perl
#################################################################################
#     File Name           :     088_file_or_dir.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 22:15]
#     Last Modified       :     [2018-06-25 22:17]
#     Description         :      
#################################################################################

use strict;
use warnings;

if (-f "test")
{
    print "test is filtest is filee\n";
}

if (-d "test")
{
    print "test is dir\n";
}

