getTab_agri_smart<-function(){
  tabPanel("Smartphone",
     fluidRow(
       column(3,wellPanel("Opciones del grafico:",
            sliderInput("RSmart","Color R:", min = 0, max = 255, value = 50),
            sliderInput("GSmart","Color G:", min = 0, max = 255, value = 50),
            sliderInput("BSmart","Color B:", min = 0, max = 255, value = 50))
       ),
       dispNewPlot("Smart",colWidth=4),
       dispNewPlot("SmartEdad",colWidth=5)
     )
           
  )
}