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
DIR_SSH='/root/.ssh'
DIR_KEYS_SSH='/etc/keys'

clear

# Atualizar os pacotes e instalando o repositorio epel
echo -e "\033[0;32m Passo 1 - Atualizando o sistema e instalando repositorio epel \033[0m"
echo ""
yum update -y ; yum install epel-release -y

clear

echo -e "\033[0;32m Passo 2 - Instalando ansible e git \033[0m"
echo ""
yum install -y git ansible
echo ""

clear

echo -e "\033[0;32m Passo 3 - Ansible instalado version: $(ansible --version |sed -n "1p" |awk '{print $2}') \033[0m"
echo "Aguarde"
sleep 5

cd /opt

echo -e "\033[0;32m Passo 4 - Baixando repositorio remoto \033[0m"
echo ""
git clone https://github.com/cezarfw/impulse.git

cd /opt/impulse


echo -e "\033[0;32m Passo 5 - Configurando SSH \033[0m"
echo ""
mkdir $DIR_SSH
mkdir $DIR_KEYS_SSH
cp -f $PWD/ssh/id_rsa* $DIR_KEYS_SSH/.
cp -f $PWD/ssh/{config,authorized_keys}  $DIR_SSH/.
chmod -R 600 $DIR_KEYS_SSH/.


# Testando se as roles ja estao criadas
if [ -e $DIR_ROLES_ANSIBLE/app ]
then 
	echo -e " \033[0;32m OBS: As roles ja existem, prosseguindo com a execucao do script \033[0m"
        echo ""
else
# Entrando no diretorio das roles e criando as mesmas
	echo -e "\033[0;32m Passo 6 - Criando as respectivas roles do ansible \033[0m"
	echo ""
	( cd $DIR_ROLES_ANSIBLE ; ansible-galaxy init $ROLE_APP ; ansible-galaxy init $ROLE_MAIL ; ansible-galaxy init $ROLE_WEBSERVER )
fi

# Copiando os arquivos do ansible para o respectivo diretorio

echo -e "\033[0;32m Passo 7 - Configurando o ansible \033[0m"
sleep 5
cp -f $PWD/ansible/hosts /etc/ansible/.

mkdir -p $PLAYBOOKS

cp -f $PWD/ansible/playbooks/* $PLAYBOOKS/.

cp -f $PWD/ansible/roles/app/tasks/main.yml $DIR_ROLES_ANSIBLE/$ROLE_APP/tasks/.

cp -f $PWD/ansible/roles/webserver/tasks/main.yml $DIR_ROLES_ANSIBLE/$ROLE_WEBSERVER/tasks/.

cp -f $PWD/ansible/roles/mail/tasks/main.yml $DIR_ROLES_ANSIBLE/$ROLE_MAIL/tasks/.

cp -f $PWD/ansible/roles/app/files/* $DIR_ROLES_ANSIBLE/$ROLE_APP/files/. 

cp -f $PWD/ansible/roles/webserver/files/* $DIR_ROLES_ANSIBLE/$ROLE_WEBSERVER/files/.

cp -f $PWD/nginx/* $DIR_ROLES_ANSIBLE/$ROLE_WEBSERVER/files/.

cp -f $PWD/ssl/* $DIR_ROLES_ANSIBLE/$ROLE_WEBSERVER/files/.

cp -f $PWD/emailconfig/* $DIR_ROLES_ANSIBLE/$ROLE_MAIL/files/.

clear
echo -e "\033[0;32m Iniciando a execucao do playbook ansible \033[0m"
echo ""
ansible-playbook $PLAYBOOKS/main.yml

clear
echo -e "\033[0;32m Provisionamento finalizado, seu servidor esta operacional. \033[0m"

