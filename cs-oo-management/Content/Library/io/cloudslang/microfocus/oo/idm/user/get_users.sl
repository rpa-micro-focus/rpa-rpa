########################################################################################################################
#!!
#! @description: Receives a list of users that matches the searchText input
#!
#! @input search_text: Text used to filter users (e.g. user name)
#! @input org_id: ID of the organization the users belong to
#!
#! @output users_json: JSON document listing all found users
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.idm.user
flow:
  name: get_users
  inputs:
    - token
    - search_text:
        required: false
    - org_id
  workflow:
    - idm_http_action:
        do:
          io.cloudslang.microfocus.oo.idm._operations.idm_http_action:
            - url: "${'/api/scim/organizations/%s/users?order-by=displayName&sort=ascending&searchText=%s&scope=manager&includePerms=false&userType=SEEDED_USER' % (org_id, search_text)}"
            - token: '${token}'
            - method: GET
        publish:
          - users_json: '${return_result}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  outputs:
    - users_json: '${users_json}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      idm_http_action:
        x: 52
        'y': 84
        navigate:
          1016836c-43b1-83ef-749c-4ebae10b0897:
            targetId: 68e54ed6-56e7-623e-0cd4-b8f49793294d
            port: SUCCESS
    results:
      SUCCESS:
        68e54ed6-56e7-623e-0cd4-b8f49793294d:
          x: 232
          'y': 87
