#!/bin/bash 
 
homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/7_samtools_view_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/7_samtools_view"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/6_star_map_results/"
inPathBit="Aligned.toTranscriptome.out.bam"

files=($(ls -d $inPath/*$inPathBit))

for inFile in ${files[@]};do

		outPathBit=`basename $inFile | sed 's/_Aligned.toTranscriptome.out.bam//'`
		echo $outPathBit
		outFile=$resultsDir/$outPathBit"_Aligned.toTranscriptome.out_paired.mapped.ONLY.bam"
		samtools_view_line="samtools view -f 3 \
			-u $inFile > $outFile"
		samtools_view_command="samtools_view_command_$outPathBit"
		jobName="samtools_view.$outPathBit"
		echo $samtools_view_line >> $samtools_view_command
		chmod 775 $samtools_view_command
		qsub -l select=1:mem=100mb:ncpus=8 -e $logDir -N paired.mapped\_$outPathBit -l walltime=40:00:00 $samtools_view_command
		
done;