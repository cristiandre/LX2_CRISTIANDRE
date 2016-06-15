#!/bin/bash
#!/usr/bin/gnuplot



rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv
rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf
 

ORIG=/home/sysadmin/lx2_cristiandre/problema2
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos

FULL_DATA=$DATA/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf
# las funciones se deben de declarar arriba sino no las ejecuta
#bash debe de cargarlas en memoria
function graficar
{
F=$FULL_DATA/g.dat
C=$FULL_DATA/plot/grafico.png

gnuplot << EOF 2> error.log
set terminal png
set output "$C"
plot "$F" using 2 with lines title 'Gastos'
EOF
}


#/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/plot
###################################################
###verifico que se borren los directorios antes####
###################################################

#if [ -a $OUT_DATA]
#then 
#sudo -s -Rf $OUT_DATA
#sudo -s rm -Rf $GRAF_DATA
#echo "Borrando directorios $OUT_DATA, $GRAF_DATA, anteriores y se prepara el ambiente"
#fi 2> /home/sysadmin/lx2_cristiandre/logs/errorIf.log

###################################################


mkdir $DATA/datos_csv
mkdir $GRAF_DATA
mkdir $FULL_DATA

set m=1
for i in `find $ORIG #name-$m'*.xls'`
do
echo "Procesando archivo $i"
xls2csv $i > $OUT_DATA/data-$m.csv
let m=m+1
done 2>/home/sysadmin/lx2_cristiandre/logs/error1.log
rm $OUT_DATA/data-.csv


set n=1
for e in `find $OUT_DATA #name-$n'*.csv'`
do
echo "Dando formato de datos para graficar el archivo $e"
pause
#cat $e | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5}'| sed '1,$ s/"//g' | sed '1 s/date/#date/g' > $GRAF_DATA/graf-$m.dat
cat $e | awk -F "\",\"" '{print $1 " " $2}'| sed '1,$ s/"//g' | sed '1d'| sed '11,$d' > $GRAF_DATA/graf-$n.dat
let n=n+1
done 2> /home/sysadmin/lx2_cristiandre/logs/error2.log
rm $GRAF_DATA/graf-.dat


###se borra el archivo full si existe ###
if [ -a $FULL_DATA/full.dat ]
then

rm $FULL_DATA/full.dat

echo "Archivo full.dat borrado"
fi 2> /home/sysadmin/lx2_cristiandre/logs/error_borraFullData.log

####creando el archivo###
for k in `find $GRAF_DATA #name '*.dat'`
do

sed '1d' $k >> $FULL_DATA/full.dat
echo "Procesando archivo $k"
done 2>/home/sysadmin/lx2_cristiandre/logs/error_CreandoFullData.log

################################################################
PS3='Digite el # con la opcion a graficar: '
options=("Agua" "Luz" "Telefono" "Celular" "Internet" "Alquiler" "Aseo" "Cable" "Asociacion" "Salir" )
select opt in "${options[@]}"
do
case $opt in 
     "Agua")
     echo "Generando datos del agua para graficar" 
     awk '/Agua/ { print $0 }' $FULL_DATA/full.dat >$FULL_DATA/g.dat 
     tree $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_agua.log
     graficar
     clear
     ;;
      
    "Luz")
     echo "Generando datos del Luz para graficar" 
     awk '/Luz/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat 
     ls -la $FULL_DATA 
     2> /home/sysadmin/lx2_cristiandre/logs/error_luz.log
     graficar	
     clear
     ;;

    "Telefono")
     echo "Generando datos del Telefono para graficar" 
     awk '/Teléfono/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_telef.log
     graficar
     clear
     ;;
 
    "Celular")
     echo "Generando datos del Celular para graficar" 
     awk '/Celular/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_celul.log
     graficar
     clear
     ;;
     
     "Internet")
     echo "Generando datos del Internet para graficar" 
     awk '/Internet/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_intern.log
     graficar
     clear
     ;;

     "Alquiler")
     echo "Generando datos del Alquiler para graficar" 
     awk '/Alquiler/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_alquil.log
     graficar
     clear 
    ;;

   "Aseo")
     echo "Generando datos del Aseo para graficar" 
     awk '/Aseo/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_aseo.log
     graficar
     clear
     ;;

    "Cable")
     echo "Generando datos del Cable para graficar" 
     awk '/Cable/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_cable.log
     graficar
     clear
     ;;


   "Asociacion")
     echo "Generando datos del Asociacion para graficar" 
     awk '/Asociacion/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_asoc.log
     graficar
     clear
     ;;

    "Salir") 
     clear
     break
     ;;
*) 
echo "La opcion no existe";;
esac
done

#F=$FULL_DATA/g.dat
#C=$FULL_DATA/plot/grafico.png
#reset
#function graficar 
#{
#F=$FULL_DATA/g.dat
#C=$FULL_DATA/plot/grafico.png

#gnuplot << EOF 2> error.log
#set terminal png
#set output "$C"
#plot "$F" using 2 with lines title 'Gastos'
#EOF
#}
#graficar liena comentada en el original no estaba comentada

###este es el final de 

exit 0
#2> /home/sysadmin/lx2_cristiandre/logs/error_plot.log
