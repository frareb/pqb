### plot: Incorpora
newPlotBarplot(plotName="incorporaV1",dataset=cuest[,c(39,44,46,51,52,48)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="incorporaV2",dataset=cuest[,c(63,68,70,75,76,72)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)
newPlotBarplot(plotName="incorporaV3",dataset=cuest[,c(87,92,94,99,100,96)],isRGB=TRUE,isDownload=TRUE,addLegend=TRUE,cond1=cuest[,4],cond2=cuest[,5],cond1Label="DPT",cond2Label="MUN",las=2,addMarBellow=8)

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
  aa<-matrix(as.logical(datasetAlt),ncol=6)
  aa<-apply(aa,MARGIN=2,FUN=sum,na.rm=TRUE)
  return(aa)
}
var1<-toLogical(cuest[,c(39,44,46,51,52,48)])
var2<-toLogical(cuest[,c(63,68,70,75,76,72)])
var3<-toLogical(cuest[,c(87,92,94,99,100,96)])
varT2<-rbind(var1,var2,var3)
varT2<-t(varT2)
rownames(varT2)<-c("Compost","Estiercol bovino","Estiercol camelido","Estiercol ovino","Gallinaza","Otro")
newPlotBarplot(plotName="incorpora",dataset=varT2,isRGB=TRUE,isDownload=TRUE,las=2,ylab="Num. de agricultores",main="",addLegend=TRUE)
