use strict;
use warnings;
use Data::Dumper;
use Test::More 'no_plan';
use File::Temp qw/tempdir/;
use Try::Tiny;
use Massprot::Fastadb;



my $output_folder= tempdir( CLEANUP => 1 );
my $output_full_path = File::Spec->catpath( '', $output_folder, "test.reverse.fasta" );

ok (initialize_fasta(),		"Test1: Uniprot Fasta database started");
ok (reversedb(5349),		"Test2: Uniprot Fasta database reversed created at $output_full_path. Filesize: 5349 bytes");

sub initialize_fasta{
	my $db=Massprot::Fastadb->new(file=>"./t/testdata/testDB.fasta");
	
	1;	
}
sub reversedb{
	my $db=Massprot::Fastadb->new(file=>"./t/testdata/testDB.fasta");
	$db->reversedb(file=>$output_full_path);
	return 1 if -s $output_full_path==$_[0];
}
















