/*==================================================================================================
  Descripción del dofile
  
           "Porcentaje de mujeres que sufrieron violencia, ejercida alguna vez
                                 por el esposo o compañero"

           .--.                  
          |o_o |         
          |:_/ |            ------------------------------------------------
         //   \ \                Organización del directorio de trabajo
        (|     | )          ------------------------------------------------       
        /'\_   _/`\   
       \___)=(___/
 
  Contenido
    1.- Atajos de teclado
    2.- Limpieza del entorno de trabajo
    3.- Establecer el directorio de trabajo
                                     
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

  { // 3.2.- Creación de carpetas
    cap mkdir "1.admin"               
    cap mkdir "2.code"                
    cap mkdir "3.data_raw"            
    cap mkdir "4.data_clean"          
    cap mkdir "5.docs"                
    cap mkdir "6.output"            
    cap mkdir "7.temp"             
  }
  
  { // 3.3.- Uso y manejo de macros globales
    global admin   "$root/1.admin"
    global code    "$root/2.code"
    global raw     "$root/3.data_raw"
    global clean   "$root/4.data_clean"
    global docs    "$root/5.docs"
    global output  "$root/6.output"
    global temp    "$root/7.temp"
  }
}




