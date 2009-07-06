#!perl -T

use strict;
use warnings;

use Test::More tests => 12;

use lib 't/lib';

use Test::MyCmd;

my $cmd = Test::MyCmd->new;

isa_ok($cmd, 'Test::MyCmd');

is_deeply(
  [ sort $cmd->command_names ],
  [ sort qw(help --help -h -? commands frob frobulate justusage stock bark) ],
  "got correct list of registered command names",
);

use Data::Dumper;
Dumper $cmd->command_plugins;
is_deeply(
  [ sort $cmd->command_plugins ],
  [ qw(
    App::Cmd::Command::commands
    App::Cmd::Command::help
    Test::MyCmd::Command::bark
    Test::MyCmd::Command::frobulate
    Test::MyCmd::Command::justusage
    Test::MyCmd::Command::stock
  ) ],
  "got correct list of registered command plugins",
);

{
  local @ARGV = qw(frob --widget wname your fat face);
  eval { $cmd->run };
  
  is(
    $@,
    "the widget name is wname - your fat face\n",
    "command died with the correct string",
  );
}

{
  local @ARGV = qw(justusage);
  eval { $cmd->run };

  my $error = $@;
  
  like(
    $error,
    qr/^basic.t justusage/,
    "default usage_desc is okay",
  );
}

{
  local @ARGV = qw(stock);
  eval { $cmd->run };
  
  like($@, qr/mandatory method/, "un-subclassed &run leads to death");
}

{
  local @ARGV = qw(bark);
  eval { $cmd->run };
  
  like(
    $@,
    qr/Required option missing: wow/, 
    "required option fileld is missing",
  );
}

SKIP: {
  my $have_TO = eval { require Test::Output; 1; };
  print STDERR $@;
  skip "these tests require Test::Output", 5 unless $have_TO;

  local @ARGV = qw(commands);

  my ($output) = Test::Output::output_from(sub { $cmd->run });

  for my $name (qw(commands frobulate justusage stock bark)) {
    like($output, qr/^\s+\Q$name\E/sm, "$name plugin in listing");
  }
}
