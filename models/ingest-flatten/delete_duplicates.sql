

{{ config(
  materialized='table',
   indexes=[
      {'columns': ['id'], 'type': 'hash'}
    ]
) }}

{{ dbt_utils.deduplicate(
    relation=ref('extract_form_params'),
    partition_by='id',
    order_by='_airbyte_emitted_at desc',
   )
}}