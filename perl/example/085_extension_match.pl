#! /usr/bin/env perl
#################################################################################
#     File Name           :     085_extension_match.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 00:15]
#     Last Modified       :     [2018-06-25 00:23]
#     Description         :      
#################################################################################

use strict;
use warnings;

my $filename;
my $ext;
my $s;


$filename = "085_in.txt";
$ext = "";

$filename =~ m/.+\.(\w+)?$/;
$ext = $1;
print "<", $ext, ">\n";


$filename = "085 in.doc";
$ext = "";

$filename =~ m/.+\.(\w+)?$/;
$ext = $1;
print "<", $ext, ">\n";


$filename = "085_in";
$ext = "";

#$filename =~ m/.+\.(\w+)?$/;
$ext = $1 if ($filename =~ m/.+\.(\w+)?$/);
print "<", $ext, ">\n";


$filename = "085... in.1st.2nd.3rd";
print "<", $filename =~ m/.+\.(\w+)?$/, ">\n";

$filename = ".085_in";
print "<", $filename =~ m/.+\.(\w+)?$/, ">\n";



