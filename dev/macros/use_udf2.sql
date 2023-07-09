${% macro use_udf2(f,input_strings,input_cols) %}

{% set query %}
  {{ f }} 
(
        {% if input_strings %}
            '{{ input_strings | join("', '") }}'
        {% endif %}

        {% if input_cols %}
            {{ input_cols | join(', ') }}
            {% if strings %}
                , 
            {% endif %}
        {% endif %}
)
 {% endset %}

 {{ return( run_query(query)  ) }}

{% endmacro %}