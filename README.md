# CHOP_exercises  
  
## Section 1  

A workflow for the functions which takes:
  - Input FastQ/BAM file
  - Use BWA MEM to re-align to hg38
  - Output CRAM file

Command line options for pipeline.sh
-a first read file in FASTQ  
-b second read file in FASTQ  
-r reference file in FASTA format  
-o output file name  
-v verbose mode  
-x 1 if bam file is present instead of inout FASTQ files  
-f bam file  
-p picard file  
  
**example : bash pipeline.sh -a y1.fastq -b y2.fastq -r yeast.fasta -o test_pipeline -x 0 -v 1**  

## Section 2


