#! /usr/bin/env perl
#################################################################################
#     File Name           :     example/Caterpillar.pm
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-09 22:00]
#     Last Modified       :     [2018-04-09 22:16]
#     Description         :      
#################################################################################

use strict;
use warnings;

package Caterpillar;

# Inherit from Exporter
use parent ("Exporter");

sub crawl { print "inch inch\n"; }
sub eat { print "chomp chmp\n"; }
sub pupate { print "bloop bloop\n" }

#our @EXPORT_OK = ("crawl", "eat"); # can not use pupate in main.pl
our @EXPORT_OK = ("crawl", "eat", "pupate");
# "sub" should be included in @EXPORT_OK 

return 1;



