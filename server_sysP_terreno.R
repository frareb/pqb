### plot: Parcelas (36)
newPlotBoxplot(plotName="Parcelas",dataset=cuest[,36]~cuest$seccion_a.departamento,isRGB=TRUE,isDownload=TRUE,ylab="Numero de parcelas",log="y")

### plot: Terreno (30:35)
### a refaire depuis le debut en plusieurs graphiques simples
### faire la fonction spécifique pour simple entrée DPT (Francois)
output$dptTerreno <- renderUI({
  deptList =  c("TODOS",unique(as.character(cuest$seccion_a.departamento)))
  selectInput("dpt", "Departamento", deptList)
})
newPlot(plotName="Terreno",funPlot=function(){
  cuestTerreno <- NULL
  if(length(input$dpt)>0 && input$dpt=="TODOS"){
    cuestTerreno <- cuest
    index<-cuestTerreno$seccion_a.departamento
  }
  if(length(input$dpt)>0 && input$dpt!="TODOS"){
    cuestTerreno <- cuest[cuest$seccion_a.departamento == input$dpt,]
    index<-cuestTerreno$seccion_a.municipio
  }
  cuestTerreno[,c(31,34,35)][cuestTerreno[,30]=="tarea",]<-cuestTerreno[,c(31,34,35)][cuestTerreno[,30]=="tarea",]*0.06288
  
  if(!is.null(cuestTerreno)){
    xl<-length(unique(index))
    layout(matrix(c(1:xl,rep((xl+1),4*xl)),byrow=TRUE,ncol=xl))
    lapply(unique(index),function(nm){
      par(mar=c(0,4,1,0),cex=1.2)
      barplot(c(sum(cuestTerreno[,32][index==nm],na.rm=TRUE),sum(cuestTerreno[,33][index==nm],na.rm=TRUE)),col="#3f4f78")
      text(0.7,0,"Propio", srt=90, pos=3,offset = 2)
      text(1.9,0,"Alquilado", srt=90, pos=3,offset = 2)
    })
    par(mar=c(8,4,3,0),cex=1.2)
    boxplot(cuestTerreno[,31]~as.character(index), log="y", border="#3f4f78", frame=FALSE, yaxt='n',main=paste0("Dpt: ",input$dpt),ylab="Log(ha)",las=2)
    axis(2,at=round(seq(from=0, to=max(cuestTerreno[,31],na.rm=TRUE),length.out = 10)),las=2)
    layout(1)
  }
},xheight=800)