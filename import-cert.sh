#!/bin/bash
# 
# Copyright 2016 Felipe Castro <fscastro@hotmail.com.br>
# Uso: import-cert.sh <diretório do JDK>
# Para o funcionamento correto deve ser utilizado uma JDK sem alterações no cacerts
#

declare -A HOSTS
HOSTS["cnj"]=www.cnj.jus.br
HOSTS["correios"]=apps.correios.com.br

JAVA_HOME=$1

if [ $# -eq 0 ]
  then
    echo "É necessário informar o diretório de instalação do java. Exemplo: import-cert.sh /usr/jvm/jdk1.8.0_92"
    exit 0
fi

if [ -e "${JAVA_HOME}/jre/lib/security/cacerts_original" ] ; then
	cp ${JAVA_HOME}/jre/lib/security/cacerts_original ${JAVA_HOME}/jre/lib/security/cacerts
	echo "Substituindo o cacerts atual pelo cacerts_original"
else
	cp ${JAVA_HOME}/jre/lib/security/cacerts ${JAVA_HOME}/jre/lib/security/cacerts_original
	echo "Criando cacerts_original com base no cacerts atual"
fi

for key in ${!HOSTS[@]}; do
    echo importando ${key} ${HOSTS[${key}]} ...
    openssl s_client -servername ${key} -connect ${HOSTS[${key}]}:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >${key}.pem
    ${JAVA_HOME}/bin/keytool -import -alias ${key} -file ${key}.pem -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit
    rm ${key}.pem
done