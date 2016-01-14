getTab_agri_perso<-function(){
  tabPanel("Perso.",
    h2("Edad de los entrevistados"),
    dispNewPlotGeneric(plotName="Edad",isBreaks=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE),
    h2("Sexo de los entrevistados"),
    dispNewPlotGeneric(plotName="Sexo",isRGB=TRUE,isDownload=TRUE),
    h2("Sexo y edad de los entrevistados"),
    dispNewPlotGeneric(plotName="SexoEdad",isRGB=TRUE,isDownload=TRUE)
  )
}