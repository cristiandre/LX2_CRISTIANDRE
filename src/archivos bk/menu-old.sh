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
#funcion para graficar los datos del problema2 Gastos
function graficar ()
{
echo $opt
b="Grafico de Gastos:$opt" 

F=$FULL_DATA/g.dat
C=$FULL_DATA/plot/grafico.png

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
#funcion para graficar los datos del problema3 valores max/min
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
plot "$F" using 1 with linespoints title "Max Kw",\
"$C" using 2 with linespoints title "Min Kw"


EOF
eog /home/sysadmin/lx2_cristiandre/hojasExcel/hojasDatos/full_datos/plot/grafico3.png
}
########################################################################################
#############################llamado a funciones de problema3###########################
#----------------------------------
# Menu de opciones problema 2
# ---------------------------------

_menu_problema2(){
    clear
    echo
    echo "Selecciona una opcion:"
    echo
    echo "1) Graficar Gastos Agua"
    echo "2) Graficar Gastos Luz"
    echo "3) Graficar Gastos Telefono"
    echo "4) Graficar Gastos Celular"
    echo "5) Graficar Gastos Internet"
    echo "6) Graficar Gastos Alquiler"
    echo "7) Graficar Gastos Aseo"
    echo "8) Graficar Gastos Cable"
    echo "9) Graficar Gastos Asociacion"
    echo
    echo "0) Salir"
    echo
    echo -n "Indique una opcion: "
}


# opcion por defecto
opc=" "
 
# bucle mientas la opcion indicada sea diferente de 0 (salir)
until [ "$opc" -eq "0" ];
do
    case $opc in
        1)
            echo "Generando datos del agua para graficar" 
            awk '/Agua/ { print $0 }' $FULL_DATA/full.dat >$FULL_DATA/g.dat 
            #tree $FULL_DATA
            2> /home/sysadmin/lx2_cristiandre/logs/error_agua.log
            $opt=Agua
            graficar $opt 
            _menu_problema2
            ;;
        2)
            echo "Generando datos del Luz para graficar" 
            awk '/Luz/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat 
            #ls -la $FULL_DATA 
            2> /home/sysadmin/lx2_cristiandre/logs/error_luz.log
            $opt="Luz"
            graficar $opt
            clear	
            _menu_problema2
            ;;
        3)
            echo "Generando datos del Telefono para graficar" 
            awk '/Teléfono/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
     	    #ls -la $FULL_DATA
     	    2> /home/sysadmin/lx2_cristiandre/logs/error_telef.log
	    $opt="Teléfono"
            graficar $opt
            clear
            _menu_problema2
            ;;
        4)
           echo "Generando datos del Celular para graficar" 
           awk '/Celular/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
           #ls -la $FULL_DATA
           2> /home/sysadmin/lx2_cristiandre/logs/error_celul.log
	   $opt="Celular"
           graficar $opt
           clear
            _menu_problema2
            ;;
  
      5)
          echo "Generando datos del Internet para graficar" 
          awk '/Internet/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
          #ls -la $FULL_DATA
          2> /home/sysadmin/lx2_cristiandre/logs/error_intern.log
          $opt="Internet"
          graficar $opt
 	  clear	
           _menu_problema2
          ;;
	
      6)
         echo "Generando datos del Alquiler para graficar" 
         awk '/Alquiler/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
         #ls -la $FULL_DATA
         2> /home/sysadmin/lx2_cristiandre/logs/error_alquil.log
         $opt="Alquiler"
         graficar $opt
         clear
         _menu_problema2
        ;;

      7)
         echo "Generando datos del Aseo para graficar" 
         awk '/Aseo/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
         #ls -la $FULL_DATA
         2> /home/sysadmin/lx2_cristiandre/logs/error_aseo.log
         $opt="Aseo"
         graficar $opt
         clear
         _menu_problema2
         ;;   			
		
      8)
         echo "Generando datos del Cable para graficar" 
         awk '/Cable/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
         #ls -la $FULL_DATA
         2> /home/sysadmin/lx2_cristiandre/logs/error_cable.log
         $opt="Cable" 
         graficar $opt
	 clear
         _menu_problema2
          ;;

     9)
        echo "Generando datos del Asociacion para graficar" 
        awk '/Asociacion/ { print $0 }' $FULL_DATA/'full.dat' >$FULL_DATA/g.dat
        #ls -la $FULL_DATA
        2> /home/sysadmin/lx2_cristiandre/logs/error_asoc.log
        $opt="Asociacion" 
        graficar $opt
        clear
        _menu_problema2
            ;;			
			
        *)
            # Esta opcion se ejecuta si no es ninguna de las anteriores
            clear
            _menu_problema2
            ;;
    esac
    read opc
done
########################################################################################
# ----------------------------------------------
menu_problema3(){
# ----------------------------------------------
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
#------------------se invoca la funcion para q grafique--------------
graficar3
pause

}

 
# ----------------------------------------------
# despliega el menu principal
# ----------------------------------------------
menu_principal() {

	clear

	echo "~~~~~~~~~~~~~~~~~~~~~"	

	echo " M A I N - M E N U"

	echo "~~~~~~~~~~~~~~~~~~~~~"

	echo "1. Problema2"

	echo "2. Problema3"

	echo "3. Exit"

}

#lee y valida las opciones que el usuario dad desde el menu principal
read_options(){

	local choice

	read -p "Enter choice [ 1 - 3] " choice

	case $choice in

		1) _menu_problema2 ;;

		2) menu_problema3 ;;

		3) exit 0;;

		*) echo -e "${RED}Error...${STD}" && sleep 2

	esac

}

 

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------

trap '' SIGINT SIGQUIT SIGTSTP

# ----------------------------------------------
#ejecuta un ciclo infinito en el menu principal
# ----------------------------------------------
while true

do

 

	menu_principal

	read_options

done



