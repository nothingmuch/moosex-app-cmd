#!/usr/bin/perl

package MooseX::App::Cmd::Command;
use Moose;

with qw/MooseX::Getopt/;

extends qw/App::Cmd::Command/;

use Getopt::Long::Descriptive ();

sub _process_args {
    my ( $class, $args, @params ) = @_;

    # @params is ignored here. it's the null list returned by opt_spec, which _attrs_to_options doesn't use
    # we're passing it around for future use if any.

    #if ( $class->does("MooseX::Getopt") ) {
    # presumably there are many styles of getopt

    local @ARGV = @$args;

    my %processed = $class->_parse_argv( options => [ $class->_attrs_to_options( @params ) ] );

    return (
        $processed{params},

        $processed{argv},

        usage => bless(sub { "<usage>" }, "Getopt::Long::Descriptive::Usage"),

        %{ $processed{params} }, # params from CLI are also fields in MooseX::Getopt
    );
    #}
}

__PACKAGE__;

__END__

=pod

=head1 NAME

MooseX::App::Cmd::Command - Base class for L<MooseX::Getopt> based L<App::Cmd::Command>s.

=head1 SYNOPSIS

	use MooseX::App::Cmd::Command;

    # no need to set opt_spec
    # see MooseX::Getopt for documentation on how to specify options
    has option_field => (
        isa => "Str",
        is  => "rw",
        required => 1,
    );

    sub run {
        my ( $self, $opts, $args ) = @_;

        print $self->option_field; # also available in $opts->{option_field}
    }

=head1 DESCRIPTION

=cut


