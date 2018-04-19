## count no. of fast reads: 
for i in *.1.fastq ; do b=$(cat $i | paste - - - - | wc -l | sed -e 's/ *//'); echo $(basename $i .1.fastq ) $b; done | tr ' ' '\t' > fastq.Batch1.txt

# count no. of Coupled Reads: 
for i in *.CoupledReads.fa ; do b=$( grep -c '>' $i); echo  $(basename $i .CoupledReads.fa ) $b ; done  | tr ' ' '\t' > Trimmed.batch1.txt


# Get assembly stats from MIGA output: 
for i in */log; do b=$(tac $i | sed -n -e 1p -e 5p); echo $(dirname "${i}") $b; done | tr ' ' '\t' > /nv/hp10/mjsg3/scratch/bactch1.assembly.stats
 
 
