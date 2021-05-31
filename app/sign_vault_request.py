import botocore.session
import json
import base64

class Generate_Login_Info():
    
    @classmethod
    def format_dict(cls, headers):
        retval = {}
        for k, v in headers.items():
            if isinstance(v, (bytes, bytearray)):
                retval[k] = v.decode('utf-8')
            else:
                retval[k] = v
        return retval

    @classmethod
    def generate_vault_request(cls, awsIamServerId):
        session = botocore.session.get_session()
        client = session.create_client('sts')
        endpoint = client._endpoint
        operation_model = client._service_model.operation_model('GetCallerIdentity')
        request_dict = client._convert_to_request_dict({}, operation_model)
        request_dict['headers']['X-Vault-AWS-IAM-Server-ID'] = awsIamServerId
        request = endpoint.create_request(request_dict, operation_model)
        headers = json.dumps(cls.format_dict(dict(request.headers)))
        
        data = {
            'iam_http_request_method': request.method,
            'iam_request_url':         base64.b64encode(request.url.encode()),
            'iam_request_body':        base64.b64encode(request.body.encode()),
            'iam_request_headers':     base64.b64encode(headers.encode()), 
        }
        
        return cls.format_dict(data)