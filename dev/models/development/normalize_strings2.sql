
{% set sql_statement %}
    select array_agg(distinct origin) ar1, array_agg(distinct foobar) ar2 
    from demo__automobiles
{% endset %}
{%- set hot_key_columns=dbt_utils.get_query_results_as_dict(sql_statement) -%}


    {%- call statement('kocham_dbt', fetch_result=True) %}
        select distinct origin     from demo__automobiles
    {%- endcall -%}

    {%- set value_list = load_result('kocham_dbt') -%}
    {%- set values = value_list['data'] | map(attribute=0) | list %}

with
cte2 as ( 
    select 
{% for col in values %} 
    {{ col }}  as first_list 
{% endfor %}

{% for key,val  in hot_key_columns.items() %} 

    {%- set another_list = string_to_list (val[0]) -%}
    {{ another_list }} 

    {% for l in another_list %} 
        {{ l }}   as another_list
    {% endfor %} 

    {%- set yet_another_list = val[0].replace(']','').replace('[','').replace('"','').replace(', ',',').replace("'",'').replace('\n','').split(sep=',', maxsplit=-1) -%}

    {% for l in yet_another_list %} 
        {{ l }}  as yet_another_list
    {% endfor %} 



{% endfor %}



from {{ ref('demo__automobiles') }} 
) select * from cte2 