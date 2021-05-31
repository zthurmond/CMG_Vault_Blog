FROM vault:latest

WORKDIR /

#add the cert files
COPY certs/vault.key /etc/ssl/vault.key
COPY certs/vault.crt /etc/ssl/vault.crt

#add the config file
COPY config/vault_config.json /vault/config/

#expose port 8200
EXPOSE 8200

#run vault
ENTRYPOINT ["vault"]