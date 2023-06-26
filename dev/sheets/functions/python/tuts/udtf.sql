create or replace function dev.dev.my_udtf( total number(10,2) )
returns table ( total number(10,2))
language python
runtime_version=3.8
handler='StockSaleSum'
as $$
class StockSaleSum:
    def __init__(self):
        self._total = 0
 
    def process(self, total):
      self._total+=total
      
    def end_partition(self):
      yield (self._total,)
$$;

create or replace table stock_sales (symbol varchar, quantity number, price number(10,2));
insert into stock_sales values ('IBM', 100, 1.0);
insert into stock_sales values ('IBM', 200, 2.0);
insert into stock_sales values ('IBM', 300, 3.0);
insert into stock_sales values ('META', 400, 1.0);
insert into stock_sales values ('META', 500, 2.0);
insert into stock_sales values ('META', 600, 3.0);


select s.*,t.*
  from stock_sales s , table(stock_sale_sum(price)) t;
  where t.symbol='IBM';

select s.*,t.total
from stock_Sales s 
left join table(my_udtf(price)) t 
on s.price=t.total