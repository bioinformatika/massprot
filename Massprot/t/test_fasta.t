 use strict;
 use warnings;
 use Data::Dumper;
 use Test::More 'no_plan';

require_ok( 'Massprot' );






TODO: {
	my $test_name="futurible";
	local $TODO = "ya lo hare";
	#ok( foo(),       $test_name );
	#is( foo(42), 23, $test_name );
};

# use Massprot::Formats::FastaDatabase;
# use File::Temp qw/tempdir/;

# my  $output_folder= tempdir( CLEANUP => 1 );


# ok (initialize_fasta(),		"Test1: Uniprot Fasta database started");
# ok (reversedb(5349),		"Test2: Uniprot Fasta database reversed created at $output_folder. Filesize: 5349 bytes");
# <STDIN>;


# #<STDIN>;
# sub initialize_fasta{
# 	my $db=Bio::Rambam::Proteomics::Formats::FastaDatabase->new(file=>"./testdata/testDB.fasta");
# 	1;	
# }
# sub reversedb{
# 	my $db=Bio::Rambam::Proteomics::Formats::FastaDatabase->new(file=>"./testdata/testDB.fasta");
# 	$db->reversedb(output_folder=>$output_folder);
# 	return 1 if -s $output_folder."/testDB.reversed.fasta"==$_[0];
# }
















