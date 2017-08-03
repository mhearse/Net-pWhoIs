#!/usr/bin/env perl

use Net::pWhoIs;
use Data::Dumper;

my %attrs = ( req => '166.70.12.30' );
my $obj = Net::pWhoIs->new(\%attrs);
my $output = $obj->pwhois();

print Dumper($output);

# Passing hostname.
my $obj = Net::pWhoIs->new({ req => 'ebay.com' });
my $output = $obj->pwhois();

print Dumper($output);
