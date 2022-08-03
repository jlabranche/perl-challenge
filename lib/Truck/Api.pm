package Truck::API;
use Mojolicious::Lite;
use Try::Tiny;
use Data::Dumper;

use _config;

sub new {
    my $class = shift;
    my $self = {
        _mojo => shift
    };
    bless $self, $class;
}

sub _dbh {
    return shift->{'_dbh'} ||= _config::dbh;
}

sub get_cors_headers {
    my $self = shift;
    my $mojo = $self->{'_mojo'};
    return $mojo->res->headers->header('Access-Control-Allow-Origin'=> '*');
}

sub render_json_resp {
    my ($self, $result) = @_;
    my $mojo = $self->{'_mojo'};

    $self->get_cors_headers();
    return $mojo->render(json => $result);
}

sub render_json_err {
    my ($self, $error) = @_;
    my $mojo = $self->{'_mojo'};
    $self->get_cors_headers();
    return $mojo->render(json => { error => 'db error: '.$error });
}

sub select {
    return {
       truck_by_id => qq{
           SELECT *
             FROM truck
            WHERE id = ?
       },
       truck => qq{
           SELECT *
             FROM truck
       },
    };
}

sub getTrucksById {
    my ($self) = @_;
    my $mojo = $self->{'_mojo'};
    my $truck_id = $mojo->stash('truck_id');
    my $result;

    try {
        $result = $self->_dbh->selectall_arrayref($self->select->{'truck_by_id'}, { Slice => {} }, $truck_id);
        $self->render_json_resp($result) if $result;
    } catch {
        $self->render_json_err('db error: '.$_);
    };
}

sub getTrucks {
    my ($self) = @_;
    my $mojo = $self->{'_mojo'};
    my $result;

    try {
        $result = $self->_dbh->selectall_arrayref($self->select->{'truck'}, { Slice => {} });
        $self->render_json_resp($result) if $result;
    } catch {
        return $self->render_json_err($mojo, 'db error: '.$_);
    };
}

1;
