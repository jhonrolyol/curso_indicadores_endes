#------------------------------------------------------------------------------#
# Descripción del script 
#
#                  Encuesta Demográfica y de Salud Familiar
#
#          .--.               
#         |o_o |                      
#         |:_/ |         ...............................................
#        //   \ \            Automatización de la descarga de datos
#       (|     | )       ...............................................         
#       /'\_   _/`\   
#      \___)=(___/
#
# Contenido
#  1.- Atajos de teclado
#  2.- Limpieza del entorno de trabajo
#  3.- Instalar paquetes
#  4.- Cargar librerias
#  5.- Estructura de la función "endesdata"
#  6.- Descarga de los archivos de datos (.dta o .sav)
#  7.- Notas 
#                                    
#                            Jhon R. Ordoñez
#                      (rolyordonezleon@gmail.com)
#
#                                                                      ><(((º>
#------------------------------------------------------------------------------#


# 1.- Atajos de teclado ---------------------------------------------------
  # Ctrl + shift + n  : New Script
  # ctrl + s          : Save
  # ctrl + shift + r  : New Section
  # ctrl + shift + p  : Show Command Palette
  # Alt  + shift + k  : Keyboard Shortcuts Help
  # ctrl + shift + m  : %>% 
  # Alt  + q          : @
  # Alt  + +          : ~
  # Alt + l           : Collapse Fold
  # Alt + shift + l   : Expand Fold
  # Alt + 0           : Collapse All Folds
  # Alt + shift + o   : Expand All Folds
  # Theme: base16 Atelier Forest (Darck)
  # ...
  
# 2.- Limpieza del entorno de trabajo -------------------------------------
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  remove(list = ls())
  getwd(); dir()
  
# 3.- Instalar paquetes ---------------------------------------------------
  if (!require("tidyverse"))    install.packages("tidyverse")
  if (!require("haven"))        install.packages("haven")
  if (!require("stringr"))      install.packages("stringr")
  if (!require("rio"))          install.packages("rio")
  if (!require("dplyr"))        install.packages("dplyr")
  if (!require("labelled"))     install.packages("labelled")
  if (!require("janitor"))      install.packages("janitor")
  
# 4.- Cargar librerias ----------------------------------------------------
  library(tidyverse)
  library(haven)
  library(stringr)
  library(rio)
  library(dplyr)
  library(labelled)
  library(janitor)

# 5.- Estructura de la función "endesdata" --------------------------------
  endesdata <- function(periodo, codigo_modulo, base, guardar = FALSE, ruta = "", codificacion = NULL) {
    options(timeout = max(3600, getOption("timeout")))
    versiones <- matrix(c(2024,968,2023,910,2022,786,2021,760,2020,739,2019,691,2018,638,2017,605,2016,548,
                          2015,504,2014,441,2013,407,2012,323,2011,290,2010,260,2009,238,2008,209,2007,194,
                          2006,183,2005,150,2004,120,2000,32,1996,32), byrow = TRUE, ncol = 2)
    cod <- versiones[versiones[,1] == periodo, 2]
    if (length(cod) == 0) stop("Periodo no válido.")
    url <- sprintf("https://proyectos.inei.gob.pe/iinei/srienaho/descarga/SPSS/%s-modulo%s.zip", cod, codigo_modulo)
    tmp <- tempfile(); td <- tempdir()
    tryCatch(download.file(url, tmp, mode = "wb", quiet = TRUE),error = function(e) stop("Error al descargar: ", url))
    arch <- unzip(tmp, list = TRUE)$Name
    arch_utf8 <- iconv(arch, from = "", to = "UTF-8", sub = "byte")
    file <- arch_utf8[str_detect(tolower(arch_utf8), paste0(tolower(base), "\\.sav$"))]
    if (length(file) == 0) stop("Base no encontrada en el ZIP.")
    if (guardar) {
      dir.create(file.path(ruta), showWarnings = FALSE, recursive = TRUE)
      unzip(tmp, files = file, exdir = ruta)
      message("Archivo guardado en: ", normalizePath(ruta))
      return(invisible(NULL))}
    data <- read_sav(unzip(tmp, files = file[1], exdir = td), encoding = codificacion)
    colnames(data) <- toupper(colnames(data))
    data
  }
  
# 6.- Descarga de los archivos de datos (.dta o .sav)  --------------------
  
  # 6.1.- Módulo: Caracteristicas de la Vivienda
    write_dta(clean_names(endesdata(2010, 65, "RECH23")), "2010_rech23.dta") 
    write_dta(clean_names(endesdata(2011, 65, "RECH23")), "2011_rech23.dta")
    write_dta(clean_names(endesdata(2012, 65, "RECH23")), "2012_rech23.dta")
    write_dta(clean_names(endesdata(2013, 65, "RECH23")), "2013_rech23.dta")
    write_dta(clean_names(endesdata(2014, 65, "RECH23")), "2014_rech23.dta")
    write_dta(clean_names(endesdata(2015, 65, "RECH23")), "2015_rech23.dta")
    write_dta(clean_names(endesdata(2016, 65, "RECH23")), "2016_rech23.dta")
    write_dta(clean_names(endesdata(2017, 65, "RECH23")), "2017_rech23.dta")
    write_dta(clean_names(endesdata(2018, 65, "RECH23")), "2018_rech23.dta")
    write_dta(clean_names(endesdata(2019, 65, "RECH23")), "2019_rech23.dta")
    write_dta(clean_names(endesdata(2020, 1630, "RECH23")), "2020_rech23.dta")
    write_dta(clean_names(endesdata(2021, 1630, "RECH23")), "2021_rech23.dta")
    write_dta(clean_names(endesdata(2022, 1630, "RECH23")), "2022_rech23.dta")
    write_dta(clean_names(endesdata(2023, 1630, "RECH23_2023")), "2023_rech23.dta")
    write_dta(clean_names(endesdata(2024, 1630, "RECH23_2024")), "2024_rech23.dta")
  
  # 6.2.- Módulo: Datos Basicos de Mujer en Edad Fertil (Datos básicos de MEF)
    write_dta(clean_names(endesdata(2010, 66, "REC0111")), "2010_rec0111.dta") 
    write_dta(clean_names(endesdata(2011, 66, "REC0111")), "2011_rec0111.dta")
    write_dta(clean_names(endesdata(2012, 66, "REC0111")), "2012_rec0111.dta")
    write_dta(clean_names(endesdata(2013, 66, "REC0111")), "2013_rec0111.dta")
    write_dta(clean_names(endesdata(2014, 66, "REC0111")), "2014_rec0111.dta")
    write_dta(clean_names(endesdata(2015, 66, "REC0111")), "2015_rec0111.dta")
    write_dta(clean_names(endesdata(2016, 66, "REC0111")), "2016_rec0111.dta")
    write_dta(clean_names(endesdata(2017, 66, "REC0111")), "2017_rec0111.dta")
    write_dta(clean_names(endesdata(2018, 66, "REC0111")), "2018_rec0111.dta")
    write_dta(clean_names(endesdata(2019, 66, "REC0111")), "2019_rec0111.dta")
    write_dta(clean_names(endesdata(2020, 1631, "REC0111")), "2020_rec0111.dta")
    write_dta(clean_names(endesdata(2021, 1631, "REC0111")), "2021_rec0111.dta")
    write_dta(clean_names(endesdata(2022, 1631, "REC0111")), "2022_rec0111.dta")
    write_dta(clean_names(endesdata(2023, 1631, "REC0111_2023")), "2023_rec0111.dta")
    write_dta(clean_names(endesdata(2024, 1631, "REC0111_2024")), "2024_rec0111.dta")
  

# 7.- Notas ---------------------------------------------------------------
  # Nota 1.- Esta versión simple es muy práctico y ayuda mucho cuando se trabaja con un pool de datos.
  # Nota 2.- La versión completa de la automatización aún está en prueba.
  # Nota 3.- Se deja a la imaginación del curios@ para explorar otras opciones de descarga más efectivas.
  
  
  