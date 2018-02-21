pdf("boxplot2.pdf")

ggplot(data = Bdata, aes(x=antibiotic, y=val)) + geom_boxplot(aes(fill = location)) +  
  geom_point(aes(y=val, group=location), position = position_dodge(width=0.75)) + 
  facet_wrap( ~ antibiotic, scales="free") + theme_classic()

dev.off()
