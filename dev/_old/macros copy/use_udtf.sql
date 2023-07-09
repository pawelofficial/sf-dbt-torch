{% macro use_udtf(udtf, columns, partition_by) %}
    {{ udtf }}({{ columns | join(', ') }}) OVER (PARTITION BY {{ partition_by }})
{% endmacro %}
