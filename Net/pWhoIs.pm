#!/usr/bin/env perl

use strict;
use IO::Socket::INET;
 
$| = 1;

package Net::pWhoIs;

######################################################
sub new {
######################################################
    my ($class, $args) = @_;
    my $self;

    my %defaults = (
        hostname => 'whois.pwhois.org',
        port     => 43,
    );

    # Apply defaults.
    for my $key (keys %defaults) {
        $self->{$key} = $defaults{$key};
    }

	# Apply arguments passed by human.
	# They will clobber our defaults.
    for my $key (keys %{$args}) {
		$self->{$key} = $args->{$key};
    }

    if (!$self->{req}) {
        die "Attribute 'req' is required for this module.\n";
    }
 
	bless $self, $class;
    return $self;
}

######################################################
sub pwhois {
######################################################
    my $self = shift;

	my $socket = new IO::Socket::INET (
	    PeerHost => $self->{hostname},
	    PeerPort => $self->{port},
	    Proto    => 'tcp',
	);
	die "Cannot connect to server $!\n" unless $socket;
 
    my $size = $socket->send($self->{req});
 
    shutdown($socket, 1);
 
    $socket->recv($self->{response}, 1024);
    $socket->close();

    if ($self->{response}) {
        $self->formatResponse();
    }
}

######################################################
sub formatResponse {
######################################################
    my $self = shift;

    my @lines = split /\n/, $self->{response};

    my %formatted;
    for my $line (@lines) {
        my ($name, $value) = split /:\s/, $line;
        $formatted{lc($name)} = $value;
    }

    return \%formatted;
}

1;