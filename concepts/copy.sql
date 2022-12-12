-- copy
select *
into PersonsCopy
from Persons2

select *
from PersonsCopy

-- empty table copy
select *
into PersonsCopy2
from Persons2
where 0 = 1000

select * from PersonsCopy2