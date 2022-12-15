-- copy
select *
into PersonsCopy
from Persons

select *
from PersonsCopy

-- copy only column
select FirstName into 
names from 
Persons 
where FirstName is not null

select * from names

-- empty table copy
select *
into PersonsCopy2
from Persons
where 0 = 1000

select *
from PersonsCopy2