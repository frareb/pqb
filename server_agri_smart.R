### plot: smartphone (15)
newPlot(plotName="Smart",funPlot=function(){
  mycolor <- rgb(input$RSmart,input$GSmart,input$BSmart,maxColorValue = 255)
  barplot(table(cuest[,15]),main="Smartphone", col = mycolor)
})

### plot smartphone ~ Edad (15;13)
newPlot(plotName="SmartEdad",funPlot=function(){
  plot(cuest[,15]~cuest[,13],xlab="Edad",ylab="Smartphone")
})