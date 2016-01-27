library(shiny)

archivo<-"data/cuestionarioquinuarjj-2016-01-04-18-03-29.csv"
tipoDatos<-c("factor","factor","Date","factor","factor","factor","factor","factor",
             "factor","character","character","factor","integer","character","factor",
             "logical","logical","logical","logical","logical","factor","factor",
             "factor","factor","character","numeric","numeric","numeric","numeric", #col 29
             "factor","numeric","logical","logical","numeric","numeric","numeric", #col 36
             "logical","logical",
             rep("character",265-38))
cuest<-read.table(archivo,sep=',',header=TRUE,na="n/a",colClasses=tipoDatos,encoding="UTF-8")

shinyServer(function(input, output, session) {
  
  source("server_plot_fun.R", local=TRUE) # new functions
  
  source("server_agri_perso.R", local=TRUE)        # data about people (age, gender)
  source("server_agri_smart.R", local=TRUE)        # data about smartphone (yes/no, f(age))
  source("server_agri_medioAmb.R", local=TRUE)     # data about enviro. (altura, temp, prec)
  source("server_sysP_afiliacion.R", local=TRUE)   # data about afiliation
  source("server_sysP_terreno.R", local=TRUE)      # data about prprety and land use
  source("server_sysP_produccion.R", local=TRUE)   # data about sys. of prod.
  source("server_sysP_variedades.R", local=TRUE)   # data about varieties
  source("server_sysP_semillas.R", local=TRUE)     # data about seeds provenance
  source("server_sysP_siembra.R", local=TRUE)      # data about sowing
  source("server_sysP_manejo.R", local=TRUE)       # data about intrants
  source("server_anal_mapasInit.R", local=TRUE)    # simple map with points
  source("server_anal_mapasNumVar.R", local=TRUE)  # maps of num. of var.
source("server_anal_mapasMAxVar.R", local=TRUE)  # maps of all varieties
source("server_anal_mapasNumVarXY.R", local=TRUE)  # maps of varieties regarding XY location
      
})
