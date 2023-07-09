${% macro use_udf(f,input_strings,input_cols) %}
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

{% endmacro %}