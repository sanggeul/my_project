#! /usr/bin/env perl
#################################################################################
#     File Name           :     test.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-09 18:30]
#     Last Modified       :     [2018-07-09 20:12]
#     Description         :      
#################################################################################

use strict;
use warnings;

#print ("What's your name ?\n");
#my $name = <STDIN>;
#print ("$name");
#chomp($name);
#print ("$name");

my $text = "acb#! Abcd_ef_^^^134";
print "$text\n";
$text =~ tr/A-Z/a-z/;
print "$text\n";
$text =~ s/\W.*/ /;
print "$text\n";


