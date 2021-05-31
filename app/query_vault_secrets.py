from sign_vault_request import Generate_Login_Info
import os
import requests

requests.packages.urllib3.disable_warnings()

class Query_Vault():

    @classmethod
    def get_pass(cls):
        vault_response = Generate_Login_Info.generate_vault_request(f"HCPVault")
        vault_response["role"] = "web-app-role"
        auth_url = "https://vault:8200/v1/auth/aws/login"
        kv_url = "https://vault:8200/v1/secret/data/web/SQL"

        auth_request = requests.post(auth_url, vault_response, verify=False)
            
        auth_token = auth_request.json()["auth"]["client_token"]
        kv_headers = {"X-Vault-Token": auth_token}
        kv_request = requests.get(kv_url, headers=kv_headers, verify=False)

        return kv_request.json()["data"]["data"]["password"]