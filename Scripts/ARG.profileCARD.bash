
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


To Plot in R: 

## BarPlots : 
library(ggplot2)

#To plot the mean with the std. dev from different location or values. 
#E. coli isolates from rural and urban

B<-read.csv(file='inputR.csv', head=TRUE,sep=",")
Bdata <- as.data.frame(B)
attach(Bdata)

## BarPlots with standar error bar
dodge <- position_dodge(width = 0.9)
limits <- aes(ymax = B$value + B$std, ymin = B$value - B$std)
p <- ggplot(data = B, aes(x=reorder(class,-value), y=value, fill=location))

p + geom_bar(stat = "identity", position = dodge) + 
  geom_errorbar(limits, position = dodge, width = 0.25) +  
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), 
        axis.title.x=element_blank()) + theme_classic() + 
  scale_fill_manual(values=c("grey", "lightblue")) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

##To sort the data de mayor a menor:
p <- ggplot(data = B, aes(x=reorder(class,-value), y=value, fill=location))
  
# To rotate x labes: 
theme(axis.text.x = element_text(angle = 90, hjust = 1))

## Colors by Metadata
scale_fill_manual(values=c("grey", "lightblue")) + 
 
scale_color_manual(values=c("orange", "chartreuse4"))

FIELD_LABELS,DAEC,EPEC-a,EPEC-t,ETEC,EIEC,EAEC
FIELD_COLORS,#FF3333,#FFCC33,#FF9900,#0099FF,#009933,#9900FF
FIELD_SHAPES,1,1,1,1,1,1
HEIGHT_FACTOR,2
SYMBOL_SPACING,20


Location of count files with all Isolates from different locations: 

/nv/hp10/mjsg3/shared3/projects/EcoZUR/ARGs.CARD.AllIsolates  
