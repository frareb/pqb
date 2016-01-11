### plot: Variedades (56, 80, 104, 154, 171, 188)
splitVar<-split(cuest[,c(56,80,103,154,188)],cuest[,4])
listVar<-lapply(splitVar,function(i){
  ii<-unlist(i)
  ii<-factor(ii,levels=unique(unlist(cuest[,c(56,80,104,154,188)])))
  tvar<-table(ii)
})
bpVar<-do.call(rbind, listVar)
bpVarPerCent<-sapply(1:nrow(bpVar),function(i){bpVar[i,]/sum(bpVar[i,],na.rm=TRUE)*100})

newPlot(plotName="Var",funPlot=function(){
  mycolor1 <- rgb(abs(input$RVar-255),input$GVar,input$BVar,maxColorValue = 255)
  mycolor2 <- rgb(input$RVar,input$GVar,input$BVar,maxColorValue = 255)
  mycolor3 <- rgb(input$RVar,input$GVar,abs(input$BVar-255),maxColorValue = 255)
  par(mar=c(16,4,4,4))
  barplot(bpVar,las=2,ylab="Num. de agricultores",main="",col=c(mycolor1,mycolor2,mycolor3))
  legend("topright",legend=c("La Paz","Oruro","Potosi"),fill=c(mycolor1,mycolor2,mycolor3))
})
newPlot(plotName="Var1",funPlot=function(){
  mycolor <- rgb(input$RVar1,input$GVar1,input$BVar1,maxColorValue = 255)
  par(mar=c(16,4,4,4))
  barplot(bpVarPerCent[,1],las=2,ylab="%",main="La Paz",col=mycolor)
})
newPlot(plotName="Var2",funPlot=function(){
  mycolor <- rgb(input$RVar2,input$GVar2,input$BVar2,maxColorValue = 255)
  par(mar=c(16,4,4,4))
  barplot(bpVarPerCent[,2],las=2,ylab="%",main="Oruro",col=mycolor)
})
newPlot(plotName="Var3",funPlot=function(){
  mycolor <- rgb(input$RVar3,input$GVar3,input$BVar3,maxColorValue = 255)
  par(mar=c(16,4,4,4))
  barplot(bpVarPerCent[,3],las=2,ylab="%",main="Potosi",col=mycolor)
})