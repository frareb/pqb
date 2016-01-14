### plot: Variedades (56, 80, 104, 154, 171, 188)
splitVar<-split(cuest[,c(56,80,103,154,188)],cuest[,4])
listVar<-lapply(splitVar,function(i){
  ii<-unlist(i)
  ii<-factor(ii,levels=unique(unlist(cuest[,c(56,80,104,154,188)])))
  tvar<-table(ii)
})
bpVar<-do.call(rbind, listVar)
bpVarPerCent<-sapply(1:nrow(bpVar),function(i){bpVar[i,]/sum(bpVar[i,],na.rm=TRUE)*100})

newPlotBarplot(plotName="Var",dataset=bpVar,isRGB=TRUE,isDownload=TRUE,las=2,ylab="Num. de agricultores",main="",addMarBellow=16,addLegend=TRUE)
newPlotBarplot(plotName="Var1",dataset=bpVarPerCent[,1],isRGB=TRUE,isDownload=TRUE,las=2,ylab="%",main="La Paz",addMarBellow=16)
newPlotBarplot(plotName="Var2",dataset=bpVarPerCent[,2],isRGB=TRUE,isDownload=TRUE,las=2,ylab="%",main="Oruro",addMarBellow=16)
newPlotBarplot(plotName="Var3",dataset=bpVarPerCent[,3],isRGB=TRUE,isDownload=TRUE,las=2,ylab="%",main="Potosi",addMarBellow=16)