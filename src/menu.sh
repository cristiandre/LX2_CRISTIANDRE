#!/bin/bash
#!/usr/bin/gnuplot


# ----------------------------------
# Paso #1: Define variables
# ----------------------------------
 

ORIG=/home/sysadmin/lx2_cristiandre/problema2
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos

FULL_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos
OUT_DATA=$DATA/datos_csv
#GRAF_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_gra
GRAF_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf


EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'


# --------------------------------------
# Step #2: Define  funciones de usuario
# --------------------------------------

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

#----------------------------------
# Funciones de grafica problema 2
# ---------------------------------

function graficar ()
{
echo $opt
b="Grafico de Gastos:$opt" 

F=$FULL_DATA/g.dat
C=$FULL_DATA/plot/grafico.png

gnuplot << EOF 2> error.log

gnuplot << EOF 2> error.log
set terminal png
set output "$C"
set grid
set xlabel "Mes" 
set ylabel "Pagos x mes"
plot "$F" using 2 with lines title "$b","$C"
EOF
eog /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/plot/grafico.png
}


#----------------------------------
# Funciones de grafica problema 3
# ---------------------------------

function graficar3 ()
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
eog /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/plot/grafico3.png
}

#----------------------------------
# Menu de opciones problema 2
# ---------------------------------


menu_problema2(){

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

        pause

}
#############################llamado a funciones de problema3###########################3

menu_problema3(){

	#copiar todo el contenido de una carpeta Problema3 a datos_csv
cp -R /home/sysadmin/lx2_cristiandre/problema3/* /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv

echo "Borrando las lineas de encabezados del archivo Data_del problema3"
#sed '1,4d' $DATA/Datos > $GRAF_DATA/graf.dat
sed '1,4d' $OUT_DATA/Datos > $GRAF_DATA/graf.dat
#ls -la $FULL_DATA
2> /home/sysadmin/lx2_cristiandre/logs/error_quitaencabezados3.log

####creando el archivo nuevamente###
echo "Procesando archivo g3_full.dat sin comillas "
cat $GRAF_DATA/graf.dat | awk -F "," '{print $6 " " $7}' | sed '1,$ s/"//g' > $FULL_DATA/g3_full.dat
#ls -la $FULL_DATA
2>/home/sysadmin/lx2_cristiandre/logs/error_Creandog3_full.dat.log


graficar3

pause

}

 

# function to display menu principal

menu_principal() {

	clear

	echo "~~~~~~~~~~~~~~~~~~~~~"	

	echo " M A I N - M E N U"

	echo "~~~~~~~~~~~~~~~~~~~~~"

	echo "1. Problema2"

	echo "2. Problema3"

	echo "3. Exit"

}


read_options(){

	local choice

	read -p "Enter choice [ 1 - 3] " choice

	case $choice in

		1) menu_problema2 ;;

		2) menu_problema3 ;;

		3) exit 0;;

		*) echo -e "${RED}Error...${STD}" && sleep 2

	esac

}

 

# ----------------------------------------------

# Step #3: Trap CTRL+C, CTRL+Z and quit singles

# ----------------------------------------------

trap '' SIGINT SIGQUIT SIGTSTP

 

# -----------------------------------

# Step #4: Main logic - infinite loop

# ------------------------------------

while true

do

 

	menu_principal

	read_options

done

