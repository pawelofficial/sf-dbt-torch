
SELECT
    l_shipmode,
    sum(case
        when o_orderpriority = '1-URGENT'
            OR o_orderpriority = '2-HIGH'
            then 1
        else 0
    end) as high_line_count,
    sum(case
        when o_orderpriority <> '1-URGENT'
            AND o_orderpriority <> '2-HIGH'
            then 1
        else 0
    end) AS low_line_count
FROM
    {{ ref('orders') }} orders,
    {{ ref('lineitem') }} lineitem
WHERE
    o_orderkey = l_orderkey
    AND l_shipmode in ('MAIL', 'SHIP')
    AND l_commitdate < l_receiptdate
    AND l_shipdate < l_commitdate
    -- AND l_receiptdate >= date '1994-01-01'
    -- AND l_receiptdate < date '1994-01-01' + interval '1' year
    AND l_receiptdate >= '1994-01-01'::date
    AND l_receiptdate < dateadd(year, 1, '1994-01-01'::date)
GROUP BY
    l_shipmode
ORDER BY
    l_shipmode
