
#!/bin/bash

module load blat/rhel6

#mkdir all.CARD.DB
for i in *.faa ; do
	b=$(basename $i .faa)
	blat -minIdentity=80 -t=prot /nv/hp10/mjsg3/data/DATABASES/CARD_wild.and.homolo.faa -q=prot $i -out=blast8 $b.blast ;
	
	sort $b.blast | BlastTab.best_hit_sorted.pl > $b.blast.bhit
		## add lenght:
	BlastTab.addlen.rb -f $i < $b.blast.bhit > $b.blast.bhit.addlen

	#filter:
	c=$(basename $b .blast.bhit.addlen)
	awk '{x=$13*0.7; y= $8-$7} {if (y>=x && $3 >= 70.00) print $0}' $b.blast.bhit.addlen > $c.filtered.blast
	
	cat $c.filtered.blast |  awk '{split ($2,a,"|"); print a[3]}' | sort -n | uniq -c | awk '{print $2"\t"$1}' > $(basename $c .filtered.blast).count;

done

Table.merge.pl 

 for i in *.filtered.blast; do cat $i |  awk '{split ($2,a,"|"); print a[3]}' | sort -n | uniq -c | awk '{print $2"\t"$1}' > $(basename
  $i .filtered.blast).count; done 



Location of count files with all Isolates from different locations: 

/nv/hp10/mjsg3/shared3/projects/EcoZUR/ARGs.CARD.AllIsolates  
