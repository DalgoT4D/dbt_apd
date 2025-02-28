-- maybe this shold be done in python


{{ config(
    materialized='table',
    indexes=[
      {'columns': ['data_id'], 'type': 'hash'}
    ]
    ) }}


with recursive flat (id, key, value) as (
    select id, key, value
    from  {{ ref('delete_duplicates') }},
    jsonb_each(_airbyte_data)
union
    select f.id, concat(f.key, '_', j.key), j.value
    from flat f,
    jsonb_each(f.value) j
    where jsonb_typeof(f.value) = 'object'
)
select id as data_id, (jsonb_pretty(jsonb_object_agg(key, value)))::jsonb as data
from flat
where jsonb_typeof(value) <> 'object'
group by id