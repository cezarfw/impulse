#!/bin/bash 

# Script para provisionamento via automacao
#
# Autor: Cezar Augusto Roggia
#
# Data: 29/03/2019
#

clear

# Atualizar os pacotes e instalando o repositorio epel
echo "Atualizando o sistema e instalando repositorio epel"
echo ""
yum update -y ; yum install epel-release -y

clear

# Instalar o ansible
echo "Instalando o ansible, aguarde"
echo ""
yum install -y ansible

clear

echo "Ansible instalado version: $(ansible --version |sed -n "1p" |awk '{print $2}')"
echo ""

# Copiando os arquivos do ansible para o respectivo diretorio

echo "Configurando o ansible e alocando os arquivos"
cp -f $PWD/ansible/hosts /etc/ansible/.
mkdir /etc/ansible/playbooks
cp -f $PWD/ansible/main.yml









