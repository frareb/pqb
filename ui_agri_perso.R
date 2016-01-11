getTab_agri_perso<-function(){
  tabPanel("Perso.",
    dispNewHist(plotName="Edad",isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",binsTitle="Numero de barras",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
    fluidRow(
      column(3,wellPanel("Opciones del grafico:",
                         sliderInput("myR_sexo","Color R:", min = 0, max = 255, value = 50),
                         sliderInput("myG_sexo","Color G:", min = 0, max = 255, value = 50),
                         sliderInput("myB_sexo","Color B:", min = 0, max = 255, value = 50))
      ),
      dispNewPlot("Sexo",colWidth=4),
      dispNewPlot("SexoEdad",colWidth=5)
    )
  )
}