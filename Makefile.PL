# Copyright (c) 2019-2022 by Martin Becker, Blaubeuren.
# This package is free software; you can distribute it and/or modify it
# under the terms of the Artistic License 2.0 (see LICENSE file).

use strict;
use warnings;
use ExtUtils::MakeMaker;
use File::Spec;

my $DN = 'Math-Polynomial-ModInt';
my %versions = map {
    my $module = $_;
    my @path   = ('lib', split /::/, "$module.pm");
    my $file   = join '/', @path;
    my $osfile = File::Spec->catfile(@path);
    $module => {
        file    => $file,
        version => MM->parse_version($osfile),
    }
} qw(
    Math::Polynomial::ModInt
    Math::Polynomial::ModInt::Order
);
my $OM = 'Math::Polynomial::ModInt::Order';
my $OF = $versions{$OM}->{'file'};
foreach my $subclass (qw(ByIndex Conway Sparse)) {
    my $module = join q[::], $OM, $subclass;
    $versions{$module} = { file => $OF };
}

WriteMakefile(
    NAME             => 'Math::Polynomial::ModInt',
    AUTHOR           => 'Martin Becker <becker-cpan-mp (at) cozap.com>',
    VERSION_FROM     => 'lib/Math/Polynomial/ModInt.pm',
    ABSTRACT_FROM    => 'lib/Math/Polynomial/ModInt.pm',
    LICENSE          => 'artistic_2',
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.64',
        'File::Spec'        => '0',
    },
    TEST_REQUIRES => {
        'Test::More'        => '0',
        'Math::BigInt'      => '0',
    },
    PREREQ_PM => {
        'Carp'              => '0',
        'Math::BigInt'      => '0',
        'Math::ModInt'      => '0.012',
        'Math::Polynomial'  => '1.015',
        'Readonly'          => '2',
    },
    SIGN => 1,
    META_MERGE => {
        'meta-spec'         => { version => 2 },
        provides            => \%versions,
        dynamic_config      => 0,
        resources           => {
            bugtracker  => {
                web => "https://github.com/mhasch/perl-$DN/issues",
            },
            license     => [
                'https://www.perlfoundation.org/artistic-license-20.html'
            ],
            repository  => {
                url  => "git://github.com/mhasch/perl-$DN.git",
                web  => "https://github.com/mhasch/perl-$DN",
                type => 'git',
            },
        },
        prereqs => {
            runtime => {
                recommends => {
                    'Math::BigInt::GMP' => 0,
                },
            },
        },
    },
);

__END__
