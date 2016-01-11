getTab_sysP_variedades<-function(){
  tabPanel("Variedades",
           h2("Variedades"),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                                sliderInput("RVar","Color R:", min = 0, max = 255, value = 0),
                                sliderInput("GVar","Color G:", min = 0, max = 255, value = 150),
                                sliderInput("BVar","Color B:", min = 0, max = 255, value = 200))
             ),
             dispNewPlot("Var",colWidth=9)
           ),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                                sliderInput("RVar1","Color R:", min = 0, max = 255, value = 255),
                                sliderInput("GVar1","Color G:", min = 0, max = 255, value = 150),
                                sliderInput("BVar1","Color B:", min = 0, max = 255, value = 200))
             ),
             dispNewPlot("Var1",colWidth=9)
           ),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                                sliderInput("RVar2","Color R:", min = 0, max = 255, value = 0),
                                sliderInput("GVar2","Color G:", min = 0, max = 255, value = 150),
                                sliderInput("BVar2","Color B:", min = 0, max = 255, value = 200))
             ),
             dispNewPlot("Var2",colWidth=9)
           ),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                                sliderInput("RVar3","Color R:", min = 0, max = 255, value = 0),
                                sliderInput("GVar3","Color G:", min = 0, max = 255, value = 150),
                                sliderInput("BVar3","Color B:", min = 0, max = 255, value = 55))
             ),
             dispNewPlot("Var3",colWidth=9)
           )
  )
}