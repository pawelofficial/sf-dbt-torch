-- dbt run-operation r__cor_scalar_fun  
-- create or replace schema 


{% macro use_scalar_fun(f,column_name) %}
    {{ f }} ({{ column_name }})  
{% endmacro %}