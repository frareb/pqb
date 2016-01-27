library(shiny)

source("server_plot_fun.R", local=TRUE)

source("ui_init.R", local=TRUE)              # home page
source("ui_agri_perso.R", local=TRUE)        # data about people (age, gender)
source("ui_agri_smart.R", local=TRUE)        # data about smartphone (yes/no, f(age))
source("ui_agri_medioAmb.R", local=TRUE)     # data about enviro. (altura, temp, prec)
source("ui_sysP_afiliacion.R", local=TRUE)   # data about afiliation
source("ui_sysP_terreno.R", local=TRUE)      # data about prprety and land use
source("ui_sysP_produccion.R", local=TRUE)   # data about sys. of prod.
source("ui_sysP_variedades.R", local=TRUE)   # data about varieties
source("ui_sysP_semillas.R", local=TRUE)     # data about seeds provenance
source("ui_sysP_siembra.R", local=TRUE)      # data about sowing
source("ui_sysP_manejo.R", local=TRUE)       # data about intrants
source("ui_anal_mapasInit.R", local=TRUE)    # simple map with points
source("ui_anal_mapasNumVar.R", local=TRUE)  # maps of num. of var.
source("ui_anal_mapasMAxVar.R", local=TRUE)  # maps of all varieties
source("ui_anal_mapasNumVarXY.R", local=TRUE)  # maps of varieties regarding XY location

shinyUI(fluidPage(
  # includeCSS("www/style.css"),
  titlePanel("Base de datos de agricultores"),
  tabsetPanel(getTabInit(),
    tabPanel("Agricultores",tabsetPanel(
      getTab_agri_perso(),
      getTab_agri_smart(),
      getTab_agri_medioAmb()
    )),
    tabPanel("Sistema productivo",tabsetPanel(
      getTab_sysP_afiliacion(),
      getTab_sysP_terreno(),
      getTab_sysP_produccion(),
      getTab_sysP_variedades(),
      getTab_sysP_semillas(),
      getTab_sysP_siembra(),
      getTab_sysP_manejo()
    )),
    tabPanel("Analisis",tabsetPanel(
      getTab_anal_mapasInit(),
      getTab_anal_mapasNumVar(),
      getTab_anal_mapasMAxVar(),
      getTab_anal_mapasNumVarXY()
    ))
  )
))
