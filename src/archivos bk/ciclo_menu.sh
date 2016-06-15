#!/bin/bash
#item es una variable que responde a lo que el 
#usuario elige, Continuar y Finalizar son las 
#opciones que tiene disponible, aunque pueden ser 
#agregadas otras más

select item in Continuar Finalizar
do
#Si el usuario elige finalizar el programa, entonces con break salimos del ciclo.
    if [ $item = "Finalizar" ]; then
        break
    fi
	done
