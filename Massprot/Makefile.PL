use 5.006;
use strict;
use warnings;
use inc::Module::Install;

name     'Massprot';
all_from 'lib/Massprot.pm';
author   q{David Ovelleiro <mass.proteomics@gmail.com>};
license  'Apache License 2';

perl_version 5.006;

tests_recursive('t');

resources (
   homepage   => 'http://bioinformatika.github.io/massprot/',
   license    => 'http://www.apache.org/licenses/LICENSE-2.0',
   repository => 'git://github.com/bioinformatika/massprot/Massprot.git',
   #repository => 'https://bitbucket.org/David Ovelleiro/Massprot',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Massprot',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
   #'ABC'              => 1.6,
   #'Foo::Bar::Module' => 5.0401,
);

install_as_cpan;
auto_install;
WriteAll;
