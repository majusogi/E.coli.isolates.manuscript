### Scripts to identify and annotate plasmids in E. coli genomes: 


1. Find plasmids using PlasmidSpades: 

/nv/hp10/mjsg3/data/tools/SPAdes-3.8.0-Linux/bin/plasmidspades.py --plasmid --careful --threads 16 --pe1-1 $NAME.1.fastq.gz --pe1-
2 $NAME.2.fastq.gz -o plasmidSpades/$NAME;


2. Divide plasmids into separate fasta files: 

#!/bin/bash

for i in plasmidSpades/*/contigs.fasta ; do 
b=`echo $i | cut -d/ -f2` 
echo $b

grep 'component_0' $i > $b.plasmid0.txt
FastA.filter.pl $b.plasmid0.txt $i > $b.plasmid0.fna ; 


grep 'component_1' $i > $b.plasmid1.txt
FastA.filter.pl $b.plasmid1.txt $i > $b.plasmid1.fna ;


grep 'component_2' $i > $b.plasmid2.txt
FastA.filter.pl $b.plasmid2.txt $i > $b.plasmid2.fna 


** delete empty files:
find . -size 0 -delete


3. Annotate plasmids using PlasmidSpades: 

blat -minIdentity=80 -tileSize=11 -t=dna /nv/hp10/mjsg3/data/DATABASES/PlasmidFinder/enterobacteriaceae.fsa -q=dna $i -out=blast8 
$b.blast; 



