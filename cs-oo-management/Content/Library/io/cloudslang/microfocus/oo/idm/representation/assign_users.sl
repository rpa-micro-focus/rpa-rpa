########################################################################################################################
#!!
#! @description: Assigns given users to the representation of the given group and organization while keeping also the originally assigned users.
#!
#! @input org_id: ID of the group organization
#! @input group_id: ID of the representation group
#! @input repre_name: Representation where to assign new users
#! @input new_user_ids: IDs of users to be added
#!
#! @output repre_json: JSON document describing the new representation
#! @output repre_id: The representation ID
#! @output original_user_ids: The originally assigned users to the representation before executing this flow.
#!!#
########################################################################################################################
namespace: io.cloudslang.microfocus.oo.idm.representation
flow:
  name: assign_users
  inputs:
    - token
    - org_id
    - group_id
    - repre_name
    - new_user_ids
  workflow:
    - get_assigned_users:
        do:
          io.cloudslang.microfocus.oo.idm.representation.get_assigned_users:
            - token: '${token}'
            - org_id: '${org_id}'
            - group_id: '${group_id}'
            - repre_name: '${repre_name}'
        publish:
          - repre_json
          - repre_id
          - original_user_ids: '${user_ids}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: set_json_properties
    - update_representation:
        do:
          io.cloudslang.microfocus.oo.idm.representation.update_representation:
            - token: '${token}'
            - org_id: '${org_id}'
            - group_id: '${group_id}'
            - repre_id: '${repre_id}'
            - repre_json: '${new_repre_json}'
        publish:
          - new_repre_json
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - set_json_properties:
        do:
          io.cloudslang.microfocus.base.json.set_json_properties:
            - json_string: '${repre_json}'
            - properties: users
            - values: '${str(list(eval(original_user_ids)+eval(new_user_ids)))}'
            - delimiter: '|'
            - evaluate: 'true'
        publish:
          - new_repre_json: '${result_json}'
        navigate:
          - SUCCESS: update_representation
  outputs:
    - repre_json: '${new_repre_json}'
    - repre_id: '${repre_id}'
    - original_user_ids: '${original_user_ids}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_assigned_users:
        x: 39
        'y': 117
      set_json_properties:
        x: 215
        'y': 118
      update_representation:
        x: 389
        'y': 118
        navigate:
          3364daf5-41bb-6467-148c-1321bc8a2649:
            targetId: 3caccbbc-55a0-a9ed-4dc2-e684cca7e39a
            port: SUCCESS
    results:
      SUCCESS:
        3caccbbc-55a0-a9ed-4dc2-e684cca7e39a:
          x: 589
          'y': 117
