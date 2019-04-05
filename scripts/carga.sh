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
export CONT_USUARIOS=10



while [ $? != 24 ]
do
CONT_REQUISICOES=$(( CONT_REQUISICOES+70000 ))
CONT_USUARIOS=$(( CONT_USUARIOS+10 ))
export CALC=`expr $CONT_REQUISICOES / $CONT_USUARIOS`
echo "Testando com $CONT_REQUISICOES requisições e $CONT_USUARIOS usuários, isso dá em média $CALC requisições por usuário!"
ab -n $CONT_REQUISICOES -c $CONT_USUARIOS -q -H "Accept-Encoding: gzip, deflate" http://localhost:80/opt/app/app.js
done

echo "O teste de carga realizado mostrou que a aplicãção respondeu até $CONT_REQUISICOES requisições de $CONT_USUARIOS simultâneos."


export CALC1=`expr $CONT_REQUISICOES / $CONT_USUARIOS`

echo "Isso dá um total de $CONT_REQUISICOES requisições oriundos de $CONT_USUARIOS usuários, são $CALC1 requisições por usuário"
