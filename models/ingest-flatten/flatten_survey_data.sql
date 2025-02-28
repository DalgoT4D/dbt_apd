{{ config(
  materialized='table',
   indexes=[
      {'columns': ['_airbyte_ab_id'], 'type': 'hash'}
    ]

) }}


{{
    flatten_json(
        model_name = source('survey-cto', 'raw_surveycto'),
        json_column = '_airbyte_data',
        form = 'baseline_ig'
    )
}}