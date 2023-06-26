create or replace function stock_sale(symbol varchar, quantity number, price number(10,2))
returns table (symbol varchar, total number(10,2))
language python
runtime_version=3.8
handler='StockSale'
as $$
class StockSale:
    def process(self, symbol, quantity, price):
      cost = quantity * price
      yield (symbol, cost)
$$;


select stock_sale.symbol,quantity,price, total
  from stocks_table, table(stock_sale(symbol, quantity, price) over (partition by symbol));


create or replace table stocks_table (symbol varchar, quantity number, price number(10,2));
insert into stocks_table values ('IBM', 100, 10.0);
insert into stocks_table values ('IBM', 200, 20.0);
insert into stocks_table values ('IBM', 300, 30.0);
insert into stocks_table values ('GE', 400, 40.0);
insert into stocks_table values ('GE', 500, 50.0);
insert into stocks_table values ('GE', 600, 60.0);