#!/bin/sh

set -e

# Creation of Root Certificate Authority
openssl genrsa \
  -out root-ca.key.pem \
  2048

openssl req \
  -x509 \
  -new \
  -nodes \
  -key root-ca.key.pem \
  -days 9999 \
  -out root-ca.crt.pem \
  -subj "/C=US/ST=Utah/L=Provo/O=ACME Signing Authority Inc/CN=example.com"

openssl genrsa \
  -out privkey.pem \
  2048

openssl req -new \
  -key privkey.pem \
  -out device-csr.pem \
  -subj "/C=US/ST=Utah/L=Provo/O=ACME Tech Inc/CN=my.example.com"

openssl x509 \
  -req -in device-csr.pem \
  -CA root-ca.crt.pem \
  -CAkey root-ca.key.pem \
  -CAcreateserial \
  -out cert.pem \
  -days 9999

cat cert.pem root-ca.crt.pem > fullchain.pem
