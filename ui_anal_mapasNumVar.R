getTab_anal_mapasNumVar<-function(){
      tabPanel("Mapas num. variedades",  
               h2("Mapa Num var"), uiOutput("varRadio"),
               dispNewPlot(plotName="MapaMaxentNum", colWidth=6)
      )
}