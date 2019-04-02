#!/bin/bash

#
#  Archivo con el código asociado a la gestión de procesos
#

mostrar_menu_secundario()
{
while !([ "$opcion_secundaria" = 'e' ])
do

	mostrar_menu_secundario_opciones
	
	case $opcion_secundaria in
      			p) 	
				informacion_inicial_procesos
				gestion_procesos
				read fin_procesos
			;;	
	
			d) 
				informacion_inicial_prioridades
				gestion_de_prioridades
				read fin_prioridades
			;;

			e) 
				informacion_final_salir_procesos
				read fin_salir		
				clear	
				
			;;
	
			*) 
				echo "Opción incorrecta"		
				read fin_incorrecto
				clear
			;;
			esac
done
}


informacion_inicial_procesos()
{    
	 clear
	 echo "----------------------------------------------------------------"    
	 echo "----------------------------------------------------------------" 	
  	 echo -e " \t Ha seleccionado la opción GESTION PROCESOS"
  	 echo "----------------------------------------------------------------" 	 
  	 echo "----------------------------------------------------------------" 
}

gestion_procesos()
{    	
    echo "Listar Procesos"
	sleep 100 &
	ps -la
	
	
	echo "Indica el PID del Proceso sleep"
	read proceso


    echo "Listar Señales"
	kill -l
	echo "Indica la Señal a Utilizar"
	read senal


    echo "Enviar Señal a Proceso"
	kill -$senal $proceso > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
	echo "Has matado al proceso"
        ps -ao stat,pcpu,pid,user,fname,nice

    else
	echo "No has eliminado nada"
    fi
}


informacion_inicial_prioridades()
{    
	 clear
	 echo "----------------------------------------------------------------"    
	 echo "----------------------------------------------------------------" 	
  	 echo -e " \t Ha seleccionado la opción GESTION DE PRIORIDADES"
  	 echo "----------------------------------------------------------------" 	 
  	 echo "----------------------------------------------------------------" 
}

gestion_de_prioridades()
{
    echo "Listar procesos"
	sleep 100 &
	ps -la
	echo "Indica el PID del Proceso sleep"
	read pid

	echo "Indica la prioridad"
	read prioridad

    echo "Cambiar Prioridad a Procesos"
	renice -$prioridad $pid

    if [ $? -eq 0 ]
    then
	echo "Hascambiado la prioridad"
        ps -ao stat,pcpu,pid,user,fname,nice

    else
	echo "No se puedo mostrar el cambio de prioridad"
    fi

}
