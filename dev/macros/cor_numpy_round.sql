-- dbt run-operation r__cor_scalar_fun  
-- create or replace schema 


{% macro cor_numpy_round(column_name) %}
    {% set query -%}
create or replace function cor_numpy_round(i int)
returns int
language python
runtime_version = '3.8'
handler = 'numpy_round'
PACKAGES =('numpy')
as
$$
import numpy as np 
def numpy_round(n):
    return np.round(n)
$$;
    {%- endset -%}
    {{ run_query(query) }}
{% endmacro %}