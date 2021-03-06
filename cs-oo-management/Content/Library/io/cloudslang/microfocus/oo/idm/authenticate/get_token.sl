########################################################################################################################
#!!
#! @description: Receives the authentication token from IDM service.
#!
#! @input generate_HPSSO: Set to true when when HPSSO required (stored in cookies); necessary to authenticate to Designer
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.idm.authenticate
flow:
  name: get_token
  inputs:
    - generate_HPSSO:
        default: 'false'
        required: false
    - oo_username:
        required: false
    - oo_password:
        required: false
        sensitive: true
    - idm_tenant:
        required: false
  workflow:
    - http_client_post:
        do:
          io.cloudslang.base.http.http_client_post:
            - url: "${'%s/v3.0/tokens' % get_sp('io.cloudslang.microfocus.oo.idm_url') + ('?generateHPSSO=true' if generate_HPSSO.lower() == 'true' else \"\")}"
            - auth_type: basic
            - username: "${get_sp('io.cloudslang.microfocus.oo.idm_username')}"
            - password:
                value: "${get_sp('io.cloudslang.microfocus.oo.idm_password')}"
                sensitive: true
            - proxy_host: "${get_sp('io.cloudslang.microfocus.oo.proxy_host')}"
            - proxy_port: "${get_sp('io.cloudslang.microfocus.oo.proxy_port')}"
            - proxy_username: "${get_sp('io.cloudslang.microfocus.oo.proxy_username')}"
            - proxy_password:
                value: "${get_sp('io.cloudslang.microfocus.oo.proxy_password')}"
                sensitive: true
            - tls_version: "${get_sp('io.cloudslang.microfocus.oo.tls_version')}"
            - trust_all_roots: "${get_sp('io.cloudslang.microfocus.oo.trust_all_roots')}"
            - x_509_hostname_verifier: "${get_sp('io.cloudslang.microfocus.oo.x_509_hostname_verifier')}"
            - headers: 'Accept: application/json'
            - body: "${'{\"tenantName\":\"%s\",\"passwordCredentials\":{\"username\":\"%s\",\"password\":\"%s\"}}' % (get_sp(\"io.cloudslang.microfocus.oo.idm_tenant\") if idm_tenant is None else idm_tenant, get_sp(\"io.cloudslang.microfocus.oo.oo_username\") if oo_username is None else oo_username, get_sp(\"io.cloudslang.microfocus.oo.oo_password\") if oo_password is None else oo_password)}"
            - content_type: application/json;charset=UTF-8
        publish:
          - token_json: '${return_result}'
          - response_headers
        navigate:
          - SUCCESS: json_path_query
          - FAILURE: on_failure
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${token_json}'
            - json_path: $.token.id
        publish:
          - token: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - token: '${token}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_post:
        x: 68
        'y': 150
      json_path_query:
        x: 239
        'y': 147
        navigate:
          2c798913-bfdf-fac4-7dde-35c99f94922b:
            targetId: 05f7289a-39ef-d301-224f-c04ca836dcfb
            port: SUCCESS
    results:
      SUCCESS:
        05f7289a-39ef-d301-224f-c04ca836dcfb:
          x: 402
          'y': 152
