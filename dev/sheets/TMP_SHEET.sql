--sf1  26s
--sf10 42s
--sf100 80s
select *
from table(information_schema.query_history(dateadd('hours',-1,current_timestamp()),current_timestamp()))
order by start_time;


SELECT * FROM DEV.DEV.MY_FIRST_PYTHON_MODEL;