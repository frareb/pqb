getTab_agri_smart<-function(){
  tabPanel("Smartphone",
    dispNewPlotGeneric(plotName="Smart",isRGB=TRUE,isDownload=TRUE),
    dispNewPlotGeneric(plotName="SmartEdad",isDownload=TRUE)
  )
}