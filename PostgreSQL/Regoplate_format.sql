select distinct
*
from
public.vehicle v1,
public.vehicleplate v2,
public.motorassetclaim v3
where
v1.id = v2.vehicle_id
and
v1.vin = v3.vehicle_vin
and
--v2.rego ~ '^[M][\b][O][0-9]+'
--or
--v2.rego ~ '^[0-9]{4}[S][T]$'
--or
--v2.rego ~ '^[0-9]{4}[T][T]$'
--or
--v2.rego ~ '^[T]{1}[0-9]{4}$'
limit 10

select
*
from
public.vehicleplate
where
(
rego !~ '^[T]{1}[C]{1}[0-9]{4,}$' and
rego !~ '^[H]{1}[C]{1}[0-9]{4,}$' and
rego !~ '^[C]{1}[C]{1}[0-9]{4,}$' or
rego ~ '^[a-zA-Z]{2}[0-9]{3}$' or
rego ~ '^[a-zA-Z]{2}[0-9]{4}$' or
rego ~ '^[a-zA-Z]{3}[0-9]{3}$' or
rego ~ '^[a-zA-Z]{3}[0-9]{2}[a-zA-Z]{1}$' or
rego ~ '^[a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2}$' or
rego ~ '^[0-9]{3}[a-zA-Z]{3}$' or
rego ~ '^[0-9]{2}[a-zA-Z]{3}$' or
rego ~ '^[0-9]{2}[a-zA-Z]{4}$' or 
rego ~ '^[0-9a-zA-Z]{6}$' 
)                                           /* Private Vehicle */
--rego ~ '^[M][\b][O][0-9]+'                /* Transit         */
--rego ~ '^[0-9]{4,}[S]{1}[T]{1}$'          /* State Transport */
--rego ~ '^[0-9]{4,}[T]{1}[T]{1}$'          /* Tow truck       */
--rego ~ '^[T]{1}[0-9]{4,}$'                /* Taxi            */
--rego ~ '^[T]{1}[C]{1}[0-9]{4,}$'          /* Taxi Regional   */
--rego ~ '^[H]{1}[C]{1}[0-9]{4,}$'          /* Hire Car        */
--rego ~ '^[C]{1}[C]{1}[0-9]{4,}$'          /* Consular Car    */
--rego ~ '^[0-9]{4,}[D]$'                   /* Conditional     */
--rego ~ '^[0-9]{4,}[N]$'                   /* Conditional MB  */
--rego ~ '^[T]{1}[V]{1}[0-9]{4}$'           /* Tourist Vehicle */
--rego ~ '^[0-9]{4,}[R]$'                   /* Rally Vehicle   */
--rego ~ '^[0-9]{4,}[H]$'                   /* Historic Veh    */
--rego ~ '^[0-9]{4,}[J]$'                   /* Historic Bikes  */
--rego ~ '^[A]{1}[0-9]{4,}$'                /* Trade Vehicle   */
--rego ~ '^[0-5]{4,}[A]{1}$'                /* Trade Trailer   */
--rego ~ '^[6-9]{4,}[A]{1}$'                /* Trade MotorBike */
--rego ~ '^[acndstvwACNQSTVW]{1}[qtxQTX]{1}[0-9]{2}[a-zA-Z]{2}$' /* heavy Vehicle (over 4.5 ton GVW) */
--(
--rego ~ '^[adnrADNR]{1}[0-9]{4,}$'         /* Military Veh    */
--rego ~ '^[1-6]{1}[0-9]{1}[0-9]{4,}$'      /* Pre 2008 MV     */
--)
