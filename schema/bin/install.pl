#!/usr/bin/env perl
use warnings;
use strict;

use FindBin qw($Bin);
use lib "$Bin/../../lib";
use _config;

#TODO
#add comparison to tables so we know if the schema doesn't match
#let user know
#if (-f "$Bin/../trucks.db") {
#    install("$Bin/../trucks.db");
#}

if (opendir(my $dh, "$Bin/../")) {
    while (my $file = readdir $dh) {
        next if $file =~ /^\.\.?$/;
        if ($file =~ /\.sql$/) {
            my $sql_base = $file;
            $sql_base =~ s/\.sql//;
            install("$Bin/../$sql_base.sql");
            if (-f "$Bin/../$sql_base.inserts") {
                install("$Bin/../$sql_base.inserts");
            }
        }
    }
}



sub install {
    my $file = shift;
    if (open(my $fh, "<", $file)) {
        my $sql;
        my $err;
        my $dbh = _config::dbh;
        if ($file =~ /.sql$/) {
            local $/;
            $sql = <$fh>;
            eval{
                $dbh->do($sql)
            };
            $err = $@;
        }
        if ($file =~ /.inserts$/) {
            foreach my $line (<$fh>)  {   
                $sql = $line;
                eval{
                    $dbh->do($sql)
                };
                $err = $@;
            }
        }
        if ($err =~ 'already exists' || $err =~ 'Duplicate entry \'\d\'') {
           $err = undef;
        }
        if ($err) {
            print "Error: $file\n$err\n";
        } else {
            print "Installed $file\n";
        }
        close($fh);
    }
}
