library(shiny)

# Define UI for application that draws a barplot
shinyUI(fluidPage(
  titlePanel("Base de datos de agricultores"),
  tabsetPanel(
    tabPanel("Agricultores",
             tabsetPanel(
               tabPanel("Perso.",
                        fluidRow(
                          column(3,wellPanel("Opciones del grafico:",
                             sliderInput("bins", "Numero de barras:", min = 1, max = 50, value = 30),
                             sliderInput("myR_edad","Color R:", min = 0, max = 255, value = 50),
                             sliderInput("myG_edad","Color G:", min = 0, max = 255, value = 50),
                             sliderInput("myB_edad","Color B:", min = 0, max = 255, value = 50)
                          )       
                          ),
                          
                          column(9,plotOutput("plotEdad"),downloadButton('downloadPlotEdad','Descargar')
                          )
                        ),
                        fluidRow(
                          column(3,wellPanel("Opciones del grafico:",
                             sliderInput("myR_sexo","Color R:", min = 0, max = 255, value = 50),
                             sliderInput("myG_sexo","Color G:", min = 0, max = 255, value = 50),
                             sliderInput("myB_sexo","Color B:", min = 0, max = 255, value = 50)
                          )       
                          ),
                          column(4,plotOutput("plotSexo"),downloadButton('downloadPlotSexo','Descargar')
                          ),
                          column(5,plotOutput("plotSexoEdad"),downloadButton('downloadPlotSexoEdad','Descargar')
                          )
                        ),
                        fluidRow(
                          column(12,plotOutput("plotSmart"),downloadButton('downloadPlotSmart','Descargar')
                        )
               ),
               tabPanel("Loc.")
             )
    ),
    tabPanel("Sistema productivo"),
    tabPanel("Variedades")
  )
))
