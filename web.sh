#!/bin/bash
#
#Autor: Yrieh
#
#Data: 15/09/2023
shopt -s -o nounset
#Instalar Servidor Web - Automatização
#CVS $Header$
#
#Declarar Váriaveis
server_root="/var/www/html"
server_port="80"
index_page="index.html"
#Título
echo "Iniciando Servidor Apache"
#Validar permissão de administrador
#Em EUID = 0 = Sudo /=/ Usuário Comum
if [["EUID" -ne 0]]; then
        echo "Necessário permissão elevada"
        sleep 3
        exit 1
fi
#Fazer a atualização dos pacotes do sistema
echo "Atualizando pacotes do sistemas (apt-get)"
apt-get update -y && apt-get upgrade -y
sleep 4
#Validar a existência dos pacotes necessários para a execução do servidor
#Resposta = Servidor Instalado
#S/Resposta = N/Instalado
if ! command -v apache2;then
         echo "O servidor Apache2 não está instalado"
         echo "Instalando o Servidor..."
         apt-get install apache2 -y
       sleep 4
else
         echo "O servidor Apache2 já está instalado!"
fi
#Validar se o dirétório existe
#Se true  diretório inexistente
#Se false diretório já existente
# -p Cria os intermediários para o diretório
if [[ ! -d "$server_root" ]]; then
        echo "Criando diretório do Servidor"
        mkdir -p "$server_root"
fi
#Validar arquivo index.html
#Se true arquivo inexistente
#Se false arquivo existente
if [[ ! "$server_root/$index_page" ]]; then
         echo "Criando a página inicial..."
         sleep 1
         echo "<html><body><h1> Bem-Vindo ao meu servidor WEB! (G_G) </h1></body></html>" > "$server_root/$index_page"
         sleep 3
fi
#Inicialização do servidor Apache2
echo "Iniciando o servidor Apache2 na porta $server_port"
systemctl start apache2
sleep 3
