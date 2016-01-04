library(shiny)

#' Make an histogram in shiny-ui.
#' 
#' \code{dispNewHist} allows to display an histogram in shiny within a \code{fluidPage} with some basic options on the right panel.
dispNewHist<-function(plotName,isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="",binsTitle="Number of bars",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Download"){
  return(fluidRow(
    column(optColWidth,wellPanel(mtitle,
      if(isBins==TRUE){sliderInput(paste0(plotName,"bins"), binsTitle, min = 1, max = 50, value = 30)},
      if(isRGB==TRUE){sliderInput(paste0("R",plotName),rTitle, min = 0, max = 255, value = 50)},
      if(isRGB==TRUE){sliderInput(paste0("G",plotName),gTitle, min = 0, max = 255, value = 50)},
      if(isRGB==TRUE){sliderInput(paste0("B",plotName),bTitle, min = 0, max = 255, value = 50)}
    )
    ),
    if(isDownload==TRUE){column(plotColWidth,plotOutput(paste0("plot",plotName)),downloadButton(paste0("downloadPlot",plotName),downloadTitle))}
  ))
}


# Define UI for application that draws a barplot
shinyUI(fluidPage(
  titlePanel("Base de datos de agricultores"),
  tabsetPanel(
    tabPanel("Agricultores",
      tabsetPanel(
         tabPanel("Perso.",
            dispNewHist(plotName="Edad",isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",binsTitle="Numero de barras",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Descargar PNG"),
            fluidRow(
              column(3,wellPanel("Opciones del grafico:",
                 sliderInput("myR_sexo","Color R:", min = 0, max = 255, value = 50),
                 sliderInput("myG_sexo","Color G:", min = 0, max = 255, value = 50),
                 sliderInput("myB_sexo","Color B:", min = 0, max = 255, value = 50))
              ),
              column(4,plotOutput("plotSexo"),downloadButton('downloadPlotSexo','Descargar')),
              column(5,plotOutput("plotSexoEdad"),downloadButton('downloadPlotSexoEdad','Descargar'))
            )
         ),
         tabPanel("Smartphone",
           fluidRow(
             column(6,plotOutput("plotSmart"),downloadButton('downloadPlotSmart','Descargar')),
             column(6,plotOutput("plotSmartEdad"),downloadButton('downloadPlotSmartEdad','Descargar'))
           )
         )
      )
    ),
    tabPanel("Sistema productivo"),
    tabPanel("Variedades")
  )
))
