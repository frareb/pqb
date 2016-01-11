getTab_sysP_siembra<-function(){
  tabPanel("Siembra",
           h2("Fecha de siembra"),
           dispNewHist(plotName="Fecha de siembra - Bolivia (2015)",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                                sliderInput("RFech","Color R:", min = 0, max = 255, value = 0),
                                sliderInput("GFech","Color G:", min = 0, max = 255, value = 150),
                                sliderInput("BFech","Color B:", min = 0, max = 255, value = 55))
             ),
             dispNewPlot("Fech",colWidth=9)
           ),
           dispNewHist(plotName="Fecha de siembra - La Paz",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
           dispNewHist(plotName="Fecha de siembra - Oruro",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
           dispNewHist(plotName="Fecha de siembra - Potosi",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc.")
  )
}