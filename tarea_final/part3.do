/*==================================================================================================
  Descripción del dofile
  
           "Porcentaje de mujeres que sufrieron violencia, ejercida alguna vez
                                 por el esposo o compañero"
  
           .--.                  
          |o_o |         
          |:_/ |               --------------------------------------------
         //   \ \                    Análisis de modelos econométricos
        (|     | )             --------------------------------------------      
        /'\_   _/`\   
       \___)=(___/
 
  Contenido
    1.- Atajos de teclado
    2.- Limpieza del entorno de trabajo
    3.- Establecer el directorio de trabajo
    4.- Estadística descriptiva (Exploración de las variables)
    5.- Modelos Lineales Generalizados - gaussian - identity
    6.- Modelos Lineales Generalizados - Poisson  - log
                                     
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



{ // 4.- Estadística descriptiva (Exploración de las variables)
  
  { // 4.1.- Estadística descriptiva 2017
    
    use "${clean}/violencia_mujer_2017.dta", clear 
    browse

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional
    mdesc

    *ssc install schemepack, replace 
    *set scheme s2color   
    *set scheme swift_red 
    set scheme cblind1

    generate obs = _n
    graph hbar (count) obs, over(vf) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(4000)16000, format(%9.0fc)) title("Mujeres que sufrieron violencia física el 2017") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2017")

    graph hbar (count) obs, over(vs) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(7000)21000, format(%9.0fc)) title("Mujeres que sufrieron violencia sexual el 2017") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2017")

    graph hbar (count) obs, over(vpsi) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(5000)15000, format(%9.0fc)) title("Mujeres que sufrieron violencia psicológica el 2017") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2017")

    graph hbar (count) obs, over(vt) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(5000)15000, format(%9.0fc)) title("Mujeres que sufrieron violencia total el 2017") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2017")
  }

  { // 4.8.- Estadística descriptiva 2024
    
    use "${clean}/violencia_mujer_2024.dta", clear 
    browse

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional
    mdesc

    *ssc install schemepack, replace 
    *set scheme s2color   
    *set scheme swift_red 
    set scheme cblind1

    generate obs = _n
    graph hbar (count) obs, over(vf) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(3000)18000, format(%9.0fc)) title("Mujeres que sufrieron violencia física el 2024") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2024")

    graph hbar (count) obs, over(vs) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(5000)20000, format(%9.0fc)) title("Mujeres que sufrieron violencia sexual el 2024") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2024")

    graph hbar (count) obs, over(vpsi) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(5000)15000, format(%9.0fc)) title("Mujeres que sufrieron violencia psicológica el 2024") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2024")

    graph hbar (count) obs, over(vt) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            ylabel(0(4000)12000, format(%9.0fc)) title("Mujeres que sufrieron violencia total el 2024") ///
                            subtitle("(A nivel muestral)") note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar, 2024")
  }

  { // 4.9.- Estadística descriptiva 2017-2024
    
    use "${clean}/violencia_mujer_2017_2024.dta", clear 
    browse

    drop if (vt == .) // Eliminar los missing no cambia los resultados de la inferencia a nivel poblacional
    mdesc

    *ssc install schemepack, replace 
    *set scheme s2color   
    *set scheme swift_red 
    set scheme cblind1

    generate obs = _n

    graph hbar (count) obs, over(vf) over(year) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            yline(4864, lcolor(red) lwidth(medium) lpattern(dash)) ylabel(0(3000)18000, format(%9.0fc)) ///
                            title("Mujeres que sufrieron violencia física por año") subtitle("(A nivel muestral)") ///
                            legend(order(1 "No" 2 "Sí") title("Violencia Física")) ///
                            note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar" "Línea de referencia: 4864 observaciones")

    graph hbar (count) obs, over(vs) over(year) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            yline(1024, lcolor(red) lwidth(medium) lpattern(dash)) ylabel(0(8000)24000, format(%9.0fc)) ///
                            title("Mujeres que sufrieron violencia sexual por año") subtitle("(A nivel muestral)") ///
                            legend(order(1 "No" 2 "Sí") title("Violencia sexual")) ///
                            note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar" "Línea de referencia: 1024 observaciones")
                            
    graph hbar (count) obs, over(vpsi) over(year) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            yline(9090, lcolor(red) lwidth(medium) lpattern(dash)) ylabel(0(5000)15000, format(%9.0fc)) ///
                            title("Mujeres que sufrieron violencia psicológica por año") subtitle("(A nivel muestral)") ///
                            legend(order(1 "No" 2 "Sí") title("Violencia psicológica")) ///
                            note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar" "Línea de referencia: 9090 observaciones ") 

    graph hbar (count) obs, over(vt) over(year) blabel(bar, format(%9.0fc)) ytitle("Número de observaciones") ///
                            yline(9941, lcolor(red) lwidth(medium) lpattern(dash)) ylabel(0(5000)15000, format(%9.0fc)) ///
                            title("Mujeres que sufrieron violencia total por año") subtitle("(A nivel muestral)") ///
                            legend(order(1 "No" 2 "Sí") title("Violencia total")) ///
                            note("Fuente: INEI - Encuesta Demográfica y de Salud Familiar" "Línea de referencia: 9,941 observaciones")
  }
}




{ // 5.- Modelos Lineales Generalizados - gaussian - identity
}


{ // 6.- Modelos Lineales Generalizados - Poisson  - log
}




