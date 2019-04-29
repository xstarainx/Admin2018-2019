#!/bin/bash
#Miguel Gomez Lahera	741302
#Guillermo Cruz Rojas	682433

anyadir() {
	IFS=', '
	while read user pass nameCom
	do
		if id -u "$user" >/dev/null 2>&1
		then
			echo "El usuario $user ya existe"
		else 
			if [ -z $user ] || [ -z $pass ] || [ -z $nameCom ]
			then
				echo "Campo invalido"
				exit 2
			else
				useradd "$user" -c COMMENT="$nameCom" -m -U -K UID_MIN=1815 -K PASS_MAX_DAYS=30 -k /etc/skel
				echo "$user:$pass" | chpasswd 
				echo "$nameCom" ha sido creado
			fi
		fi
	done < "$1"
}

borrar() {
	IFS=', '
	mkdir -p /extra/backup
	while read user ignore
	do
		if id -u "$user" >/dev/null 2>&1
		then
			usermod -L "$user"
			direc=$(grep "$user" /etc/passwd | cut -d':' -f 6)
			tar -cf "/extra/backup/$user.tar" -C "$direc" . 
			if [ $? -eq 0 ]
			then
				userdel -r "$user" 2>/dev/null
			fi
		fi
	done < "$1"
}


if [ $UID != 0 ]
then
	echo "Este script necesita privilegios de administracion"
	exit 1
fi
if [ "$1" != "-a" ] && [ "$1" != "-s" ]
then
	>&2 echo "Opcion invalida"
	exit 1
fi
if [ $# != 2 ]
then
	echo "Numero incorrecto de parametros"
	exit 2
fi

fich="$2"
if [ "$1" == "-a" ]	#anyadir
then
	anyadir "$fich"
	
elif [ "$1" == "-s" ]	#borrar
then	
	borrar "$fich"
fi
