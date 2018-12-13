#! /usr/bin/env perl
#################################################################################
#     File Name           :     071_remove_space_tab_side.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-20 22:28]
#     Last Modified       :     [2018-06-20 22:36]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $s="   AAAA BBB       CCC        ";
printf("[%s]\n", trim($s) );

my @a = ("     apple        ",
         "bed               ",
         "          cool    ",
         "      deal        ",
         );
@a = trim(@a);
#printf("[%s]", $_) foreach(@a);
printf("[%s]\n", $_) foreach(@a);


sub trim 
{
    my @result = @_;

    foreach (@result)
    {
        s/^\s+//;
        s/\s+$//;
    }

    return wantarray ? @result : $result[0];
}
