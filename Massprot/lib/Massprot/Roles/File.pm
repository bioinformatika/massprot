package Massprot::Roles::File;
use Moose::Role;
#use namespace::autoclean;
use File::Basename;
use File::Spec;
use Try::Tiny;

use Cwd 'abs_path';

use Data::Dumper;

has 'file'		=>	(is=>'rw',	isa=>'Str',	trigger =>\&_start_file		);			#Complete path to the file
has 'filename'	=>	(is=>'ro',	isa=>'Str',	writer => '_set_filename'	);		#Only filename



sub _start_file{
	my $self=shift;
  try {
		$self->file(abs_path($self->file)) unless File::Spec->file_name_is_absolute($self->file);	# Convert path to absolute
      open my $input_file,"<",$self->file;
    	while(<$input_file>){
    		last;
    	}
    	close $input_file;
  	} catch {
    	die "Can't open the file: $self->file";
  	};
	my $filename= fileparse($self->file);
	$self->_set_filename($filename);
}


sub _create_outputfile {
    # Checks if the outputfile can be generated. Additionally: if the output filename is not an absolute
    #       path, constructs an absolute path based on the inputs' complete path. If the absolute filename
    #       of the output results equal to the input's filename, dies
    #  Params: -file : output filename, only filename or complete path

    my ($input_filename,%opt) = @_;
    my ($input_filename_without_extension,$input_path,$input_extension)=fileparse($input_filename);
    my $output_filename=$opt{file};


    $output_filename = File::Spec->catpath( '', $input_path, $output_filename) unless File::Spec->file_name_is_absolute($output_filename);
    my ($output_filename_without_extension,$output_path,$output_extension)=fileparse($output_filename);
    die "ERROR: $output_extension generation interrupted: Not a valid output directory\n" unless -d$output_path;
    die "ERROR: The file $output_filename  already exists!\n" if $input_filename eq $output_filename;
    try{
        no warnings;
        open FH,">",$output_filename;
        print FH "";
        die if(tell(FH) == -1);
    }
    catch{
        print $_,"\n";
        die "ERROR: The output $output_extension file can not be written\nMaybe you don't have permissions to write there or the filename contains forbidden characters\n";
    };
    return $output_filename;   
}





no Moose::Role;

1;

__END__
