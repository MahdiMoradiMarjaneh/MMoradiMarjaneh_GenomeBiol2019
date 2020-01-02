# Identification and quantification of non-coding RNAs (Moradi Marjaneh et al., *Genome Biology* 2020)

This repository provides `bash` scripts used for identification and quantification of ncRNAs including: 

1. trimming the sequencing reads with `trim_galore`
2. *de novo* assembly with `Trinity`
3. mapping back the *de novo* assemblies against hg19 reference genome with `gmap`
4. merging assemblies with `cuffmerge`
5. `STAR` indexing
6. mapping the sequencing reads against the merged assembly with `STAR`
7. filtering for paired mapped reads with `samtools view`
8. sorting with `novosort`
9. merging sorted bam files for each library with `samtools cat`
10. indexing with `rsem-prepare-reference`
11. quantification (gene and isoform level) with `rsem-calculate-expression`
12. making genome level bam files with `rsem-calculate-expression`
13. exon level quantification with `samtools view` and `coverageBed`

## References

Moradi Marjaneh M, Beesley J, O’Mara TA, Mukhopadhyay P, Koufariotis LT, Kazakoff S, et al. Non-coding RNAs underlie genetic predisposition to breast cancer. ***Genome Biology***. 2020. In press. 

Bartonicek N, Clark MB, Quek XC, Torpy JR, Pritchard AL, Maag JLV, et al. Intergenic disease-associated regions are abundant in novel transcripts. ***Genome Biology***. 2017; 18:241.
