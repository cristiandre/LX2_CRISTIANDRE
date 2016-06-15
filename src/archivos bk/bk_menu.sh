#!/bin/bash
#!/usr/bin/gnuplot

#rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_csv
#rm /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_graf
 

ORIG=/home/sysadmin/lx2_cristiandre/problema2
DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos

FULL_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=/home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/datos_gra



## ----------------------------------
# Step #1: Define variables
# ----------------------------------

EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
# ----------------------------------
# Step #2: User defined function
# ----------------------------------

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

#----------------------------------
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
set xrange [1:6]
set boxwidth 0.5 relative
set style fill solid 0.5
set xlabel "Mes" 
set ylabel "Pagos x mes"
plot "$F" using 2 with boxes fill title "$b","$C"
EOF
}



#-----------------------------------
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

menu_problema3(){

	echo "menu_problema3() called"

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

# read input from the keyboard and take a action

# invoke the menu_problema2() when the user select 1 from the menu option.

# invoke the menu_problema3() when the user select 2 from the menu option.

# Exit when user the user select 3 form the menu option.

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

