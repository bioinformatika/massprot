#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Massprot' ) || print "Bail out!\n";
}

diag( "Testing Massprot $Massprot::VERSION, Perl $], $^X" );
