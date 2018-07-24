/* using rank Filter  */
select rank_filter.*
from
(
select 
vehicle."year",
vehicle.make,
count(vehicle.make),
rank() over (partition by "year" order by count(make) desc) as rank
from vehicle
where
"year" = :veh_year::text
group by
vehicle."year",
vehicle.make
)
rank_filter where rank <= :topN::numeric

/* using limit        */
select 
"year", 
make, 
sum(count(make)) over (partition by make order by "year" asc)
from
vehicle
where "year" = :veh_year::text 
group by
"year",
make
order by
sum(count(make)) over (partition by make order by "year" asc) desc
limit 5
