create or replace  function dev.dev.add_one_to_input(x number(10, 0))
returns number(10, 0)
language python
runtime_version = 3.8
packages = ('pandas','numpy')
handler = 'add_one_to_inputs'
as $$
import pandas as pd
import numpy as np 
from _snowflake import vectorized

@vectorized(input=pd.DataFrame)
def add_one_to_inputs(df):
  return pd.Series(np.max(df))
$$;

select n_regionkey,add_one_to_input(n_regionkey)
from nation



