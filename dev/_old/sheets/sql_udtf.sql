-- example of sql udf:

create table users (
  id int,
  user_name varchar,
  active varchar
);
insert into users values (1, 'foo', 'Y');
insert into users values (1, 'bar', 'N');
insert into users values (2, 'baz', 'Y');
insert into users values (4, 'missing details', 'Y');

create table user_details(
  user_id int
  ,phone_number varchar
  ,address varchar
);
insert into user_details values (1, '1234567890', '123 main st');
insert into user_details values (2, '0987654321', '456 main st');
insert into user_details values (3, '1234567890', '789 main st');

--make udtf to get user details with business logic 
create  function get_user_details(user_id int)
 returns table(user_name varchar, user_phone varchar, user_address varchar)
 AS 
 $$
    select users.user_name, user_details.phone_number as phone ,user_details.address
    from users 
    left join user_details on users.id = user_details.user_id
    where users.id = user_id
    and user_details.user_id is not null 
    and users.active = 'Y'
 $$
;

-- query udtf for a specific id 
select * from table(get_user_details(1)); -- only active user returned  
select * from table(get_user_details(4)); -- no data returned due to missing details

--user udtf in a join - two rows instead of four, why/? 
select u.* 
from users u 
left join table(get_user_details(u.id)) ud 
on u.user_name = ud.user_name;
-- no bar user because it's inactive 
-- no missing details user because it has missing details 
