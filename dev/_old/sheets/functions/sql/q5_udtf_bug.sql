CREATE OR REPLACE FUNCTION kpal_test_unsupported_type(c string)
  RETURNS TABLE (a string, b integer)
  as
  $$
    select 
        *
        FROM VALUES('a', 1), ('b', 2), ('c', 3)
       WHERE ENDSWITH(c, column1)    // change "AND" to "OR" and it will stop working! 
  $$;
 
 
SELECT * FROM TABLE(kpal_test_unsupported_type('a'));   // < This always works
SELECT * FROM (SELECT * FROM VALUES('la', 1) c1 , ('lb', 2) c2 ) t1 
join  TABLE(kpal_test_unsupported_type(a.column1)) t2 
where t1.c1=t2.a;

with cte as ( 
SELECT * FROM VALUES ('a', 1) , ('b', 2)   
)
,cte2 as (  select column1 as c1, column2 as c2 from cte)
select * from cte2,table(kpal_test_unsupported_type(c1)) t2
where cte2.c1=t2.a;


select * from table(kpal_test_unsupported_type('a')) t2
union all 
select * from cte2


