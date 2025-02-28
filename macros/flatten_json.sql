{% macro flatten_json(model_name, json_column, form) %}
  
{% set survey_methods_query %}

SELECT DISTINCT(jsonb_object_keys({{json_column}})) as column_name
from {{model_name}}
where _airbyte_data ->> 'form_id' = '{{form}}'
{% endset %}

{% set results = run_query(survey_methods_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

select
_airbyte_ab_id,
_airbyte_data,
{% for column_name in results_list %}
_airbyte_data->>'{{ column_name }}' as {{ column_name }}{% if not loop.last %},{% endif %}
{% endfor %}
from {{model_name}}
where _airbyte_data ->> 'form_id' = '{{form}}'
{% endmacro %}

