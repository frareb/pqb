getTab_sysP_afiliacion<-function(){
  tabPanel("Afiliacion",
           h2("Afiliacion"),
           fluidRow(
             column(3,
                    wellPanel(uiOutput("reacDepartamento"), uiOutput("reacMunicipio"))
             ),
             dispNewPlot("Afiliacion",colWidth=9)
           ),
           verbatimTextOutput("aso"),
           verbatimTextOutput("coo"),
           verbatimTextOutput("emp"),
           verbatimTextOutput("cam")
  )
}