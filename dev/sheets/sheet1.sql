--https://docs.snowflake.com/en/developer-guide/udf/python/udf-python-packages#getting-started
--displaying all packages available
select * from information_schema.packages 
where language = 'python'
and package_name ='transformers'

--When queries that call Python UDFs are executed inside a Snowflake warehouse, Anaconda packages are installed seamlessly and cached on the virtual warehouse on your behalf.
--You can display a list of the packages and modules a UDF or UDTF is using by executing the DESCRIBE FUNCTION command. Executing the DESCRIBE FUNCTION command for a UDF whose handler is implemented in Python returns the values of several properties, including a list of imported modules and packages, as well as installed packages, the function signature, and its return type.

--For more efficient resource management, newly provisioned virtual warehouses do not preinstall Anaconda packages. Instead, Anaconda packages are installed on-demand the first time a UDF is used. The packages are cached for future UDF execution on the same warehouse. The cache is dropped when the warehouse is suspended. This may result in slower performance the first time a UDF is used or after the warehouse is resumed. The additional latency could be approximately 30 seconds.

desc function stock_sale_average(varchar,varchar,varchar)

--sf1  26s
--sf10 42s
--sf100 80s
;
select * from region;

select * from table(Dev.dev.tpch_q5_by_region('ASIA'))