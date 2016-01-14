getTab_sysP_terreno<-function(){
  tabPanel("Terreno",
           h2("Numero de parcelas"),
           dispNewPlotGeneric(plotName="Parcelas",isRGB=TRUE,isDownload=TRUE),
           h2("Tamaño y propiedad del terreno"),
           fluidRow(
             column(3,wellPanel(uiOutput("dptTerreno"))),
             dispNewPlot("Terreno",colWidth=9,reverse=TRUE)
           )
  )
}