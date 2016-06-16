#!/bin/bash
#!/usr/bin/gnuplot

#rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv
#rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf

#----------------------------------------------------------------
#definicion de variables y funciones
#---------------------------------------------------------------- 

ORIG=/home/sysadmin/lx2_cristiandre/problema2
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos
FULL_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf

#----------------------------------------------------------------
# las funciones se deben de declarar arriba sino no las ejecuta
#bash debe de cargarlas en memoria
#----------------------------------------------------------------
function graficar ()
{
echo $opt
b="Grafico de Gastos:$opt" 
F=$FULL_DATA/g.dat
C=$FULL_DATA/plot/grafico.png
#plot 'avg_max_min.csv' every ::2 using 1:2 with boxes  con esta linea puedo decirle a plot que grafique desde la linea 2
gnuplot << EOF 2>/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/error_GraficandoGastos_$opt.log
set terminal png
set output "$C"
set grid
set auto x
set xtic scale 0
set boxwidth 0.5 relative
set style fill solid 0.5
set xlabel "Mes" 
set ylabel "Pagos x mes"
plot "$F" using 2 with boxes fill title "$b","$C"
EOF
eog /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/plot/grafico.png

}

#----------------------------------------------------------------------------
#borro lo que los otros programas han dejado por alli, conservo el directorio
#----------------------------------------------------------------------------
find /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv -type f -exec rm {} \;
find /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf -type f -exec rm {} \;


#---------------------------------------------------------------------------
# se recorre cada archivo *.xls y se convierte en un archivo *.csv
#---------------------------------------------------------------------------
set m=1
for i in `find $ORIG #name-$m'*.xls'`
do
echo "Procesando archivo $i"
xls2csv $i > $OUT_DATA/data-$m.csv
let m=m+1
done 2>/home/sysadmin/lx2_cristiandre/logs/error_ConvertXLS_CSV_problema2.log
rm $OUT_DATA/data-.csv 

#---------------------------------------------------------------------------
# se recorre cada archivo *.csv y se convierte en un archivo *.dat
# de una vez se aprovecha y se filtran las col1,col2 con los datos necesarios
# se reemplazan las " por nada
#---------------------------------------------------------------------------

set n=0
for e in `find $OUT_DATA #data-$n'*.csv'`
do
echo "Dando formato de datos para graficar el archivo $e"
cat $e | awk -F "\",\"" '{print $1 " " $2}'| sed '1,$ s/"//g' | sed '1d'| sed '11,$d' > $GRAF_DATA/graf-$n.dat
let n=n+1
done 2> /home/sysadmin/lx2_cristiandre/logs/error_GenerandoCSV_problema2.log
rm $GRAF_DATA/graf-.dat

#---------------------------------------------------------------------------
#se borra el archivo full si existe, se hace esto porque el mismo se arma
# con las lecturas sucesivas a los *.dat adjuntando los datos por >>
#---------------------------------------------------------------------------
if [ -a $FULL_DATA/full.dat ]
then
   rm $FULL_DATA/full.dat
   echo "Archivo full.dat borrado"
   fi 2> /home/sysadmin/lx2_cristiandre/logs/error_BorraFullDataProblema2.log

#---------------------------------------------------------------------------
#creando el archivo full.dat contiene la informacion de todos los gastos
#mezclados.
#---------------------------------------------------------------------------
for k in `find $GRAF_DATA #name '*.dat'`
do
sed '1d' $k >> $FULL_DATA/full.dat
echo "Procesando archivo $k"
done 2>/home/sysadmin/lx2_cristiandre/logs/error_CreandoFullDataProblema2.log
clear


#--------------------------------------------------------------------------
#entra al menu de opciones para que el usuario escoja el gasto
# a graficar si para el mismo existen montos en el archivo generado
#filtra el archivo full.dat y extrae el dato que el usuario quiere generar en
#grafico
#---------------------------------------------------------------------------

PS3='Digite el # con la opcion a graficar: '
options=("Agua" "Luz" "Telefono" "Celular" "Internet" "Alquiler" "Aseo" "Cable" "Asociacion" "Salir" )
select opt in "${options[@]}"
do
case $opt in 
     "Agua")
     echo "Generando datos del agua para graficar" 
     awk '/Agua/ { print $0 }' $FULL_DATA/full.dat >$FULL_DATA/g.dat 
     #tree $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_agua.log
     graficar $opt
     #clear
     ;;
      
    "Luz")
     echo "Generando datos del Luz para graficar" 
     awk '/Luz/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat 
     #ls -la $FULL_DATA 
     2> /home/sysadmin/lx2_cristiandre/logs/error_luz.log
     graficar $opt	
     ;;

    "Telefono")
     echo "Generando datos del Telefono para graficar" 
     awk '/Teléfono/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_telef.log
     graficar $opt
     ;;
 
    "Celular")
     echo "Generando datos del Celular para graficar" 
     awk '/Celular/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_celul.log
     graficar $opt
     ;;
     
     "Internet")
     echo "Generando datos del Internet para graficar" 
     awk '/Internet/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_intern.log
     graficar $opt
     ;;

     "Alquiler")
     echo "Generando datos del Alquiler para graficar" 
     awk '/Alquiler/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_alquil.log
     graficar $opt
    ;;

   "Aseo")
     echo "Generando datos del Aseo para graficar" 
     awk '/Aseo/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_aseo.log
     graficar $opt
     ;;

    "Cable")
     echo "Generando datos del Cable para graficar" 
     awk '/Cable/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_cable.log
     graficar $opt
     ;;


   "Asociacion")
     echo "Generando datos del Asociacion para graficar" 
     awk '/Asociacion/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     #ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_asoc.log
     graficar $opt
     ;;

    "Salir") 
     clear
     break
     ;;
*) 
echo "La opcion no existe";;
esac
done 

exit 0

