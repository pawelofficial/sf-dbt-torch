

{%- set columns = adapter.get_columns_in_relation( ref('demo__base_mdl')  ) -%}

{% set query = 'select 1 as c1, 2 as c2 ' %}
{%- set final_query = dbt_utils.get_query_results_as_dict(query) -%}


SELECT 
    {% for k,v in final_query.items() %}
        {{ v[0] }}  as {{ k }} {% if not loop.last %},{% endif %}
    {% endfor %}

    {% for column in columns %}
        ,{{ column.column }}
    {% endfor %}







