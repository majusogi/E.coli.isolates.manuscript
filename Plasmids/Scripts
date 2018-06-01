### Scripts to identify and annotate plasmids in E. coli genomes: 


1. Find plasmids using PlasmidSpades: 



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
FastA.filter.pl $b.plasmid2.txt $i > $b.plasmid2.fna ;
