

{{ config(materialized='table') }}

select c1
,{{ use_scalar_fun('numpy_round','c1') }} as numpy_round
from dev.dev.test