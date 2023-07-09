# https://quickstarts.snowflake.com/guide/data_engineering_with_snowpark_python_and_dbt/index.html?index=..%2F..index#2
#As mentioned above, every dbt Python model must define a method named model that has the following signature: model(dbt, session).
# As of 10/17/2022 only table or incremental materializations are supported, which is why we configured it explicitly here.
# You can use dbt.ref() and dbt.source() just the same as their Jinja equivalents in SQL models. And you can refer to either Python or SQL models interchangeably!
def model(dbt, session):
    # Must be either table or incremental (view is not currently supported)
    dbt.config(materialized = "table")

    # DataFrame representing an upstream model
    df = dbt.ref("q6")
 
    return df

