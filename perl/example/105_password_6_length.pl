#! /usr/bin/env perl
#################################################################################
#     File Name           :     105_password_6_length.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-07-03 20:05]
#     Last Modified       :     [2018-07-03 20:08]
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
    $pw = getPassword();
    if (verifyPassword($pw))
    {
        print "input password : [$pw] \n";
        last;
    }
    else
    {
        print "plz, type the password more than 6-length. \n";
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

sub verifyPassword
{
    my $password = shift;
    return 0 if (length($password) < 6);

    my @a = unpack "C*", $password;
    foreach (@a)
    {
        return 0 if ($_ < 0x21 || $__ > 0x7e);
    }

    return 1;
}
}

