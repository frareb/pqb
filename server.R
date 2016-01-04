library(shiny)
library(plotrix)

archivo<-"data/cuestionarioquinuarjj-2015-12-01-11-58-53.csv"
tipoDatos<-c("factor","factor","Date","factor","factor","factor","factor","factor",
             "factor","character","character","factor","integer","character","factor",
             "logical","logical","logical","logical","logical","factor","factor",
             "factor","factor","character","numeric","numeric","numeric","numeric",
             rep("character",265-29))
cuest<-read.table(archivo,sep=',',header=TRUE,na="n/a",colClasses=tipoDatos,encoding="UTF-8")

# AGRI: edad(13) ; sexo(12) ; smartphone (15) ; 

shinyServer(function(input, output) {
  
  source("server_fun.R", local=TRUE)
  
  ### plot smartphone
  newPlot(plotName="Smart",funPlot=function(){
    barplot(table(cuest[,15]),main="Smartphone")
  })
  
  ### plot smartphone = f(Edad)
  newPlot(plotName="SmartEdad",funPlot=function(){
    plot(cuest[,15]~cuest[,13],xlab="Edad",ylab="Smartphone")
  })
  
  ### plot: Edad
  newHist(plotName="Edad",dataset=cuest[,13],isBins=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE,mwidth=800,mheight=600)

  ### plot and download: Sexo
  newPlot(plotName="Sexo",funPlot=function(){
    col <- 12 # factor sexo
    x    <- cuest[,col]
    mycolor <- rgb(input$myR_sexo,input$myG_sexo,input$myB_sexo,maxColorValue = 255)
    barplot(table(x), col = mycolor, border = 'white',main=names(cuest)[col])
  })
  
  ### plot and download: Sexo_Edad
  newPlot(plotName="SexoEdad",funPlot=function(){
    datos<-table(cuest[,13],cuest[,12])
    xy.pop<-datos[,2]
    xx.pop<-datos[,1]
    agelabels<-names(datos[,2])
    mcol<-color.gradient(c(0,0,0.5,1),c(0,0,0.5,1),c(1,1,0.5,1),length(datos[,2]))
    fcol<-color.gradient(c(1,1,0.5,1),c(0.5,0.5,0.5,1),c(0.5,0.5,0.5,1),length(datos[,2]))
    par(mar=pyramid.plot(xx.pop,xy.pop,lxcol=mcol,rxcol=fcol,gap=0.5,show.values=FALSE,labels=agelabels))
  })
  
  ### Reactive UI
  output$reacDepartamento <- renderUI({
    departamentoList =  unique(as.character(cuest$seccion_a.departamento))
    selectInput("departamento", "Departamento", departamentoList)
  })
  output$reacMunicipio <- renderUI({
    municipioList =  unique(as.character(cuest$seccion_a.municipio[cuest$seccion_a.departamento == input$departamento]))
    selectInput("municipio", "Municipio", municipioList)
  })
  output$barPlotAfiliacion <- renderPlot({
    if(input$variables == "afiliacion"){
      dataMunicipio <- cuest[cuest$seccion_a.municipio == input$municipio,]
      asociacion<-length(dataMunicipio$seccion_a.afiliaciones.asociacion[dataMunicipio$seccion_a.afiliaciones.asociacion == TRUE])
      empresa<-length(dataMunicipio$seccion_a.afiliaciones.empresa[dataMunicipio$seccion_a.afiliaciones.empresa == TRUE])
      indepediente<-length(dataMunicipio$seccion_a.afiliaciones.independiente[dataMunicipio$seccion_a.afiliaciones.independiente == TRUE])
      camara<-length(dataMunicipio$seccion_a.afiliaciones.camara[dataMunicipio$seccion_a.afiliaciones.camara == TRUE])
      bp <- cbind(asociacion,empresa,indepediente,camara)
      par(bg="#ebf0fb", col.axis="#3f4f78",col.lab="#3f4f78", cex=1.2)
      barplot(bp, names.arg=colnames(bp), col="#3f4f78")
    }
    if(input$variables == "parcelas"){
      dataDepartamento <- data.frame(cuest$seccion_a.municipio[cuest$seccion_a.departamento == input$departamento],cuest$seccion_a.parcela[cuest$seccion_a.departamento == input$departamento])
      par(bg="#ebf0fb", col.axis="#3f4f78",col.lab="#3f4f78", cex=1.2, mar=c(8,4,4,4))
      boxplot(as.numeric(dataDepartamento[,2]) ~ as.character(dataDepartamento[,1]), las=2,border="#3f4f78", frame=FALSE, xaxt='n',yaxt='n')
      axis(1,at=1:length(unique(as.character(dataDepartamento[,1]))),labels=unique(as.character(dataDepartamento[,1])), lwd=0, las=2)
      axis(2,ylim=seq(from=0, to=max(as.numeric(dataDepartamento[,2])),length.out = 4) ,lwd=1, col="#3f4f78")
    }
  })
  
})
