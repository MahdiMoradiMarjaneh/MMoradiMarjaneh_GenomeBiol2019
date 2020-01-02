export PATH=$PATH:/working/lab_julietF/mahdiM/tools/cufflinks-2.2.1.Linux_x86_64/ 
cd $PBS_O_WORKDIR 
cuffmerge -s /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/reference/mmm/my.fasta/hg19_ERCC_E.coli.fa -o /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/4_cuffmerge_results/ myGFFs.txt 