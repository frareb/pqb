getTab_agri_medioAmb<-function(){
  tabPanel("Medio Amb.",
    h2("Altura de los campos de quinua"),
    dispNewPlotGeneric(plotName="Alti",isBreaks=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE)
  )
}