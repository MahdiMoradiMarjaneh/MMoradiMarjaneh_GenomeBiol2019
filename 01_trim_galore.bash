#!/bin/bash
module load /software/modulefiles/python/3.5.5 
module load /software/modulefiles/fastqc/0.11.5  

homedir="/working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01"

inPath="$homedir/raw_files/"

inExt="fastq.gz"

scriptsPath="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/1_trim"

outPath="/$homedir/1_trim_results/"

commandFile="/mnt/backedup/home/mahdiM/my_projects/RNAcaptureseq_01/scripts/1_trim/trimgalore_command"

logDir=$scriptsPath/"logs"
 
mkdir -p $outPath
mkdir -p $logDir
rm $commandFile

i=0   
files=( $(ls $inPath/*) )
for file in ${files[@]};do
        echo The file used is: $file
        filesTotal[i]=$file;
        let i++;
done;

j=0
echo -e "The total number of files is:"
echo ${#filesTotal[@]}
echo -e

while [ $j -lt ${#filesTotal[@]} ]; do

        inFile1=${files[$j]}
        inFile2=${files[$(($j+1))]}

        uniqueID=`basename $inFile1 | sed s/_R.*//`
        echo $uniqueID
        name=$uniqueID
        outDir=$outPath/$uniqueID/
        mkdir -p $outDir
        module load python/3.6.1  
        module load fastqc/0.11.5 
        command_line="/working/lab_julietF/mahdiM/tools/trim_galore/TrimGalore-0.4.5/trim_galore $inFile1 $inFile2 --fastqc --paired --retain_unpaired --length 16 --path_to_cutadapt /mnt/backedup/home/mahdiM/.local/bin/cutadapt -o $outDir"
        echo $command_line > $commandFile
        chmod 775 $commandFile
        qsub -l select=ncpus=3:mem=4gb -e $logDir -N $uniqueID -l walltime=40:00:00 $commandFile
        j=$(($j+2))
done;