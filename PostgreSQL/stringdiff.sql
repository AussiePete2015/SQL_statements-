/* calles a indiff function to determine difference between 2 strings and the position within the string */

select
in[1] as in_1,
in[2] as in_2,
substring(in[1],strpos(in[2],trim(indiff(in[1], in[2]))),1) as inchr_df1,
trim(indiff(in[1], in[2])) as inchr_df2,
strpos(in[2],trim(indiff(in[1], in[2]))) as chrpos
from (
select array(
with t as (
select distinct
vin
from motor
)
select distinct on (t.in)
t.in
from t
join motor e
on e.in like t.in
order by t.in desc))
as dt (in)
