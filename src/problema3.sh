#!/bin/bash
#!/usr/bin/gnuplot

#-----------------------------------------------------------------
#declaracion de variables y funciones
#-----------------------------------------------------------------

ORIG=/home/sysadmin/lx2_cristiandre/problema3
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv

FULL_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf

#----------------------------------------------------------------------
#borra los archivos del directorio principal y luego copia 
# el archivo Datos para procesarlo
#----------------------------------------------------------------------

function mover ()
{
#borro lo que los otros programas han dejado por alli, conservo el directorio
find /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv -type f -exec rm {} \;
find /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf -type f -exec rm {} \;
#muevo una copia del Archivo Datos al directorio para procesarlo
find /home/sysadmin/lx2_cristiandre/problema3 -type f -exec cp {} /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv \;

}

#-------------------------------------------------------------------
#grafica el resultado
#-------------------------------------------------------------------
function graficar ()
{

F=$FULL_DATA/g3_full.dat 
C=$FULL_DATA/plot/grafico3.png

FMT_BEGIN='20120316 0000'
FMT_END='20120530 0200'
t1="Ind rad KW/m2 Max"
t2="Ind rad KW/m2 Min"

gnuplot << EOF 2> /home/sysadmin/lx2_cristiandre/logs/errorGeneraGrafico_problema3.log
xdata time
timefmt " %Y %m %d %H %M"
xrange ["$FMT_BEGIN" : "$FMT_END"]
set terminal png
set output "$C"
plot "$F" using 1 with linespoints title "$t1",\
     "$F" using 2 with linespoints title "$t2"
EOF
eog /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/plot/grafico3.png	
}


#----------------------------------------------------------------------------
#borro lo que los otros programas han dejado por alli, conservo el directorio
#----------------------------------------------------------------------------
mover

#---------------------------------------------------------------------
# borra lineas de encabezados del archivo Datos el nuevo archivo se llama
# graf.dat
#---------------------------------------------------------------------
echo "Borrando las lineas de encabezados del archivo Data_del problema3"
sed '1,4d' $DATA/Datos > $GRAF_DATA/graf.dat
ls -la $GRAF_DATA
2> /home/sysadmin/lx2_cristiandre/logs/error_quitaencabezados3.log

#-----------------------------------------------------------------------
# toma el archivo graf.dat y le quita las comillas, toma las col6, col7
# las necesarias para realizaar el grafico. Genera un nuevo archivo
# g3_full.dat
#-----------------------------------------------------------------------

echo "Procesando archivo g3_full.dat sin comillas "
cat $GRAF_DATA/graf.dat | awk -F "," '{print $6 " " $7}' | sed '1,$ s/"//g' > $FULL_DATA/g3_full.dat
ls -la $FULL_DATA
2>/home/sysadmin/lx2_cristiandre/logs/error_Creandog3_full.dat.log

#-----------------------------------------------------------------------
# invoca a la funcion graficar
#-----------------------------------------------------------------------
graficar
 
