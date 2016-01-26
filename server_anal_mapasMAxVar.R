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

output$varSelect <- renderUI({
      varList =  unique(as.character(variedades))
      selectInput("varListSelect", "Variedad", varList)
})

newPlot( plotName="MapaMaxentVar",xheight=400, funPlot=function(){
      
      showMapVariety <- function(variety="Real_Blanca_Quinua_Real"){
            occ <- getCoords(data=cuest, variedad=variety)
            if(nrow(occ) >=10){
                  maxentRaster<-raster(paste0("data/mapas/maxentMaps/maxent_",variety,".asc"))
                  val <- getValues(maxentRaster)
                  xy <- as.data.frame(xyFromCell(maxentRaster,1:ncell(maxentRaster)))
                  xy <- cbind(xy,val)
                  # xy$val[xy$val==4.989345e-16] <- NA
                  plot(maxentRaster, col=rev(heat.colors(40)))
                  plot(borderBOL, add=TRUE, lwd=2)
                  points(x=occ$lon, y=occ$lat, pch=1, col='blue')
            }
      }
      showMapVariety(input$varListSelect)
      
})



