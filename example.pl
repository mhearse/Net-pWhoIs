#!/usr/bin/env perl

use Net::pWhoIs;

my %attrs = ( req => '166.70.12.30' );
my $obj = Net::pWhoIs->new(\%attrs);

# Or my $obj = Net::pWhoIs->new({req => '166.70.12.30'});

my $output = $obj->pwhois();

use Data::Dumper;
print Dumper($output);
