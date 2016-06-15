#! /bin/bash

# Limpiamos la pantalla
tput clear
 
# Movemos el cursos a la posición 3,15 en la pantalla (arriba, izquierda = 0,0)
tput cup 3 18
 
# Damos color a las letras
tput setaf 5
echo "OVTOASTER"
tput sgr0

# Movemos el cursor de posición
tput cup 5 17

# Coloca la pantalla en modo de vídeo inverso 
tput rev
echo "MENU PRINCIPAL"
tput sgr0

# Movemos el cursor de posición
tput cup 7 15
echo "1. Primera opcion"

# Movemos el cursor de posición
tput cup 8 15
echo "2. Segunda opcion"
 
# Coloca la pantalla en modo de realce 
tput bold
# Movemos el cursor de posición
tput cup 12 15
read -p "Introduce tu eleccion [1-2] " choice
 
tput clear
tput sgr0
# Coloca el cursor en la posición marcada por el último sc
tput rc
