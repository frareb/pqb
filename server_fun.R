#' Make a simple plot in shiny-server.
#' 
#' \code{newPlot} allows to build a plot in shiny with a download button for PNG export.
#' @param plotName The name of the plot.
#' @param funPlot A function which contain the code to build the plot, see examples.
#' @param mwidth The width of the plot to be downloaded in pixels.
#' @param mheight The height of the plot to be downloaded in pixels.
#' @return NULL.
#' @examples
#' \dontrun{
#' newPlot(plotName="myNewPlot",funPlotfunction(){plot(1)},mwidth=800,mheight=600)
#' }
#' @details \code{newPlot} computes a plot input name starting with "plotInput"
#'   with the name of the plot as a suffix, a plot output name starting with 
#'   "plot" with the name of the plot as a suffix, a download button name 
#'   starting with "downloadPlot" with the name of the plot as a suffix, and
#'   a PNG file name with the same name as the \code{plotName}. These names
#'   can later be used in the ui file to organize the layout.
#'   The example above will create a simple plot \code{plot(1)} with 
#'   plotInputmyNewPlot as plot input name,
#'   plotmyNewPlot as plot output name,
#'   downloadPlotmyNewPlot as download button name, and
#'   myNewPlot.png as plot export name.
#'   The counterpart in ui file could look like the following:
#'   \code{column(4,plotOutput("plotmyNewPlot"),downloadButton('downloadPlotmyNewPlot','PNG'))}.
newPlot<-function(plotName,funPlot,mwidth=800,mheight=600){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  buttonDownloadName<-paste0("downloadPlot",plotName)
  pngName<-paste0(plotName,".png")
  assign(plotInputName,funPlot)
  output[[get('plotOutputName')]]<-renderPlot({ get(get('plotInputName'))() })
  output[[get('buttonDownloadName')]]<-downloadHandler(
    filename = function(){
      pngName
    },
    content = function(file){
      png(file,width=mwidth,height=mheight)
      get(get('plotInputName'))()
      dev.off()
    }
  )
}

#' Make an histogram in shiny-server.
#' 
#' \code{newHist} allows to build an histogram in shiny.
#' @param plotName The name of the plot.
#' @param dataset The dataset for the histogram.
#' @param isBins A logical to specify if number of breaks is user-defined.
#' @param isRGB A logical to specify if colors are user-defined.
#' @param isDensity A logical to specify if density should be drawn.
#' @param isDownload A logical to specify if export to PNG option should be available.
#' @param mwidth The width of the plot to be downloaded in pixels.
#' @param mheight The height of the plot to be downloaded in pixels.
#' @return NULL.
#' @examples
#' \dontrun{
#' newHist(plotName="myNewPlot",dataset=rnorm(100,mean=0,sd=1),isBins=FALSE,isRGB=FALSE,isDensity=TRUE,isDownload=FALSE,mwidth=800,mheight=600)
#' }
newHist<-function(plotName,dataset,isBins=TRUE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE,mwidth=800,mheight=600){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  if(isDownload==TRUE){
    buttonDownloadName<-paste0("downloadPlot",plotName)
    pngName<-paste0(plotName,".png")
  }
  assign(plotInputName,function(){
    if(isBins==TRUE){
      bins <- seq(as.integer(min(dataset,na.rm=TRUE)), as.integer(max(dataset,na.rm=TRUE)),length.out = input[[paste0(plotName,"bins")]] + 1)
    }else{bins<-"Sturges"}
    if(isRGB==TRUE){
      mycolor <- rgb(input[[paste0("R",plotName)]],input[[paste0("G",plotName)]],input[[paste0("B",plotName)]],maxColorValue = 255)
    } else {mycolor <- 0}
    hist(dataset,breaks=bins,freq=FALSE,col=mycolor,main=plotName)
    if(isDensity==TRUE){points(density(dataset),type='l',lwd=2)}
  })
  output[[get('plotOutputName')]]<-renderPlot({ get(get('plotInputName'))() })
  if(isDownload==TRUE){
    output[[get('buttonDownloadName')]]<-downloadHandler(
      filename = function(){pngName},
      content = function(file){
        png(file,width=mwidth,height=mheight)
        get(get('plotInputName'))()
        dev.off()
      }
    )
  }
}
