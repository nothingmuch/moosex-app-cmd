#!perl -T

use strict;
use warnings;
use Test::More;

BEGIN
{
    eval {
        require MooseX::ConfigFromFile;
        require YAML;
    };
    if ($@) {
        plan( skip_all => "These tests require MooseX::ConfigFromFile and YAML" );
    } else {
        plan( tests => 2 );
    }
}

use lib 't/lib';
use Test::ConfigFromFile;

my $cmd = Test::ConfigFromFile->new;

{
  local @ARGV = qw(moo);
  eval { $cmd->run };
  
  like(
    $@,
    qr/Required option missing/,
    "command died with the correct string",
  );
}

{
  local @ARGV = qw(moo --configfile=t/lib/Test/ConfigFromFile/config.yaml);
  eval { $cmd->run };
  
  like(
    $@,
    qr/cows go moo1 moo2 moo3/,
    "command died with the correct string",
  );
}
