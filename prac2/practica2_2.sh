#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433

for i in "$@"
do
	if [ -f "${i}" ] #Comprueba si es un fichero
	then
		more "${i}"
	else
		echo "${i} no es un fichero"
	fi
done
