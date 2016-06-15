#!/bin/bash
#!/usr/bin/gnuplot

ORIG=/home/sysadmin/lx2_cristiandre/problema3
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv

FULL_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf


# las funciones se deben de declarar arriba sino no las ejecuta
#bash debe de cargarlas en memoria

function mover ()
{
echo $ORIG
for file in '$ORIG  -d *' ; do
   find . -name *.* -mtime -10 -exec cp $"file" $DATA {} ;
echo'seguimos moviendo archivos Datos'
done

}


function graficar ()
{

F=$FULL_DATA/g3_full.dat 
C=$FULL_DATA/plot/grafico3.png

FMT_BEGIN='20120316 0000'
FMT_END='20120530 0200'
t1="Indice de radiacion KW/m2 Max"
t2="Indice de radiacion KW/m2 Max"

gnuplot << EOF 2> error.log
xdata time
timefmt " %Y %m %d %H %M"
xrange ["$FMT_BEGIN" : "$FMT_END"]
set terminal png
set output "$C"
plot "$F" using 1 with linespoints title "$t1",
"$C" using 2 with linespoints title "$t2"

EOF
}


#mkdir $DATA
#mkdir $GRAF_DATA
#mkdir $FULL_DATA
#mover
#copiar todo el contenido de una carpeta Problema3 a datos_csv
cp -R /home/sysadmin/lx2_cristiandre/problema3/* /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv

echo "Borrando las lineas de encabezados del archivo Data_del problema3"
sed '1,4d' $DATA/Datos > $GRAF_DATA/graf.dat
ls -la $GRAF_DATA
2> /home/sysadmin/lx2_cristiandre/logs/error_quitaencabezados3.log

####creando el archivo nuevamente###
echo "Procesando archivo g3_full.dat sin comillas "
cat $GRAF_DATA/graf.dat | awk -F "," '{print $6 " " $7}' | sed '1,$ s/"//g' > $FULL_DATA/g3_full.dat
ls -la $FULL_DATA
2>/home/sysadmin/lx2_cristiandre/logs/error_Creandog3_full.dat.log


graficar
 
