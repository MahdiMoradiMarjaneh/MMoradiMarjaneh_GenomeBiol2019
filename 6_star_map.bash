#!/bin/bash

homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/6_star_map_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/6_star_map"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/1_trim_results/"
inPathBit="_001_val_*.fq.gz"

names=($(ls -d $inPath/*))

for dir in ${names[@]};do
	shortname=`basename $dir`
	echo $shortname
	files=( $(ls $dir/*$inPathBit) )
	inFile1=${files[0]}
	inFile2=`echo $inFile1 | sed 's/R1_001_val_1/R2_001_val_2/'`
	
	
	star_map_version="/working/lab_julietF/mahdiM/tools/STAR_2.5.2b/bin/Linux_x86_64/STAR"
	
        star_map_line="$star_map_version \
		--genomeDir /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/5_star_index_results
                --readFilesIn $inFile1 $inFile2 \
                --readFilesCommand zcat \
                --outFileNamePrefix $resultsDir/$shortname"_" \
                --outFilterType BySJout \
                --outFilterMultimapNmax 20 \
                --alignSJoverhangMin 6 \
                --alignSJDBoverhangMin 1 \
                --outFilterMismatchNmax 999 \
                --alignIntronMin 20 \
                --alignIntronMax 1500000 \
                --alignMatesGapMax 1500000 \
                --limitBAMsortRAM 80000000000 \
                --outSAMattributes NH HI AS NM MD \
                --outSAMtype BAM SortedByCoordinate \
                --outWigType wiggle --outWigNorm None \
                --outFilterMismatchNoverReadLmax 0.04 \
                --outFilterMatchNmin 101 \
                --quantMode TranscriptomeSAM ;"
                
	star_map_command="star_map_$shortname"
	echo $star_map_line >> $star_map_command
	chmod 775 $star_map_command
	qsub -l select=1:mem=35g -e $logDir -N $shortname -l walltime=40:00:00 $star_map_command
done;