#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433

#Guarda en num el numero de ficheros que se corresponden con "binXXX"
num=`find $HOME -type d -name "bin???" | wc -l`
if [ $num == 0 ]
then
	temporal=`mktemp -d $HOME/binXXX`		#Caso de que tenga que crear uno
	echo "Se ha creado el directorio $temporal"
else
	#Caso de que ya exista alguno, coge el nombre del mas viejo
	temporal=`stat -c "%Y %n" $HOME/bin??? | sort -n | head -n 1 | cut -d " " -f 2`
fi
count=0
echo "Directorio destino de copia: $temporal"
for i in ./*
do
	if [ -x "$i" -a -f "$i" ] #Si es un fichero ejecutable lo copia al directorio destino
	then
		cp "$i" $temporal
		echo ""$i" ha sido copiado a "$temporal""
		let "count+=1"	#Incrementa la variable de archivos copiados
	fi
done

if [ $count -eq 0 ]
then
	echo "No se ha copiado ningun archivo"
else
	echo "Se han copiado $count archivos"
fi
