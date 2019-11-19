#!/bin/bash

homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/12_rsem_makeGenomeLevelBam_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/12_rsem_makeGenomeLevelBam"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/9_samtools_cat_results/"
inPathBit="merged.bam"

files=($(ls -d $inPath/*$inPathBit))

for inFile in ${files[@]};do
                
        outPathBit=`basename $inFile | sed 's/_merged.bam//'`
        echo $outPathBit
        outFilePrefix=$resultsDir/$outPathBit
                
        rsem_makeGenomeLevelBam_version="/mnt/lustre/working/lab_julietF/mahdiM/tools/rsem-1.2.25/rsem-calculate-expression"
                
        reference="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/10_rsem_index_results/hg19_ERCC_E.coli.fa__merged.gtf"
                
        rsem_makeGenomeLevelBam_line="$rsem_makeGenomeLevelBam_version \
                --paired-end \
                --bam \
                --output-genome-bam \
                --sampling-for-bam \
                --seed 12345 \
                -p 8 \
                --forward-prob 0 \
                $inFile \
                $reference \
                $outFilePrefix ;"

	rsem_makeGenomeLevelBam_command="rsem_makeGenomeLevelBam_$outPathBit"
	echo $rsem_makeGenomeLevelBam_line >> $rsem_makeGenomeLevelBam_command
	chmod 775 $rsem_makeGenomeLevelBam_command
        qsub -l select=1:mem=20gb:ncpus=8 -e $logDir -N rsem_makeGenomeLevelBam\_$outPathBit -l walltime=40:00:00 $rsem_makeGenomeLevelBam_command
        
done;