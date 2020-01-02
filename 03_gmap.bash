#!/bin/bash

homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"
resultsDir="$homedir/3_gmap_results/"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/3_gmap"
logDir=$scriptsPath"/logs"
mkdir -p $logDir

inPath="$homedir/2_trinity_results/"
inPathBit="trinity.Trinity.fasta"

files=($(ls -d $inPath/*$inPathBit))

for inFile in ${files[@]};do

		outPathBit=`basename $inFile | sed 's/.trinity.Trinity.fasta//'`
		echo $outPathBit
		outGff=$resultsDir/$outPathBit".gff"
		gsnap_params="-K 2000000 -w 4000000 -L 5000000 --canonical-mode=0 "
		gmap_gff_line="/working/lab_julietF/mahdiM/tools/gmap-2015-11-20/src/gmap \
			-t $numcores -n 0 -D /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/reference/gmap_index_hg19 -d hg19_ERCC_E.coli $inFile -f gff3_gene > $outGff"
		gmap_gff_command="gmap_gff_command_$outPathBit"
		jobName="gmap_gff.$outPathBit"
		echo $gmap_gff_line >> $gmap_gff_command
		chmod 775 $gmap_gff_command
		qsub -l select=1:mem=10gb:ncpus=8 -e $logDir -N gff\_$outPathBit -l walltime=1000:00:00 $gmap_gff_command
		
done;