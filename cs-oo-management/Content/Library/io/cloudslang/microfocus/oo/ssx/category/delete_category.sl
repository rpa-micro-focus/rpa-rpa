########################################################################################################################
#!!
#! @description: Removes an SSX category.
#!
#! @input category_id: ID of the category to be removed
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.ssx.category
flow:
  name: delete_category
  inputs:
    - token
    - category_id
  workflow:
    - ssx_http_action:
        do:
          io.cloudslang.microfocus.oo.ssx._operations.ssx_http_action:
            - url: "${'/rest/v0/categories/%s' % category_id}"
            - token: '${token}'
            - method: DELETE
        publish: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ssx_http_action:
        x: 80
        'y': 80
        navigate:
          34d1ba30-9b13-061f-528a-cea7a5d93d98:
            targetId: 0fc33028-6982-ffb4-682f-4b28028d19fe
            port: SUCCESS
    results:
      SUCCESS:
        0fc33028-6982-ffb4-682f-4b28028d19fe:
          x: 282
          'y': 81
