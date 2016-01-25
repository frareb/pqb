getTab_sysP_manejo<-function(){
  tabPanel("Manejo",
           h2("Si incorpora ..."),
           dispNewPlotGeneric(plotName="incorpora",isRGB=TRUE,isDownload=TRUE),
           h2("Si incorpora ... (variedad 1)"),
           dispNewPlotGeneric(plotName="incorporaV1",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("Si incorpora ... (variedad 2)"),
           dispNewPlotGeneric(plotName="incorporaV2",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("Si incorpora ... (variedad 3)"),
           dispNewPlotGeneric(plotName="incorporaV3",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE)#,
  )
}