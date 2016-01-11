### plot: Afiliacion (16:20) + (21:24)
output$reacDepartamento <- renderUI({
  departamentoList =  c("TODOS",unique(as.character(cuest$seccion_a.departamento)))
  selectInput("departamento", "Departamento", departamentoList)
})
output$reacMunicipio <- renderUI({
  if(length(input$departamento)>0){
    municipioList =  c("TODOS",unique(as.character(cuest$seccion_a.municipio[cuest$seccion_a.departamento == input$departamento])))
    selectInput("municipio", "Municipio", municipioList)
  }
})
newPlot(plotName="Afiliacion",funPlot=function(){
  dataMunicipio <- NULL
  if(length(input$departamento)>0 && input$departamento=="TODOS"){dataMunicipio <- cuest}
  if(length(input$departamento)>0 && input$departamento!="TODOS"){
    if(input$municipio!="TODOS"){
      dataMunicipio <- cuest[cuest$seccion_a.municipio == input$municipio,]
    } else {
      dataMunicipio <- cuest[cuest$seccion_a.departamento == input$departamento,]
    }
  }
  if(length(dataMunicipio[,16:20])>0){
    bp<-apply(dataMunicipio[,16:20],MARGIN=2,FUN=sum,na.rm=TRUE)
    names(bp)<-sapply(strsplit(names(bp),split="\\."),"[[",3)
    barplot(bp, names.arg=colnames(bp), col="#3f4f78",main=paste0("Dpt: ",input$departamento,", Mun: ",input$municipio))
    output$aso<-renderText({
      paste0("Asociaciones: ",paste0(unique(as.character(dataMunicipio$seccion_a.asociacion[dataMunicipio$seccion_a.afiliaciones.asociacion==TRUE])),collapse=", "))
    })
    output$coo<-renderText({
      paste0("Cooperativas: ",paste0(unique(as.character(dataMunicipio$seccion_a.cooperativa[dataMunicipio$seccion_a.afiliaciones.cooperativa==TRUE])),collapse=", "))
    })
    output$emp<-renderText({
      paste0("Empresas: ",paste0(unique(as.character(dataMunicipio$seccion_a.empresa[dataMunicipio$seccion_a.afiliaciones.empresa==TRUE])),collapse=", "))
    })
    output$cam<-renderText({
      paste0("Camaras: ",paste0(unique(as.character(dataMunicipio$seccion_a.camara[dataMunicipio$seccion_a.afiliaciones.camara==TRUE])),collapse=", "))
    })
  }
})