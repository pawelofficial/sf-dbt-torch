import numpy as np 
def add_one(x):
    return np.round(x) + 1

def model(dbt, session):
    dbt.config(materialized="table")
    temps_df = dbt.ref("q6")

    # warm things up just a little
    df = temps_df.withColumn("degree_plus_one", add_one(temps_df["revenue"]))
    return df