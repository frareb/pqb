### plot: Edad (13)
newPlotHist(plotName="Edad",dataset=cuest[,13],isBreaks=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE,xlab="Edad",main="")

### plot: Sexo (12)
newPlotBarplot(plotName="Sexo",dataset=table(cuest[,12]),isRGB=TRUE,isDownload=TRUE)

### plot: Sexo ~ Edad (12;13)
newPlotBoxplot(plotName="SexoEdad",dataset=cuest[,13]~cuest[,12],isRGB=TRUE,isDownload=TRUE,xlab="Sexo",ylab="Edad")