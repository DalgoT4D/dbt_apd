{{ config(
    materialized='view',
    indexes=[
      {'columns': ['data_id'], 'type': 'hash'}
    ]
    ) }}

--WIP -  dbt - issue with using reference 
--depends_on: {{ ref('unnest_json') }}

--select create_jsonb_flat_view({{ref('unnest_json')}}, 'data_id', 'data')

select create_jsonb_flat_view('"dbt_test".unnest_json', 'data_id', 'data')
