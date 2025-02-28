
{{
    config(
        materialized='incremental',
         unique_key = '_airbyte_ab_id'
    )
}}

select 	* from  {{ source('survey-cto', 'raw_surveycto') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where _airbyte_emitted_at >= (select max(_airbyte_emitted_at) from {{ this }})

{% endif %}