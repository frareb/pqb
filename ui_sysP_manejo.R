getTab_sysP_manejo<-function(){
  tabPanel("Manejo",
           h2("Si incorpora ... var 1"),
           dispNewPlotGeneric(plotName="incorporaV1",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE)#,
  )
}