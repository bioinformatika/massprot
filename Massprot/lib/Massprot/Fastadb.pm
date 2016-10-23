package Massprot::Fastadb;
use Moose;
use namespace::autoclean;
use Try::Tiny;
use Data::Dumper;;
use File::Basename;
with 'Massprot::Roles::File';



sub reversedb{
	my ($self,%opt)=@_;
	my $output_filename=_create_outputfile($self->file,%opt);
	my $num_decoys=0;
	open my $fasta,"<",$self->file;
	open my $fasta_reversed,">",$output_filename;
	{
		local $/ = "\n>";
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
	my $reversedb=Massprot::Fastadb->new(file=>$output_filename);
	return $reversedb;
}


__PACKAGE__->meta->make_immutable;