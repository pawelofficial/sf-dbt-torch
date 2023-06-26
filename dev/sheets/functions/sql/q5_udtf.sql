-- this wont work https://docs.snowflake.com/en/developer-guide/udf/sql/udf-sql-troubleshooting
CREATE OR REPLACE FUNCTION dev.dev.tpch_q5_by_region(region varchar)
    RETURNS TABLE (nation varchar, revenue number)
    as
    $$
SELECT
    n_name as nation
    ,sum(l_extendedprice * (1 - l_discount)) as revenue
FROM
    DEV.DEV.customer customer,
    DEV.DEV.orders  orders,
    DEV.DEV.lineitem lineitem,
    DEV.DEV.supplier supplier,
    DEV.DEV.nation nation,
    DEV.DEV.region region
WHERE
    c_custkey = o_custkey
    AND l_orderkey = o_orderkey
    AND l_suppkey = s_suppkey
    AND c_nationkey = s_nationkey
    AND s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = region
    AND o_orderdate >= date '1994-01-01'::date
    --AND o_orderdate < date '1994-01-01' + interval '1' year
    and o_orderdate < dateadd(year,1,'1994-01-01'::date)
GROUP BY
    n_name
    $$;


with t1 as ( select * from table(tpch_q5_by_region('AFRICA')))
,t2 as ( select * from table(tpch_q5_by_region('ASIA')))
select r.*,t1.* from region  r 
left join t1 on r.r_name=t1.nation
;

-- this wont work because it creates illegal subquery
--https://docs.snowflake.com/en/developer-guide/udf/sql/udf-sql-troubleshooting
select * from region r, table(tpch_q5_by_region(r.r_name));

