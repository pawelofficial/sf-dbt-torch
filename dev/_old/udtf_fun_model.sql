{{ config(materialized='table') }}

select stock_sale_sum.symbol, total
  from {{ref('stock_sales')}}, 
  TABLE({{ use_udtf('stock_sale_sum', ['symbol', 'quantity', 'price'], 'symbol') }})
