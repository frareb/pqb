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
  
  #' Make a simple plot in shiny-server.
  #' 
  #' \code{newPlot} allows to build a plot in shiny with a download button for PNG export.
  #' @param plotName The name of the plot.
  #' @param funPlot A function which contain the code to build the plot, see examples.
  #' @param mwidth The width of the plot to be downloaded in pixels.
  #' @param mheight The height of the plot to be downloaded in pixels.
  #' @return NULL.
  #' @examples
  #' \dontrun{
  #' newPlot(plotName="myNewPlot",funPlotfunction(){plot(1)},mwidth=800,mheight=600)
  #' }
  #' @details \code{newPlot} computes a plot input name starting with "plotInput"
  #'   with the name of the plot as a suffix, a plot output name starting with 
  #'   "plot" with the name of the plot as a suffix, a download button name 
  #'   starting with "downloadPlot" with the name of the plot as a suffix, and
  #'   a PNG file name with the same name as the \code{plotName}. These names
  #'   can later be used in the ui file to organize the layout.
  #'   The example above will create a simple plot \code{plot(1)} with 
  #'   plotInputmyNewPlot as plot input name,
  #'   plotmyNewPlot as plot output name,
  #'   downloadPlotmyNewPlot as download button name, and
  #'   myNewPlot.png as plot export name.
  #'   The counterpart in ui file could look like the following:
  #'   \code{column(4,plotOutput("plotmyNewPlot"),downloadButton('downloadPlotmyNewPlot','PNG'))}.
  newPlot<-function(plotName,funPlot,mwidth=800,mheight=600){
    plotInputName<-paste0("plotInput",plotName)
    plotOutputName<-paste0("plot",plotName)
    buttonDownloadName<-paste0("downloadPlot",plotName)
    pngName<-paste0(plotName,".png")
    assign(plotInputName,funPlot)
    output[[get('plotOutputName')]]<-renderPlot({ get(get('plotInputName'))() })
    output[[get('buttonDownloadName')]]<-downloadHandler(
      filename = function(){
        pngName
      },
      content = function(file){
        png(file,width=mwidth,height=mheight)
        get(get('plotInputName'))()
        dev.off()
      }
    )
  }
  
  #  ### plot smartphone (old procedure)
  #   plotInputSmart <- function(){
  #     col <- 15 # logical smartphone
  #     x    <- cuest[,col]
  #     par(mfrow=c(1,2))
  #     barplot(table(cuest[,15]),main="Smartphone")
  #     plot(cuest[,15]~cuest[,13],xlab="Edad",ylab="Smartphone")
  #   }
  #   output$plotSmart <- renderPlot({ plotInputSmart() })
  #   output$downloadPlotSmart <- downloadHandler(
  #     filename = function(){paste0("agri_smart",".png")},
  #     content = function(file){
  #       png(file,width=800,height=600)
  #       plotInputSmart()
  #       dev.off()
  #     }
  #   )  
  
  ### plot smartphone
  newPlot(plotName="Smart",funPlot=function(){
    barplot(table(cuest[,15]),main="Smartphone")
  })
  
  ### plot smartphone = f(Edad)
  newPlot(plotName="SmartEdad",funPlot=function(){
    plot(cuest[,15]~cuest[,13],xlab="Edad",ylab="Smartphone")
  })

  ### plot and download: Edad
  newPlot(plotName="Edad",funPlot=function(){
    col <- 13 # integer edad
    x    <- cuest[,col]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    mycolor <- rgb(input$myR_edad,input$myG_edad,input$myB_edad,maxColorValue = 255)
    hist(x, breaks = bins, col = mycolor, border = 'white',main=names(cuest)[col])
  })

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
  
})
