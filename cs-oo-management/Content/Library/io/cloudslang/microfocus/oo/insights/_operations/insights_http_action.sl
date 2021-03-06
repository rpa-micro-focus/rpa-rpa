########################################################################################################################
#!!
#! @description: HTTP client action (GET, POST, PUT, DELETE). It only accepts url and body; it uses basic authentication with OO credentials (taken from OO central system properties).
#!               It does not use cookies (to handle X-CSRF-TOKEN).
#!               It's a copy of central_http_action.
#!
#! @input method: GET, POST, PUT, DELETE, HEAD
#! @input body: Request body to be sent
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.insights._operations
flow:
  name: insights_http_action
  inputs:
    - url
    - method
    - body:
        required: false
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: "${'%s%s' % (get_sp('io.cloudslang.microfocus.oo.insights_url'), url)}"
            - auth_type: basic
            - username: "${get_sp('io.cloudslang.microfocus.oo.oo_username')}"
            - password:
                value: "${get_sp('io.cloudslang.microfocus.oo.oo_password')}"
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
            - use_cookies: 'false'
            - body: '${body}'
            - content_type: application/json
            - method: '${method}'
        publish:
          - return_result
          - response_headers
          - error_message
          - status_code
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result: '${return_result}'
    - response_headers: '${response_headers}'
    - error_message: '${error_message}'
    - status_code: '${status_code}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_action:
        x: 135
        'y': 114
        navigate:
          1276763d-c63f-7564-93ff-9d45c6ff7039:
            targetId: 7ad9349e-7386-7bde-dbe8-328c348b169f
            port: SUCCESS
    results:
      SUCCESS:
        7ad9349e-7386-7bde-dbe8-328c348b169f:
          x: 306
          'y': 114
