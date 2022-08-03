#!/usr/local/bin/perl
use warnings;
use strict;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Mojolicious::Lite;

use Truck::API;

use Data::Dumper;


get '/' => sub { shift->render(json => {}) };
get '/api' => sub { shift->render(json => {}) };

get '/api/trucks' => sub {
    my $self = shift;
    my $truckApi = new Truck::API($self);
    my $truck_id = $self->stash('truck_id');
    my $result = {
        truck_id => $truck_id,
    };

    return $truckApi->getTrucks();
};


get '/api/trucks/:truck_id' => sub {
    my $self = shift;
    my $truckApi = new Truck::API($self);
    my $truck_id = $self->stash('truck_id');
    my $result = {
        truck_id => $truck_id,
    };

    return $truckApi->getTrucksById($truck_id);
};



app->start;
