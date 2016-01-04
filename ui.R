library(shiny)

source("ui_fun.R")


# Define UI for application that draws a barplot
shinyUI(fluidPage(
  # includeCSS("www/style.css"),
  titlePanel("Base de datos de agricultores"),
  tabsetPanel(
    tabPanel("Inicio",
      titlePanel("Title"),
      sidebarLayout(
        sidebarPanel(p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque 
                       malesuada orci quis ultricies cursus. Fusce finibus aliquam odio fermen
                       tum luctus. Suspendisse scelerisque pulvinar sem non molestie. Maecenas
                       tincidunt enim erat. Sed a dolor tempus, ornare ex tempus, ullamcorper 
                       diam.",align="justify"),img(src="belarus-farmer-300px.png")),
        mainPanel(
          p("Aliquam ut ante at tortor posuere iaculis. Proin placerat vitae lorem at finibus.
            Nam rhoncus sagittis lorem eu pulvinar. Morbi sed risus faucibus, cursus nisi sed,
            tristique libero. Donec semper interdum risus, ut aliquet tellus efficitur non. Ae
            nean eget orci ornare magna ultricies rhoncus. Aenean ac mauris vel orci luctus ul
            tricies sit amet eget risus. Duis sit amet turpis id mauris tincidunt efficitur ne
            c non lorem. Etiam eu feugiat nibh. Cras ullamcorper nec nunc posuere consectetur.
            Quisque eu massa ac nibh egestas feugiat eu sed metus.",align="justify"),
          p("Phasellus dictum tellus quis eleifend dictum. Phasellus in nisl a nunc ornare eui
            smod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames a
            c turpis egestas. Praesent nec feugiat leo. Quisque dictum eget nisi vitae pharetr
            a. Proin vitae dignissim tellus. Class aptent taciti sociosqu ad litora torquent p
            er conubia nostra, per inceptos himenaeos. Vivamus vehicula nulla id consectetur o
            rnare. Pellentesque nulla dui, lacinia a sollicitudin id, tempor vitae orci. Donec
            at lacus eu purus tristique pretium. Class aptent taciti sociosqu ad litora torque
            nt per conubia nostra, per inceptos himenaeos. Proin consequat efficitur neque, ac
            cumsan varius lectus pulvinar eu. Praesent lacinia metus ut nisi porta fermentum."
            ,align="justify"),
          p("Donec lobortis dictum eros at dignissim. Nunc tincidunt ornare mi, eget sodales l
            ectus. Aenean vel euismod est, vitae pellentesque justo. Ut varius sed odio at pel
            lentesque. Integer rhoncus nibh ac tempor pulvinar. Integer eget interdum sapien. 
            Maecenas porta purus congue eros maximus euismod. Nulla eleifend, dolor in loborti
            s pretium, ligula enim tempor ipsum, quis mattis enim nisi et odio. In consequat a
            nte sit amet urna tempor fermentum. Nullam posuere dictum sem in fringilla. Praese
            nt enim magna, tempor quis est et, faucibus imperdiet diam. Vestibulum at tellus e
            st. Pellentesque sem quam, facilisis a tincidunt sit amet, dictum sed urna. Nam ar
            cu turpis, mattis eu blandit eu, aliquet eu neque. Nunc efficitur vitae massa in u
            ltrices.",align="justify"),
          p("Phasellus imperdiet sagittis cursus. Nam dapibus pellentesque elit. Praesent at p
            retium tortor. Cras fermentum justo eget pellentesque vulputate. Ut rutrum auctor 
            arcu, eget imperdiet purus varius ac. In hac habitasse platea dictumst. Proin elem
            entum fringilla dui. Ut vel scelerisque dui. Nunc hendrerit diam dui, vel pulvinar
            enim varius in.")
          )
      )
    ),
    tabPanel("Agricultores",
      tabsetPanel(
         tabPanel("Perso.",
            dispNewHist(plotName="Edad",isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",binsTitle="Numero de barras",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Descargar PNG"),
            fluidRow(
              column(3,wellPanel("Opciones del grafico:",
                 sliderInput("myR_sexo","Color R:", min = 0, max = 255, value = 50),
                 sliderInput("myG_sexo","Color G:", min = 0, max = 255, value = 50),
                 sliderInput("myB_sexo","Color B:", min = 0, max = 255, value = 50))
              ),
              dispNewPlot("Sexo",colWidth=4),
              # column(4,plotOutput("plotSexo"),downloadButton('downloadPlotSexo','Descargar')),
              dispNewPlot("SexoEdad",colWidth=5)
              # column(5,plotOutput("plotSexoEdad"),downloadButton('downloadPlotSexoEdad','Descargar'))
            )
         ),
         tabPanel("Smartphone",
           fluidRow(
             dispNewPlot("Smart",colWidth=6),
             dispNewPlot("SmartEdad",colWidth=6)
             # column(6,plotOutput("plotSmartEdad"),downloadButton('downloadPlotSmartEdad','Descargar'))
           )
            
         )
      )
    ),
    tabPanel("Sistema productivo",
      fluidRow(
        column(3,
           radioButtons("variables", "Variables", list("Afiliacion"="afiliacion","N° parcelas"="parcelas")),
           uiOutput("reacDepartamento"),
           conditionalPanel(condition = "input.variables == 'afiliacion'",uiOutput("reacMunicipio"))
         ),
        column(9,plotOutput("barPlotAfiliacion"))
      )
    ),
    tabPanel("Variedades")
  )
))
