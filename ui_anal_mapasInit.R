getTab_anal_mapasInit<-function(){
  tabPanel("Mapa puntos",  
           h2("Mapa de agricultores"),
           dispNewPlot(plotName="MapaPuntos", colWidth=12))
}