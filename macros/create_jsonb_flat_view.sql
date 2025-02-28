{% macro create_jsonb_flat_view_udf() %}
create or replace function {{ target.schema }}.create_jsonb_flat_view(table_name text, regular_columns text, json_column text)
    returns text language plpgsql as $$
declare
    cols text;
begin
    execute format ($ex$
        select string_agg(format('%2$s->>%%1$L "%%1$s"', key), ', ')
        from (
            select distinct key
            from %1$s, jsonb_each(%2$s)
            order by 1
            ) s;
        $ex$, table_name, json_column)
    into cols;
    execute format($ex$
        drop view if exists %1$s_view;
        create view %1$s_view as 
        select %2$s, %3$s from %1$s
        $ex$, table_name, regular_columns, cols);
    return cols;
end $$;
{% endmacro %}