/*==================================================================================================
  Descripción del dofile
  
                                        "Introducción"
  
           .--.                  
          |o_o |         
          |:_/ |           ---------------------------------------------------
         //   \ \               Encuesta Demográfica y de Salud Familiar
        (|     | )         ---------------------------------------------------        
        /'\_   _/`\   
       \___)=(___/
    
  Contenido 
    1.- Atajos de teclado  
    2.- Limpieza del entorno de trabajo
    3.- Establecer el directorio de trabajo 
    4.- Exploración de variables 
    5.- Procesamiento del módulo hogar - rech23
    6.- Procesamiento del módulo individual - rec0111
    7.- Unión de archivos (hogar + individual)
    8.- Notas

                                      Jhon R. Ordoñez
                                 (rolyordonezleon@gmail.com)
                                                                                            ><(((º>
==================================================================================================*/



{ // 1.- Atajos de teclado
  * ctrl + s: guardar
  * ctrl + d: compilar el comando de stata
  * ctrl + click : seleccionar varias filas 
  * ...
}



{ // 2.- Limpieza del entorno de trabajo
  cls
  clear all
  set more off
  capture log close
}



{ // 3.- Establecer el directorio de trabajo

  { // 3.1.- Ruta de la carpeta raíz
    global root "..."
    cd "$root"
  }

  { // 3.2.- Directorios principales
    cap mkdir "1.lecture_notes"
    cap mkdir "2.lectures"
    cap mkdir "3.codes"
    cap mkdir "4.problem_sets"
    cap mkdir "5.raw_data"
    cap mkdir "6.docs"
    cap mkdir "7.processed_data"
    cap mkdir "8.results"
    cap mkdir "8.results/8.1.tables"
    cap mkdir "8.results/8.2.figures"
    cap mkdir "8.results/8.3.maps"
    cap mkdir "9.temp"
  }

  { // 3.3.- Definir rutas globales
    global codes   "${root}/3.codes"
    global raw     "${root}/5.raw_data"
    global clean   "${root}/7.processed_data"
    global tables  "${root}/8.results/8.1.tables"
    global figures "${root}/8.results/8.2.figures"
    global maps    "${root}/8.results/8.3.maps"
    global temps   "${root}/9.temps"
  }
}



{ // 4.- Exploración de variables 
  
  use "${raw}/2010_rech23.dta", clear // Caracteristicas de la Vivienda
  ...
  use "${raw}/2024_rech23.dta", clear // Caracteristicas de la Vivienda

  use "${raw}/2010_rec0111.dta", clear // Datos Basicos de MEF
  ...
  use "${raw}/2024_rec0111.dta", clear // Datos Basicos de MEF
} 



{ // 5.- Procesamiento del módulo hogar - rech23
  
  forvalues i = 2010/2024 {
    display _newline "===== Procesando módulo hogar año `i' ====="
    use "${raw}/`i'_rech23.dta", clear
    generate año = `i'
    drop if (hv271 == .)
    rename hv218 hvidx
    recode hv207 (1 = 1) (0 = 0), generate(radio)
    recode hv208 (1 = 1) (0 = 0), generate(televisor)
    recode hv209 (1 = 1) (0 = 0), generate(refri)
    recode hv211 (1 = 1) (0 = 0), generate(moto)
    recode hv212 (1 = 1) (0 = 0), generate(carro)
    generate bienes_durables = radio + televisor + refri + moto + carro
    generate bienes3 = (bienes_durables >= 3)
    recode hv201 (11/13 = 1) (21/71 96 = 0), generate(agua)
    recode hv205 (11/22 = 1) (23/96 = 0), generate(desague)
    recode hv206 (1 = 1) (2 = 0), generate(luz)
    generate acceso_servicios = agua == 1 & desague == 1 & luz == 1
    recode shregion (1/2 = 1 "Costa") (3 = 2 "Sierra") (4 = 3 "Selva"), generate(region_natural)
    keep año hhid hvidx acceso_servicios bienes_durables bienes3 region_natural
    order año hhid hvidx
    destring hhid, replace
    if `i' == 2010 {
      save "${clean}/hogar_2010_2024.dta", replace
    }
    else {
      append using "${clean}/hogar_2010_2024.dta", force 
      save "${clean}/hogar_2010_2024.dta", replace
    }
  }
  display _newline "===== MÓDULO HOGAR COMPLETADO ====="
}



{ // 6.- Procesamiento del módulo individual - rec0111
  
  forvalues i = 2010/2024 {
    display _newline "===== Procesando módulo individual año `i' ====="
    use "${raw}/`i'_rec0111.dta", clear
    generate año = `i'
    generate peso2 = v005/1000000
    recode v025 (1 = 1 "Urbano") (2 = 0 "Rural"), generate(area)
    keep if (v015 == 1)
    keep caseid año v101 v149 area peso2
    order año caseid
    if `i' == 2010 {
      save "${clean}/indiv_2010_2024.dta", replace
    }
    else {
      append using "${clean}/indiv_2010_2024.dta"
      save "${clean}/indiv_2010_2024.dta", replace
    }
  }
  display _newline "===== MÓDULO INDIVIDUAL COMPLETADO ====="
}



{ // 7.- Unión de archivos (hogar + individual) 
  
  display _newline "===== UNIENDO MÓDULO HOGAR + MÓDULO INDIVIDUAL ====="
  use "${clean}/indiv_2010_2024.dta", clear
  split caseid
  rename (caseid1 caseid2) (hhid hvidx)
  destring hhid hvidx, replace
  order año hhid hvidx
  merge 1:1 año hhid hvidx using "${clean}/hogar_2010_2024.dta", generate(merge_1)
  display "Resultado del merge:"
  tabulate merge_1
  save "${clean}/endes_unida_2010_2024.dta", replace
  display _newline "✓ BASE FINAL COMPLETADA"
  display "Ubicación: ${clean}/endes_unida_2010_2024.dta"
}



{ // 8.- Notas 
  
  * Nota 1.- Este Do-file forma parte del curso "Construcción e interpretación de indicadores ..." en ExpertiseMinds Perú impartido por la docente "Alexandra Otero" 
  * Nota 2.- Los créditos o autoría de la mayor parte de este Do-file le corresponden a la docente del curso, porque este código simplemente lo adapté a mi método de trabajo.
  * Nota 3.- Cualquier error en el presente código es totalmente mi responsabilidad, y si tienes sugerencias para seguir mejorando lo puedes enviar a "rolyordonezleon@gmail.com".
}


