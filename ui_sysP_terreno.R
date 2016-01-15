getTab_sysP_terreno<-function(){
  tabPanel("Terreno",
           h2("Numero de parcelas"),
           dispNewPlotGeneric(plotName="Parcelas",isRGB=TRUE,isDownload=TRUE),
           h2("Propiedad del terreno"),
           dispNewPlotGeneric(plotName="Terreno",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("Hectares de parcelas"),
           dispNewPlotGeneric(plotName="SizeF",isRGB=TRUE,isDownload=TRUE)#,
  )
}