library(shiny)
library(plotrix)

archivo<-"data/cuestionarioquinuarjj-2016-01-04-18-03-29.csv"
tipoDatos<-c("factor","factor","Date","factor","factor","factor","factor","factor",
             "factor","character","character","factor","integer","character","factor",
             "logical","logical","logical","logical","logical","factor","factor",
             "factor","factor","character","numeric","numeric","numeric","numeric", #col 29
             "factor","numeric","logical","logical","numeric","numeric","numeric", #col 36
             "logical","logical",
             rep("character",265-38))
cuest<-read.table(archivo,sep=',',header=TRUE,na="n/a",colClasses=tipoDatos,encoding="UTF-8")

shinyServer(function(input, output) {
  
  source("server_fun.R", local=TRUE)
  
  ### plot: smartphone (15)
  newPlot(plotName="Smart",funPlot=function(){
    mycolor <- rgb(input$RSmart,input$GSmart,input$BSmart,maxColorValue = 255)
    barplot(table(cuest[,15]),main="Smartphone", col = mycolor)
  })
  
  ### plot smartphone ~ Edad (15;13)
  newPlot(plotName="SmartEdad",funPlot=function(){
    plot(cuest[,15]~cuest[,13],xlab="Edad",ylab="Smartphone")
  })
  
  ### plot: Edad (13)
  newHist(plotName="Edad",dataset=cuest[,13],isBins=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE)

  ### plot: Sexo (12)
  newPlot(plotName="Sexo",funPlot=function(){
    mycolor <- rgb(input$myR_sexo,input$myG_sexo,input$myB_sexo,maxColorValue = 255)
    barplot(table(cuest[,12]), col = mycolor, border = 'white',main=names(cuest)[12])
  })
  
  ### plot: Sexo ~ Edad (12;13)
  newPlot(plotName="SexoEdad",funPlot=function(){
    datos<-table(cuest[,13],cuest[,12])
    xy.pop<-datos[,2]
    xx.pop<-datos[,1]
    agelabels<-names(datos[,2])
    mcol<-color.gradient(c(0,0,0.5,1),c(0,0,0.5,1),c(1,1,0.5,1),length(datos[,2]))
    fcol<-color.gradient(c(1,1,0.5,1),c(0.5,0.5,0.5,1),c(0.5,0.5,0.5,1),length(datos[,2]))
    par(mar=pyramid.plot(xx.pop,xy.pop,lxcol=mcol,rxcol=fcol,gap=0.5,show.values=FALSE,labels=agelabels))
  })
  
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
  
  ### plot: Terreno (30:35)  
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
  
  ### plot: Parcelas (36)
  newPlot(plotName="Parcelas",funPlot=function(){
    mycolor <- rgb(input$RParcelas,input$GParcelas,input$BParcelas,maxColorValue = 255)
    boxplot(cuest[,36]~cuest$seccion_a.departamento,xlab="",ylab="Numero de parcelas", log="y", border="#3f4f78", frame=FALSE,col=mycolor,main="Numero de parcelas")
  })
  
  ### plot: Variedades (56, 80, 104, 154, 171, 188)
  splitVar<-split(cuest[,c(56,80,103,154,188)],cuest[,4])
  listVar<-lapply(splitVar,function(i){
    ii<-unlist(i)
    ii<-factor(ii,levels=unique(unlist(cuest[,c(56,80,104,154,188)])))
    tvar<-table(ii)
  })
  bpVar<-do.call(rbind, listVar)
  bpVarPerCent<-sapply(1:nrow(bpVar),function(i){bpVar[i,]/sum(bpVar[i,],na.rm=TRUE)*100})
  
  newPlot(plotName="Var",funPlot=function(){
    mycolor1 <- rgb(abs(input$RVar-255),input$GVar,input$BVar,maxColorValue = 255)
    mycolor2 <- rgb(input$RVar,input$GVar,input$BVar,maxColorValue = 255)
    mycolor3 <- rgb(input$RVar,input$GVar,abs(input$BVar-255),maxColorValue = 255)
    par(mar=c(16,4,4,4))
    barplot(bpVar,las=2,ylab="Num. de agricultores",main="",col=c(mycolor1,mycolor2,mycolor3))
    legend("topright",legend=c("La Paz","Oruro","Potosi"),fill=c(mycolor1,mycolor2,mycolor3))
  })
  newPlot(plotName="Var1",funPlot=function(){
    mycolor <- rgb(input$RVar1,input$GVar1,input$BVar1,maxColorValue = 255)
    par(mar=c(16,4,4,4))
    barplot(bpVarPerCent[,1],las=2,ylab="%",main="La Paz",col=mycolor)
  })
  newPlot(plotName="Var2",funPlot=function(){
    mycolor <- rgb(input$RVar2,input$GVar2,input$BVar2,maxColorValue = 255)
    par(mar=c(16,4,4,4))
    barplot(bpVarPerCent[,2],las=2,ylab="%",main="Oruro",col=mycolor)
  })
  newPlot(plotName="Var3",funPlot=function(){
    mycolor <- rgb(input$RVar3,input$GVar3,input$BVar3,maxColorValue = 255)
    par(mar=c(16,4,4,4))
    barplot(bpVarPerCent[,3],las=2,ylab="%",main="Potosi",col=mycolor)
  })
  
  ### siembra 
  splitDate<-split(cuest[,c(58,82,106,139,156)],cuest[,4])
  i1<-unlist(splitDate[[1]])
  i2<-unlist(splitDate[[2]])
  i3<-unlist(splitDate[[3]])
  newHist(plotName="Fecha de siembra - La Paz",dataset=as.Date(i1,format="%Y-%m-%d"),isBins=TRUE,isDate=TRUE,isRGB=TRUE,isDensity=FALSE,isDownload=TRUE)
  newHist(plotName="Fecha de siembra - Oruro",dataset=as.Date(i2,format="%Y-%m-%d"),isBins=TRUE,isDate=TRUE,isRGB=TRUE,isDensity=FALSE,isDownload=TRUE)
  newHist(plotName="Fecha de siembra - Potosi",dataset=as.Date(i3,format="%Y-%m-%d"),isBins=TRUE,isDate=TRUE,isRGB=TRUE,isDensity=FALSE,isDownload=TRUE)
  newHist(plotName="Fecha de siembra - Bolivia (2015)",dataset=as.Date(unlist(cuest[,c(58,82,106,139,156)]),format="%Y-%m-%d"),isBins=TRUE,isDate=TRUE,isRGB=TRUE,isDensity=FALSE,isDownload=TRUE)
  # hist(as.Date(unlist(cuest[,c(58,82,106,139,156)]),format="%Y-%m-%d"),breaks="weeks",las=2)
  
  newPlot(plotName="Fech",funPlot=function(){
    mycolor1 <- rgb(abs(input$RFech-255),input$GFech,input$BFech,maxColorValue = 255)
    mycolor2 <- rgb(input$RFech,input$GFech,input$BFech,maxColorValue = 255)
    mycolor3 <- rgb(input$RFech,input$GFech,abs(input$BFech-255),maxColorValue = 255)
    hist(as.Date(unlist(cuest[,c(58,82,106,139,156)]),format="%Y-%m-%d"),breaks="weeks",las=2,ylim=c(0,0.08),main="Fecha de siembra por departamento",xlab="")
    lines(density(as.numeric(as.Date(i1,format="%Y-%m-%d")),na.rm=TRUE,adjust=3),lwd=3,col=mycolor1)
    lines(density(as.numeric(as.Date(i2,format="%Y-%m-%d")),na.rm=TRUE,adjust=3),lwd=3,col=mycolor2)
    lines(density(as.numeric(as.Date(i3,format="%Y-%m-%d")),na.rm=TRUE,adjust=3),lwd=3,col=mycolor3)
    legend("topright",legend=c("La Paz","Oruro","Potosi"),fill=c(mycolor1,mycolor2,mycolor3))
  })
  
})
