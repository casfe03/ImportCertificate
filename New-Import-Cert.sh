#!/bin/bash
#
# Copyright 2016 Felipe Castro <fscastro@hotmail.com.br>
# Uso: import-cert.sh <diretório do JDK>
# Para o funcionamento correto deve ser utilizado uma JDK sem alterações no cacerts
#

declare -A HOSTS
HOSTS["cnj"]=www.cnj.jus.br
HOSTS["correios"]=apps.correios.com.br

	for key in ${!HOSTS[@]}; do
    echo importando ${key} ${HOSTS[${key}]} ...
    openssl s_client -servername ${key} -connect ${HOSTS[${key}]}:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >${key}.pem
	$diff_var="$(diff "cnj.pem" "cnj2.pem")"
    if [ $diff_var = '' ]; then echo "0 ${key} - ${HOSTS[${key}]} - $(date "+%a , dia %d de %b de %Y")"  >> CertificadoIgual.txt
	else echo "1 ${key} - ${HOSTS[${key}]} - $(date "+%a , dia %d de %b de %Y") " >> CertificadoDiferente.txt
fi
done
