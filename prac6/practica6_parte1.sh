#!/bin/bash

#Guillermo Cruz Rojas	682433
#Miguel Gomez Lahera	741302

if [ $# != 1 ]
then
	echo "Numero de parametros incorrectos"
	exit 1
fi

ip=$1

ping -c2 $ip >/dev/null 2>&1

if [ $? != 0 ]
then
	echo "La maquina con la ip $ip no es alcanzable"
	exit 2
fi

uptime | cut -d "," -f2,3,4,5 | logger -p local0.info
free -h | awk '{print $1 "\t" $2 "\t" $3 "\t" $4}' | logger -p local0.info
df -h | awk '{print $1 "\t" $2 "\t" $3}' | logger -p local0.info
netstat | awk 'BEGIN { x=0 } /CONNECTED/ {x=x+1} END { print "Conexiones: ", x } END {print "Puertos abiertos: " NR-4}' | logger -p local0.info
ps -e --user as | awk 'END {print "Procesos:\t" NR-1}' | logger -p local0.info

#Con esto hacemos logger de la segunda maquina desde ssh
ssh as@$ip uptime | cut -d "," -f2,3,4,5 | logger -p local0.info
ssh as@$ip free -h | awk '{print $1 "\t" $2 "\t" $3 "\t" $4}' | logger -p local0.info
ssh as@$ip df -h | awk '{print $1 "\t" $2 "\t" $3}' | logger -p local0.info
ssh as@$ip netstat | awk 'BEGIN { x=0 } /CONNECTED/ {x=x+1} END { print "Conexiones: ", x } END {print "Puertos abiertos: " NR-4}' | logger -p local0.info
ssh as@$ip ps -e --user as | awk 'END {print "Procesos:\t" NR-1}' | logger -p local0.info

#en uptime, loadaverage saca 3 numeros y son: load average ultimo minuto, el de los ultimos 5 minutos, y el de los ultimos 15 minutos