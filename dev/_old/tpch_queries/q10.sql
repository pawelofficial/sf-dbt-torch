SELECT
    c_custkey,
    c_name,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    c_acctbal,
    n_name,
    c_address,
    c_phone,
    c_comment
FROM
    {{ ref('customer') }} customer,
    {{ ref('orders') }} orders,
    {{ ref('lineitem') }} lineitem,
    {{ ref('nation') }} nation
WHERE
    c_custkey = o_custkey
    AND l_orderkey = o_orderkey
    --AND o_orderdate >= date '1993-10-01'
    --AND o_orderdate < date '1993-10-01' + interval '3' month
    AND o_orderdate >= '1993-10-01'::date
    AND o_orderdate < dateadd(month, 3, '1993-10-01')
    AND l_returnflag = 'R'
    AND c_nationkey = n_nationkey
GROUP BY
    c_custkey,
    c_name,
    c_acctbal,
    c_phone,
    n_name,
    c_address,
    c_comment
ORDER BY
    revenue desc
LIMIT 20
