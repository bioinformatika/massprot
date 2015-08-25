#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'MassProt' ) || print "Bail out!\n";
}

diag( "Testing MassProt $MassProt::VERSION, Perl $], $^X" );
