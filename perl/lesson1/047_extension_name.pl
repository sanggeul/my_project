#! /usr/bin/env perl
#################################################################################
#     File Name           :     047_extension_name.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-19 02:28]
#     Last Modified       :     [2018-06-19 02:31]
#     Description         :      
#################################################################################

use strict;
use warnings;


print "<", &getFileExtension("test.txt"), ">\n";
print "<", &getFileExtension("test.jpg"), ">\n";
print "<", &getFileExtension("test.cpp"), ">\n";
print "<", &getFileExtension("test.doc"), ">\n";
print "<", &getFileExtension("test.foo bar"), ">\n";
print "<", &getFileExtension("test"), ">\n";
print "<", &getFileExtension(".test"), ">\n";
print "<", &getFileExtension("test."), ">\n";

sub getFileExtension {
    my $pos = rindex $_[0], ".";
    return "" if $pos < 1;
    substr $_[0], $pos + 1;
}


