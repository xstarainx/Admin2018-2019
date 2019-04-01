#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433

echo -n "Introduzca el nombre de un directorio: " #-n para que no salte de linea al escribir
read directorio

#En el if compruebas que el nombre exista y que ademas sea un directorio
if [ -d "$directorio" ]
then
	#ahora en numFiles y numDirs guardas el numero de archivos y directorios respectivamente
	numFiles=$(find "$directorio" -type f | wc -l)
	numDirs=$(find "$directorio" -type d | wc -l)
	numDirs=$(($numDirs-1)) #es necesario restar uno, pq si esta vacio, saldria 1 si no le restamos, pues cuenta el dir actual (".")
	echo "El numero de ficheros y directorios en $directorio es de $numFiles y $numDirs, respectivamente"
else
	echo "$directorio no es un directorio"
fi
