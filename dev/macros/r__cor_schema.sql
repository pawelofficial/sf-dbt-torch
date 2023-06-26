-- dbt run-operation r__cor_schema --args '{database_name: dev,schema_name: dev}'
-- create or replace schema 

{% macro r__cor_schema(database_name ,schema_name) -%}
    {%- set namespace = database_name ~ '.' ~ schema_name -%}

    {% set query -%}
        CREATE or replace SCHEMA {{ namespace }};
    {%- endset -%}

    {{ run_query(query) }}
    {{ log(" Namespace " ~ namespace ~ " has been created or replaced", info=True) }}
{% endmacro %}
