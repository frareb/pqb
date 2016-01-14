getTab_agri_smart<-function(){
  tabPanel("Smartphone",
    h2("Tiene smartphone?"),
    dispNewPlotGeneric(plotName="Smart",isRGB=TRUE,isDownload=TRUE),
    h2("Smartphone segun la edad de los entrevistados"),
    dispNewPlotGeneric(plotName="SmartEdad",isRGB=TRUE,isDownload=TRUE),
    h2("Smartphone segun el sexo de los entrevistados"),
    dispNewPlotGeneric(plotName="SmartSexo",isRGB=TRUE,isDownload=TRUE)
  )
}