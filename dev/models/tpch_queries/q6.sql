SELECT
    sum(l_extendedprice * l_discount) as revenue
FROM
    {{ ref('lineitem') }} lineitem
WHERE
    l_shipdate >= '1994-01-01'::date
    -- AND l_shipdate < date '1994-01-01' + interval '1' year
    AND l_shipdate < dateadd(year, 1, '1994-01-01'::date)
    AND l_discount between 0.06 - 0.01 AND 0.06 + 0.01
    AND l_quantity < 24
