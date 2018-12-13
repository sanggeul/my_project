#! /usr/bin/env perl
#################################################################################
#     File Name           :     086_path_parse.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-06-25 00:26]
#     Last Modified       :     [2018-06-25 00:42]
#     Description         :      
#################################################################################

use strict;
use warnings;

use File::Basename;

my ($fileNameOnly, $dir, $ext) = fileparse("My Jukebox/Cool jazz.mp3", '\.[^.]*');

print "dir:  <", $dir, ">\n";
print "file: <", $fileNameOnly, ">\n";
print "ext:  <", $ext, ">\n";


my $s = basename("/000/perl.pdf");
print $s, "\n";

$s = dirname("/000/perl.pdf");
print $s, "\n";

$s = (fileparse("/000/perl.pdf", '\.[^.]*'))[2];
print $s, "\n";

$s = (fileparse("/000/perl", '\.[^.]*'))[2];
print $s, "\n";

$s = (fileparse("/000/perl.pdf.doc", '\.[^.]*'))[2];
print $s, "\n";


