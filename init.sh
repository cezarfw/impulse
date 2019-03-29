#!/bin/bash 

# Script para provisionamento via automacao
#
# Autor: Cezar Augusto Roggia
#
# Data: 29/03/2019
#

clean

# Atualizar os pacotes e instalando o repositorio epel
echo "Atualizando o sistema e instalando repositorio epel"
echo ""
yum update -y ; yum install epel-release -y

# Instalar o ansible
echo "Instalando o ansible, aguarde"
echo ""
yum install ansible

