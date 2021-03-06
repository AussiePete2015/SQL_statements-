select
v1.vin,
substring(v1.vin,9,1) as nineth_diginvin,
((v1.translit_vin[1]::numeric * 8) +
(v1.translit_vin[2]::numeric * 7) +
(v1.translit_vin[3]::numeric * 6) +
(v1.translit_vin[4]::numeric * 5) +
(v1.translit_vin[5]::numeric * 4) +
(v1.translit_vin[6]::numeric * 3) +
(v1.translit_vin[7]::numeric * 2) +
(v1.translit_vin[8]::numeric * 10) +
(v1.translit_vin[9]::numeric * 0) +
(v1.translit_vin[10]::numeric * 9) +
(v1.translit_vin[11]::numeric * 8) +
(v1.translit_vin[12]::numeric * 7) +
(v1.translit_vin[13]::numeric * 6) +
(v1.translit_vin[14]::numeric * 5) +
(v1.translit_vin[15]::numeric * 4) +
(v1.translit_vin[16]::numeric * 3) +
(v1.translit_vin[17]::numeric * 2)
) as vinsum,
(v1.translit_vin[1]::numeric * 8) as vin01_wt,
(v1.translit_vin[2]::numeric * 7) as vin02_wt,
(v1.translit_vin[3]::numeric * 6) as vin03_wt,
(v1.translit_vin[4]::numeric * 5) as vin04_wt,
(v1.translit_vin[5]::numeric * 4) as vin05_wt,
(v1.translit_vin[6]::numeric * 3) as vin06_wt,
(v1.translit_vin[7]::numeric * 2) as vin07_wt,
(v1.translit_vin[8]::numeric * 10) as vin08_wt,
(v1.translit_vin[9]::numeric * 0) as vin09_wt,
(v1.translit_vin[10]::numeric * 9) as vin10_wt,
(v1.translit_vin[11]::numeric * 8) as vin11_wt,
(v1.translit_vin[12]::numeric * 7) as vin12_wt,
(v1.translit_vin[13]::numeric * 6) as vin13_wt,
(v1.translit_vin[14]::numeric * 5) as vin14_wt,
(v1.translit_vin[15]::numeric * 4) as vin15_wt,
(v1.translit_vin[16]::numeric * 3) as vin16_wt,
(v1.translit_vin[17]::numeric * 2) as vin17_wt,
mod((
(v1.translit_vin[1]::numeric * 8) +
(v1.translit_vin[2]::numeric * 7) +
(v1.translit_vin[3]::numeric * 6) +
(v1.translit_vin[4]::numeric * 5) +
(v1.translit_vin[5]::numeric * 4) +
(v1.translit_vin[6]::numeric * 3) +
(v1.translit_vin[7]::numeric * 2) +
(v1.translit_vin[8]::numeric * 10) +
(v1.translit_vin[9]::numeric * 0) +
(v1.translit_vin[10]::numeric * 9) +
(v1.translit_vin[11]::numeric * 8) +
(v1.translit_vin[12]::numeric * 7) +
(v1.translit_vin[13]::numeric * 6) +
(v1.translit_vin[14]::numeric * 5) +
(v1.translit_vin[15]::numeric * 4) +
(v1.translit_vin[16]::numeric * 3) +
(v1.translit_vin[17]::numeric * 2)
),11) as vinmod,
v1.translit_vin[9]::numeric as checkdig,
case
when mod((
(v1.translit_vin[1]::numeric * 8) +
(v1.translit_vin[2]::numeric * 7) +
(v1.translit_vin[3]::numeric * 6) +
(v1.translit_vin[4]::numeric * 5) +
(v1.translit_vin[5]::numeric * 4) +
(v1.translit_vin[6]::numeric * 3) +
(v1.translit_vin[7]::numeric * 2) +
(v1.translit_vin[8]::numeric * 10) +
(v1.translit_vin[9]::numeric * 0) +
(v1.translit_vin[10]::numeric * 9) +
(v1.translit_vin[11]::numeric * 8) +
(v1.translit_vin[12]::numeric * 7) +
(v1.translit_vin[13]::numeric * 6) +
(v1.translit_vin[14]::numeric * 5) +
(v1.translit_vin[15]::numeric * 4) +
(v1.translit_vin[16]::numeric * 3) +
(v1.translit_vin[17]::numeric * 2)
),11) = 10 and substring(v1.vin,9,1) = 'X' then '1'
when mod((
(v1.translit_vin[1]::numeric * 8) +
(v1.translit_vin[2]::numeric * 7) +
(v1.translit_vin[3]::numeric * 6) +
(v1.translit_vin[4]::numeric * 5) +
(v1.translit_vin[5]::numeric * 4) +
(v1.translit_vin[6]::numeric * 3) +
(v1.translit_vin[7]::numeric * 2) +
(v1.translit_vin[8]::numeric * 10) +
(v1.translit_vin[9]::numeric * 0) +
(v1.translit_vin[10]::numeric * 9) +
(v1.translit_vin[11]::numeric * 8) +
(v1.translit_vin[12]::numeric * 7) +
(v1.translit_vin[13]::numeric * 6) +
(v1.translit_vin[14]::numeric * 5) +
(v1.translit_vin[15]::numeric * 4) +
(v1.translit_vin[16]::numeric * 3) +
(v1.translit_vin[17]::numeric * 2)
),11) = v1.translit_vin[9]::numeric then '1'
else '0'
end as checksum
from
(
select distinct on (vin)
vin,
regexp_split_to_array(replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(
replace(lower(vin),'a','1'),
'j','1'),
'b','2'),
'k','2'),
's','2'),
'c','3'),
'l','3'),
't','3'),
'd','4'),
'm','4'),
'u','4'),
'e','5'),
'n','5'),
'v','5'),
'f','6'),
'w','6'),
'g','7'),
'p','7'),
'x','7'),
'h','8'),
'y','8'),
'r','9'),
'z','9'),E'') as translit_vin
from
public.vehicle
where
length(vin) = 17
and
vin ~ '[A-Z0-9]*$'
and
vin !~ '[IOQ]'
and
vin !~ '^[0-9]*$'
and
vin ~ '[^.-]$'
) v1;
