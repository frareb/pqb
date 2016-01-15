newPlotGeneric_bak<-function(type,plotName,dataset,isBreaks=FALSE,isRGB=FALSE,isDensity=FALSE,isDownload=FALSE,addMarBellow=4,addLegend=FALSE,...){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  if(isBreaks==TRUE){
    wgbreaksName<-paste0("breaks",plotName)
  }
  if(isRGB==TRUE){
    # wgRName<-paste0("R",plotName)
    # wgGName<-paste0("G",plotName)
    # wgBName<-paste0("B",plotName)
    wgColName<-paste0("col",plotName)
  }
#   if(isXYlab==TRUE){
#     wgxlabName<-paste0("xlab",plotName)
#     wgylabName<-paste0("ylab",plotName)
#   }
#   if(isMain==TRUE){
#     wgMainName<-paste0("main",plotName)
#   }
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
      # mycolor <- rgb(input[[wgRName]],input[[wgGName]],input[[wgBName]],maxColorValue = 255)
      mycolor <- input[[wgColName]]
    } else {mycolor <- rgb(1,1,1)}
    
#     if(isXYlab==TRUE){
#       myxlab<-input[[wgxlabName]]
#       myylab<-input[[wgylabName]]
#     }else{
#       myxlab<-""
#       myylab<-"Frequency"
#     }
    
#     if(isMain==TRUE){
#       mymain<-input[[wgMainName]]
#     }else{
#       mymain<-plotName
#     }
    
    if(isDensity==TRUE){
      if(is.numeric(dataset)){
        dens <- density(dataset)
      }else{
        if(is(dataset,"Date")){
          dens <- density(as.numeric(dataset))
        }
      }
    }
    
    if(type=="hist"){
      hist(dataset,breaks=bins,freq=FALSE,col=mycolor,...)
      if(isDensity==TRUE){if(input[[wgDensName]]==TRUE){points(dens,type='l',lwd=2)}}
    } else {
      if(type=="barplot"){
        if(class(dataset)=="matrix" && nrow(dataset)>1){
          rgbcol<-col2rgb(mycolor)
          if(nrow(dataset)==2){
            mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
            par(mar=c(addMarBellow,4,4,4))
            barplot(dataset,col=c(mycolor,mycolor2),...)
          } else {
            if(nrow(dataset)==3){
              mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
              mycolor3<-rgb(rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
              mycolors<-c(mycolor,mycolor2,mycolor3)
              par(mar=c(addMarBellow,4,4,4))
              barplot(dataset,col=mycolors,...)
              if(addLegend==TRUE){legend("topright",legend=rownames(dataset),fill=mycolors)}
            } else {
              if(nrow(dataset)==4){
                mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
                mycolor3<-rgb(rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
                mycolor4<-rgb(rgbcol[1],rgbcol[2],255-rgbcol[3],maxColorValue=255)
                mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4)
                par(mar=c(addMarBellow,4,4,4))
                barplot(dataset,col=mycolors,...)
                if(addLegend==TRUE){legend("topright",legend=rownames(dataset),fill=mycolors)}
              } else {
                if(nrow(dataset)==5){
                  mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
                  mycolor3<-rgb(rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
                  mycolor4<-rgb(rgbcol[1],rgbcol[2],255-rgbcol[3],maxColorValue=255)
                  mycolor5<-rgb(255-rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
                  mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5)
                  par(mar=c(addMarBellow,4,4,4))
                  barplot(dataset,col=mycolors,...)
                  if(addLegend==TRUE){legend("topright",legend=rownames(dataset),fill=mycolors)}
                } else {
                  if(nrow(dataset)==6){
                    mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
                    mycolor3<-rgb(rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
                    mycolor4<-rgb(rgbcol[1],rgbcol[2],255-rgbcol[3],maxColorValue=255)
                    mycolor5<-rgb(255-rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
                    mycolor6<-rgb(255-rgbcol[1],rgbcol[2],255-rgbcol[3],maxColorValue=255)
                    mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5,mycolor6)
                    par(mar=c(addMarBellow,4,4,4))
                    barplot(dataset,col=mycolors,...)
                    if(addLegend==TRUE){legend("topright",legend=rownames(dataset),fill=mycolors)}
                  } else {
                    par(mar=c(addMarBellow,4,4,4))
                    barplot(dataset,...)
                  }
                }
              }
            }
          }
        } else {
          mycolors<-mycolor
          par(mar=c(addMarBellow,4,4,4))
          barplot(dataset,col=mycolors,...)
        }
      } else {
        if(type=="scatterplot"){
          if(is.factor(dataset[[2]])){
            rgbcol<-col2rgb(mycolor)
            mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
            plot(dataset[[1]]~dataset[[2]],col=c(mycolor,mycolor2),...)
          } else {
            plot(dataset[[1]]~dataset[[2]],col=mycolor,...)
          }
        } else {
          if(type=="boxplot"){
            boxplot(dataset,col=mycolor,...)
          } else {
            
          }
        }
      }
    }
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

newPlotGeneric<-function(type,plotName,dataset,
                         isBreaks=FALSE,isRGB=FALSE,isDensity=FALSE,isDownload=FALSE,
                         addMarBellow=4,addLegend=FALSE,
                         cond1=NULL,cond2=NULL,cond1Label="",cond2Label="",
                         ...){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  if(isBreaks==TRUE){
    wgbreaksName<-paste0("breaks",plotName)
  }
  if(isRGB==TRUE){
    # wgRName<-paste0("R",plotName)
    # wgGName<-paste0("G",plotName)
    # wgBName<-paste0("B",plotName)
    wgColName<-paste0("col",plotName)
  }
  #   if(isXYlab==TRUE){
  #     wgxlabName<-paste0("xlab",plotName)
  #     wgylabName<-paste0("ylab",plotName)
  #   }
  #   if(isMain==TRUE){
  #     wgMainName<-paste0("main",plotName)
  #   }
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
  if(!is.null(cond1)){
    wgCond1OutName<-paste0("cond1",plotName)
    output[[paste0("cond1",plotName)]]<-renderUI({selectInput(wgCond1OutName, cond1Label, c("ALL",unique(as.character(cond1))))})
  }
  if(!is.null(cond2)){
    wgCond2OutName<-paste0("cond2",plotName)
    output[[paste0("cond2",plotName)]]<-renderUI({
      if(length(input[[wgCond1OutName]]>0)){
        selectInput(wgCond2OutName, cond2Label, c("ALL",unique(as.character(cond2[cond1==input[[wgCond1OutName]]]))))
      }
    })
  }
  
  assign(plotInputName,function(){
    
    if(!is.null(cond1)){
      datasetAlt<-NULL
      if(length(input[[wgCond1OutName]])>0 && input[[wgCond1OutName]]=="ALL"){datasetAlt <- dataset} else {
        if(length(input[[wgCond1OutName]])>0 && input[[wgCond1OutName]]!="ALL"){
          if(is.null(cond2)){#!
            datasetAlt <- dataset[cond1 == input[[wgCond1OutName]],]
          } else {
            if(input[[wgCond2OutName]]!="ALL"){
              datasetAlt <- dataset[cond2 == input[[wgCond2OutName]],]
            } else {
              datasetAlt <- dataset[cond1 == input[[wgCond1OutName]],]
            }
          }
        }
      }
      if(!is.null(datasetAlt)){
        # dataset<-apply(datasetAlt,MARGIN=2,FUN=sum,na.rm=TRUE)
        if(any(datasetAlt=="True") || any(datasetAlt=="False")){
          xx<-sapply(1:ncol(datasetAlt),function(x){
            datasetAlt[,x][datasetAlt[,x]=="True"]<-TRUE
            return(datasetAlt[,x])
            })
          xx<-sapply(1:ncol(xx),function(x){
            xx[,x][xx[,x]=="False"]<-FALSE
            return(xx[,x])
          })
          colnames(xx)<-names(datasetAlt)
          datasetAlt<-xx
        }
        
        if(class(datasetAlt)!="data.frame"){datasetAlt<-data.frame(datasetAlt)}
        
        xx<-lapply(datasetAlt,FUN=table,useNA="always")
        xxx<-sapply(xx,function(x){
          if(!is.na(x['TRUE'])){
            TRUEs<-x['TRUE']/sum(x,na.rm=TRUE)
          }else{TRUEs<-0}
#           if(!is.na(x['FALSE'])){
#             FALSEs<-x['FALSE']/sum(x,na.rm=TRUE)
#           }else{FALSEs<-0}
#           return(rbind(TRUEs,FALSEs))
          return(TRUEs)
        })
        names(xxx)<-names(xx)
        # rownames(xxx)<-c("TRUE","FALSE")
        # names(xxx)<-"TRUE"
        dataset<-xxx
        
        
        if(any(grepl("\\.",names(dataset))==TRUE)){
          names(dataset)<-sapply(strsplit(names(dataset),split="\\."),"[[",length(strsplit(names(dataset),split="\\.")[[1]]))
        }
      }else{dataset<-0}
    }
    
    if(isBreaks==TRUE){
      if(is.numeric(dataset)){
        bins <- seq(min(dataset,na.rm=TRUE), max(dataset,na.rm=TRUE),length.out = input[[wgbreaksName]] + 1)
      }else{bins<-"Sturges"}
    }else{bins<-"Sturges"}
    
    if(isRGB==TRUE){
      # mycolor <- rgb(input[[wgRName]],input[[wgGName]],input[[wgBName]],maxColorValue = 255)
      mycolor <- input[[wgColName]]
    } else {mycolor <- rgb(1,1,1)}
    
    #     if(isXYlab==TRUE){
    #       myxlab<-input[[wgxlabName]]
    #       myylab<-input[[wgylabName]]
    #     }else{
    #       myxlab<-""
    #       myylab<-"Frequency"
    #     }
    
    #     if(isMain==TRUE){
    #       mymain<-input[[wgMainName]]
    #     }else{
    #       mymain<-plotName
    #     }
    
    if(isDensity==TRUE){
      if(is.numeric(dataset)){
        dens <- density(dataset)
      }else{
        if(is(dataset,"Date")){
          dens <- density(as.numeric(dataset))
        }
      }
    }
    
    if(type=="hist"){
      hist(dataset,breaks=bins,freq=FALSE,col=mycolor,...)
      if(isDensity==TRUE){if(input[[wgDensName]]==TRUE){points(dens,type='l',lwd=2)}}
    } else {
      if(type=="barplot"){
        if(class(dataset)=="matrix" && nrow(dataset)>1){
          rgbcol<-col2rgb(mycolor)
          mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
          mycolor3<-rgb(rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
          mycolor4<-rgb(rgbcol[1],rgbcol[2],255-rgbcol[3],maxColorValue=255)
          mycolor5<-rgb(255-rgbcol[1],255-rgbcol[2],rgbcol[3],maxColorValue=255)
          mycolor6<-rgb(255-rgbcol[1],rgbcol[2],255-rgbcol[3],maxColorValue=255)
          mycolor7<-rgb(rgbcol[1],255-rgbcol[2],255-rgbcol[3],maxColorValue=255)
          mycolor8<-rgb(255-rgbcol[1],255-rgbcol[2],255-rgbcol[3],maxColorValue=255)
          if(nrow(dataset)==2){
            mycolors<-c(mycolor,mycolor2)
          } else {
            if(nrow(dataset)==3){
              mycolors<-c(mycolor,mycolor2,mycolor3)
            } else {
              if(nrow(dataset)==4){
                mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4)
              } else {
                if(nrow(dataset)==5){
                  mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5)
                } else {
                  if(nrow(dataset)==6){
                    mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5,mycolor6)
                  } else {
                    if(nrow(dataset)==7){
                      mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5,mycolor6,mycolor7)
                    } else {
                      if(nrow(dataset)==8){
                        mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5,mycolor6,mycolor7,mycolor8)
                      } else {
                        print("Warnings: more than 8 colors, colors could be used twice")
                        mycolors<-c(mycolor,mycolor2,mycolor3,mycolor4,mycolor5,mycolor6,mycolor7,mycolor8)
                      }
                    }
                  }
                }
              }
            }
          }
          par(mar=c(addMarBellow,4,4,4))
          barplot(dataset,col=mycolors,...)
          if(addLegend==TRUE){legend("topright",legend=rownames(dataset),fill=mycolors)}
        } else {
          mycolors<-mycolor
          par(mar=c(addMarBellow,4,4,4))
          barplot(dataset,col=mycolors,...)
        }
      } else {
        if(type=="scatterplot"){
          if(is.factor(dataset[[2]])){
            rgbcol<-col2rgb(mycolor)
            mycolor2<-rgb(255-rgbcol[1],rgbcol[2],rgbcol[3],maxColorValue=255)
            plot(dataset[[1]]~dataset[[2]],col=c(mycolor,mycolor2),...)
          } else {
            plot(dataset[[1]]~dataset[[2]],col=mycolor,...)
          }
        } else {
          if(type=="boxplot"){
            boxplot(dataset,col=mycolor,...)
          } else {
            
          }
        }
      }
    }
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







newPlotHist<-function(...){
  newPlotGeneric(type="hist",...)
}

newPlotBarplot<-function(...){
  newPlotGeneric(type="barplot",...)
}

newPlotScatterplot<-function(...){
  newPlotGeneric(type="scatterplot",...)
}

newPlotBoxplot<-function(...){
  newPlotGeneric(type="boxplot",...)
}

dispNewPlotGeneric<-function(plotName,isBreaks=FALSE,isRGB=FALSE,isDensity=FALSE,isDownload=FALSE,isCond1=FALSE,isCond2=FALSE){
  return(fluidRow(
    column(3,wellPanel(
      # if(isRGB==TRUE){sliderInput(paste0("R",plotName),"R", min = 0, max = 255, value = 0)},
      # if(isRGB==TRUE){sliderInput(paste0("G",plotName),"G", min = 0, max = 255, value = 150)},
      # if(isRGB==TRUE){sliderInput(paste0("B",plotName),"B", min = 0, max = 255, value = 55)},
      if(isRGB==TRUE){selectInput(paste0("col",plotName),"Color:",choices=colors(),selected="lightblue")},
      if(isBreaks==TRUE){sliderInput(paste0("breaks",plotName),"bins", min = 1, max = 50, value = 30)},
      if(isDensity==TRUE){checkboxInput(paste0("dens",plotName),"density",value=TRUE)},
      if(isCond1==TRUE){uiOutput(paste0("cond1",plotName))},
      if(isCond2==TRUE){uiOutput(paste0("cond2",plotName))}#,
      # if(isXYlab==TRUE){textInput(paste0("xlab",plotName),"xlab",value=plotName)},
      # if(isXYlab==TRUE){textInput(paste0("ylab",plotName),"ylab",value="Frequency")},
      # if(isMain==TRUE){textInput(paste0("main",plotName),"main",value=plotName)}
      )
    ),
    column(
      9,plotOutput(paste0("plot",plotName)),
      if(isDownload==TRUE){fluidRow(
        column(3,numericInput(inputId=paste0("width",plotName),label=NULL,value=800)),
        column(3,numericInput(inputId=paste0("height",plotName),label=NULL,value=600)),
        column(3,downloadButton(paste0("downloadPlotPNG",plotName),"PNG")),
        column(3,downloadButton(paste0("downloadPlotPDF",plotName),"PDF"))
      )}
    )
  ))
}

# newPlotGenericCond1<-function(type,plotName,dataset,cond1)
# newPlotGenericCond2<-function(type,plotName,dataset,cond1,cond2)


#' Make a simple plot in shiny-server.
#' 
#' \code{newPlot} allows to build a plot in shiny with a download button for PNG export.
#' @param plotName The name of the plot.
#' @param funPlot A function which contain the code to build the plot, see examples.
#' @param xheight Height of the plot in pixels.
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
# newPlot<-function(plotName,funPlot){
#   plotInputName<-paste0("plotInput",plotName)
#   plotOutputName<-paste0("plot",plotName)
#   buttonDownloadName<-paste0("downloadPlot",plotName)
#   pngName<-paste0(plotName,".png")
#   assign(plotInputName,funPlot)
#   output[[get('plotOutputName')]]<-renderPlot({ get(get('plotInputName'))() })
#   output[[get('buttonDownloadName')]]<-downloadHandler(
#     filename = function(){
#       pngName
#     },
#     content = function(file){
#       png(file,width=mwidth,height=mheight)
#       get(get('plotInputName'))()
#       dev.off()
#     }
#   )
# }
newPlot<-function(plotName,funPlot,xheight=400){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  buttonDownloadName<-paste0("downloadPlot",plotName)
  pngName<-paste0(plotName,".png")
  iwidth<-paste0("width",plotName)
  iheight<-paste0("height",plotName)
  assign(plotInputName,funPlot)
  output[[get('plotOutputName')]]<-renderPlot({ get(get('plotInputName'))() }, height=xheight)
  output[[get('buttonDownloadName')]]<-downloadHandler(
    filename = function(){
      pngName
    },
    content = function(file){
      png(file,width=as.integer(input[[get('iwidth')]]),height=as.integer(input[[get('iheight')]]) )
      get(get('plotInputName'))()
      dev.off()
    }
  )
}

#' Make a plot in shiny-ui.
#' 
#' \code{dispNewPlot} allows to display an histogram in shiny within a \code{fluidRow}
#'   followed by two numerical inputs for width and height and a download button.
dispNewPlot<-function(plotName,colWidth=6,reverse=FALSE){
  return(
    if(reverse==FALSE){
      column(colWidth,plotOutput(paste0("plot",plotName)),
             fluidRow(
               column(4,numericInput(inputId=paste0("width",plotName),label=NULL,value=800)),
               column(4,numericInput(inputId=paste0("height",plotName),label=NULL,value=600)),
               column(4,downloadButton(paste0("downloadPlot",plotName),"Desc."))
             ))
    } else {
      column(colWidth,
             fluidRow(
               column(4,numericInput(inputId=paste0("width",plotName),label=NULL,value=800)),
               column(4,numericInput(inputId=paste0("height",plotName),label=NULL,value=600)),
               column(4,downloadButton(paste0("downloadPlot",plotName),"Desc."))
             ),
             plotOutput(paste0("plot",plotName))
      )
    }
  )
}

### OLD FUNCTIONS

#' Make an histogram in shiny-server.
#' 
#' \code{newHist} allows to build an histogram in shiny.
#' @param plotName The name of the plot.
#' @param dataset The dataset for the histogram.
#' @param isBins A logical to specify if number of breaks is user-defined.
#' @param isRGB A logical to specify if colors are user-defined.
#' @param isDensity A logical to specify if density should be drawn.
#' @param isDownload A logical to specify if export to PNG option should be available.
#' @return NULL.
#' @examples
#' \dontrun{
#' newHist(plotName="myNewPlot",dataset=rnorm(100,mean=0,sd=1),isBins=FALSE,isRGB=FALSE,isDensity=TRUE,isDownload=FALSE,mwidth=800,mheight=600)
#' }
newHist<-function(plotName,dataset,isBins=TRUE,isDate=FALSE,isRGB=TRUE,isDensity=TRUE,isDownload=TRUE){
  plotInputName<-paste0("plotInput",plotName)
  plotOutputName<-paste0("plot",plotName)
  if(isDownload==TRUE){
    buttonDownloadName<-paste0("downloadPlot",plotName)
    pngName<-paste0(plotName,".png")
    iwidth<-paste0("width",plotName)
    iheight<-paste0("height",plotName)
  }
  assign(plotInputName,function(){
    if(isBins==TRUE){
      if(isDate==TRUE){
        bins <- "weeks"
      }else{
        bins <- seq(as.integer(min(dataset,na.rm=TRUE)), as.integer(max(dataset,na.rm=TRUE)),length.out = input[[paste0(plotName,"bins")]] + 1)
      }
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
        png(file,width=as.integer(input[[get('iwidth')]]),height=as.integer(input[[get('iheight')]]))
        get(get('plotInputName'))()
        dev.off()
      }
    )
  }
}


#' Make an histogram in shiny-ui.
#' 
#' \code{dispNewHist} allows to display an histogram in shiny within a \code{fluidPage} 
#'   with some basic options on the right panel.
dispNewHist<-function(plotName,isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="",binsTitle="Number of bars",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Download"){
  return(fluidRow(
    column(optColWidth,wellPanel(mtitle,
                                 if(isBins==TRUE){sliderInput(paste0(plotName,"bins"), binsTitle, min = 1, max = 50, value = 30)},
                                 if(isRGB==TRUE){sliderInput(paste0("R",plotName),rTitle, min = 0, max = 255, value = 0)},
                                 if(isRGB==TRUE){sliderInput(paste0("G",plotName),gTitle, min = 0, max = 255, value = 150)},
                                 if(isRGB==TRUE){sliderInput(paste0("B",plotName),bTitle, min = 0, max = 255, value = 55)}
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

