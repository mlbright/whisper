#!/usr/bin/env perl

use Mojolicious::Lite;
use Sys::Hostname;
use Socket;

state $ip = inet_ntoa( ( gethostbyname(hostname) )[4] );
state $password = "";

post '/' => sub {
    my $c = shift;
    $password = $c->req->body;
    $c->render( text => "thank you" );
};

get '/' => sub {
    my $c         = shift;
    my $remote_ip = $c->tx->remote_address;
    if ( $remote_ip eq $ip ) {
        $c->render( text => $password );
    }
    else {
        $c->render( text => "Stop snooping! request from $remote_ip" );
    }
};

app->start;
