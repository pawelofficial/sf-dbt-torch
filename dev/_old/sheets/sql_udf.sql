-- example of sql udf:

create or replace function get_user_name(user_id int)
 returns varchar  
 AS 
 $$
    select any_value(user_name) from users where id=user_id and active='Y'
    --note that we need any_value clause to meaningfully use this scalar function
 $$
;

create or replace table users (
  id int,
  user_name varchar,
  active varchar
);
insert into users values (1, 'foo', 'Y');
insert into users values (1, 'bar', 'N');
insert into users values (2, 'baz', 'Y');


select get_user_name(1); -- call like that 
select id,get_user_name(id) udf_scalar_fun,round(id) as typical_scalar_fun
 from users; -- call like that - like a scalar function

select get_user_name(id) from users; --pass whole column to a scalar fun 