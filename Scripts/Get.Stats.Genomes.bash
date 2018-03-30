# Get assembly stats from MIGA output: 

 for i in */log; do b=$(tac $i | sed -n -e 1p -e 5p); echo $(dirname "${i}") $b; done | tr ' ' '\t' > /nv/hp10/mjsg3/scratch/bactch1.assembly.stats
 
 
