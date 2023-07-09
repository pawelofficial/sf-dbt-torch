{{ config(materialized='table') }}

select * from {{ref('seed_automobiles')}}