#!/bin/bash
#!/usr/bin/gnuplot
rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv
rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf
 

ORIG=/home/sysadmin/lx2_cristiandre/problema2
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos

FULL_DATA=$DATA/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf
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

##esta parte filtra los datos para alimentar el grafico####
echo "#########################################################"
echo -n "############digite el valor a graficar################"
echo
echo '1. Agua -Grafica gastos de Agua'
echo '2. Luz -Grafica gastos de Luz'
echo '3. Telefono -Grafica gastos de Teléfono'
echo '4. Celular -Grafica gastos de Celular'
echo '5. Internet -Grafica gastos de Internet'
echo '6. Alquiler -Grafica gastos de Alquiler'
echo '7. Aseo -Grafica gastos de Aseo'
echo '8. Cable -Grafica gastos de Cable'
echo '9. Asociacion -Grafica gastos de Asociación'
echo '0 -Salir'

###espero la respuesta##
#select item in Continuar Finalizar
#do
#Si el usuario elige finalizar el programa, entonces con break salimos del ciclo.
 #   if [ $item = "Finalizar" ]; then
  #      break
   # fi
#done


echo "Respuesta: " 
read x
case $x in 
     '1')
     echo "Generando datos del agua para graficar" 
     awk '/Agua/ { print $0 }' $FULL_DATA/full.dat >$FULL_DATA/g.dat 
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_agua.log
     F=$FULL_DATA/g.dat
     ;;
      
    '2')
     echo "Generando datos del Luz para graficar" 
     awk '/Luz/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat 
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_luz.log
     ;;

    '3')
     echo "Generando datos del Telefono para graficar" 
     awk '/Teléfono/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_telef.log
     ;;
 
    '4')
     echo "Generando datos del Celular para graficar" 
     awk '/Celular/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_celul.log
     ;;
     
     '5')
     echo "Generando datos del Internet para graficar" 
     awk '/Internet/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_intern.log
     ;;

     '6')
     echo "Generando datos del Alquiler para graficar" 
     awk '/Alquiler/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_alquil.log
     ;;

   '7')
     echo "Generando datos del Aseo para graficar" 
     awk '/Aseo/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_aseo.log
     ;;


    '8')
     echo "Generando datos del Cable para graficar" 
     awk '/Cable/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_cable.log
     ;;


   '9')
     echo "Generando datos del Asociacion para graficar" 
     awk '/Asociacion/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     ls -la $FULL_DATA
     2> /home/sysadmin/lx2_cristiandre/logs/error_asoc.log
     ;;

    '0')
     echo "SALIENDO" 
     exit
     ;;

*) 
echo "la opcion $x no existe"
esac
F=$FULL_DATA/g.dat
C=$FULL_DATA/plot/grafico.png
#reset
graficar() 
{
gnuplot << EOF 2> error.log
set terminal png
set output "$C"
plot "$F" using 2 with lines title 'Gastos'
EOF
}
graficar
#EOF
exit 0
#2> /home/sysadmin/lx2_cristiandre/logs/error_plot.log
