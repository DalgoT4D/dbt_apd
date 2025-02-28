{{ config(
  materialized='table',
   indexes=[
      {'columns': ['_airbyte_ab_id'], 'type': 'hash'}
    ]

) }}


select c.* from 
(select (_airbyte_data::json->>'KEY') AS "id", (_airbyte_data::json->>'form_id') AS "form_id",_airbyte_ab_id::uuid ,_airbyte_emitted_at ,_airbyte_data 
from {{ source('survey-cto', 'raw_surveycto') }})c


-- --select c.* from 
-- --(select (_airbyte_data::json->>'id')::uuid AS "id", (_airbyte_data::json->>'form')::json->>'@xmlns' AS "form_xmlns",(_airbyte_data::json->>'form')::json->>'@name' AS "form_name",_airbyte_ab_id::uuid ,_airbyte_emitted_at ,_airbyte_data 
-- --from "test_airbyte_commcare"._airbyte_raw_form)c
-- ---- try for one form
-- --where c.form_xmlns = 'http://openrosa.org/formdesigner/B158EBDA-64CB-45C2-9064-58B0B5906029'


-- select c.* from 
-- (select (_airbyte_data::json->>'KEY') AS "id", (_airbyte_data::json->>'form_id') AS "form_id",_airbyte_ab_id::uuid ,_airbyte_emitted_at ,_airbyte_data 
-- from "public"._airbyte_raw_surveycto_stream)c
-- -- try for one form
-- -- where c.form_id = 'http://openrosa.org/formdesigner/B158EBDA-64CB-45C2-9064-58B0B5906029'



