########################################################################################################################
#!!
#! @description: Receives an SSX scenario by its name.
#!
#! @input scenario_name: Name of the scenario to be received
#!
#! @output scenario_json: JSON document describing the scenario
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.ssx.scenario
flow:
  name: get_scenario
  inputs:
    - token
    - scenario_name
  workflow:
    - get_scenarios:
        do:
          io.cloudslang.microfocus.oo.ssx.scenario.get_scenarios:
            - token: '${token}'
        publish:
          - scenarios_json
        navigate:
          - FAILURE: on_failure
          - SUCCESS: json_path_query
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${scenarios_json}'
            - json_path: "${\"$.items[?(@.name=='%s')]\" % scenario_name}"
        publish:
          - scenario_json: '${return_result[1:-1]}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - scenario_json
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      get_scenarios:
        x: 61
        'y': 154
      json_path_query:
        x: 218
        'y': 156
        navigate:
          9080ac7a-2d0b-1463-5e97-3567f713d03e:
            targetId: 95dfb3ec-a5cd-6574-d06a-da1e85b158de
            port: SUCCESS
    results:
      SUCCESS:
        95dfb3ec-a5cd-6574-d06a-da1e85b158de:
          x: 374
          'y': 153
