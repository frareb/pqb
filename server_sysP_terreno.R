### plot: Parcelas (36)
newPlotBoxplot(plotName="Parcelas",dataset=cuest[,36]~cuest$seccion_a.departamento,isRGB=TRUE,isDownload=TRUE,ylab="Numero de parcelas",log="y")
### plot: Propiedad (32,33)
newPlotBarplot(plotName="Terreno",dataset=cuest[,32:33],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN")

### plot: field size (31)
cuestTerreno <- cuest
cuestTerreno[,c(31,34,35)][cuestTerreno[,30]=="tarea",]<-cuestTerreno[,c(31,34,35)][cuestTerreno[,30]=="tarea",]*0.06288
newPlotBoxplot(plotName="SizeF",dataset=cuestTerreno[,31]~cuest$seccion_a.departamento,isRGB=TRUE,isDownload=TRUE,ylab="Log(ha)",log="y")