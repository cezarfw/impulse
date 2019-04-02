#!/bin/bash 

# Script para provisionamento via automacao
#
# Autor: Cezar Augusto Roggia
#
# Data: 29/03/2019
#

DIR_ROLES_ANSIBLE='/etc/ansible/roles'
DIR_ANSIBLE='/etc/ansible'
ROLE_SYSTEM='system_config'
ROLE_APP='app'
ROLE_MAIL='mail'
PLAYBOOKS='/etc/ansible/playbooks'

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
sleep 5

# Entrando no diretorio das roles e criando as mesmas
echo "Criando as respectivas roles do ansible"
echo ""
( cd $DIR_ROLES_ANSIBLE ; ansible-galaxy init $ROLE_SYSTEM ; ansible-galaxy init $ROLE_APP ; ansible-galaxy init $ROLE_MAIL ) 

# Copiando os arquivos do ansible para o respectivo diretorio

echo "Configurando o ansible e alocando os arquivos"
cp -f $PWD/ansible/hosts /etc/ansible/.

mkdir -p $PLAYBOOKS

cp -f $PWD/ansible/playbooks/* $PLAYBOOKS/.

echo ""
echo "Copiando as roles para os respectivos diretorios"

cp -f $PWD/ansible/roles/system_config/tasks/main.yml $DIR_ANSIBLE/$ROLE_SYSTEM/tasks/.

 





