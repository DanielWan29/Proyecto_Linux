#!/bin/bash

#
#  Archivo con el código asociado operaciones extra
#


mostrar_menu(){    
	 clear	
    echo -e "\n \n"
    echo "*************** MENU PRINCIPAL MI SCRIPT MÓDULO ISO *******************************"
    echo -e "\n \n"
    echo -e "\t [u] ---> Gestionar Usuarios"
    echo -e "\t [d] ---> Gestionar Disco"
    echo -e "\t [p] ---> Gestionar Procesos"
    echo -e "\n"
    echo "[s]----------------------> Salir del script"
    echo "***********************************************************************************"  
	 echo -e "\n"
	 echo "seleccionar una opcion"	
	 read opcion  
}

mostrar_menu_secundario_opciones(){    
	 clear	
    echo -e "\n \n"
    echo "*************** MENU SECUNDARIO MI SCRIPT MÓDULO ISO *******************************"
    echo -e "\n \n"
    echo -e "\t [p] ---> Gestionar procesos"
    echo -e "\t [d] ---> Gestion de prioridades"
    echo -e "\n"
    echo "[e]----------------------> Salir del script"
    echo "***********************************************************************************"  
	 echo -e "\n"
	 echo "seleccionar una opcion"	
	 read opcion_secundaria
}




informacion_final_salir(){ 
	clear;
	echo "Ha seleccionado salir del script......."
	
	# Instalar juegos cowsay y fortune	
	apt install cowsay > /dev/null 2>&1
	apt install fortune-mod > /dev/null 2>&1
	
	# Crear enlaces simbólicos para ejecutar desde el bash los juegos cowsay y fortune
	ln -s /usr/games/cowsay /usr/bin/cowsay > /dev/null 2>&1
	ln -s /usr/games/cowthink /usr/bin/cowthink > /dev/null 2>&1

	# Ejecutar juegos instalados
	cowsay -f $(ls /usr/share/cowsay/cows/ | sort -R | head -1) $(fortune -s)
}

informacion_final_salir_procesos(){ 
	clear;
	echo "Proceso terminado con exito"
	echo "Volviendo a todas las funciones..."
}

