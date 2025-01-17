Pupil Bio Test 2 - NGS Data Analysis
This pipeline automates the process of variant calling from NGS data, including quality control, alignment, sorting, and somatic variant calling.

Script Information
Main Script:
Pupil_Bio_automation_Test2.sh

Additional Input File:
samples_details.txt

Input Requirements
A sample input file (samples_details.txt) must be provided in the specified format:

SampleID;Tumor_R1.fastq;Tumor_R2.fastq;Normal_R1.fastq;Normal_R2.fastq

Example: PA220KH;/vinayak/bioinfo-data/Vinayak_II/Project/Pup_Bio/Test_2/PA220KH-lib09-P19-Tumor_S2_L001_R1_001.fastq.gz;/vinayak/bioinfo-data/Vinayak_II/Project/Pup_Bio/Test_2/PA220KH-lib09-P19-Tumor_S2_L001_R2_001.fastq.gz;/vinayak/bioinfo-data/Vinayak_II/Project/Pup_Bio/Test_2/PA221MH-lib09-P19-Norm_S1_L001_R1_001.fastq.gz;/vinayak/bioinfo-data/Vinayak_II/Project/Pup_Bio/Test_2/PA221MH-lib09-P19-Norm_S1_L001_R2_001.fastq.gz
Modify the input file as per your dataset's paths and sample IDs.

Usage
Run the script using the following command:

Usage
sh Pupil_Bio_automation_Test2.sh

Output
Upon successful execution, the pipeline generates the following files and directories:

QC_Files folder: Contains quality control reports for the input data.

BAM Files: Raw BAM files and Sorted BAM files
Somatic Variant File: somatic_variant.vcf Final output containing the identified somatic variants.

Notes
Ensure the input file paths are correctly formatted and accessible.
The script should be executed in the directory containing the required input files and the script itself.
Outputs are created in the working directory unless specified otherwise.
