package Test::MyCmd::Command::frobulate;
use Moose;

extends qw(MooseX::App::Cmd::Command);

sub command_names {
  return qw(frobulate frob);
}

has foo_bar => (
    isa => "Bool",
    is  => "ro",
    cmd_aliases => "F",
    documentation => "enable foo-bar subsystem",
);

has widget => (
    isa => "Str",
    is  => "ro",
    documentation => "set widget name",
);

sub run {
  my ($self, $opt, $arg) =@_;

  die "the widget name is " . $self->widget . " - @$arg\n";
}

1;
