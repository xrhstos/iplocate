#!/usr/bin/env perl -w
use 5.010;
use Geo::IP;
use strict;
use warnings;
use Socket;
use Data::Validate::IP;

# Script to check IP

#here is argv
my $num_args = $#ARGV + 1;
if ($num_args != 1) {
        say "\n Usage: iplocate.pl 127.0.0.1";
        exit;
}

my $ip = $ARGV[0];

chomp($ip);

my $elegxosip = $ip;

if (is_ipv4($elegxosip)) {

        my $gi = Geo::IP->open("/usr/share/GeoIP/GeoIPCity.dat", GEOIP_STANDARD);
        my $gp = Geo::IP->open("/usr/share/GeoIP/GeoIPASNum.dat", GEOIP_STANDARD);
        my $record = $gi->record_by_addr($ip);
        my $isp = $gp->isp_by_addr($ip);
        my $hostname = gethostbyaddr(inet_aton($ip), AF_INET);

        say "The IP: " . $ip . " is at " . $record->country_name .  " Network provider by " . $isp . " resolves to " . $hostname;
}

else {
say "This is not a valid IP idiot";
}
