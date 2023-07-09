{% macro udf__get_columns(_table_name) -%}


{% set query -%}

CREATE or replace FUNCTION get_columns(_table_name varchar)
  RETURNS array
  AS
  $$
    select array_agg(column_name) as columns from information_Schema.columns where upper(table_name)= upper( _table_name )
  $$
  ;

{%- endset -%}
{% set results = run_query(query) %}

{{ log("Running some_macro: " ~ res ~ ", ") }}

{% endmacro %}
