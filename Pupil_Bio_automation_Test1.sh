echo " "
echo "***********************************************************************************************************************************"
echo "********************************* Script Developed by Vinayak Rao For Variant Calling *********************************************"
echo "***********************************************************************************************************************************"
echo " "

#packages required
#fastQC
#bwa
#samtools
#gatk



path_ref='/home/vinayak/Downloads/bwa-0.7.15/hg19.fasta'
path_bwa='/home/vinayak/Downloads/bwa-0.7.15/bwa'
cat samples_details.txt | while read file_name; do
        SID=$(echo $file_name | cut -d";" -f1)
        echo "Sample ID is : $SID"
        echo " "
        SID2=$(echo $file_name | cut -d";" -f2)
        echo "Tumor R1 : $SID2"
        echo " "
		SID3=$(echo $file_name | cut -d";" -f3)
        echo "Tumor R2 : $SID3"
        echo " "
		SID4=$(echo $file_name | cut -d";" -f4)
        echo "Normal R1 : $SID4"
        echo " "
		SID5=$(echo $file_name | cut -d";" -f5)
        echo "Normal R2 : $SID5"
        echo " "
        
        mkdir "${SID}_analysis"
        cd ${SID}_analysis
        pwd
        mkdir QC_Files
        ###############################Quality Check ############################################################
        fastqc $SID2 $SID3 $SID4 $SID5 -o QC_Files
        
	## alignement for Normal sample
	bwa mem -t 4 -R "@RG\tID:P19\tLB:lib09\tPL:Illumina\tPM:illumina\tSM:${SID}_normal" $path_ref $SID4 $SID5 > ${SID}_aligned_normal.sam
	samtools view -Sb ${SID}_aligned_normal.sam > ${SID}_aligned_normal.bam
	samtools sort ${SID}_aligned_normal.bam -o ${SID}_aligned_normal_sorted.bam
	samtools index ${SID}_aligned_normal_sorted.bam
		
		
	## alignement for tissue sample
	
	bwa mem -t 4 -R "@RG\tID:P19\tLB:lib09\tPL:Illumina\tPM:illumina\tSM:${SID}_tissue" $path_ref $SID4 $SID5 > ${SID}_aligned_tissue.sam
	samtools view -Sb ${SID}_aligned_tissue.sam > ${SID}_aligned_tissue.bam
	samtools sort ${SID}_aligned_tissue.bam -o ${SID}_aligned_tissue_sorted.bam
	samtools index ${SID}_aligned_tissue_sorted.bam
		
		
	#####################Variant calling using Mutect2 using Normal########################################
	gatk Mutect2   -R $path_ref   -I ${SID}_aligned_tissue_sorted.bam   -I ${SID}_aligned_normal_sorted.bam   --tumor-sample ${SID}_tissue   --normal-sample ${SID}_normal  -O ${SID}_somatic_variants.vcf

		
done


