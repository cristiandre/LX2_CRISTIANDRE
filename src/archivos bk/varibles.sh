#!/bin/bash

echo" SOY $USER, mi userid: $UID, en la estacion $HOSTNAME"
echo""
#echo"Redireccionamiento de Cristian" >> ./logs/milog_varibles.error
 

echo"############### USUARIOS ###############"
who
echo""
cd Docs 2>> ../error/error_$USER

echo""
echo"########### Espacio en Disco #########"
df -lh

echo""
echo"######### Conexiones activas ##########"
netstat -ltuna | grep EST

echo""
echo"########### Puertos #####################"
nmap localhost
 
2> /home/sysadmin/lx2_cristiandre/logs/error_varibles.log
