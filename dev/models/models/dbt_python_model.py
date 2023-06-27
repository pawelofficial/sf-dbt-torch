# https://docs.getdbt.com/docs/building-a-dbt-project/building-models/python-models



import snowflake.snowpark.functions as func

def model(dbt, session):
    dbt.config(materialized = "table")
 
    df = dbt.ref("trips") \
        .groupBy("start_station_name") \
        .agg([func.count("*").alias("total_trips"), func.avg("tripduration").alias("avg_trip_duration")]) \
        .sort(func.col("total_trips").desc()) \
        .limit(10)
 
    return df