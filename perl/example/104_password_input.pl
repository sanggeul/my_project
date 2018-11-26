#! /usr/bin/env perl
#################################################################################
#     File Name           :     104_password_input.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-03 19:59]
#     Last Modified       :     [2018-07-03 20:05]
#     Description         :      
#################################################################################

use strict;
use warnings;

use Term::ReadKey;
# need to install ReadKey.pm

print "type the password. \n";
my $pw;

for (;;) # infinite loop
{
    if ($pw = getPassword())
    {
        print "input password : [$pw] \n";
        last;
    }
    else
    {
        print "plz, type the password. \n";
    }
}
        

sub getPassword 
{
    ReadMode 'noecho';
    my $s = <STDIN>;
    ReadMode 'normal';

    chomp($s);
    return $s;
}

