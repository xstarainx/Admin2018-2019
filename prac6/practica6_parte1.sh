#!/bin/bash

#Guillermo Cruz Rojas	682433
#Miguel Gomez Lahera	741302

ruta="~/.ssh/id_as_ed25519"
ip=192.168.56.2

ping -c2 $ip >/dev/null 2>&1

if [ $? != 0 ]
then
	echo "La maquina con la ip $ip no es alcanzable" | logger -p local0.info
	exit 2
fi

echo "uptime0 > " | logger -p local0.info
uptime | cut -d "," -f2,3,4,5 | logger -p local0.info
echo "free > " | logger -p local0.info
free -h  |sed 's/ \{1,\}/ /g' |grep "Mem"| cut -d ' ' -f 3,4 | logger -p local0.info
echo "swap > " | logger -p local0.info
free -h  |sed 's/ \{1,\}/ /g' |grep "Swap"| cut -d ' ' -f 3 | logger -p local0.info
echo "df > " | logger -p local0.info
df -h --total | grep "total" | sed 's/ \{1,\}/ /g' | cut -d ' ' -f 3,4 | logger -p local0.info
netstat | awk 'BEGIN { x=0 } /CONNECTED/ {x=x+1} END { print "Conexiones: ", x } END {print "Puertos abiertos: " NR-4}' | logger -p local0.info
ps -e --user "$USER" | awk 'END {print "Procesos: " NR-1}' | logger -p local0.info

#Con esto hacemos logger de la segunda maquina desde ssh
echo "uptime0 maquina $ip > " | logger -p local0.info
ssh -n -i "$ruta" as@$ip uptime | cut -d "," -f2,3,4,5 | logger -p local0.info
echo "free maquina $ip > " | logger -p local0.info
ssh -n -i "$ruta" as@$ip free -h  |sed 's/ \{1,\}/ /g' |grep "Mem"| cut -d ' ' -f 3,4 | logger -p local0.info
echo "swap maquina $ip > " | logger -p local0.info
ssh -n -i "$ruta" as@$ip free -h  | sed 's/ \{1,\}/ /g' |grep "Swap"| cut -d ' ' -f 3 | logger -p local0.info
echo "df maquina $ip > " | logger -p local0.info
ssh -n -i "$ruta" as@$ip df -h --total | grep "total" | sed 's/ \{1,\}/ /g' | cut -d ' ' -f 3,4 | logger -p local0.info
ssh -n -i "$ruta" as@$ip netstat | awk 'BEGIN { x=0 } /CONNECTED/ {x=x+1} END { print "Conexiones de 192.168.56.2: ", x } END {print "Puertos abiertos de 192.168.56.2: " NR-4}' | logger -p local0.info
ssh -n -i "$ruta" as@$ip ps -e --user as | awk 'END {print "Procesos de 192.168.56.2: " NR-1}' | logger -p local0.info

#en uptime, loadaverage saca 3 numeros y son: load average ultimo minuto, el de los ultimos 5 minutos, y el de los ultimos 15 minutos
