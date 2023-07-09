

{%- set columns = adapter.get_columns_in_relation( ref('demo__base_mdl')  ) -%}

with norm_cte as ( 
SELECT 
    {% for column in columns %}
        avg({{ column.column }}) as mean_{{ column.column }}{% if not loop.last %},{% endif %}
    {% endfor %}
    ,
    {% for column in columns %}
        STDDEV({{ column.column }}) as std_{{ column.column }}{% if not loop.last %},{% endif %}
    {% endfor %}
    FROM {{ ref('demo__base_mdl') }} 
)
 select 
    {% for column in columns %} 
    nvl(                                                                                --casting nulls to zeros, aka using mean value for calculating z-score 
        ({{ column.column }} - mean_{{ column.column }}) / std_{{ column.column }}
        ,0) as z_{{ column.column }}{% if not loop.last %},{% endif %}
{% endfor %} 
    FROM {{ ref('demo__base_mdl') }}
    cross join norm_cte 






