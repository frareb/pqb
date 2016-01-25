### plot: Semillas (41,42,45,50,54,59,61,62)
newPlotBarplot(plotName="SemillasV1",dataset=cuest[,c(41,42,45,50,54,59,61,62)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="SemillasV2",dataset=cuest[,c(65,66,69,74,78,83,85,86)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="SemillasV3",dataset=cuest[,c(89,90,93,98,102,108,110,111)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="SemillasV4",dataset=cuest[,c(141,142,147,149,152,144,150,148)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="SemillasV5",dataset=cuest[,c(158,159,164,166,169,161,167,165)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="SemillasV6",dataset=cuest[,c(175,176,181,183,186,178,184,182)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)

toLogical<-function(datasetAlt){
  if(any(datasetAlt=="True") || any(datasetAlt=="False")){
    xx<-sapply(1:ncol(datasetAlt),function(x){
      datasetAlt[,x][datasetAlt[,x]=="True"]<-TRUE
      return(datasetAlt[,x])
    })
    xx<-sapply(1:ncol(xx),function(x){
      xx[,x][xx[,x]=="False"]<-FALSE
      return(xx[,x])
    })
    colnames(xx)<-names(datasetAlt)
    datasetAlt<-xx
  }
  aa<-matrix(as.logical(datasetAlt),ncol=8)
  aa<-apply(aa,MARGIN=2,FUN=sum,na.rm=TRUE)
  return(aa)
}
var1<-toLogical(cuest[,c(41,42,45,50,54,59,61,62)])
var2<-toLogical(cuest[,c(65,66,69,74,78,83,85,86)])
var3<-toLogical(cuest[,c(89,90,93,98,102,108,110,111)])
var4<-toLogical(cuest[,c(141,142,147,149,152,144,150,148)])
var5<-toLogical(cuest[,c(158,159,164,166,169,161,167,165)])
var6<-toLogical(cuest[,c(175,176,181,183,186,178,184,182)])
varT<-rbind(var1,var2,var3,var4,var5,var6)
varT<-t(varT)
rownames(varT)<-c("Propia","Organizacion","Agropecuaria","Otro","Empresa","PROINPA","Otra comunidad","Comunidad")
newPlotBarplot(plotName="Semillas",dataset=varT,isRGB=TRUE,isDownload=TRUE,las=2,ylab="Num. de agricultores",main="",addLegend=TRUE)

