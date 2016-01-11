newPlotHist<-function(plotName,dataset,isBreaks=TRUE,isRGB=TRUE,isXYlab=TRUE,isMain=TRUE,isDensity=TRUE,isDownload=TRUE,...){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  if(isBreaks==TRUE){
    wgbreaksName<-paste0("breaks",plotName)
  }
  if(isRGB==TRUE){
    wgRName<-paste0("R",plotName)
    wgGName<-paste0("G",plotName)
    wgBName<-paste0("B",plotName)
  }
  if(isXYlab==TRUE){
    wgxlabName<-paste0("xlab",plotName)
    wgylabName<-paste0("ylab",plotName)
  }
  if(isMain==TRUE){
    wgMainName<-paste0("main",plotName)
  }
  if(isDensity==TRUE){
    wgDensName<-paste0("dens",plotName)
  }
  if(isDownload==TRUE){
    wgDownPNGName<-paste0("downloadPlotPNG",plotName)
    wgDownPDFName<-paste0("downloadPlotPDF",plotName)
    pngName<-paste0(plotName,".png")
    pdfName<-paste0(plotName,".pdf")
    wgWidthName<-paste0("width",plotName)
    wgHeightName<-paste0("height",plotName)
  }
  
  assign(plotInputName,function(){
    
    if(isBreaks==TRUE){
      if(is.numeric(dataset)){
        bins <- seq(min(dataset,na.rm=TRUE), max(dataset,na.rm=TRUE),length.out = input[[wgbreaksName]] + 1)
      }else{bins<-"Sturges"}
    }else{bins<-"Sturges"}
    
    if(isRGB==TRUE){
      mycolor <- rgb(input[[wgRName]],input[[wgGName]],input[[wgBName]],maxColorValue = 255)
    } else {mycolor <- rgb(1,1,1)}
    
    if(isXYlab==TRUE){
      myxlab<-input[[wgxlabName]]
      myylab<-input[[wgylabName]]
    }else{
      myxlab<-""
      myylab<-"Frequency"
    }
    
    if(isMain==TRUE){
      mymain<-input[[wgMainName]]
    }else{
      mymain<-plotName
    }

    if(isDensity==TRUE){
      if(is.numeric(dataset)){
        dens <- density(dataset)
      }else{
        if(is(dataset,"Date")){
          dens <- density(as.numeric(dataset))
        }
      }
    }
    
    hist(dataset,breaks=bins,freq=FALSE,col=mycolor,xlab=myxlab,ylab=myylab,main=mymain,...)
    if(isDensity==TRUE){if(input[[wgDensName]]==TRUE){points(dens,type='l',lwd=2)}}
  })
  output[[plotOutputName]]<-renderPlot({ get(plotInputName)() })
  if(isDownload==TRUE){
    output[[wgDownPNGName]]<-downloadHandler(
      filename = function(){pngName},
      content = function(file){
        png(file,width=as.integer(input[[wgWidthName]]),height=as.integer(input[[wgHeightName]]))
        get(plotInputName)()
        dev.off()
      }
    )
    output[[wgDownPDFName]]<-downloadHandler(
      filename = function(){pdfName},
      content = function(file){
        pdf(file,width=as.integer(input[[wgWidthName]])*7/800,height=as.integer(input[[wgHeightName]])*7/800)
        get(plotInputName)()
        dev.off()
      }
    )
    
  }
}


# if(isBreaks==TRUE){sliderInput(paste0("breaks",plotName), binsTitle, min = 1, max = 50, value = 30)},
dispNewPlotHist<-function(plotName,isBreaks=TRUE,isRGB=TRUE,isXYlab=TRUE,isMain=TRUE,isDensity=TRUE,isDownload=TRUE,rTitle="R:",gTitle="G:",bTitle="B:"){
  return(fluidRow(
    column(3,wellPanel(
      if(isRGB==TRUE){sliderInput(paste0("R",plotName),rTitle, min = 0, max = 255, value = 0)},
      if(isRGB==TRUE){sliderInput(paste0("G",plotName),gTitle, min = 0, max = 255, value = 150)},
      if(isRGB==TRUE){sliderInput(paste0("B",plotName),bTitle, min = 0, max = 255, value = 55)},
      if(isBreaks==TRUE){sliderInput(paste0("breaks",plotName),"bins", min = 1, max = 50, value = 30)}
      )
    ),
    column(
      6,plotOutput(paste0("plot",plotName)),
      if(isDownload==TRUE){fluidRow(
        column(3,numericInput(inputId=paste0("width",plotName),label=NULL,value=800)),
        column(3,numericInput(inputId=paste0("height",plotName),label=NULL,value=600)),
        column(3,downloadButton(paste0("downloadPlotPNG",plotName),"PNG")),
        column(3,downloadButton(paste0("downloadPlotPDF",plotName),"PDF"))
      )}
    ),
    column(3,wellPanel(
      if(isXYlab==TRUE){textInput(paste0("xlab",plotName),"xlab",value=plotName)},
      if(isXYlab==TRUE){textInput(paste0("ylab",plotName),"ylab",value="Frequency")},
      if(isMain==TRUE){textInput(paste0("main",plotName),"main",value=plotName)},
      if(isDensity==TRUE){checkboxInput(paste0("dens",plotName),"density",value=TRUE)}
      )
    )
  ))
}