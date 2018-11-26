#! /usr/bin/env perl
#################################################################################
#     File Name           :     040_array_to_string.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-18 23:51]
#     Last Modified       :     [2018-06-18 23:56]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @num = qw/ 24 6523.0 9857 51 2 43 90 2 0 0.0 636.63 /;

print "hard to read\n";
print @num;


print "\n\n";

print "\n<foreach print>\n";
print $_, "\n" foreach (@num);


print "\n\n";

my @foo = qw/ abc apple back couple dead zoo finger /;

print "\n<use join function>\n";
print join " ", @foo, "\n";

print (join(" ", @foo), "\n"); # code readability


my $bar = join "/", @foo;
print $bar, "\n";


