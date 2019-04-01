#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433

echo -n "Introduzca el nombre del fichero: "
read nombre

#Comprobar si existe el fichero
if [ -f "$nombre" ]  
then
	echo -n "Los permisos del archivo $nombre son: "
	ls -l "$nombre" | cut -c 2-4 #Muestra solo los permisos
else
	echo "$nombre no existe"
fi
