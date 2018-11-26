#! /usr/bin/env perl
#################################################################################
#     File Name           :     011_basic_program.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-17 23:23]
#     Last Modified       :     [2018-04-17 23:40]
#     Description         :      
#################################################################################

use strict;
use warnings;

# ex1 : print simple text
print "Hello, This is Tom. \n";

# ex2 : function call
&my_function;

# ex3 : number calc
my $i=2*31;
print "2 x 31 = $i\n";
printf("2 x 31 = 0x%x\n", $i);

#function define
sub my_function {
    print "Hello, I'm sub-routine of perl\n";
}


