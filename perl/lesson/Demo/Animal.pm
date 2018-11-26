#! /usr/bin/env perl
#################################################################################
#     File Name           :     Demo/Animal.pm
#     Created By          :     leesangg
#     Creation Date       :     [2018-04-08 22:41]
#     Last Modified       :     [2018-04-09 01:14]
#     Description         :      
#################################################################################

use strict;
use warnings;

#package Demo::Animal;
package Animal;

sub eat {
    # first arg is always the object to act upon
    my $self = shift@_;

    foreach my $food (@_) {
        if($self->can_eat($food)) {
            print "Eating ", $food, "\n";
        }
        else {
            print "Cannot eat ", $food, "\n";
        }
    }

}

# Animal can eat anything.
sub can_eat {
    return 1;
}

return 1;

