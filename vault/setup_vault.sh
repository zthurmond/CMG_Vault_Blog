#!/bin/bash

# Inbitialize the vault and save the response
init=$(curl --request POST --insecure --data '{"secret_shares": 1, "secret_threshold": 1}' https://127.0.0.1:8200/v1/sys/init | jq)

# Parse the previous response for the Unseal key
keys=$(echo "$init" | jq '.keys_base64[0]')

# Parse the response for the root token
token=$(echo "$init" | jq -r '.root_token')

# Unseal the vault with the unseal key
curl --request POST --insecure --data "{\"key\": $keys}" "https://127.0.0.1:8200/v1/sys/unseal" | jq

# Enable AWS authentication
curl -X POST -H "X-Vault-Token:$token" --insecure "https://127.0.0.1:8200/v1/sys/auth/aws" -d '{"type":"aws"}'

# Enable the Key/Value secrets engine at the /secret path
curl -X POST -H "X-Vault-Token:$token" --insecure "https://127.0.0.1:8200/v1/sys/mounts/secret" -d '{"type":"kv-v2"}'

# Output the root token and unseal key as they need to be saved somewehere
echo "Root Token: $token"
echo "Unseal Key: $keys"
