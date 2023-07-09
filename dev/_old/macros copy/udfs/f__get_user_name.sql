{% macro f__get_user_name() %}
    {% set query -%}
create or replace function f__get_user_name(user_id int)
 returns varchar  
 AS 
 $$
    select any_value(user_name) from users where id=user_id and active='Y'
    --note that we need any_value clause to meaningfully use this scalar function
 $$
;
    {%- endset -%}
    {{ run_query(query) }}
{% endmacro %}