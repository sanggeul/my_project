#! /usr/bin/env perl
#################################################################################
#     File Name           :     package.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 21:44]
#     Last Modified       :     [2018-04-08 22:37]
#     Description         :      
#################################################################################

use strict;
use warnings;

require Demo::StringUtils;
require Demo::StringUtils2;

sub subroutine {
    print "universe", "\n";
}

# have to check "::" 
package Food::Potatoes;

# no name collision
sub subroutine {
    print "kingedward", "\n";
}

subroutine();
main::subroutine();
Food::Potatoes::subroutine();

print Demo::StringUtils::zombify2("i want brains"), "\n"; # r wrnt btttns

# Do not use package in .pl
# name.pl usually includes "name" module (only one)

