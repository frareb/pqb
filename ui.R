library(shiny)

source("ui_fun.R")


# Define UI for application that draws a barplot
shinyUI(fluidPage(
  # includeCSS("www/style.css"),
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
    tabPanel("Sistema productivo",
       sidebarLayout(
         sidebarPanel(
           radioButtons(
             "variables", "Variables", list("Afiliacion"="afiliacion","N° parcelas"="parcelas" )
           ),
           uiOutput("reacDepartamento"),
           conditionalPanel(
             condition = "input.variables == 'afiliacion'",
             uiOutput("reacMunicipio")
           )
         ),
         
         mainPanel(
           plotOutput("barPlotAfiliacion")
         )
       )
    ),
    tabPanel("Variedades")
  )
))
