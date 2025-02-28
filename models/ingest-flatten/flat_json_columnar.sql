
{{ config(
    materialized='table',
    indexes=[
      {'columns': ['data_id'], 'type': 'hash'}
    ]
    ) }}

 select data_id, flat_data.form_wddate,flat_data.form_co_id from {{ref('unnest_json')}},  jsonb_to_record(data) AS flat_data(form_wddate date, form_co_id text)
 