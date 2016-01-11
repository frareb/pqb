### plot: smartphone (15)
newPlotBarplot(plotName="Smart",dataset=table(cuest[,15]),isRGB=TRUE,isDownload=TRUE)

### plot smartphone ~ Edad (15;13)
newPlotScatterplot(plotName="SmartEdad",dataset=list(cuest[,15],cuest[,13]),isDownload=TRUE,xlab="Edad",ylab="Tiene smartphone?")
