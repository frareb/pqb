#' Make an histogram in shiny-ui.
#' 
#' \code{dispNewHist} allows to display an histogram in shiny within a \code{fluidPage} with some basic options on the right panel.
dispNewHist<-function(plotName,isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="",binsTitle="Number of bars",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Download"){
  return(fluidRow(
    column(optColWidth,wellPanel(mtitle,
      if(isBins==TRUE){sliderInput(paste0(plotName,"bins"), binsTitle, min = 1, max = 50, value = 30)},
      if(isRGB==TRUE){sliderInput(paste0("R",plotName),rTitle, min = 0, max = 255, value = 50)},
      if(isRGB==TRUE){sliderInput(paste0("G",plotName),gTitle, min = 0, max = 255, value = 50)},
      if(isRGB==TRUE){sliderInput(paste0("B",plotName),bTitle, min = 0, max = 255, value = 50)}
    )
    ),
    column(plotColWidth,plotOutput(paste0("plot",plotName)),
    if(isDownload==TRUE){
       # downloadButton(paste0("downloadPlot",plotName),downloadTitle)
      fluidRow(
        column(4,numericInput(inputId=paste0("width",plotName),label=NULL,value=800)),
        column(4,numericInput(inputId=paste0("height",plotName),label=NULL,value=600)),
        column(4,downloadButton(paste0("downloadPlot",plotName),"Desc."))
      )
    })
  ))
}

#' Make a plot in shiny-ui.
#' 
#' \code{dispNewPlot} allows to display an histogram in shiny within a \code{fluidRow}.
dispNewPlot<-function(plotName,colWidth=6){
  return(
    column(colWidth,plotOutput(paste0("plot",plotName)),
     fluidRow(
       column(4,numericInput(inputId=paste0("width",plotName),label=NULL,value=800)),
       column(4,numericInput(inputId=paste0("height",plotName),label=NULL,value=600)),
       column(4,downloadButton(paste0("downloadPlot",plotName),"Desc."))
     ))
  )
}