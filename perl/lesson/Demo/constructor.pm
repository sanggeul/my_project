#! /usr/bin/env perl
#################################################################################
#     File Name           :     Demo/consructor.pm
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 22:41]
#     Last Modified       :     [2018-04-09 19:40]
#     Description         :      
#################################################################################

use strict;
use warnings;

package constructor;

sub new {
    # first arg is always the object to act upon
    my $class = shift@_;
    return bless { "legs", 4, "colour", "brown", }, $class;
}

return 1;



