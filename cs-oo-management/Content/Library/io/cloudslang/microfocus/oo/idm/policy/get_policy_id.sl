########################################################################################################################
#!!
#! @description: Receives an ID of the organization policy.
#!
#! @input org_id: Organization ID the policy belongs to.
#!
#! @output policy_id: Policy ID of the organization
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.idm.policy
flow:
  name: get_policy_id
  inputs:
    - token
    - org_id
  workflow:
    - get_policies:
        do:
          io.cloudslang.microfocus.oo.idm.policy.get_policies:
            - token: '${token}'
            - org_id: '${org_id}'
        publish:
          - policies_json
        navigate:
          - FAILURE: on_failure
          - SUCCESS: json_path_query
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${policies_json}'
            - json_path: $.id
        publish:
          - policy_id: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - policy_id: '${policy_id}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      get_policies:
        x: 58
        'y': 120
      json_path_query:
        x: 219
        'y': 117
        navigate:
          1b67838c-8d3a-ccc4-602e-2de6336ca218:
            targetId: 23abcc90-f29e-69b6-9dd3-c3e49052f211
            port: SUCCESS
    results:
      SUCCESS:
        23abcc90-f29e-69b6-9dd3-c3e49052f211:
          x: 375
          'y': 119
