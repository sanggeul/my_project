#! /usr/bin/env perl
#################################################################################
#     File Name           :     082_extract_string.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-21 01:08]
#     Last Modified       :     [2018-06-21 01:15]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $foo;
my $result;

#$foo = <>;
$foo = "<title> texttexttexttexttexttext </title>";
print $foo, "\n";
$foo =~ /<title>(.*)<\/title>/;
$result = $1;

print "\n";
print $0, "\n";
print $1, "\n";
#print $2, "\n"; # none

$foo = '<a href="http://www.google.com"><img src="img/title.gif" title=novel /></a>';
$foo =~ /<a href="(.*)"><img src=/;
$result = $1;
print $1, "\n";



