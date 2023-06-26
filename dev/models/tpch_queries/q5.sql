
SELECT
    n_name,
    sum(l_extendedprice * (1 - l_discount)) as revenue
FROM
    {{ref('customer')}} customer,
    {{ref('orders')}}  orders,
    {{ref('lineitem')}} lineitem,
    {{ref('supplier')}} supplier,
    {{ref('nation')}} nation,
    {{ref('region')}} region
WHERE
    c_custkey = o_custkey
    AND l_orderkey = o_orderkey
    AND l_suppkey = s_suppkey
    AND c_nationkey = s_nationkey
    AND s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = 'ASIA'
    AND o_orderdate >= date '1994-01-01'::date
    --AND o_orderdate < date '1994-01-01' + interval '1' year
    and o_orderdate < dateadd(year,1,'1994-01-01'::date)
GROUP BY
    n_name
ORDER BY
    revenue desc