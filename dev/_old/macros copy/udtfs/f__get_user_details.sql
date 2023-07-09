{% macro f__get_user_details() %}
    {% set query -%}
--- 
create  function f__get_user_details(user_id int)
 returns table(user_name varchar, user_phone varchar, user_address varchar)
 AS 
 $$
    select users.user_name, user_details.phone_number::varchar as phone ,user_details.address
    from users 
    left join user_details on users.id = user_details.user_id
    where users.id = user_id
    and user_details.user_id is not null 
    and users.active = 'Y'
 $$
;
--- 
    {%- endset -%}
    {{ run_query(query) }}
{% endmacro %}