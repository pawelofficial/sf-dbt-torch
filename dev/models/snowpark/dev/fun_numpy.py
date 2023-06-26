import numpy as np 
def add_one(x):
    return 1

def model(dbt, session):
    dbt.config(materialized="table")
    model_df = dbt.ref("orders")
    model_df = model_df.withColumn("degree_plus_one", add_one(model_df["o_totalprice"]))
    #model_df['out']=model_df.apply(add_one)
    return model_df