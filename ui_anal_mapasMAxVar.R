getTab_anal_mapasMAxVar<-function(){
  tabPanel("Mapas distri. variedades",  
           h2("Mapa Quinoa"), uiOutput("varSelect"),
           dispNewPlot(plotName="MapaMaxentVar", colWidth=6)
          )
}