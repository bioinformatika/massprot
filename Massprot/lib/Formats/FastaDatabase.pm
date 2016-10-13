package Massprot::Formats::FastaDatabase;
use Moose;
use namespace::autoclean;
use Try::Tiny;
use Data::Dumper;;
use File::Basename;
with 'Massprot::Roles::Textfile';
extends 'Bio::Rambam::Proteomics::Formats::File';


sub _start_fastakkkkkk{
	# Validates the file: 
	#  - if the file exists
	#  - if it's a correct textfile
	# The creation of the object dies if any problem is found.
	my ( $self, $file, $old_file ) = @_;
	# Open the file and test if is a textfile
	
	try {
		#no warnings;
		local $/ = "\n>";
		my $first_protein;
    	open my $infile,"<",$file;
		die if(tell($infile) == -1);
    	while(<$infile>){
    		$first_protein=$_;
    		last;
    	}
    	close $infile;
    	$first_protein=~/\>(.+)\n/;
    	my ($db,$accession,$description)=split /\|/,$1;
    	die unless ($db eq 'tr' || $db eq 'sp' || $db eq 'dc');
    	$accession=~/^([A-Z]).+([0-9])$/;
    	die unless ($1 && $2);
    	die unless $description;
    	my $filename= fileparse($self->file);
		$self->_set_filename($filename);
  	} catch {
    	die "\n\nCan't open the proteins database file: $_\nPlease, check if the file path is correct and if it's a Uniprot FASTA database\n\n";
  	};
}

sub reversedb{
	my ($self,%opt)=@_;
	my ($output_folder,$output_filename)=_create_outputfile($self->file,'fasta|Fasta|FASTA','reversed.fasta',%opt);
	my ($fasta,$fasta_reversed,$rev_name);
	$rev_name=$output_folder.$output_filename;
	my $num_decoys=0;
	try{
		open $fasta,"<",$self->file;
		open $fasta_reversed,">",$rev_name;
	}
	catch{
		die "Can't generate the output DB\n$_";
	};

	{
		local $/ = "\n>";
		#print $fasta_reversed "k";	#Mira esto, es un parche horrible. La escituro hace un espacio y se come el primer caracter usado.
		while(<$fasta>){
			chomp;
			$_ =~ s/(^>*.+)\n//;  # remove FASTA header
			my $head=$1;
			$head=">".$head unless $head=~/^>/;
			next unless $head;
    		$_ =~ s/\n//g;  # remove endlines			
			####Original fasta protein
			my $seq=$_;
			
			print $fasta_reversed $head."\n";
			#print  $head."\n";
			while (my $chunk = substr($seq, 0, 60, "")) {
        		print $fasta_reversed $chunk."\n";
        		#print $chunk."\n";
			}
			
			####Reversed fasta protein
			my $seq_rev=reverse($_);
			my $reverese_head="dc|decoy_".(split /\|/,$head)[1];
			print $fasta_reversed ">".$reverese_head."\n";
			#print ">".$reverese_head."\n";
			while (my $chunk = substr($seq_rev, 0, 60, "")) {
	        	print $fasta_reversed $chunk."\n";
	        	#print $chunk."\n";
			}
		}
	}
	close $fasta;
	close $fasta_reversed;
}


__PACKAGE__->meta->make_immutable;