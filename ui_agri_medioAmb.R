getTab_agri_medioAmb<-function(){
  tabPanel("Medio Amb.",
    dispNewPlotGeneric(plotName="Alti",isBreaks=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE)
  )
}