#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'MooseX::App::Cmd',
    VERSION_FROM => 'lib/MooseX/App/Cmd.pm',
    INSTALLDIRS  => 'site',
    SIGN         => 1,
    PL_FILES     => {},
    PREREQ_PM    => {
        'Test::use::ok'             => 0,
        'App::Cmd'                  => 0.3,
        'Moose'                     => 0.86,
        'MooseX::Getopt'            => "0.18",
        'Getopt::Long::Descriptive' => 0,
    },
);

