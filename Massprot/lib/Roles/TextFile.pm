package Massprot::Roles::TextFile;

use Moose::Role;








sub _create_outputfile {
    # Prepares de output file
    # Based in one or more intput extensions (eg: mzML), generates an empty file with the complete path using the output extension (eg:mgf)
    #   Params:
    #  ===================================================================
    #   -Sorted params (mandatory)
    #   -- $filename: input file (complete path!!)
    #   -- $input_extensions: possible extensions of the input filename
    #   -- $output_extension
    #   -Unsorted (optional) 
    #   --output_folder
    #   --output_file
    #  ===================================================================
    my ($filename,$input_extensions,$output_extension,%opt) = @_;
    my $regex_string='\.('.$input_extensions.')$';
    my $output_filename=(fileparse($filename))[0];
    $output_filename=~s/$regex_string/\.$output_extension/;
    my $output_folder = delete $opt{output_folder} // (fileparse($filename))[1];
    $output_filename = delete $opt{output_file} // $output_filename;
    die "$output_extension generation interrupted: Not a valid output directory\n" unless -d$output_folder;
    $output_folder.='/' unless $output_folder=~/\/$/;
    
    my $file=$output_folder.$output_filename;
    #print $filename."\n";
    #print $output_folder."\n";
    #print $file,"\n";
    try{
        no warnings;
        open FH,">",$file;
        print FH "\n";
        die if(tell(FH) == -1)
    }
    catch{
        print $_,"\n";
        die "The output $output_extension file can not be written\nMaybe you don't have permissions to write there or the filename contains forbidden characters\n";
    };
    return ($output_folder,$output_filename);   
}




no Moose::Role;

1;

__END__

