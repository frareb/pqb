library(raster)
library(ggmap)

load("data/mapas/borderBOL.rda")

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

output$varRadio <- renderUI({
      checkboxGroupInput("varListRadio", "Variedades:",
                   variedades, selected="Real_Blanca_Quinua_Real")
})

newPlot( plotName="MapaMaxentNum",xheight=400, funPlot=function(){
      showMapVariety <- function(variety="Real_Blanca_Quinua_Real"){
          
                  listStackRaster <- list()
                  listStackRaster<-sapply(1:length(variety), function(i){
                        occ <- getCoords(data=cuest, variedad=variety[i])
                        if(nrow(occ) >=10){
                              maxentRaster<-raster(paste0("data/mapas/maxentMaps/maxent_",variety[i],".asc"))
                              val <- getValues(maxentRaster)
                              val[val<0.5] <- 0
                              val[val>=0.5] <- 1
                              values(maxentRaster) <- val
                              listStackRaster[i] <- maxentRaster
                              return(listStackRaster[i])
#                               plot(maxentRaster, col=rev(heat.colors(40)))
#                               plot(borderBOL, add=TRUE, lwd=2)
#                               points(x=occ$lon, y=occ$lat, pch=1, col='blue')
                        } 
                        
                  })
                   r3 <- Reduce("+",listStackRaster)
                  val <- getValues(r3)
                  val[val<length(listStackRaster)] <- 0
                  val[val>=length(listStackRaster)] <- 1
                  values(r3) <- val
                  
                  plot(r3, col=rev(heat.colors(40)))
                  plot(borderBOL, add=TRUE, lwd=2)
#                   points(x=occ$lon, y=occ$lat, pch=1, col='blue')
            
      }
      showMapVariety(input$varListRadio)
      
})



