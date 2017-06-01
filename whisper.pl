#!/usr/bin/env perl

use Mojolicious::Lite;

state $password = "";

post '/' => sub {
    my $c = shift;
    $password = $c->req->body;
    $c->render( text => "thank you" );
};

get '/' => sub {
    my $c         = shift;
    my $remote_ip = $c->tx->remote_address;
    if ( $remote_ip eq "127.0.0.1" ) {
        $c->render( text => $password );
    }
    else {
        $c->render( text => "Stop snooping! request from $remote_ip" );
    }
};

app->start;
