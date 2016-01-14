getTab_sysP_produccion<-function(){
  tabPanel("Produccion",
           h2("Produccion"),
           dispNewPlotGeneric(plotName="Prod",isBreaks=FALSE,isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE)#,
#            fluidRow(
#              column(3,wellPanel(uiOutput("dptProd"))),
#              dispNewPlot("Prod",colWidth=9)
#            )
  )
}