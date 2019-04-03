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

# Testando se as roles ja estao criadas
if [ -e $DIR_ROLES_ANSIBLE ]
then 
	echo -e " \033[0;32m As roles ja existem, prosseguindo com a execucao do script \033[0m"
        echo ""
else
# Entrando no diretorio das roles e criando as mesmas
	echo "Criando as respectivas roles do ansible"
	echo ""
	( cd $DIR_ROLES_ANSIBLE ; ansible-galaxy init $ROLE_SYSTEM ; ansible-galaxy init $ROLE_APP ; ansible-galaxy init $ROLE_MAIL )fi

# Copiando os arquivos do ansible para o respectivo diretorio

echo "Configurando o ansible"
cp -f $PWD/ansible/hosts /etc/ansible/.

mkdir -p $PLAYBOOKS

cp -f $PWD/ansible/playbooks/* $PLAYBOOKS/.

cp -f $PWD/ansible/roles/system_config/tasks/main.yml $DIR_ROLES_ANSIBLE/$ROLE_SYSTEM/tasks/.

cp -f $PWD/ansible/roles/app/files/* $DIR_ROLES_ANSIBLE/$ROLE_APP/files/. 

clear
echo -e "\033[0;32m Instalacao finalizada, seu servidor esta pronto para operar \033[0m"


