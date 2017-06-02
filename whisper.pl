#!/usr/bin/env perl

use Mojolicious::Lite;

helper secrets => sub {
    state $cache = {};
};

post '/:secret' => sub {
    my $c = shift;
    $c->secrets->{ $c->stash('secret') } = $c->req->body;
    $c->render( text => "thank you!" );
};

get '/:secret' => sub {
    my $c = shift;
    if ( $c->tx->remote_address eq "127.0.0.1" ) {
        $c->render( text => $c->secrets->{ $c->stash('secret') } );
    }
    else {
        $c->render( text =>
              "Stop snooping! Rejecting requests from $c->tx->remote_address" );
    }
};

app->start;
