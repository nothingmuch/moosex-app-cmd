#!/usr/bin/perl

package MooseX::App::Cmd;
use Moose;

extends qw/App::Cmd/;

__PACKAGE__;

__END__

=pod

=head1 NAME

MooseX::App::Cmd - Combines L<MooseX::Getopt> with L<App::Cmd>.

=head1 SYNOPSIS

See L<App::Cmd/SYNOPSIS>.

    package YourApp::Cmd;
	use Moose;

    extends qw/MooseX::App::Cmd/;

    package YourApp::Cmd::Command::blort;
    use Moose;

    extends qw/MooseX::App::Cmd::Command/;

    has blortex => (
        isa => "Bool",
        is  => "rw",
        cmd_aliases   => "X",
        documentation => "use the blortext algorithm",
    );

    has recheck => (
        isa => "Bool",
        is  => "rw",
        cmd_aliases => "r",
        documentation => "recheck all results",
    );

    sub run {
        my ( $self, $opt, $args ) = @_;

        # you may ignore $opt, it's in the fields
        
        my $result = $self->blortex ? blortex() : blort();

        recheck($result) if $self->recheck;

        print $result;
    } 

=head1 DESCRIPTION

=cut


