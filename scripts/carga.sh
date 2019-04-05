#!/bin/bash

# Autor: Cezar Augusto Roggia
# E-mail: cezarfw@gmail.com
#
#
# Data: 29/03/2019
#
#
#============================================================================================



export CONT_REQUISICOES=10000
export CONT_USUARIOS=30



while [ $? != 24 ]
do
CONT_REQUISICOES=$(( CONT_REQUISICOES+200000 ))
CONT_USUARIOS=$(( CONT_USUARIOS+20 ))
export CALC=`expr $CONT_REQUISICOES / $CONT_USUARIOS`
<<<<<<< HEAD
echo "Testando com $CONT_REQUISICOES requisições e $CONT_USUARIOS usuários, isso dá em média $CALC requisições por usuário!"
=======
echo "Testando com $CONT_REQUISICOES requisicoes e $CONT_USUARIOS usuarios, isso da em media $CALC requisicoes por usuario!"
>>>>>>> b22d5b97232f58217c4a67e9927e82eb5dd11061
ab -n $CONT_REQUISICOES -c $CONT_USUARIOS -q -H "Accept-Encoding: gzip, deflate" http://localhost:80/opt/app/app.js
done

echo "O teste de carga realizado mostrou que a aplicacao respondeu $CONT_REQUISICOES requisicoes de $CONT_USUARIOS simultaneos."


export CALC1=`expr $CONT_REQUISICOES / $CONT_USUARIOS`

echo "Isso da um total de $CONT_REQUISICOES requisicoes oriundos de $CONT_USUARIOS usuarios, sao $CALC1 requisicoes por usuario"
