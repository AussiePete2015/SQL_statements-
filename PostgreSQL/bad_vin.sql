/* Testing vin numbers using regex   */

select distinct
vin
from motor
where
vin !~ '^[D]{1}[U]{1}[a-zA-Z]+'
OR
vin !~ '^[i,o,q,I,O,Q]+'
or
vin !~ '^(.)\1{17}'
or
length(vin) < 17;
