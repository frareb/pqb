library(raster)

getCoords<-function(data=cuest, variedad="Real_Blanca_Quinua_Real")
{
      presenceVar<-subset(cuest, (cuest$seccion_a.variedades.1..variedad == variedad) |
                                (cuest$seccion_a.variedades.2..variedad == variedad) |
                                (cuest$seccion_a.variedades.3..variedad == variedad) |
                                (cuest$seccion_a.variedades.4..variedad == variedad) |
                                (cuest$seccion_a.variedades.5..variedad == variedad) |
                                (cuest$seccion_a.variedades.6..variedad == variedad)
      )
      presData <- data.frame(lon = presenceVar$seccion_a._georeferenciacion_longitude, 
                             lat = presenceVar$seccion_a._georeferenciacion_latitude)
      return(presData)
}

variedades <- unique(na.omit(c(cuest$seccion_a.variedades.1..variedad,cuest$seccion_a.variedades.2..variedad, cuest$seccion_a.variedades.3..variedad,	cuest$seccion_a.variedades.4..variedad,	cuest$seccion_a.variedades.5..variedad,	cuest$seccion_a.variedades.6..variedad)))

variedadList <- vector()
variedadList <- sapply(1:length(variedades), function(i){
      if(nrow(getCoords(data=cuest, variedad=variedades[i])) >= 10){
            variedadList <- c(variedadList,variedades[i])
      }
})
variedades<-unlist(variedadList)
names(variedades) <- variedades


showMapVarietyXY <- function(x, y){
      listVarietyXY <- vector()
      
      listVarietyXY<-sapply(1:length(variedades), function(i){
            occ <- getCoords(data=cuest, variedad=variedades[i])
            if(nrow(occ) >=10){
                  maxentRaster<-raster(paste0("data/mapas/maxentMaps/maxent_",variedades[i],".asc"))
                  val <- getValues(maxentRaster)
                  val[val<0.5] <- 0
                  val[val>=0.5] <- 1
                  values(maxentRaster) <- val
                  valXY <- extract(maxentRaster, y=cbind(x, y))
                  if(valXY ==1)
                  {
                        listVarietyXY[i] <- paste0(variedades[i],"\n")
                        return(listVarietyXY[i])
                  }
            } 
            
      })
      return(listVarietyXY)
      
}

output$MapaVarXY <- renderText({
      listQuinoaXY<-unlist(showMapVarietyXY(x=input$xvar, y=input$yvar))
      listQuinoaXY
})

maxentRasterAllVar<-raster("data/mapas/maxentMaps/maxent_ALLVARIETIES.asc")
load("data/mapas/borderBOL.rda")

newPlot( plotName="MapaAllVar",xheight=400, funPlot=function(){
      
      plot(maxentRasterAllVar, col=rainbow(10))
      plot(borderBOL, add=TRUE, lwd=1)
      points(input$xvar,input$yvar,pch=21, col="black", bg="white", cex=1.8, lwd=2)
})









