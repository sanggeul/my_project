#! /usr/bin/env perl
#################################################################################
#     File Name           :     example/main.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-09 22:13]
#     Last Modified       :     [2018-04-09 22:13]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Caterpillar ("crawl", "pupate"); # cannot use "eat"
#use Caterpillar ("crawl", "eat", "pupate");
# if each list is not included in @EXPORT_OK, it cannot be used.

crawl(); # "inch inch"
#eat(); # cannot use because it it not included in @EXPORT_OK
pupate();

