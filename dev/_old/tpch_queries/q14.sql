
SELECT
    100.00 * sum(case
        when p_type like 'PROMO%'
            then l_extendedprice * (1 - l_discount)
        else 0
    end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
FROM
    {{ ref('lineitem') }} lineitem,
    {{ ref('part') }} part
WHERE
    l_partkey = p_partkey
    -- AND l_shipdate >= date '1995-09-01'
    -- AND l_shipdate < date '1995-09-01' + interval '1' month;
    AND l_shipdate >= '1995-09-01'::date
    AND l_shipdate < dateadd(month, 1, '1995-09-01'::date)
