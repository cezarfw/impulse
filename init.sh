#!/bin/bash 

# Script para provisionamento via automacao
#
# Autor: Cezar Augusto Roggia
#
# Data: 29/03/2019
#

DIR_ROLES_ANSIBLE='/etc/ansible/roles'
DIR_ANSIBLE='/etc/ansible'
ROLE_APP='app'
ROLE_WEBSERVER='webserver'
ROLE_MAIL='mail'
PLAYBOOKS='/etc/ansible/playbooks'

clear

# Atualizar os pacotes e instalando o repositorio epel
echo "Atualizando o sistema e instalando repositorio epel"
echo ""
yum update -y ; yum install epel-release -y

clear

# Instalando o ansible e git
echo "Instalando ansible e git"
yum install -y git ansible
echo ""

clear

echo "Ansible instalado version: $(ansible --version |sed -n "1p" |awk '{print $2}')"
echo ""
sleep 5

cd /opt

echo "Baixando repositorio remoto"
git clone https://github.com/cezarfw/impulse.git

cd /opt/impulse

# Testando se as roles ja estao criadas
if [ -e $DIR_ROLES_ANSIBLE/app ]
then 
	echo -e " \033[0;32m As roles ja existem, prosseguindo com a execucao do script \033[0m"
        echo ""
else
# Entrando no diretorio das roles e criando as mesmas
	echo "Criando as respectivas roles do ansible"
	echo ""
	( cd $DIR_ROLES_ANSIBLE ; ansible-galaxy init $ROLE_APP ; ansible-galaxy init $ROLE_MAIL ; ansible-galaxy init $ROLE_WEBSERVER )
fi

# Copiando os arquivos do ansible para o respectivo diretorio

echo "Configurando o ansible"
cp -f $PWD/ansible/hosts /etc/ansible/.

mkdir -p $PLAYBOOKS

cp -f $PWD/ansible/playbooks/* $PLAYBOOKS/.

cp -f $PWD/ansible/roles/app/tasks/main.yml $DIR_ROLES_ANSIBLE/$ROLE_APP/tasks/.

cp -f $PWD/ansible/roles/app/files/* $DIR_ROLES_ANSIBLE/$ROLE_APP/files/. 

cp -f $PWD/ssl/* $DIR_ROLES_ANSIBLE/$ROLE_WEBSERVER/files/.

cp -f $PWD/emailconfig/* $DIR_ROLES_ANSIBLE/$ROLE_MAIL/files/.

clear
echo -e "\033[0;32m Instalacao finalizada, seu servidor esta pronto para operar \033[0m"


