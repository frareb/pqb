getTab_sysP_terreno<-function(){
  tabPanel("Terreno",
           h2("Numero de parcelas"),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                                sliderInput("RParcelas","Color R:", min = 0, max = 255, value = 255),
                                sliderInput("GParcelas","Color G:", min = 0, max = 255, value = 255),
                                sliderInput("BParcelas","Color B:", min = 0, max = 255, value = 255))
             ),
             dispNewPlot("Parcelas",colWidth=9)
           ),
           verbatimTextOutput(NULL),
           h2("Tamaño y propiedad del terreno"),
           fluidRow(
             column(3,wellPanel(uiOutput("dptTerreno"))),
             dispNewPlot("Terreno",colWidth=9,reverse=TRUE)
           )
  )
}