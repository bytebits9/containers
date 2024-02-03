#!/bin/bash

export CA_KEY=${CA_KEY-"/etc/ssl/certs/ca-certificate.key"}
export CA_CERT=${CA_CERT-"/etc/ssl/certs/ca-certificate.pem"}
export CA_SUBJECT=${CA_SUBJECT-"localhost"}
export CA_EXPIRE=${CA_EXPIRE-365}

export SSL_CONFIG=${SSL_CONFIG:-"openssl.cnf"}
export SSL_KEY=${SSL_KEY:-"/etc/ssl/certs/localhost.key"}
export SSL_CSR=${SSL_CSR:-"/etc/ssl/certs/localhost.csr"}
export SSL_CERT=${SSL_CERT:-"/etc/ssl/certs/default.pem"}
export SSL_SIZE=${SSL_SIZE:-"2048"}
export SSL_EXPIRE=${SSL_EXPIRE:-"60"}

export SSL_SUBJECT=${SSL_SUBJECT:-"localhost"}
export SSL_DNS=${SSL_DNS}
export SSL_IP=${SSL_IP}

if [[ ! -e ./${CA_KEY} ]]; then
    openssl genrsa -out ${CA_KEY} 2048
fi

if [[ ! -e ./${CA_CERT} ]]; then
    openssl req -x509 -new -nodes -key ${CA_KEY} -days ${CA_EXPIRE} -out ${CA_CERT} -subj "/CN=${CA_SUBJECT}"  || exit 1
fi

openssl genrsa -out ${SSL_KEY} ${SSL_SIZE}  || exit 1
openssl req -new -key ${SSL_KEY} -out ${SSL_CSR} -subj "/CN=${SSL_SUBJECT}" || exit 1
openssl x509 -req -in ${SSL_CSR} -CA ${CA_CERT} -CAkey ${CA_KEY} -CAcreateserial -out ${SSL_CERT} \
    -days ${SSL_EXPIRE} -extensions v3_req || exit 1