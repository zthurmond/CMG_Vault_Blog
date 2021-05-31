#!/bin/bash

# Create the certificate request
sudo openssl req -new -sha256 -subj "/CN=vault" -addext 'subjectAltName=DNS:vault,DNS:127.0.0.1' -key /etc/ssl/rootCA.key -out certs/vault.csr

# Create the server certificate with the request
sudo openssl x509 -req -in certs/vault.csr -CA /etc/ssl/rootCA.crt -CAkey /etc/ssl/rootCA.key -CAcreateserial -out certs/vault.crt -days 1825 -sha256

# Decrypt the root key out to a new file to be used with the server certificate
sudo openssl rsa -in /etc/ssl/rootCA.key -out certs/vault.key
