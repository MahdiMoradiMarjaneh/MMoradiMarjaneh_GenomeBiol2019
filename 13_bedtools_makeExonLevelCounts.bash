#!/bin/bash

homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/13_bedtools_makeExonLevelCounts_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/13_bedtools_makeExonLevelCounts"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/12_rsem_makeGenomeLevelBam_results/"
inPathBit="genome.sorted.bam"

exonFile="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/13_bedtools_makeExonLevelCounts/rnacaptureseqSCtranscripts.bed"

files=($(ls -d $inPath/*$inPathBit))

for inBam in ${files[@]};do
                
        outPathBit=`basename $inBam | sed 's/.genome.sorted.bam//'`
        echo $outPathBit
        outFilePrefix=$resultsDir/$outPathBit
                
        bedtools_makeExonLevelCounts_line="samtools view -uf 0x2 $inBam | \
                coverageBed -b - -a $exonFile \
                > $outFilePrefix".exons.bed.proper.coverage";"
 
	bedtools_makeExonLevelCounts_command="bedtools_makeExonLevelCounts_$outPathBit"
	echo $bedtools_makeExonLevelCounts_line >> $bedtools_makeExonLevelCounts_command
	chmod 775 $bedtools_makeExonLevelCounts_command
        # qsub -l select=1:mem=10gb:ncpus=2 -e $logDir -N bedtools_makeExonLevelCounts\_$outPathBit -l walltime=40:00:00 $bedtools_makeExonLevelCounts_command
        qsub <<< "
#PBS -l select=ncpus=2:mem=250gb
#PBS -e $logDir
#PBS -N bedtools_makeExonLevelCounts\_$outPathBit
#PBS -l walltime=40:00:00

module load bedtools/2.26.0
$scriptsPath/$bedtools_makeExonLevelCounts_command
"
done;