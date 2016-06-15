#!bin/bash

### programa para graficar el problema3
# se debede convertir el archivos Datos a .out
#luego se debe de convertir a .csv

ORIG=/home/sysadmin/lx2_cristiandre/problema3
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf/graf.dat

FULL_DATA=$DATA/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf


# las funciones se deben de declarar arriba sino no las ejecuta
#bash debe de cargarlas en memoria
plot "/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/g3.dat" using 1:2 with lines
function graficar ()
{
echo $opt
b="Grafico de valores Kw>$opt" 

F=$FULL_DATA/g3.dat
C=$FULL_DATA/plot/grafico3.png

gnuplot << EOF 2> error.log
set terminal png
set output "$C"
set xlabel "Valores min y max de Kw" 
set ylabel "mes"
plot "$F" using 2 with lines title "$b" 
EOF
}


mkdir $DATA/datos_csv
mkdir $GRAF_DATA
mkdir $FULL_DATA

echo "Borrando las lineas de encabezados del archivo Data_problema3"
pause
sed '1,4d' -i /home/sysadmin/lx2_cristiandre/problema3/Datos >/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf/graf.dat
done 2> /home/sysadmin/lx2_cristiandre/logs/error_quitaencabezados3.log
rm $GRAF_DATA/graf.dat ##revisar esta linea


###se borra el archivo full si existe ###
if [ -a $FULL_DATA/g3_full.dat]
then

rm $FULL_DATA/g3_full.dat

echo "Archivo g3_full.dat borrado"
fi 2> /home/sysadmin/lx2_cristiandre/logs/error_borraFull3Data.log

####creando el archivo###

cat /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf/graf.dat  | awk -F "," '{print $6 " " $7}' | sed '1,$ s/"//g' > /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/g3_full.dat

echo "Procesando archivo g3_full.dat"
done 2>/home/sysadmin/lx2_cristiandre/logs/error_Creandog3_full.dat.log
clear



