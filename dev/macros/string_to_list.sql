{% macro string_to_list(string) %}
    {%- set my_list = string.replace("[", "").replace("]", "").replace("'", "").replace('"', "").replace('\n  ','').replace('\n','').strip().split(",") -%}
    {{ return (my_list) }}
{% endmacro %}
