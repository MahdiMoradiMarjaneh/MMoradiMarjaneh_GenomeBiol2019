#!/bin/bash 
 
homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/9_samtools_cat_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/9_samtools_cat"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/8_novosort_results/"
inPathBit="Aligned.toTranscriptome.out_paired.mapped.ONLY_s.bam"

cat $scriptsPath/samples.txt | while read -r line; do
                
                sampleID=${line/$'\r'/}
                echo $sampleID
                samplefiles=$inPath/$sampleID*$inPathBit
                outFile=$resultsDir/$sampleID"_merged.bam"
                samtools_cat_line="samtools cat -o $outFile $samplefiles"
                samtools_cat_command="samtools_cat_command_$sampleID"
                jobName="samtools_cat.$sampleID"
                echo $samtools_cat_line >> $samtools_cat_command
                chmod 775 $samtools_cat_command
                qsub -l select=1:mem=1gb:ncpus=1 -e $logDir -l walltime=40:00:00 $samtools_cat_command

done;