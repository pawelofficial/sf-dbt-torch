{%- set tbl =  ref ('demo__automobiles') -%}  -- now using demo automobiles, then switch to demo__base_mdl
-- GET STRING COLUMNS OF A TABLE 
{% set sql_statement %}
    select column_name from information_schema.columns 
    where lower(table_name)= '{{tbl.name}}'
    and data_type='TEXT'

{% endset %}
{%- set string_cols = dbt_utils.get_query_results_as_dict(sql_statement) -%}

-- PUT THOSE COLUMNS INTO ARRAYS 
{% set sql_statement %}
    select array_agg(distinct origin) ar1, array_agg(distinct foobar) ar2 
    from demo__automobiles
{% endset %}
{%- set hot_key_columns=dbt_utils.get_query_results_as_dict(sql_statement) -%}


with cte1 as ( -- COUNT DISTINCTS 
select 
{% for key in string_cols['COLUMN_NAME'] %} 
     COUNT(DISTINCT {{ key }}) AS CNT_{{ key }}  {% if not loop.last %},{% endif %}
{% endfor %}
), 
cte2 as ( 
    select 
{{ hot_key_columns }}

{% for _column,_array  in hot_key_columns.items() %}
 {{ _array[0] }} 

{% endfor %}


from {{ ref('demo__automobiles') }} 
) select * from cte2 