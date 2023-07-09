from snowflake.snowpark.functions import udf

def model(dbt,session):
    dbt.config(materialized="table")
    
    @udf
    def add_one(x: int) -> int:
        x = 0 if not x else x
        return x + 1
    
    df = dbt.ref("q6")

    # Add a new column containing the id incremented by one
    df = df.withColumn("revenue_plus_one", add_one(df["revenue"]))
    return df 