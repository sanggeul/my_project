#! /usr/bin/env perl
#################################################################################
#     File Name           :     026_comment.pl
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-29 20:23]
#     Last Modified       :     [2018-04-29 21:49]
#     Description         :      
#################################################################################

use strict;
use warnings;

my @dir=`dir`;
my @ls=`ls`;
my @ps=`ps`;

#print "---------------------------------------------------------------------------\n";
#print @dir;
print "---------------------------------------------------------------------------\n";
print @ls;
print "---------------------------------------------------------------------------\n";
print @ps;
print "---------------------------------------------------------------------------\n";

=put
print $#dir, "\n";
print $#ls, "\n";
print $dir[0];
print $dir[1];
print $dir[$#dir];
=cut
print $ls[0];
print $ls[1];
print $ls[$#ls];
print $ps[0];
print $ps[1];
print $ps[$#ps];

# check the results of `ls` and `dir`

__END__
erro ?
no error ?
end of perl

