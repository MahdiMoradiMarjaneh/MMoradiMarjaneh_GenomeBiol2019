cd $PBS_O_WORKDIR 
/working/lab_julietF/mahdiM/tools/STAR_2.5.2b/bin/Linux_x86_64/STAR --runMode genomeGenerate --genomeDir /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/5_star_index_results --genomeFastaFiles /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq/reference/mmm/my.fasta/hg19_ERCC_E.coli.fa --sjdbGTFfile /working/lab_julietF/mahdiM/my_projects/RNAcaptureseq_01/4_cuffmerge_results/merged_no.strand.info.missing.gtf --sjdbOverhang 150