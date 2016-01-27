getTab_anal_mapasNumVarXY<-function(){
      tabPanel("Variedades XY",  
               h2("Variedades ubicacion"), 
               numericInput("xvar", "Longitud", -67.56, min = -70, max = -60, step = 0.01) ,
               numericInput("yvar", "Latitud", -18.99, min = -20, max = -10, step = 0.01) ,
               verbatimTextOutput("MapaVarXY"),
               dispNewPlot(plotName="MapaAllVar", colWidth=6)
               
      )
}