create or replace function dev.dev.numpy_round(i int)
returns int
language python
runtime_version = '3.8'
handler = 'numpy_round'
PACKAGES =('numpy')
as
$$
import numpy as np 
def numpy_round(n):
    return np.round(n)
$$;


select dev.dev.cor_numpy_round(c1)
from dev.dev.test