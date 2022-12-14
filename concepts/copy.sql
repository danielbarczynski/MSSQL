-- copy
select *
into PersonsCopy
from Persons

select *
from PersonsCopy

-- empty table copy
select *
into PersonsCopy2
from Persons
where 0 = 1000

select *
from PersonsCopy2