#!/usr/bin/perl

package MooseX::App::Cmd;
use File::Basename ();
use Moose;

extends qw(Moose::Object App::Cmd);

sub BUILDARGS {
  my $class = shift;
  return {} unless @_;
  return { arg => $_[0] } if @_ == 1;;
  return { @_ };
}

sub BUILD {
  my ($self,$args) = @_;

  my $class = blessed $self;
  my $arg0 = $0;
  $self->{arg0}      = File::Basename::basename($arg0);
  $self->{command}   = $class->_command( {}  );
  $self->{full_arg0} = $arg0;
}

our $VERSION = "0.06";

__PACKAGE__;

__END__

=pod

=head1 NAME

MooseX::App::Cmd - Mashes up L<MooseX::Getopt> and L<App::Cmd>.

=head1 SYNOPSIS

See L<App::Cmd/SYNOPSIS>.

    package YourApp::Cmd;
	use Moose;

    extends qw(MooseX::App::Cmd);



    package YourApp::Cmd::Command::blort;
    use Moose;

    extends qw(MooseX::App::Cmd::Command);

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

    sub execute {
        my ( $self, $opt, $args ) = @_;

        # you may ignore $opt, it's in the attributes anyway
        
        my $result = $self->blortex ? blortex() : blort();

        recheck($result) if $self->recheck;

        print $result;
    } 

=head1 DESCRIPTION

This module marries L<App::Cmd> with L<MooseX::Getopt>.

Use it like L<App::Cmd> advises (especially see L<App::Cmd::Tutorial>),
swapping L<App::Cmd::Command> for L<MooseX::App::Cmd::Command>.

Then you can write your moose commands as moose classes, with L<MooseX::Getopt>
defining the options for you instead of C<opt_spec> returning a
L<Getopt::Long::Descriptive> spec.

=head1 AUTHOR

Yuval Kogman E<lt>nothingmuch@woobling.orgE<gt>

With contributions from:

=over 4

=item Guillermo Roditi E<lt>groditi@cpan.orgE<gt>

=back

=head1 COPYRIGHT

    Copyright (c) 2007-2008 Infinity Interactive, Yuval Kogman. All rights
    reserved This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
