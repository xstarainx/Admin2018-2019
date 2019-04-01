#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433


if [ $# -eq 1 ]
then
	if [ -f "$1" ]
	then
		chmod ug+x "$1"		#Otorga permisos de ejecucion a usuario y grupo
		stat -c %A "$1"
	else
		echo "$1 no existe"
	fi	
else
	echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi	
