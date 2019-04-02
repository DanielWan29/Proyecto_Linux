#!/bin/bash

#
#  Comprobar si el usuario es root
#  En el texto `` tienes que añadir un comando que compruebe cuál es el usuario logueado actualmente
#

informacion_inicial_usuarios()
{    
	 clear
	 echo "----------------------------------------------------------------"    
	 echo "----------------------------------------------------------------" 	
  	 echo -e " \t Ha seleccionado la opción GESTION USUARIOS"
  	 echo "----------------------------------------------------------------" 	 
  	 echo "----------------------------------------------------------------" 
}

gestion_usuarios()
{
usuario=$(whoami)
ruta=$(pwd)

#echo $ruta
#echo $usuario

if [ $usuario != "root" ]
then
	echo El script tiene que ejecutarse con usuario root
        echo "El usuario utilizado es: $usuario"
	exit 1
else
        echo "El usuario es correcto ----> $usuario"
fi

echo "Especifica el primer usuario"
read usu1

echo "Especifica el segundo usuario"
read usu2

echo "Especifica un grupo para los usuarios"
read grp

echo "Especifica un paquete que deseas instalar"
read app

#echo "El numero de parametros es: $#"
echo "El primer parametro es: $usu1"
echo "El segundo parametro es: $usu2"
echo "El tercer parametro es: $grp"
echo "El cuarto parametro es: $app"

# Validación de número de parámetros
#if [ $# -lt 4 ]
#then
#   echo Número de parámetros insuficiente
#   exit 2
#fi

# El usuario 1 es $1 (primer parámetro), el usuario 2 es $2 (segundo parámetro) y el grupo es $3 (tercer parámetro)
# $1, $2 y $3 son variables que se pueden utilizar en los comandos (por ejemplo /home/$1 sería el directorio del usuario 1)


# Aquí se añade el código para crear usuarios y grupos

groupadd $grp
useradd -g $grp $usu1
useradd -G 0 $usu2
usermod -G $grp $usu2


# Aquí se asigna una contraseña al usuario $2

passwd $usu2

# Debajo actualizamos los paquetes sin mostrar nada por pantalla (el operador para hacerlo está en el comando para actualizar la contraseña)

apt-get update > update.txt

# Control de errores por si hay algún problema al actualizar los paquetes
if [ $? -gt 0 ]; then
   echo Error al actualizar los paquetes
   exit 3
fi

# El cuarto parámetro $4 es el nombre del software a instalar (en este caso se ha guardado en una variable)

apt-get install $app

# Control de errores por si algún problema al instalar el paquete que se recibe por parámetro
if [ $? -gt 0 ]; then
   echo Error al instalar el paquete $paquete. Puede que no exista
   exit 4
fi

	echo "                           "
	echo "                           "
	echo "Proceso terminado con exito"
	echo "Volviendo a todas las funciones..."
	echo "Pulsa enter para salir"
}
