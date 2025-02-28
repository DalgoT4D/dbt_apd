-- maybe this shold be done in connector itself by specifying schema

{{ config(
  materialized='table',
   indexes=[
      {'columns': ['_airbyte_ab_id'], 'type': 'hash'}
    ]

) }}

select c.* from 
(select (_airbyte_data::json->>'id')::uuid AS "id", (_airbyte_data::json->>'form')::json->>'@xmlns' AS "form_xmlns",(_airbyte_data::json->>'form')::json->>'@name' AS "form_name",_airbyte_ab_id::uuid ,_airbyte_emitted_at ,_airbyte_data 
from {{ source('commcare', 'raw_form') }} )c
-- try for one form
where c.form_xmlns = 'http://openrosa.org/formdesigner/B158EBDA-64CB-45C2-9064-58B0B5906029'

