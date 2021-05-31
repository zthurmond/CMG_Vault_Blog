#!/bin/bash

# Generate the Root Key
sudo openssl genrsa -des3 -out /etc/ssl/rootCA.key 4096

# Generate the Root Certificate in the current directory
sudo openssl req -x509 -new -nodes -key /etc/ssl/rootCA.key -sha256 -days 7300 -out /etc/ssl/rootCA.crt
