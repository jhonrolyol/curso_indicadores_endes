/*==================================================================================================
  Descripción del dofile
  
           "Porcentaje de mujeres que sufrieron violencia, ejercida alguna vez
                                 por el esposo o compañero"
  
           .--.                  
          |o_o |         
          |:_/ |              -------------------------------------------------
         //   \ \                 Creación de tablas, figuras, mapas, etc.
        (|     | )            -------------------------------------------------       
        /'\_   _/`\   
       \___)=(___/
 
  Contenido
    1.- Atajos de teclado
    2.- Limpieza del entorno de trabajo
    3.- Establecer el directorio de trabajo
    4.- Construcción de tablas
    5.- Construcción de figuras
    6.- Construcción de mapas
                                     
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
  { // 3.1.- Carpeta raíz
    global root "... Colocar la ruta raíz..."
    cd          "$root"
  }

  { // 3.2.- Uso y manejo de macros globales
    global admin   "$root/1.admin"
    global code    "$root/2.code"
    global raw     "$root/3.data_raw"
    global clean   "$root/4.data_clean"
    global docs    "$root/5.docs"
    global output  "$root/6.output"
    global temp    "$root/7.temp"
  }
}




{ // 4.- Construcción de tablas
  
  { // 4.1.- Tablas 2017
    
    use "${clean}/violencia_mujer_2017.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }
  
  { // 4.2.- Tablas 2018
    use "${clean}/violencia_mujer_2018.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }

  { // 4.3.- Tablas 2019
    use "${clean}/violencia_mujer_2019.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }

  { // 4.4.- Tablas 2020 (Hay una observación respecto al factor de expansión o ponderación "Revisar ok")
    use "${clean}/violencia_mujer_2020.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }

  { // 4.5.- Tablas 2021
    use "${clean}/violencia_mujer_2021.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }

  { // 4.6.- Tablas 2022
    use "${clean}/violencia_mujer_2022.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }

  { // 4.7.- Tablas 2023

    use "${clean}/violencia_mujer_2023.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }

  { // 4.8.- Tablas 2024
  
    use "${clean}/violencia_mujer_2024.dta", replace
    browse 

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional

    tabulate vf   [iweight = fp_mujer]
    tabulate vs   [iweight = fp_mujer]
    tabulate vpsi [iweight = fp_mujer]
    tabulate vt   [iweight = fp_mujer]
    
    bysort urbano: tabulate vf   [iweight = fp_mujer]
    bysort urbano: tabulate vs   [iweight = fp_mujer]
    bysort urbano: tabulate vpsi [iweight = fp_mujer]
    bysort urbano: tabulate vt   [iweight = fp_mujer]

    bysort gedad_mujer: tabulate vf   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vs   [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vpsi [iweight = fp_mujer]
    bysort gedad_mujer: tabulate vt   [iweight = fp_mujer]

    bysort dpto: tabulate vf   [iweight = fp_mujer]
    bysort dpto: tabulate vs   [iweight = fp_mujer]
    bysort dpto: tabulate vpsi [iweight = fp_mujer]
    bysort dpto: tabulate vt   [iweight = fp_mujer]
  }
}


{ // 5.- Construcción de figuras
}


{ // 6.- Construcción de mapas
}


