#!/bin/bash 
 
homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/8_novosort_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/8_novosort"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/7_samtools_view_results/"
inPathBit="Aligned.toTranscriptome.out_paired.mapped.ONLY.bam"

files=($(ls -d $inPath/*$inPathBit))

for inFile in ${files[@]};do

		outPathBit=`basename $inFile | sed 's/_Aligned.toTranscriptome.out_paired.mapped.ONLY.bam//'`
		echo $outPathBit
		outFile=$resultsDir/$outPathBit"_Aligned.toTranscriptome.out_paired.mapped.ONLY_s.bam"
		novosort_version="/working/lab_julietF/mahdiM/tools/novocraft/novosort"
                novosort_line="$novosort_version \
			-c 16 -m 50G -n $inFile -o $outFile"
                novosort_command="novosort_command_$outPathBit"
		jobName="novosort.$outPathBit"
		echo $novosort_line >> $novosort_command
		chmod 775 $novosort_command
		qsub -l select=1:mem=50gb:ncpus=16 -e $logDir -N novosort\_$outPathBit -l walltime=40:00:00 $novosort_command
		
done;