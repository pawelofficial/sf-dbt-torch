
{% set sql_statement %}
    select array_agg(distinct origin) origin, array_agg(distinct foobar) foobar 
    from demo__automobiles
{% endset %}
{%- set hot_key_columns=dbt_utils.get_query_results_as_dict(sql_statement) -%}


    {%- call statement('kocham_dbt', fetch_result=True) %}
        select distinct origin     from demo__automobiles
    {%- endcall -%}

    {%- set value_list = load_result('kocham_dbt') -%}                 -- one way of making lists 
    {%- set values = value_list['data'] | map(attribute=0) | list %}

with
cte1 as ( 
select 
{% for key, val in hot_key_columns.items() %} 
    array_agg( distinct {{ key }} ) as AR_{{ key }} {% if not loop.last %},{% endif %}
{% endfor %} 
from {{ ref('demo__automobiles') }}
)
,cte2 as ( 
    select 

{% for key,val  in hot_key_columns.items() %} 

    {%- set another_list = string_to_list (val[0]) -%}

    {% for l in another_list %} 
        (array_position( {{ key }} :: variant, AR_{{key}} ) = {{ loop.index -1 }} ) ::int as is_{{ key }}_{{ l | upper }} {%- if not loop.last %},{% endif -%}
    {% endfor %}  {%- if not loop.last %},{% endif -%}
{% endfor %}



from {{ ref('demo__automobiles') }} cross join cte1 
) select * from cte2 