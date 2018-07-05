SELECT 
vin,
count(vin) as vin_cnt,
make,
model,
modelyear,
state
FROM 
motor
where 
levenshtein(vin,'######%') = 3
group by
vin,
make,
model,
modelyear,
state
order by count(vin) Desc;
