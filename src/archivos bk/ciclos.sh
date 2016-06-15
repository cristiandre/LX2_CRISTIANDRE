#!/bin/bash

###evalua distintos tipos de parametros
#recibe 3 parametros como maximo; de lo contrario devulve error

ARGS=3
#-ne not equal
# es el archivo q estoy ejecutando
# si los parametros no son tres le indica q no son tres
if [ $# -ne "$ARGS" ]
then 
echo "basename $0' <op1> <op2> <op3>"
exit 1
fi



#tira los parametros que recibio
VAR1=1
for param in "$@"; do
    echo "el parametro" $VAR es $param
    let "VAR1=$VAR+1"
done




