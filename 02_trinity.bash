#!/bin/bash

homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/2_trinity_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/2_trinity"
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
	
	OutPath="$resultsDir/$shortname".trinity"/"
	mkdir -p $OutPath

	outDir=$resultsDir/$shortname
	mkdir -p $outDir
        
    	trinity_version="/working/lab_julietF/mahdiM/tools/trinityrnaseq-Trinity-v2.6.5/Trinity"
	
        trinity_line="$trinity_version --seqType fq \
		--max_memory 200G \
		--left $inFile1 --right $inFile2 \
		--CPU $numcores \
		--SS_lib_type RF \
		--output $OutPath \
		--full_cleanup \
		--bflyHeapSpaceMax 6G \
                --normalize_max_read_cov 50 ;"
		

	trinity_command="trinity_command_$shortname"
	jobName="tri.$shortname"
	echo $trinity_line >>$trinity_command
	chmod 775 $trinity_command
	totalMem=$(($numcores*8))
	qsub <<< "
#PBS -l select=ncpus=16:mem=150gb
#PBS -e $logDir
#PBS -N $shortname
#PBS -l walltime=40:00:00

module load python/2.7.13
$scriptsPath/$trinity_command
"
done;