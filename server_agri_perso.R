### plot: Edad (13)
newHist(plotName="Edad",dataset=cuest[,13],isBins=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE)

### plot: Sexo (12)
newPlot(plotName="Sexo",funPlot=function(){
  mycolor <- rgb(input$myR_sexo,input$myG_sexo,input$myB_sexo,maxColorValue = 255)
  barplot(table(cuest[,12]), col = mycolor, border = 'white',main=names(cuest)[12])
})

### plot: Sexo ~ Edad (12;13)
newPlot(plotName="SexoEdad",funPlot=function(){
  datos<-table(cuest[,13],cuest[,12])
  xy.pop<-datos[,2]
  xx.pop<-datos[,1]
  agelabels<-names(datos[,2])
  mcol<-color.gradient(c(0,0,0.5,1),c(0,0,0.5,1),c(1,1,0.5,1),length(datos[,2]))
  fcol<-color.gradient(c(1,1,0.5,1),c(0.5,0.5,0.5,1),c(0.5,0.5,0.5,1),length(datos[,2]))
  par(mar=pyramid.plot(xx.pop,xy.pop,lxcol=mcol,rxcol=fcol,gap=0.5,show.values=FALSE,labels=agelabels))
})