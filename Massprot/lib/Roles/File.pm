package Massprot::Roles::File;
use Moose;
use namespace::autoclean;
use File::Basename;
use File::Spec;
use Try::Tiny;
use Cwd 'abs_path';

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



















__PACKAGE__->meta->make_immutable;
