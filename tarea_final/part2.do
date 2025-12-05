/*==================================================================================================
  Descripción del dofile
  
           "Porcentaje de mujeres que sufrieron violencia, ejercida alguna vez
                                 por el esposo o compañero"
  
           .--.                  
          |o_o |         
          |:_/ |                --------------------------------------
         //   \ \                   Limpieza de la base de datos
        (|     | )              --------------------------------------        
        /'\_   _/`\   
       \___)=(___/
 
  Contenido
    1.- Atajos de teclado  
    2.- Limpieza del entorno de trabajo
    3.- Establecer el directorio de trabajo
    4.- Integración de base de datos
      4.1.- Merge y criterios de limpieza de los archivos 2017
            ...
      4.8.- Merge y criterios de limpieza de los archivos 2024
    5.- Construcción de las variables de estudio
      5.1.- Variables de estudio 2017
            ...
      5.8.- Variables de estudio 2024
    6.- Consolidación de todos los archivos 
      6.1.- Revisión de las archivos integrados por año
      6.2.- Concatenación de los años y guardar la base final
                                 
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



{ // 4.- Integración de base de datos
  
  { // 4.1.- Merge y criterios de limpieza de los archivos 2017
    use "${raw}/2017_rec91.dta", clear    // Módulo 66 Datos Basicos de MEF | caseid
    use "${raw}/2017_rec0111.dta", clear  // Módulo 66 Datos Basicos de MEF | caseid
    use "${raw}/2017_re223132.dta", clear // Módulo 67 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2017_rec42.dta", clear    // Módulo 70 Inmunización y Salud | caseid
    use "${raw}/2017_re516171.dta", clear // Módulo 71 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2017_rec84dv.dta", clear  // Módulo 73 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2017_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2017_rec0111.dta", generate(merge_1)
    save "${clean}/2017_rec91_rec0111.dta", replace 

    use "${raw}/2017_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2017_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2017_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2017_rec84dv.dta", generate(merge_4)
    save "${clean}/2017_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2017_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2017_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2017
    save "${clean}/2017_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2017_rec91_rec0111.dta"
    erase "${clean}/2017_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.2.- Merge y criterios de limpieza de los archivos 2018
    use "${raw}/2018_rec91.dta", clear    // Módulo 66 Datos Basicos de MEF | caseid
    use "${raw}/2018_rec0111.dta", clear  // Módulo 66 Datos Basicos de MEF | caseid
    use "${raw}/2018_re223132.dta", clear // Módulo 67 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2018_rec42.dta", clear    // Módulo 70 Inmunización y Salud | caseid
    use "${raw}/2018_re516171.dta", clear // Módulo 71 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2018_rec84dv.dta", clear  // Módulo 73 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2018_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2018_rec0111.dta", generate(merge_1)
    save "${clean}/2018_rec91_rec0111.dta", replace 

    use "${raw}/2018_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2018_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2018_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2018_rec84dv.dta", generate(merge_4)
    save "${clean}/2018_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2018_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2018_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2018
    save "${clean}/2018_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2018_rec91_rec0111.dta"
    erase "${clean}/2018_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.3.- Merge y criterios de limpieza de los archivos 2019
    use "${raw}/2019_rec91.dta", clear    // Módulo 66 Datos Basicos de MEF | caseid
    use "${raw}/2019_rec0111.dta", clear  // Módulo 66 Datos Basicos de MEF | caseid
    use "${raw}/2019_re223132.dta", clear // Módulo 67 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2019_rec42.dta", clear    // Módulo 70 Inmunización y Salud | caseid
    use "${raw}/2019_re516171.dta", clear // Módulo 71 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2019_rec84dv.dta", clear  // Módulo 73 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2019_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2019_rec0111.dta", generate(merge_1)
    save "${clean}/2019_rec91_rec0111.dta", replace 

    use "${raw}/2019_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2019_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2019_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2019_rec84dv.dta", generate(merge_4)
    save "${clean}/2019_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2019_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2019_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2019
    save "${clean}/2019_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2019_rec91_rec0111.dta"
    erase "${clean}/2019_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.4.- Merge y criterios de limpieza de los archivos 2020
    use "${raw}/2020_rec91.dta", clear    // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2020_rec0111.dta", clear  // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2020_re223132.dta", clear // Módulo 1632 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2020_rec42.dta", clear    // Módulo 1634 Inmunización y Salud | caseid
    use "${raw}/2020_re516171.dta", clear // Módulo 1635 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2020_rec84dv.dta", clear  // Módulo 1637 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2020_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2020_rec0111.dta", generate(merge_1)
    save "${clean}/2020_rec91_rec0111.dta", replace 

    use "${raw}/2020_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2020_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2020_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2020_rec84dv.dta", generate(merge_4)
    save "${clean}/2020_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2020_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2020_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2020
    save "${clean}/2020_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2020_rec91_rec0111.dta"
    erase "${clean}/2020_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.5.- Merge y criterios de limpieza de los archivos 2021
    use "${raw}/2021_rec91.dta", clear    // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2021_rec0111.dta", clear  // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2021_re223132.dta", clear // Módulo 1632 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2021_rec42.dta", clear    // Módulo 1634 Inmunización y Salud | caseid
    use "${raw}/2021_re516171.dta", clear // Módulo 1635 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2021_rec84dv.dta", clear  // Módulo 1637 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2021_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2021_rec0111.dta", generate(merge_1)
    save "${clean}/2021_rec91_rec0111.dta", replace 

    use "${raw}/2021_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2021_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2021_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2021_rec84dv.dta", generate(merge_4)
    save "${clean}/2021_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2021_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2021_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2021
    save "${clean}/2021_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2021_rec91_rec0111.dta"
    erase "${clean}/2021_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.6.- Merge y criterios de limpieza de los archivos 2022
    use "${raw}/2022_rec91.dta", clear    // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2022_rec0111.dta", clear  // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2022_re223132.dta", clear // Módulo 1632 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2022_rec42.dta", clear    // Módulo 1634 Inmunización y Salud | caseid
    use "${raw}/2022_re516171.dta", clear // Módulo 1635 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2022_rec84dv.dta", clear  // Módulo 1637 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2022_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2022_rec0111.dta", generate(merge_1)
    save "${clean}/2022_rec91_rec0111.dta", replace 

    use "${raw}/2022_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2022_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2022_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2022_rec84dv.dta", generate(merge_4)
    save "${clean}/2022_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2022_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2022_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2022
    save "${clean}/2022_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2022_rec91_rec0111.dta"
    erase "${clean}/2022_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.7.- Merge y criterios de limpieza de los archivos 2023
    use "${raw}/2023_rec91.dta", clear    // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2023_rec0111.dta", clear  // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2023_re223132.dta", clear // Módulo 1632 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2023_rec42.dta", clear    // Módulo 1634 Inmunización y Salud | caseid
    use "${raw}/2023_re516171.dta", clear // Módulo 1635 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2023_rec84dv.dta", clear  // Módulo 1637 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2023_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2023_rec0111.dta", generate(merge_1)
    save "${clean}/2023_rec91_rec0111.dta", replace 

    use "${raw}/2023_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2023_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2023_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2023_rec84dv.dta", generate(merge_4)
    save "${clean}/2023_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2023_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2023_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2023
    save "${clean}/2023_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2023_rec91_rec0111.dta"
    erase "${clean}/2023_re223132_rec42_re516171_rec84dv.dta"
  }

  { // 4.8.- Merge y criterios de limpieza de los archivos 2024
    use "${raw}/2024_rec91.dta", clear    // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2024_rec0111.dta", clear  // Módulo 1631 Datos Basicos de MEF | caseid
    use "${raw}/2024_re223132.dta", clear // Módulo 1632 Historia de Nacimiento - Tabla de Conocimiento de Metodo | caseid
    use "${raw}/2024_rec42.dta", clear    // Módulo 1634 Inmunización y Salud | caseid
    use "${raw}/2024_re516171.dta", clear // Módulo 1635 Nupcialidad - Fecundidad - Cónyugue y Mujer | caseid 
    use "${raw}/2024_rec84dv.dta", clear  // Módulo 1637 Mortalidad Materna - Violencia Familiar | caseid

    use "${raw}/2024_rec91.dta", clear
    merge 1:1 caseid using "${raw}/2024_rec0111.dta", generate(merge_1)
    save "${clean}/2024_rec91_rec0111.dta", replace 

    use "${raw}/2024_re223132.dta", clear  
    merge 1:1 caseid using "${raw}/2024_rec42.dta", generate(merge_2)
    merge 1:1 caseid using "${raw}/2024_re516171.dta", generate(merge_3)
    merge 1:1 caseid using "${raw}/2024_rec84dv.dta", generate(merge_4)
    save "${clean}/2024_re223132_rec42_re516171_rec84dv.dta", replace

    use "${clean}/2024_rec91_rec0111.dta", clear 
    merge 1:1 caseid using "${clean}/2024_re223132_rec42_re516171_rec84dv.dta", generate(merge_5)
    generate year = 2024
    save "${clean}/2024_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", replace
    erase "${clean}/2024_rec91_rec0111.dta"
    erase "${clean}/2024_re223132_rec42_re516171_rec84dv.dta"
  }
}



{ // 5.- Construcción de las variables de estudio
  
  { // 5.1.- Variables de estudio 2017

    use "${clean}/2017_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse v024
      fre v024
      generate dpto = v024 
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }

    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2017.dta", replace
      erase  "${clean}/2017_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2017.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.2.- Variables de estudio 2018
    
    use "${clean}/2018_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }
    
    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2018.dta", replace
      erase  "${clean}/2018_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2018.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.3.- Variables de estudio 2019
    
    use "${clean}/2019_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }
    
    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2019.dta", replace
      erase  "${clean}/2019_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2019.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.4.- Variables de estudio 2020
    
    use "${clean}/2020_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }
    
    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2020.dta", replace
      erase  "${clean}/2020_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2020.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.5.- Variables de estudio 2021
    
    use "${clean}/2021_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }
    
    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2021.dta", replace
      erase  "${clean}/2021_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2021.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.6.- Variables de estudio 2022
    
    use "${clean}/2022_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }
    
    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2022.dta", replace
      erase  "${clean}/2022_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2022.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.7.- Variables de estudio 2023
    
    use "${clean}/2023_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse 

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }
    
    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2023.dta", replace
      erase  "${clean}/2023_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2023.dta", replace
      mdesc 
      browse 
    }
  }

  { // 5.8.- Variables de estudio 2024

    use "${clean}/2024_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta", clear 
    browse

    { // 0.- Factor de ponderación
      browse v005
      generate fp_mujer = v005/1000000
      label variable fp_mujer "Factor de ponderación mujer"
      codebook fp_mujer
    }

    { // 1.- Grupo de edad
      browse v013
      fre    v013
      generate gedad_mujer = .
      replace gedad_mujer = 1 if (v013 == 1)
      replace gedad_mujer = 2 if (v013 == 2)
      replace gedad_mujer = 3 if (v013 == 3)
      replace gedad_mujer = 4 if (v013 == 4)
      replace gedad_mujer = 5 if (v013 == 5)
      replace gedad_mujer = 6 if (v013 == 6)
      replace gedad_mujer = 7 if (v013 == 7)
      label define lab_gedad_mujer 1 "15 a 19 años" 2 "20 a 24 años" 3 "25 a 29 años" 4 "30 a 34 años" 5 "35 a 39 años" 6 "40 a 44 años" 7 "45 a 49 años", replace
      label values gedad_mujer lab_gedad_mujer
      label variable gedad_mujer "Edad de la mujer en grupos de 5 años"
      fre gedad_mujer
    }

    { // 2.- Tipo de lugar de residencia
      browse v025 
      fre    v025   
      generate urbano = .
      replace urbano = 1 if (v025 == 1)
      replace urbano = 0 if (v025 == 2)
      label define lab_urbano 1 "Urbano" 0 "Rural", replace
      label values urbano lab_urbano 
      label variable urbano "Tipo de lugar de residencia | 1: Urbano, 0: Rural"
      fre urbano
    }

    { // 3.- Región natural
      browse sregion
      fre    sregion
      generate regnat = .
      replace regnat = 1 if (sregion == 1 | sregion == 2)
      replace regnat = 2 if (sregion == 3)
      replace regnat = 3 if (sregion == 4)
      label define lab_regnat 1 "Costa" 2 "Sierra" 3 "Selva", replace
      label values regnat lab_regnat
      label variable regnat "Región natural"
      fre regnat
    }

    { // 4.- Departamentos más la Prov. Const. del Callao
      browse ubigeo
      fre ubigeo
      generate dpto = substr(ubigeo, 1, 2)
      destring dpto, replace
      label define lab_dpto 1 "Amazonas" 2 "Ancash" 3 "Apurímac" 4 "Arequipa" ///
                            5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" ///
                            11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima"  16 "Loreto" ///
                            17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martín" ///
                            23 "Tacna" 24 "Tumbes" 25 "Ucayali", replace 
      label values dpto lab_dpto
      label variable dpto "Departamento | 1: Amazonas, ..., 25: Ucayali"
    }

    { // 5.- Violencia física ejercida por el esposo o compañero

      { // 5.1.- Empujo, sacudio o tiro algo
        browse v044 v502 d105a
        fre v044 v502 d105a
        generate vf_c1 = .
        replace vf_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c1 = 1 if (d105a > 0 & d105a <= 3)
        label define lab_vf_c1 1 "Sí" 0 "No", replace
        label values vf_c1 lab_vf_c1
        label variable vf_c1 "Violencia física | Empujo, sacudio o tiro algo"
        fre vf_c1
      }

      { // 5.2.- Abofeteo
        browse v044 v502 d105b
        fre v044 v502 d105b
        generate vf_c2 = .
        replace vf_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c2 = 1 if (d105b > 0 & d105b <= 3)
        label define lab_vf_c2 1 "Sí" 0 "No", replace
        label values vf_c2 lab_vf_c2
        label variable vf_c2 "Violencia física | Abofeteo"
        fre vf_c2
      }

      { // 5.3.- Golpeo con el puño o algo que pudo dañarla
        browse v044 v502 d105c
        fre v044 v502 d105c
        generate vf_c3 = .
        replace vf_c3 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c3 = 1 if (d105c > 0 & d105c <= 3)
        label define lab_vf_c3 1 "Sí" 0 "No", replace
        label values vf_c3 lab_vf_c3
        label variable vf_c3 "Violencia física | Golpeo con el puño o algo que pudo dañarla"
        fre vf_c3
      }

      { // 5.4.- Pateo o arrastro
        browse v044 v502 d105d
        fre v044 v502 d105d
        generate vf_c4 = .
        replace vf_c4 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c4 = 1 if (d105d > 0 & d105d <= 3)
        label define lab_vf_c4 1 "Sí" 0 "No", replace
        label values vf_c4 lab_vf_c4
        label variable vf_c4 "Violencia física | Pateo o arrastro"
        fre vf_c4
      }

      { // 5.5.- Trato de estrangularla o quemarla 
        browse v044 v502 d105e
        fre v044 v502 d105e
        generate vf_c5 = .
        replace vf_c5 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c5 = 1 if (d105e > 0 & d105e <= 3)
        label define lab_vf_c5 1 "Sí" 0 "No", replace
        label values vf_c5 lab_vf_c4
        label variable vf_c5 "Violencia física | Trato de estrangularla o quemarla"
        fre vf_c5
      }

      { // 5.6.- Amenazo con cuchillo, pistola u otra arma
        browse v044 v502 d105f
        fre v044 v502 d105f
        generate vf_c6 = .
        replace vf_c6 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c6 = 1 if (d105f > 0 & d105f <= 3)
        label define lab_vf_c6 1 "Sí" 0 "No", replace
        label values vf_c6 lab_vf_c6
        label variable vf_c6 "Violencia física | Amenazo con cuchillo, pistola u otra arma"
        fre vf_c6
      }

      { // 5.7.- Ataco, agredio con cuchillo, pistola u otra arma
        browse v044 v502 d105g
        fre v044 v502 d105g
        generate vf_c7 = .
        replace vf_c7 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c7 = 1 if (d105g > 0 & d105g <= 3)
        label define lab_vf_c7 1 "Sí" 0 "No", replace
        label values vf_c7 lab_vf_c7
        label variable vf_c7 "Violencia física | Ataco, agredio con cuchillo, pistola u otra arma"
        fre vf_c7
      }

      { // 5.8.- Retorcio el brazo
        browse v044 v502 d105j
        fre v044 v502 d105j
        generate vf_c8 = .
        replace vf_c8 = 0 if (v044 == 1 & v502 > 0)
        replace vf_c8 = 1 if (d105j > 0 & d105j <= 3)
        label define lab_vf_c8 1 "Sí" 0 "No", replace
        label values vf_c8 lab_vf_c8
        label variable vf_c8 "Violencia física | Retorcio el brazo"
        fre vf_c8
      }

      { // 5.9.- Violencia física
        browse v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        fre    v044 v502 d105a d105b d105c d105d d105e d105f d105g d105j 
        generate vf = .
        replace vf = 0 if (v044 == 1 & v502 > 0)
        foreach x in a b c d e f g j {
          replace vf = 1 if (d105`x'> 0 & d105`x'<= 3)
        }
        label define lab_vf 1 "Sí" 0 "No", replace
        label values vf lab_vf
        label variable vf "Violencia física | 1: Sí, 0: No"
        fre vf
        browse vf_c1 vf_c2 vf_c3 vf_c4 vf_c5 vf_c6 vf_c7 vf_c8 vf
      }
    }

    { // 6.- Violencia sexual ejercida por el esposo o compañero

      { // 6.1.- Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria
        browse v044 v502
        fre    v044 v502 d105h 
        generate vs_c1 = .
        replace vs_c1 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c1 = 1 if (d105h > 0 & d105h <= 3)
        label define lab_vs_c1 1 "Sí" 0 "No", replace
        label values vs_c1 lab_vs_c1
        label variable vs_c1 "Violencia sexual | Esposo alguna vez la forzo a tener relaciones sexuales aunque no queria"
        fre vs_c1
      }

      { // 6.2.- Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria
        browse v044 v502
        fre    v044 v502 d105i 
        generate vs_c2 = .
        replace vs_c2 = 0 if (v044 == 1 & v502 > 0)
        replace vs_c2 = 1 if (d105i > 0 & d105i <= 3)
        label define lab_vs_c2 1 "Sí" 0 "No", replace
        label values vs_c2 lab_vs_c2
        label variable vs_c2 "Violencia sexual | Esposo alguna vez la obligo a realizar otros actos sexuales cuando no queria"
        fre vs_c2
      }

      { // 6.3.- Violencia sexual
        browse v044 v502 d105h d105i 
        fre    v044 v502 d105h d105i
        generate vs = .
        replace vs = 0 if (v044 == 1 & v502 > 0)
        foreach x in h i {
          replace vs = 1 if (d105`x' > 0 & d105`x' <= 3)
        }
        label define lab_vs 1 "Sí" 0 "No", replace
        label values vs lab_vs 
        label variable vs "Violencia sexual | 1: Sí, 0: No"
        fre vs 
        browse vs_c1 vs_c2 vs 
      }
    }

    { // 7.- Violencia psicológica y/o verbal ejercida por el esposo o compañero
      
      { // 7.1.- Situaciones humillantes
        browse v044 v502 d103a
        fre    v044 v502 d103a
        generate situh = .
        replace situh = 0 if (v044 == 1 & v502 > 0)
        replace situh = 1 if (d103a > 0 & d103a <= 3)
        label define lab_situh 1 "Sí" 0 "No", replace
        label values situh lab_situh
        label variable situh "Situaciones humillantes"
        fre situh
      }

      { // 7.2.- Situaciones de control

        { // 7.2.1.- Es celoso o molesto
          browse v044 v502 d101a
          fre    v044 v502 d101a
          generate situc_c1 = .
          replace situc_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c1 = 1 if (d101a == 1)
          label define lab_situc_c1 1 "Sí" 0 "No", replace
          label values situc_c1 lab_situc_c1
          label variable situc_c1 "Situaciones de control | Es celoso o molesto"
          fre situc_c1
        }

        { // 7.2.2.- Acusa de ser infiel
          browse v044 v502 d101b
          fre    v044 v502 d101b
          generate situc_c2 = .
          replace situc_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c2 = 1 if (d101b == 1)
          label define lab_situc_c2 1 "Sí" 0 "No", replace
          label values situc_c2 lab_situc_c2
          label variable situc_c2 "Situaciones de control | Acusa de ser infiel"
          fre situc_c2
        }

        { // 7.2.3.- Impide que visite o la visiten sus amistades/familiares
          browse v044 v502 d101c d101d
          fre    v044 v502 d101c d101d
          generate situc_c3 = .
          replace situc_c3 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c3 = 1 if (d101c == 1 | d101d == 1)
          label define lab_situc_c3 1 "Sí" 0 "No", replace
          label values situc_c3 lab_situc_c3
          label variable situc_c3 "Situaciones de control | Impide que visite o la visiten sus amistades/familiares"
          fre situc_c3
        }

        { // 7.2.4.- Insiste en saber donde va
          browse v044 v502 d101e
          fre    v044 v502 d101e
          generate situc_c4 = .
          replace situc_c4 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c4 = 1 if (d101e == 1)
          label define lab_situc_c4 1 "Sí" 0 "No", replace
          label values situc_c4 lab_situc_c4
          label variable situc_c4 "Situaciones de control | Insiste en saber donde va"
          fre situc_c4
        }

        { // 7.2.5.- Desconfia con el dinero
          browse v044 v502 d101f
          fre    v044 v502 d101f
          generate situc_c5 = .
          replace situc_c5 = 0 if (v044 == 1 & v502 > 0)
          replace situc_c5 = 1 if (d101f == 1)
          label define lab_situc_c5 1 "Sí" 0 "No", replace
          label values situc_c5 lab_situc_c5
          label variable situc_c5 "Situaciones de control | Desconfia con el dinero"
          fre situc_c5
        }

        { // 7.2.6.- Situaciones de control 
          browse v044 v502 d101a d101b d101c d101d d101e d101f 
          fre    v044 v502 d101a d101b d101c d101d d101e d101f
          egen situc = rowtotal(situc_c1 situc_c2 situc_c3 situc_c4 situc_c5) if (v044 == 1 & v502 > 0)
          recode situc (1 2 3 4 5 = 1)
          label define lab_situc 1 "Sí" 0 "No", replace
          label values situc lab_situc 
          label variable situc "Situaciones de control"
          fre situc
          browse situc_c1 situc_c2 situc_c3 situc_c4 situc_c5 situc
        }
      }

      { // 7.3.- Situaciones de amenaza

        { // 7.3.1.- Amenaza con hacerle daño
          browse v044 v502 d103b 
          fre    v044 v502 d103b
          generate situa_c1 = .
          replace situa_c1 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c1 = 1 if (d103b > 0 & d103b <= 3)
          label define lab_situa_c1 1 "Sí" 0 "No", replace
          label values situa_c1 lab_situa_c1
          label variable situa_c1 "Situaciones de amenaza | Amenaza con hacerle daño"
          fre situa_c1
        }

        { // 7.3.2.- Amenaza con irse de casa, quitarle hijos, detener ayuda economica
          browse v044 v502 d103d 
          fre    v044 v502 d103d
          generate situa_c2 = .
          replace situa_c2 = 0 if (v044 == 1 & v502 > 0)
          replace situa_c2 = 1 if (d103d > 0 & d103d <= 3)
          label define lab_situa_c2 1 "Sí" 0 "No", replace
          label values situa_c2 lab_situa_c2
          label variable situa_c2 "Situaciones de amenaza | Amenaza con irse de casa, quitarle hijos, detener ayuda economica"
          fre situa_c2
        }

        { // 7.3.3.- Situaciones de amenaza
          browse v044 v502 d103b d103d 
          fre    v044 v502 d103b d103d 
          egen situa = rowtotal(situa_c1 situa_c2) if (v044 == 1 & v502 > 0)
          recode situa (1 2 = 1)
          label define lab_situa 1 "Sí" 0 "No", replace
          label values situa lab_situa 
          label variable situa "Situaciones de amenaza"
          fre situa
          browse situa_c1 situa_c2 situa 
        }
      }

      { // 7.4.- Violencia psicológica y/o verbal
        browse situh situc situa 
        fre    situh situc situa
        generate vpsi = .
        replace vpsi = 0 if (v044 == 1 & v502 > 0)
        replace vpsi = 1 if (situh == 1 | situc == 1 | situa == 1)
        label define lab_vpsi 1 "Sí" 0 "No", replace
        label values vpsi lab_vpsi 
        label variable vpsi "Violencia psicológica y/o verbal | 1: Sí, 0: No"
        fre vpsi 
        browse situh situc situa vpsi 
      }
    }

    { // 8.- Violencia total (Violencia física | Violencia sexual | Violencia psicológica y/o verbal)
      browse vf vs vpsi 
      fre    vf vs vpsi 
      generate vt = . 
      replace vt = 0 if (v044 == 1 & v502 > 0)
      replace vt = 1 if (vf == 1 | vs == 1 | vpsi == 1)
      label define lab_vt 1 "Sí" 0 "No", replace
      label values vt lab_vt 
      label variable vt "Violencia total | 1: Sí, 0: No"
      fre vt 
      browse vf vs vpsi vt
    }

    { // 9.- Seleccionar y guardar las variables de interés
      browse year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt 
      order  year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      keep   year fp_mujer gedad_mujer urbano regnat dpto vf vs vpsi vt
      save   "${clean}/violencia_mujer_2024.dta", replace
      erase  "${clean}/2024_rec91_rec0111_re223132_rec42_re516171_rec84dv.dta"
      use    "${clean}/violencia_mujer_2024.dta", replace
      mdesc 
      browse 
    }
  }
}



{ // 6.- Consolidación de todos los archivos
  
  { // 6.1.- Revisión de las archivos integrados por año
    use "${clean}/violencia_mujer_2017.dta", replace
    use "${clean}/violencia_mujer_2018.dta", replace
    use "${clean}/violencia_mujer_2019.dta", replace
    use "${clean}/violencia_mujer_2020.dta", replace
    use "${clean}/violencia_mujer_2021.dta", replace
    use "${clean}/violencia_mujer_2022.dta", replace
    use "${clean}/violencia_mujer_2023.dta", replace
    use "${clean}/violencia_mujer_2024.dta", replace
  }

  { // 6.2.- Concatenación de los años y guardar la base final
    use "${clean}/violencia_mujer_2017.dta", replace
    append using "${clean}/violencia_mujer_2018.dta", force 
    append using "${clean}/violencia_mujer_2019.dta", force
    append using "${clean}/violencia_mujer_2020.dta", force
    append using "${clean}/violencia_mujer_2021.dta", force
    append using "${clean}/violencia_mujer_2022.dta", force
    append using "${clean}/violencia_mujer_2023.dta", force
    append using "${clean}/violencia_mujer_2024.dta", force
    save "${clean}/violencia_mujer_2017_2024.dta", replace 
  }
}




