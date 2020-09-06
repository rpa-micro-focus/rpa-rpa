########################################################################################################################
#!!
#! @description: Removes the given scenario.
#!
#! @input scenario_id: ID of the scenario to be removed
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.rpa.ssx.scenario
flow:
  name: delete_scenario
  inputs:
    - token
    - scenario_id
  workflow:
    - ssx_http_action:
        do:
          io.cloudslang.microfocus.rpa.ssx._operations.ssx_http_action:
            - url: "${'/rest/v0/scenarios/%s' % scenario_id}"
            - token: '${token}'
            - method: DELETE
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
        x: 101
        'y': 128
        navigate:
          8f07b9f0-0243-66d9-db83-e081b846a077:
            targetId: 7ab215ed-40a2-6cd8-949a-23c9aa01981d
            port: SUCCESS
    results:
      SUCCESS:
        7ab215ed-40a2-6cd8-949a-23c9aa01981d:
          x: 278
          'y': 128
