#! /usr/bin/env perl
#################################################################################
#     File Name           :     StringUtils.pm
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 21:46]
#     Last Modified       :     [2018-04-08 22:32]
#     Description         :      
#################################################################################

use strict;
use warnings;

sub zombify {
    my $word=shift @_;
    $word =~ s/[aeiou]/r/g;
    return $word;
}
return 1;


