import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col
import nltk
#nltk.download('vader_lexicon')
from nltk.sentiment.vader import SentimentIntensityAnalyzer

def add_one(x):
    return x+1

def model(dbt, session):
    dbt.config(packages=["pandas","numpy","nltk"])
    dbt.config(materialized="table")
    temps_df = dbt.ref("q6")
    sia = SentimentIntensityAnalyzer()
    df = temps_df.withColumn("degree_plus_one", add_one(temps_df["revenue"]))
    return df



# opcje 
#   - snowpark
#        cons: not full python, snowpark syntax 
#   - python udfs 
#        cons: not full python 
#        pros: very pythonic 
#   - dbt 
#        cons: not full python, not very pythonic 
#        pros: dbt objects 
#   - fal 
#        pros: full python, full dbt 
#        cons: premium version 
#   - zipy
#        pros: full python
#        cons: leaning curve, no dbt 