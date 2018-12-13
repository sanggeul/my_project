#! /usr/bin/env perl
#################################################################################
#     File Name           :     StringUtils2.pm
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 21:46]
#     Last Modified       :     [2018-04-08 22:39]
#     Description         :      
#################################################################################

use strict;
use warnings;

package Demo::StringUtils; # added for package session

sub zombify2 {
    my $word=shift @_;
    $word =~ s/[aeiou]/r/g;
    return $word;
}
return 1;


