#!/usr/bin/env perl

use Net::pWhoIs;
use Data::Dumper;

# Passing IP.
my %attrs = ( req => '166.70.12.30' );
my $obj = Net::pWhoIs->new(\%attrs);
my $output = $obj->pwhois();

print Dumper($output);

# Passing hostname.
my $obj = Net::pWhoIs->new({ req => 'ebay.com' });
my $output = $obj->pwhois();

print Dumper($output);

# Bulk query, combination of IPs and hostnames.
my @list = ('166.70.12.30', '207.20.243.105', '67.225.131.208', 'perlmonks.org');
my $obj = Net::pWhoIs->new({ req => \@list });
my $output = $obj->pwhois();

print Dumper($output);
