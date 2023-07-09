create or replace function stock_sale_sum(symbol varchar, quantity number, price number(10,2))
returns table (symbol varchar, total number(10,2))
language python
runtime_version=3.8
handler='StockSaleSum'
as $$
class StockSaleSum:
    def __init__(self):
        self._cost_total = 0
        self._symbol = ""

    def process(self, symbol, quantity, price):
      self._symbol = symbol
      cost = quantity * price
      self._cost_total += cost
      #yield (symbol, cost)

    def end_partition(self):
      yield (self._symbol, self._cost_total)
$$;




select stock_sale_sum.symbol, total
  from stock_sales, table(stock_sale_sum(symbol, quantity, price) over (partition by symbol))
  ;
