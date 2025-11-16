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
    4.- ...

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
















