args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

par(mai=c(0.5,1.5,0,0)); #set margin for plot bottom,left top, right
library(multcomp)
strains<-read.csv(args[1],header=TRUE)
strains$Sample = relevel(strains$Sample,args[2])
test<-summary(glht(aov(X2log ~ Sample, data=strains), linfct=mcp(Sample="Dunnett")))
pdf(paste0(gsub("ANOVA\\.csv","T-test",args[1]),".pdf"),width=8, height=6,useDingbats=FALSE)
plot(glht(aov(X2log ~ Sample, data=strains), linfct=mcp(Sample="Dunnett")))
dev.off()