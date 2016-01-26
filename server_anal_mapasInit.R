library(shiny)
library(raster)
library(ggmap)

load("data/mapas/borderBOL.rda")
border <- fortify(borderBOL)
load("data/mapas/gmap.rda")



newPlot( plotName="MapaPuntos",xheight=400, funPlot=function(){
      lat <- cuest$seccion_a._georeferenciacion_latitude
      lon <- cuest$seccion_a._georeferenciacion_longitude
      coords <- na.omit(data.frame(lon = lon, lat = lat))
      myMap <- ggmap(mapaValles, legend="right") +
            geom_map(data = border, map = border, aes(x = long, y = lat, map_id=id), color = "black", fill=NA, size = 0.9) + 
            geom_point(data = coords, aes(x = lon, y = lat), size = 3, fill="red",color="white",alpha = 0.75, shape=21) + labs(x = "Longitude", y = "Latitude") +
            coord_map() +
            theme_classic()
      plot(myMap)
})
  


