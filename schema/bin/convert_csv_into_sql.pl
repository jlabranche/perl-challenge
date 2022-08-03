#!/usr/bin/env perl
use warnings;
use strict;

use FindBin qw($Bin);
use lib "$Bin/../../lib";

use _config;
use Data::Dumper;

sub open_csv {
    my $file = shift;
    my $dbh = _config::dbh;

    if (open(my $fh, "<", $file)) {
        my $line_ = 0;
        my @csv_keys;
        my $csv_hash;
        foreach my $csv (<$fh>)  {   
            $line_++;
            chomp $csv;
            if ($line_ == 1) {
                  @csv_keys = split(",", $csv);
            } else {
                my @csv_values = split(",", $csv);
                my $i = 0;
                for my $value (@csv_values) {
                    $csv_hash->{$line_}->{$csv_keys[$i]} = $value;
                    $i++;
                }
            }
        }
        close($fh);

        # make it's own subroutine
        my $select = {
            facility_type => qq{
               SELECT *
                 FROM facility_type
            },
        };
        my $facility_types = $dbh->selectall_arrayref($select->{'facility_type'}, { Slice => {} });
        my $facility_ids = {};
        for my $ft (@$facility_types) {
            $facility_ids->{$ft->{'facility_type'}} = $ft->{'id'};
        }

        # make it's own subroutine 
        if (open(my $truck_inserts, ">", "$Bin/../../schema/truck.inserts")) {
            #if (open(my $truck_location_inserts, ">", "$Bin/../../schema/truck_location.inserts")) {
                my $id = 1;
                for my $truck (values %$csv_hash) {
                    my $insert_line = qq{
                        INSERT INTO truck (id, applicant, cnn, facility_type, truck_permit_id, food_items, schedule, longitude, latitude)
                                   VALUES ($id,
                                           "$truck->{'Applicant'}",
                                           $truck->{'cnn'},
                                           $facility_ids->{lc($truck->{'FacilityType'})},
                                           "$truck->{'permit'}",
                                           "$truck->{'FoodItems'}",
                                           "$truck->{'Schedule'}",
                                           "$truck->{'Longitude'}",
                                           "$truck->{'Latitude'}"
                                          );
                    };
                    $insert_line =~ s/^\s+|\s+$|  +//g;
                    $insert_line =~ s/\n/ /g;

                    print $truck_inserts "$insert_line\n";
                    $id++;
                }
                close($truck_inserts);
            #}
        } else {
            die $@;
        }
    } else {
        die $@;
    }
}

MAIN: {
    open_csv("$Bin/../../schema/base/Mobile_Food_Facility_Permit.csv");
}
