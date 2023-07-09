-- dbt run-operation r__cor_scalar_fun  
-- create or replace schema 


{% macro use_fun(f, columns=none, strings=none) %}
    {{ f }} (
        {% if columns %}
            {{ columns | join(', ') }}
            {% if strings %}
                , 
            {% endif %}
        {% endif %}
        {% if strings %}
            '{{ strings | join("', '") }}'
        {% endif %}
    )
{% endmacro %}


