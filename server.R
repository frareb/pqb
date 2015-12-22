library(shiny)
library(plotrix)

# setwd("/home/irdfr/Bureau/R_cap7_3/App-1")

archivo<-"data/cuestionarioquinuarjj-2015-12-01-11-58-53.csv"
tipoDatos<-c("factor","factor","Date","factor","factor","factor","factor","factor",
             "factor","character","character","factor","integer","character","factor",
             "logical","logical","logical","logical","logical","factor","factor",
             "factor","factor","character","numeric","numeric","numeric","numeric",
             rep("character",265-29))
cuest<-read.table(archivo,sep=',',header=TRUE,na="n/a",colClasses=tipoDatos,encoding="UTF-8")

# AGRI: edad(13) ; sexo(12) ; smartphone (15)
#barplot(table(cuest[,15]),main="Smartphone")
#plot(cuest[,15]~cuest[,13],xlab="Edad",ylab="Smartphone") # tiene samrtphone = f(edad)


shinyServer(function(input, output) {
  ### plot and download: Edad
  plotInputEdad <- function(){
    col <- 13 # edad
    x    <- cuest[,col]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    mycolor <- rgb(input$myR_edad,input$myG_edad,input$myB_edad,maxColorValue = 255)
    hist(x, breaks = bins, col = mycolor, border = 'white',main=names(cuest)[col])
  }
  output$plotEdad <- renderPlot({ plotInputEdad() })
  output$downloadPlotEdad <- downloadHandler(
    filename = function(){paste0("agri_edad",".png")},
    content = function(file){
      png(file,width=800,height=600)
      plotInputEdad()
      dev.off()
    }
  )
  ### plot and download: Sexo
  plotInputSexo<-function(){
    col <- 12 # sexo
    x    <- cuest[,col]
    mycolor <- rgb(input$myR_sexo,input$myG_sexo,input$myB_sexo,maxColorValue = 255)
    barplot(table(x), col = mycolor, border = 'white',main=names(cuest)[col])
  }
  output$plotSexo <- renderPlot({ plotInputSexo() })
  output$downloadPlotSexo <- downloadHandler(
    filename = function(){paste0("agri_sexo",".png")},
    content = function(file){
      png(file,width=800,height=600)
      plotInputSexo()
      dev.off()
    }
  )
})
