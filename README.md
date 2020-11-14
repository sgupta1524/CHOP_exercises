# CHOP_exercises  
  
## Section 1  
Folder Name: Section1

A workflow which takes:
  - Input FastQ/BAM file
  - Use BWA MEM to re-align to hg38  
and outputs CRAM file

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

###Q1  
#####Folder Name: Section2/Q1   
Result Files : male_patients.csv, male_patients.sql  

###Q2
#####Folder Name: Section2/Q2

Folder : Diagnoses
Visualisation of diagnoses categories for patients

Folder : total_patients_demographics
Visualisation of demographics of all patients

Folder : total_visits
Visualisation of demographics of patients who have had atleast 1 diagnosis


