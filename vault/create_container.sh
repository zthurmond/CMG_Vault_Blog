#!/bin/bash

# Build the Docker image and name it hcp_vault
sudo docker build -t hcp_vault .

# Create a network so that the Vault can resolve it's hostname via the container name
sudo docker network create vault_net

# Run the HCP Vault image opening port 8200 and 8201 with the config that was in the GitHub repo
# Additionally, always restart the container and mount the file directory that will store the HCP Vault data
sudo docker run --name=vault --network=vault_net --restart=always --cap-add=IPC_LOCK -d -e "VAULT_ADDR=https://vault:8200" -p 8200:8200 -p 8201:8201 -v $PWD/file:/vault/file hcp_vault server -config /vault/config/vault_config.json
