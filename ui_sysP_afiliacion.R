getTab_sysP_afiliacion<-function(){
  tabPanel("Afiliacion",
           h2("Afiliacion"),
           dispNewPlotGeneric(plotName="Afiliacion",isBreaks=FALSE,isRGB=TRUE,isDownload=TRUE,isCond1=TRUE,isCond2=TRUE)#,
#            verbatimTextOutput("aso"),
#            verbatimTextOutput("coo"),
#            verbatimTextOutput("emp"),
#            verbatimTextOutput("cam")
  )
}