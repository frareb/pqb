getTab_sysP_semillas<-function(){
  tabPanel("Semillas",
           h2("De donde vienen las semillas VARIEDAD 1"),
           dispNewPlotGeneric(plotName="SemillasV1",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("De donde vienen las semillas VARIEDAD 2"),
           dispNewPlotGeneric(plotName="SemillasV2",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("De donde vienen las semillas VARIEDAD 3"),
           dispNewPlotGeneric(plotName="SemillasV3",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("De donde vienen las semillas VARIEDAD 4"),
           dispNewPlotGeneric(plotName="SemillasV4",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("De donde vienen las semillas VARIEDAD 5"),
           dispNewPlotGeneric(plotName="SemillasV5",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE),
           h2("De donde vienen las semillas VARIEDAD 6"),
           dispNewPlotGeneric(plotName="SemillasV6",isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE)#,
  )
}