#!/usr/bin/env perl

use strict;
use Socket;
use IO::Socket::INET;
use Scalar::Util 'reftype';
 
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
sub resolveReq {
######################################################
    my $self = shift;
    my $what = shift;

    if ($what !~ /\\d+\\.\\d+\\.\\d+\\.\\d+/) {
    	my @host = gethostbyname($what);
    	if (scalar(@host) == 0) {
    		die "Failed host to resolve to IP: $what\n";
    	} else {
    	    return Socket::inet_ntoa($host[4]);
    	}
    }
}

######################################################
sub pwhois {
######################################################
    my $self = shift;

    if (Scalar::Util::reftype($self->{req}) eq 'ARRAY') {
        return $self->pwhoisBulk();
    }

	my $socket = new IO::Socket::INET (
	    PeerHost => $self->{hostname},
	    PeerPort => $self->{port},
	    Proto    => 'tcp',
	);
	die "Cannot connect to server $!\n" unless $socket;

    my $resolved = $self->resolveReq($self->{req});
    my $size = $socket->send($resolved);

    shutdown($socket, 1);
 
    my $response;
    $socket->recv($response, 1024);
    $socket->close();

    my $formatted;
    if ($response) {
        $formatted = $self->formatResponse($response);
    }
    return $formatted;
}

######################################################
sub pwhoisBulk {
######################################################
    my $self = shift;

	my $socket = new IO::Socket::INET (
	    PeerHost => $self->{hostname},
	    PeerPort => $self->{port},
	    Proto    => 'tcp',
	);
	die "Cannot connect to server $!\n" unless $socket;

    $socket->send("begin\n");

    my %results;
    for my $elmt (@{$self->{req}}) {
        my $resolved = $self->resolveReq($elmt);

        $socket->send("$resolved\n");

        my $response;
        $socket->recv($response, 1024);

        if ($response) {
            my $formatted = $self->formatResponse($response);
            if ($formatted) {
                $results{$elmt} = $formatted;
            }
        }
    }

    $socket->send("end\n");

    shutdown($socket, 1);
    $socket->close();

    return \%results;
}

######################################################
sub formatResponse {
######################################################
    my $self = shift;
    my $what = shift;

    my @lines = split /\n/, $what;

    my %formatted;
    for my $line (@lines) {
        my ($name, $value) = split /:\s/, $line;
        if ($name && $value) {
            $formatted{lc($name)} = $value;
        }
    }

    return \%formatted;
}

1;
