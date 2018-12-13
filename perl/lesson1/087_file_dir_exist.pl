#! /usr/bin/env perl
#################################################################################
#     File Name           :     087_file_dir_exist.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 00:44]
#     Last Modified       :     [2018-06-25 00:46]
#     Description         :      
#################################################################################

use strict;
use warnings;

if (-f "086_path_parse.pl")
{
    print "file exists\n";
}
else 
{
    print "file not exists\n";
}

if (-f "087_path_parse.pl")
{
    print "file exists\n";
}
else 
{
    print "file not exists\n";
}

if (-d "text")
{
    print "directory exists\n";
}
else 
{
    print "directory not exists\n";
}

if (-d "test")
{
    print "directory exists\n";
}
else 
{
    print "directory not exists\n";
}


