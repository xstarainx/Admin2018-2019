#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433

echo -n "Introduzca una tecla: " 
read -n 1 tecla
echo
case $tecla in
	[[:alpha:]])
		echo "$tecla es una letra";;
	[[:digit:]])
		echo "$tecla es un numero";;
	*)
		echo "$tecla es un caracter especial";;
esac
