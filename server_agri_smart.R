### plot: smartphone (15)
newPlotBarplot(plotName="Smart",dataset=table(cuest[,15]),isRGB=TRUE,isDownload=TRUE)

### plot smartphone ~ Edad (15;13)
newPlotBoxplot(plotName="SmartEdad",dataset=cuest[,13]~cuest[,15],isRGB=TRUE,isDownload=TRUE,ylab="Edad")

### plot smartphone ~ Sexo (15;12)
newPlotScatterplot(plotName="SmartSexo",dataset=list(cuest[,12],cuest[,15]),isRGB=TRUE,isDownload=TRUE,ylab="Sexo",xlab="Smartphone")