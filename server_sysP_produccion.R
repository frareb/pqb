### plot: Produccion (37:38)
output$dptProd <- renderUI({
  deptList =  c("TODOS",unique(as.character(cuest$seccion_a.departamento)))
  selectInput("dptP", "Departamento", deptList)
})
newPlot(plotName="Prod",funPlot=function(){
  cuestProd <- NULL
  if(length(input$dptP)>0 && input$dptP=="TODOS"){
    cuestProd <- cuest
    index<-as.character(cuestProd$seccion_a.departamento)
  }
  if(length(input$dptP)>0 && input$dptP!="TODOS"){
    cuestProd <- cuest[cuest$seccion_a.departamento == input$dptP,]
    index<-as.character(cuestProd$seccion_a.municipio)
  }
  if(!is.null(cuestProd)){
    cuestProd[,37]<-factor(cuestProd[,37],levels=c("FALSE","TRUE"))
    sumProd<-table(cuestProd[,37],index)
    par(mar=c(8,4,4,4))
    barplot(sumProd,beside=TRUE,col=c(grey(0.8),"#3f4f78"),las=2,main=paste0("Dpt: ",input$dptP))
    legend("topright",legend=c("convencional","organico"),fill=c(grey(0.8),"#3f4f78"))
  }
})