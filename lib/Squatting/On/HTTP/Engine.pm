package Squatting::On::HTTP::Engine;
use strict;
no  strict 'refs';
use warnings;
use HTTP::Engine;
use Data::Dump 'pp';

our $VERSION = '0.01';

our %p;

$p{init_cc} = sub {
  my ($c, $req) = @_;
  my $cc = $c->clone;
  $cc->env     = { 
    REQUEST_METHOD => 'GET',
    REQUEST_PATH   => $req->path,
  };
  $cc->cookies = $req->cookies;
  $cc->input   = $req->parameters;
  $cc->headers = { 'Content-Type' => 'text/html' };
  $cc->v       = {};
  $cc->state   = undef;
  $cc->log     = undef;
  $cc->status  = 200;
  $cc;
};

sub http_engine {
  my ($app, %options) = @_;
  $options{request_handler} = sub {
    my ($req)   = @_;
    my ($c, $p) = &{ $app . "::D" }($req->uri->path);
    my $cc      = $p{init_cc}($c, $req);
    my $content = $app->service($cc, @$p);
    my $res     = HTTP::Engine::Response->new(
      status  => $cc->status,
      cookies => $cc->cookies,
      body    => $content
    );
  };
  HTTP::Engine->new(interface => \%options);
}

1;

__END__

=head1 NAME

Squatting::On::HTTP::Engine - run Squatting apps on top of HTTP::Engine

=head1 SYNOPSIS

Basic

  use App 'On::HTTP::Engine';
  App->init;
  App->http_engine->run;

=head1 DESCRIPTION



=head1 API



=head1 AUTHOR

John BEPPU E<lt>beppu@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright (c) 2008 John BEPPU E<lt>beppu@cpan.orgE<gt>.

=head2 The "MIT" License

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

# Local Variables: ***
# mode: cperl ***
# indent-tabs-mode: nil ***
# cperl-close-paren-offset: -2 ***
# cperl-continued-statement-offset: 2 ***
# cperl-indent-level: 2 ***
# cperl-indent-parens-as-block: t ***
# cperl-tab-always-indent: nil ***
# End: ***
# vim:tabstop=8 softtabstop=2 shiftwidth=2 shiftround expandtab
