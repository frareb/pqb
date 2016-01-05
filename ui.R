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
            dispNewHist(plotName="Edad",isBins=TRUE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",binsTitle="Numero de barras",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
            fluidRow(
              column(3,wellPanel("Opciones del grafico:",
                 sliderInput("myR_sexo","Color R:", min = 0, max = 255, value = 50),
                 sliderInput("myG_sexo","Color G:", min = 0, max = 255, value = 50),
                 sliderInput("myB_sexo","Color B:", min = 0, max = 255, value = 50))
              ),
              dispNewPlot("Sexo",colWidth=4),
              dispNewPlot("SexoEdad",colWidth=5)
            )
         ),
         tabPanel("Smartphone",
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
                sliderInput("RSmart","Color R:", min = 0, max = 255, value = 50),
                sliderInput("GSmart","Color G:", min = 0, max = 255, value = 50),
                sliderInput("BSmart","Color B:", min = 0, max = 255, value = 50))
             ),
             dispNewPlot("Smart",colWidth=4),
             dispNewPlot("SmartEdad",colWidth=5)
           )
            
         )
      )
    ),
    tabPanel("Sistema productivo",
      tabsetPanel(
        tabPanel("Afiliacion",
          h2("Afiliacion"),
          fluidRow(
            column(3,
                wellPanel(uiOutput("reacDepartamento"), uiOutput("reacMunicipio"))
             ),
            dispNewPlot("Afiliacion",colWidth=9)
          ),
            verbatimTextOutput("aso"),
            verbatimTextOutput("coo"),
            verbatimTextOutput("emp"),
            verbatimTextOutput("cam")
        ),
        tabPanel("Terreno",
           h2("Numero de parcelas"),
           fluidRow(
             column(3,wellPanel("Opciones del grafico:",
              sliderInput("RParcelas","Color R:", min = 0, max = 255, value = 255),
              sliderInput("GParcelas","Color G:", min = 0, max = 255, value = 255),
              sliderInput("BParcelas","Color B:", min = 0, max = 255, value = 255))
             ),
             dispNewPlot("Parcelas",colWidth=9)
           ),
           verbatimTextOutput(NULL),
           h2("Tamaño y propiedad del terreno"),
           fluidRow(
             column(3,wellPanel(uiOutput("dptTerreno"))),
             dispNewPlot("Terreno",colWidth=9,reverse=TRUE)
           )
        ),
        tabPanel("Produccion",
          h2("Produccion"),
           fluidRow(
             column(3,wellPanel(uiOutput("dptProd"))),
             dispNewPlot("Prod",colWidth=9)
           )
        ),
        tabPanel("Variedades",
         h2("Variedades"),
         fluidRow(
           column(3,wellPanel("Opciones del grafico:",
                              sliderInput("RVar","Color R:", min = 0, max = 255, value = 0),
                              sliderInput("GVar","Color G:", min = 0, max = 255, value = 150),
                              sliderInput("BVar","Color B:", min = 0, max = 255, value = 200))
           ),
           dispNewPlot("Var",colWidth=9)
         ),
         fluidRow(
           column(3,wellPanel("Opciones del grafico:",
              sliderInput("RVar1","Color R:", min = 0, max = 255, value = 255),
              sliderInput("GVar1","Color G:", min = 0, max = 255, value = 150),
              sliderInput("BVar1","Color B:", min = 0, max = 255, value = 200))
           ),
           dispNewPlot("Var1",colWidth=9)
         ),
         fluidRow(
           column(3,wellPanel("Opciones del grafico:",
                              sliderInput("RVar2","Color R:", min = 0, max = 255, value = 0),
                              sliderInput("GVar2","Color G:", min = 0, max = 255, value = 150),
                              sliderInput("BVar2","Color B:", min = 0, max = 255, value = 200))
           ),
           dispNewPlot("Var2",colWidth=9)
         ),
         fluidRow(
           column(3,wellPanel("Opciones del grafico:",
                              sliderInput("RVar3","Color R:", min = 0, max = 255, value = 0),
                              sliderInput("GVar3","Color G:", min = 0, max = 255, value = 150),
                              sliderInput("BVar3","Color B:", min = 0, max = 255, value = 55))
           ),
           dispNewPlot("Var3",colWidth=9)
         )
        ),
        tabPanel("Siembra",
          h2("Fecha de siembra"),
          dispNewHist(plotName="Fecha de siembra - Bolivia (2015)",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
          fluidRow(
            column(3,wellPanel("Opciones del grafico:",
               sliderInput("RFech","Color R:", min = 0, max = 255, value = 0),
               sliderInput("GFech","Color G:", min = 0, max = 255, value = 150),
               sliderInput("BFech","Color B:", min = 0, max = 255, value = 55))
            ),
            dispNewPlot("Fech",colWidth=9)
          ),
          dispNewHist(plotName="Fecha de siembra - La Paz",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
          dispNewHist(plotName="Fecha de siembra - Oruro",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc."),
          dispNewHist(plotName="Fecha de siembra - Potosi",isBins=FALSE,isRGB=TRUE,isDownload=TRUE,optColWidth=3,plotColWidth=9,mtitle="Opciones del grafico",rTitle="R:",gTitle="G:",bTitle="B:",downloadTitle="Desc.")
        )
      )
    ),
    tabPanel("Mapas")
  )
))
