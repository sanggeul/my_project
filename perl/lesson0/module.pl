#! /usr/bin/env perl
#################################################################################
#     File Name           :     module.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 21:44]
#     Last Modified       :     [2018-04-09 01:11]
#     Description         :      
#################################################################################

use strict;
use warnings;

require Demo::StringUtils;
require Demo::StringUtils2;
# need export PERL5LIB=[StringUtils DIR PATH]:$PERL5LIB in .bashrc

print "i want brains", "\n"; # r wrnt btttns
print 'zombify("i want brains")', "\n"; 
print zombify("i want brains"), "\n"; # r wrnt btttns

print Demo::StringUtils::zombify2("i want brains"), "\n"; # r wrnt btttns


