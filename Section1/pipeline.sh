#!/bin/bash

## Place your gatech userame in the below export

export NAME="sgupta671"


get_input () {
        while getopts "a:b:r:o:vx:xf:p:h" options
do
        case $options in
                a)reads1=$OPTARG;;
                b)reads2=$OPTARG;;
                r)ref=$OPTARG;;
                o)output=$OPTARG;;
                v)v=1;;
                x)x=$OPTARG     ;;
                f)bam_file=$OPTARG;;
                p)picard=$OPTARG;;
                h)echo "-a first read file in FASTQ
-b second read file in FASTQ
-r reference file in FASTA format
-o output file name
-v verbose mode
-x 1 if bam file is present instead of inout FASTQ files
-f bam file
-p picard file";;
                *)echo "invalid"

        esac
done
}


check_files () {
        # Function for checking for presence of input files, reference genome,
        # and the output VCF file
        #
        # Input: File locations (string)
        # Output: True, if checks pass; False, if checks fail (bool)

    if [ "$ref" == "" ] || [ "$x" == "" ] 
        then
            echo "Please send the complete arguments. "
            exit 1
    fi
	
	if [[ "$v" == 1 ]]
        then
                echo "Checking existence of input files"
        fi


    if [[ "$x" == 1 ]]; then 
        if [ "$bam_file" == "" ] || [ "$picard" == "" ]; then
            echo "Please give picard file and bam file"
            exit 1
    fi
fi




    if [ ! -f "$reads1" ];then
        if [[ "$x" == 0 ]]; then

        echo "reads1 is missing"
        exit 1
        #correct this
        #return 0
    fi
else
    cp "$reads1" r1
    fi


    if [ ! -f "$reads2" ]; then
        if [[ "$x" == 0 ]]; then
        echo "reads2 is missing"
        exit 1
    fi
else
    cp "$reads2" r2
    fi


   	if [ ! -f "$ref" ]; then
        
		echo "reference genome is missing"
		exit 1
	fi

   
	 if [ -f "$output".cram ];then
         
                echo "cram file already exists. What do you want to do? o for overwrite e for exit"
              
	        read -r answer
	       
	       if [[ "$answer" == 'e' ]]
	       then
		      exit 1
	       fi

                #correct this
                #return 0
        fi
}


prepare_temp () {
	# Preparing your temporary directory
	
	if [[ "$v" == '1' ]]
        then
                echo "preparing temp directory"
        fi

	tmpfile=$(mktemp -d temp.XXXX)
	
}



mapping () {
        # Function for the mapping step of the SNP-calling pipeline
        #
        # Input: File locations (string), Verbose flag (bool)
        # Output: File locations (string)

        #gunzip -fc $reads1 > ./tmp/reads1
        #gunzip -fc $reads2 > ./tmp/reads2
        #gunzip -fc $ref > ./tmp/ref
     if [[ "$x" == 1 ]]; then
        echo "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
        java -jar "$picard" SamToFastq I="$bam_file" FASTQ=r1 SECOND_END_FASTQ=r2
    fi

	if [[ "$v" == '1' ]]
    then
		echo "mapping reads to reference genome"
        fi
	
	
    bwa index "$ref"
    bwa mem "$ref" r1 r2 > "$tmpfile"/lane.sam
	samtools sort -O bam -T /tmp -l 0 -o "$tmpfile"/lane.bam "$tmpfile"/lane.sam       
	
}




convert_to_cram () {
    samtools view -T "$ref" -C -o "$output".cram "$tmpfile"/lane.bam
}


main() {
        # Function that defines the order in which functions will be called
        # You will see this construct and convention in a lot of structured code.

        # Add flow control as you see appropriate
        get_input "$@"
        check_files "$reads1" "$reads2" "$ref" 
 	    prepare_temp
	    mapping "$ref" "$reads1" "$reads2" "$tmpfile" "$picard" "$bam_file"
        convert_to_cram "$ref" "$tmpfile"
}

# Calling the main function
main "$@"

