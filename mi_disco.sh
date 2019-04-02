#!/bin/bash

informacion_inicial_discos()
{    
	 clear
	 echo "----------------------------------------------------------------"    
	 echo "----------------------------------------------------------------" 	
  	 echo -e " \t Ha seleccionado la opción GESTION DE DISCOS"
  	 echo "----------------------------------------------------------------" 	 
  	 echo "----------------------------------------------------------------" 
}


inicio_discos(){
# Comprobamos si el usuario es root
# En el texto entre `` tienes que añadir un comando que comprueba cuál es el usuario logueado actuamente
echo "COMPROBANDO QUE ERES USUARIO ROOT..."
usuario=`whoami`
if [ $usuario != "root" ]; then
   echo El script tiene que ejecutarse con usuario root
   exit 1 
fi
echo "ACCESO PERMITIDO"
}

verificacion_montaje(){
# En esta validación se ejecutará un comando que busca si existe el segundo disco duro
# Se redirige la salida estándar y de error 
# Lo que tienes que añadir es un comando delante de > que busque el segundo disco duro
# En caso de que no lo encuentre, la validación de debajo comprueba si ha habido un error y en caso afirmativo termina el script

echo "VERIFICANDO PUNTOS DE MONTAJE..."
fdisk -l | grep /dev/sdb > /dev/null 2>&1
if [ $? -gt 0 ]; then
   echo No existe el dispositivo a montar
   exit 2
fi
echo "PUNTOS DE MONTAJE ENCONTRADOS"
}

comprobando_espacio(){
# Ejecuta un comando que devuelva el tamaño en GB del segundo disco duro
# El comando deberás incluirlo entre `` dentro de la variable denominada size

echo "COMPROBANDO ESPACIO EN DISCO..."
size=`df -h /dev/sdb`
if [ $size -le 5 ]; then
   echo El disco debe ser mayor que 5
   exit 3
fi
}

resto_de_gestion(){
# Desmontamos la primera y segunda partición por si previamente existen
# Redirigimos la salida de error a /dev/null para que no nos muestre un error en el caso de que no existan

echo "DESMONTANDO EL DISPOSITIVO..."
umount /dev/sdb1 2> /dev/null; umount /dev/sdb2 2> /dev/null
rm -rf /mnt/disco_1 2> /dev/null; rm -rf /mnt/disco_2 2> /dev/null


# Ahora en las líneas entre los dos EOF debes incluir todas las opciones necesarias para crear dos particiones
# La primera es de 5 GB y la segunda con la opción por defecto
# Puedes probar antes ejecutando el comando de forma interactiva 

echo "CREANDO PARTICIÓN 1..."

fdisk /dev/sdb <<EOF
n
p
1

+5G
w
EOF
echo "CREADA CON EXITO"

echo "CREANDO PARTICIÓN 2..."

fdisk /dev/sdb <<EOF
n
p
2

 
w
EOF
echo "CREADA CON EXITO"

# Ahora formateamos los discos duros y los montamos

echo "FORMATEANDO PARTICION 1..."
mkfs.ext4 /dev/sdb1
echo "FORMATEADA CORRECTAMENTE"

echo "FORMATEANDO PARTICION 2..."
mkfs.ext4 /dev/sdb2
echo "FORMATEADA CORRECTAMENTE"

# Cuando creamos la carpeta de montaje es recomendable redirigir la salida de error a /dev/null
# Esto se hace porque si se ejecuta el script varias veces y las carpetas existen, así ocultamos el error

echo "CREANDO CARPETAS DE MONTAJE..."
mkdir -p ./mnt/disco_1 2> /dev/null; mkdir -p ./mnt/disco_2 2> /dev/null
echo "CREADAS CON EXITO"

echo "MONTANDO LAS PARTICIONES EN SUS RUTAS ASIGNADAS..."
mount -t ext4 /dev/sdb1 ./mnt/disco_1; mount -t ext4 /dev/sdb2 ./mnt/disco_2
echo "MONTADAS CON EXITO"

# Añadimos los nuevos discos duros a /etc/fstab, aunque antes borramos la información que pueda haber antes en este fichero
# Para ello redirigimos a un fichero temporal todo el contenido de /etc/fstab excepto aquellas líneas que contienen sdb
# Sobreescribimos /etc/fstab con el contenido del fichero temporal y después borramos el temporal

grep -v sdb /etc/fstab > temporal; 

cat temporal > /etc/fstab

#rm -r temporal

echo "/dev/sbd1 /mnt/disco_1 ext4 defaults 2 1" >> /etc/fstab

echo "/dev/sbd2 /mnt/disco_2 ext4 defaults 2 1" >> /etc/fstab



# La variable $actual almacena el primer usuario logueado en el sistema. Debes ejecutar un comando que devuelva solo el nombre de este usuario

echo "ALMACENANDO PRIMER LOG DEL SISTEMA..."
actual=`who --users | tr -s " "|cut -d " " -f 1`

# Ahora quedaría copiar el directorio personal del usuario a la carpeta donde está montada la primera partición del disco
# Para acceder a una carpeta utilizando una variable, se puede reemplazar en la ruta el texto de las carpetas por la variable
# Por ejemplo /home/$nombre_variable (o /home/$1 en caso de que fuera un parámetro)

echo "COPIANDO EL DIRECTORIO PERSONAL A LA RUTA DE LA PRIMERA PARTICIÓN..."
cp -R /home/$actual ./mnt/disco_1 2> /dev/null

echo "FINALIZANDO SCRIPT"

exit 1
}
