#! /usr/bin/env perl
#################################################################################
#     File Name           :     101_file_rename.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-28 18:30]
#     Last Modified       :     [2018-06-28 18:34]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $filename_old = "101_in_old.txt";
my $filename_new = "101_in_new.txt";

if(!safeRename($filename_old, $filename_new))
{
    print"rename error\n";
}
else 
{
    print"rename success\n";
}

sub safeRename
{
    my $old = shift;
    my $new = shift;

    return 1 if ( ($old eq $new) && -e $old);

    return 0 if (!-e $old || -e $new);

    rename($old, $new) or return 0;

    return 1;
}

