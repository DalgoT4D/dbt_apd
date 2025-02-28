
{{ config(
  materialized='table',
   indexes=[
      {'columns': ['id'], 'type': 'hash'}
    ]
) }}

{{ dbt_utils.deduplicate(
    relation=ref('survey_form'),
    partition_by='id',
    order_by='_airbyte_emitted_at desc',
   )
}}